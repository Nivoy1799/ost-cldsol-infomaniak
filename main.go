package main

import (
	"encoding/json"
	"fmt"
	"html/template"
	"log/slog"
	"net/http"
	"net/url"
	"os"
	"strconv"
	"strings"
	"time"

	"github.com/bradfitz/gomemcache/memcache"
)

// --- Types ---

type Station struct {
	Name string `json:"name"`
	ID   string `json:"id"`
}

type LocationResponse struct {
	Stations []Station `json:"stations"`
}

type StationBoardEntry struct {
	Stop     StopInfo `json:"stop"`
	Name     string   `json:"name"`
	Category string   `json:"category"`
	Number   string   `json:"number"`
	To       string   `json:"to"`
	Operator string   `json:"operator"`
}

type StopInfo struct {
	Departure string `json:"departure"`
	Platform  string `json:"platform"`
	Delay     *int   `json:"delay"`
}

type StationBoardResponse struct {
	Station      Station             `json:"station"`
	Stationboard []StationBoardEntry `json:"stationboard"`
}

type Departure struct {
	Line          string
	Category      string
	Destination   string
	DepartureTime string
	Delay         int
	Platform      string
}

type CacheResult struct {
	Departures  []Departure
	Cached      bool
	ResponseMs  int64
	StationName string
	Error       string
}

type PageData struct {
	Query  string
	Result *CacheResult
}

// --- Config ---

type Config struct {
	Port          string
	MemcachedHost string
	CacheTTL      int32
}

func loadConfig() Config {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	mcHost := os.Getenv("MEMCACHED_HOST")
	if mcHost == "" {
		mcHost = "localhost:11211"
	}
	ttl := int32(30)
	if v := os.Getenv("CACHE_TTL_SECONDS"); v != "" {
		if parsed, err := strconv.Atoi(v); err == nil {
			ttl = int32(parsed)
		}
	}
	return Config{Port: port, MemcachedHost: mcHost, CacheTTL: ttl}
}

// --- Server ---

type Server struct {
	mc     *memcache.Client
	config Config
	client *http.Client
	tmpl   *template.Template
}

func NewServer(cfg Config) *Server {
	mc := memcache.New(cfg.MemcachedHost)
	mc.Timeout = 500 * time.Millisecond

	funcMap := template.FuncMap{
		"add":   func(a, b int) int { return a + b },
		"lower": strings.ToLower,
	}

	tmpl := template.Must(template.New("page").Funcs(funcMap).Parse(pageTemplate))

	return &Server{
		mc:     mc,
		config: cfg,
		client: &http.Client{Timeout: 10 * time.Second},
		tmpl:   tmpl,
	}
}

func (s *Server) handleIndex(w http.ResponseWriter, r *http.Request) {
	if r.URL.Path != "/" {
		http.NotFound(w, r)
		return
	}
	w.Header().Set("Content-Type", "text/html; charset=utf-8")
	if err := s.tmpl.Execute(w, PageData{}); err != nil {
		slog.Error("template execute failed", "error", err)
	}
}

func (s *Server) handleDepartures(w http.ResponseWriter, r *http.Request) {
	station := r.URL.Query().Get("station")
	if station == "" {
		http.Redirect(w, r, "/", http.StatusSeeOther)
		return
	}

	start := time.Now()
	result := s.getDepartures(station)
	result.ResponseMs = time.Since(start).Milliseconds()

	w.Header().Set("Content-Type", "text/html; charset=utf-8")
	if err := s.tmpl.Execute(w, PageData{Query: station, Result: &result}); err != nil {
		slog.Error("template execute failed", "error", err)
	}
}

func (s *Server) handleHealth(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	_ = json.NewEncoder(w).Encode(map[string]string{"status": "ok"})
}

func (s *Server) getDepartures(station string) CacheResult {
	cacheKey := "departures:" + strings.ToLower(station)

	// Try cache first
	if item, err := s.mc.Get(cacheKey); err == nil {
		var deps []Departure
		if err := json.Unmarshal(item.Value, &deps); err == nil {
			slog.Info("cache hit", "station", station)
			return CacheResult{Departures: deps, Cached: true, StationName: station}
		}
	}

	// Fetch from API
	slog.Info("cache miss, fetching from API", "station", station)
	apiURL := fmt.Sprintf("http://transport.opendata.ch/v1/stationboard?station=%s&limit=10", url.QueryEscape(station))

	resp, err := s.client.Get(apiURL)
	if err != nil {
		slog.Error("API request failed", "error", err)
		return CacheResult{Error: "Verbindung zur Transport-API fehlgeschlagen.", StationName: station}
	}
	defer func() { _ = resp.Body.Close() }()

	if resp.StatusCode != http.StatusOK {
		slog.Error("API returned error", "status", resp.StatusCode)
		return CacheResult{Error: fmt.Sprintf("Transport-API Fehler (HTTP %d).", resp.StatusCode), StationName: station}
	}

	var board StationBoardResponse
	if err := json.NewDecoder(resp.Body).Decode(&board); err != nil {
		slog.Error("failed to decode API response", "error", err)
		return CacheResult{Error: "Antwort der Transport-API konnte nicht verarbeitet werden.", StationName: station}
	}

	if board.Station.Name != "" {
		station = board.Station.Name
	}

	deps := make([]Departure, 0, len(board.Stationboard))
	for _, entry := range board.Stationboard {
		dep := Departure{
			Line:        entry.Category + " " + entry.Number,
			Category:    entry.Category,
			Destination: entry.To,
			Platform:    entry.Stop.Platform,
		}

		if entry.Stop.Delay != nil {
			dep.Delay = *entry.Stop.Delay
		}

		if entry.Stop.Departure != "" {
			parsed := false
			for _, layout := range []string{
				time.RFC3339,
				"2006-01-02T15:04:05-0700",
			} {
				if t, err := time.Parse(layout, entry.Stop.Departure); err == nil {
					dep.DepartureTime = t.Format("15:04")
					parsed = true
					break
				}
			}
			if !parsed {
				dep.DepartureTime = entry.Stop.Departure
			}
		}

		deps = append(deps, dep)
	}

	// Store in cache
	if data, err := json.Marshal(deps); err == nil {
		cacheErr := s.mc.Set(&memcache.Item{
			Key:        cacheKey,
			Value:      data,
			Expiration: s.config.CacheTTL,
		})
		if cacheErr != nil {
			slog.Warn("failed to write cache", "error", cacheErr)
		}
	}

	return CacheResult{Departures: deps, Cached: false, StationName: station}
}

func main() {
	cfg := loadConfig()

	slog.Info("starting server",
		"port", cfg.Port,
		"memcached", cfg.MemcachedHost,
		"cache_ttl", cfg.CacheTTL,
	)

	srv := NewServer(cfg)

	mux := http.NewServeMux()
	mux.HandleFunc("/", srv.handleIndex)
	mux.HandleFunc("/departures", srv.handleDepartures)
	mux.HandleFunc("/health", srv.handleHealth)

	server := &http.Server{
		Addr:         ":" + cfg.Port,
		Handler:      mux,
		ReadTimeout:  15 * time.Second,
		WriteTimeout: 15 * time.Second,
	}

	if err := server.ListenAndServe(); err != nil {
		slog.Error("server failed", "error", err)
		os.Exit(1)
	}
}

// --- HTML Template ---

const pageTemplate = `<!DOCTYPE html>
<html lang="de">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Swiss Transport Board</title>
<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }

  body {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
    background: #f5f5f5;
    color: #333;
    min-height: 100vh;
  }

  header {
    background: #e20010;
    color: white;
    padding: 1.2rem 1rem;
    text-align: center;
    box-shadow: 0 2px 8px rgba(0,0,0,0.15);
  }

  header h1 {
    font-size: 1.5rem;
    font-weight: 700;
    letter-spacing: 0.02em;
  }

  header h1 .flag {
    display: inline-block;
    width: 1.4em;
    height: 1.4em;
    background: white;
    color: #e20010;
    font-weight: 900;
    font-size: 1rem;
    line-height: 1.4em;
    text-align: center;
    border-radius: 3px;
    margin-right: 0.4em;
    vertical-align: middle;
    position: relative;
    top: -1px;
  }

  .container {
    max-width: 700px;
    margin: 0 auto;
    padding: 1.5rem 1rem;
  }

  .search-form {
    display: flex;
    gap: 0.5rem;
    margin-bottom: 1.5rem;
  }

  .search-form input[type="text"] {
    flex: 1;
    padding: 0.75rem 1rem;
    font-size: 1rem;
    border: 2px solid #ddd;
    border-radius: 6px;
    outline: none;
    transition: border-color 0.2s;
  }

  .search-form input[type="text"]:focus {
    border-color: #e20010;
  }

  .search-form button {
    padding: 0.75rem 1.5rem;
    font-size: 1rem;
    font-weight: 600;
    background: #e20010;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: background 0.2s;
    white-space: nowrap;
  }

  .search-form button:hover {
    background: #b8000d;
  }

  .meta {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
    align-items: center;
    margin-bottom: 1rem;
    font-size: 0.85rem;
    color: #666;
  }

  .badge {
    display: inline-block;
    padding: 0.2em 0.6em;
    border-radius: 4px;
    font-size: 0.75rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.04em;
  }

  .badge-cached {
    background: #d4edda;
    color: #155724;
  }

  .badge-live {
    background: #fff3cd;
    color: #856404;
  }

  .station-name {
    font-size: 1.1rem;
    font-weight: 700;
    color: #333;
    margin-bottom: 0.75rem;
  }

  .departures {
    background: white;
    border-radius: 8px;
    box-shadow: 0 1px 4px rgba(0,0,0,0.08);
    overflow: hidden;
  }

  .dep-row {
    display: grid;
    grid-template-columns: 4.5rem 1fr auto auto;
    gap: 0.5rem;
    align-items: center;
    padding: 0.75rem 1rem;
    border-bottom: 1px solid #f0f0f0;
  }

  .dep-row:last-child {
    border-bottom: none;
  }

  .dep-row:hover {
    background: #fafafa;
  }

  .dep-time {
    font-size: 1.2rem;
    font-weight: 700;
    font-variant-numeric: tabular-nums;
    color: #333;
  }

  .dep-delay {
    color: #e20010;
    font-size: 0.8rem;
    font-weight: 600;
  }

  .dep-dest {
    font-size: 0.95rem;
  }

  .dep-line {
    font-size: 0.8rem;
    font-weight: 600;
    background: #333;
    color: white;
    padding: 0.15em 0.5em;
    border-radius: 4px;
    text-align: center;
    white-space: nowrap;
  }

  .dep-line.s    { background: #0078c8; }
  .dep-line.ir   { background: #e20010; }
  .dep-line.ic   { background: #e20010; }
  .dep-line.ice  { background: #e20010; }
  .dep-line.re   { background: #555; }
  .dep-line.bus  { background: #ffcc00; color: #333; }
  .dep-line.tram { background: #0078c8; }
  .dep-line.t    { background: #0078c8; }

  .dep-platform {
    font-size: 0.85rem;
    color: #888;
    text-align: right;
    min-width: 3rem;
  }

  .error {
    background: #f8d7da;
    color: #721c24;
    padding: 1rem;
    border-radius: 6px;
    margin-bottom: 1rem;
  }

  .empty {
    text-align: center;
    padding: 2rem;
    color: #999;
  }

  footer {
    text-align: center;
    padding: 1.5rem;
    font-size: 0.75rem;
    color: #aaa;
  }

  @media (max-width: 500px) {
    .dep-row {
      grid-template-columns: 3.5rem 1fr auto;
      gap: 0.3rem;
    }
    .dep-platform {
      display: none;
    }
    header h1 { font-size: 1.2rem; }
  }
</style>
</head>
<body>
<header>
  <h1><span class="flag">+</span> Swiss Transport Board</h1>
</header>

<div class="container">
  <form class="search-form" action="/departures" method="get">
    <input type="text" name="station" placeholder="Station eingeben (z.B. Zürich HB)" value="{{.Query}}" autofocus>
    <button type="submit">Suchen</button>
  </form>

  {{if .Result}}
    {{if .Result.Error}}
      <div class="error">{{.Result.Error}}</div>
    {{else}}
      <div class="meta">
        {{if .Result.Cached}}
          <span class="badge badge-cached">Cached</span>
        {{else}}
          <span class="badge badge-live">Live</span>
        {{end}}
        <span>{{.Result.ResponseMs}} ms</span>
      </div>

      {{if .Result.StationName}}
        <div class="station-name">{{.Result.StationName}}</div>
      {{end}}

      {{if .Result.Departures}}
        <div class="departures">
          {{range $i, $dep := .Result.Departures}}
          <div class="dep-row">
            <div>
              <span class="dep-time">{{$dep.DepartureTime}}</span>
              {{if gt $dep.Delay 0}}
                <span class="dep-delay">+{{$dep.Delay}}</span>
              {{end}}
            </div>
            <div class="dep-dest">{{$dep.Destination}}</div>
            <div class="dep-line {{$dep.Category | lower}}">{{$dep.Line}}</div>
            <div class="dep-platform">
              {{if $dep.Platform}}Gl. {{$dep.Platform}}{{end}}
            </div>
          </div>
          {{end}}
        </div>
      {{else}}
        <div class="empty">Keine Abfahrten gefunden.</div>
      {{end}}
    {{end}}
  {{end}}
</div>

<footer>
  Daten: transport.opendata.ch | Cloud Solutions FS2026
</footer>
</body>
</html>`
