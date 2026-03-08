# Swiss Transport Board

Live-Abfahrtszeiten des Schweizer ÖV via [transport.opendata.ch](https://transport.opendata.ch), gecached mit Memcached.

Entwickelt als Hello-World-Applikation für die Gruppenarbeit 1 "Cloud Solutions" (OST).

## Stack

- Go (net/http, kein Framework)
- Memcached (gomemcache)
- HTML/CSS inline (kein Frontend-Framework)

## Lokal starten

```bash
# Memcached starten (macOS)
brew install memcached && memcached -d

# App starten
go run main.go

# Browser öffnen
open http://localhost:8080
```

## Environment Variables

| Variable | Default | Beschreibung |
|---|---|---|
| `PORT` | `8080` | HTTP Server Port |
| `MEMCACHED_HOST` | `localhost:11211` | Memcached Adresse |
| `CACHE_TTL_SECONDS` | `30` | Cache-TTL in Sekunden |

## Deployment auf Infomaniak Jelastic (Native Go PaaS)

Die App wird nativ auf dem Jelastic Go Application Server deployed -- kein Docker nötig. Jelastic baut den Go-Code direkt aus dem Source.

### 1. Environment erstellen

1. Im Jelastic Dashboard → **New Environment**
2. Tab **Go** wählen → Go-Version auswählen (z.B. 1.23.x)
3. Cloudlets konfigurieren (z.B. 2 Reserved, 4 Dynamic)
4. **Memcached** Node hinzufügen (Bereich "Cache")
5. Environment benennen (z.B. `transport-board`)
6. **Create** klicken

### 2. Git-Repository verbinden und deployen

1. Im Dashboard unten → **Deployment Manager** öffnen
2. Tab **Git/SVN** → **Add Repo**
3. Repository-URL eingeben: `https://github.com/Nivoy1799/ost-cldsol-infomaniak.git`
4. Branch: `main`
5. Path: Falls das Go-Projekt in einem Unterordner liegt, dies beachten
6. Auf das Projekt hovern → **Deploy to...** → Go-Environment wählen → Context: **ROOT**
7. Jelastic klont das Repo, führt `go get` + `go build` aus und startet die App

**Optional:** "Check and auto-deploy updates" aktivieren für automatisches Redeployment bei Git-Pushes.

### 3. Environment Variables setzen

Im Jelastic Dashboard auf den Go-Node klicken → **Variables**:

```
MEMCACHED_HOST=<memcached-internal-hostname>:11211
CACHE_TTL_SECONDS=30
```

Den internen Hostnamen des Memcached-Nodes findet man im Dashboard (Format: `nodeXXXXX` oder `memcached-envname.jcloud.ik-server.com`).

**Hinweis:** `PORT` muss nicht gesetzt werden -- die App lauscht standardmässig auf 8080, was dem Jelastic-Standard entspricht.

### 4. Verifizieren

```
GET https://<environment-url>/health → 200 OK {"status":"ok"}
GET https://<environment-url>/ → Suchseite
GET https://<environment-url>/departures?station=Bern → Live-Abfahrten
```

### Jelastic-spezifische Variablen

| Variable | Beschreibung |
|---|---|
| `GOPATH` | Automatisch auf `/home/jelastic/webapp` gesetzt |
| `GO_RUN` | Name des Binary (auto-erkannt aus Projektname) |
| `GO_BUILD_OPTIONS` | Build-Flags (default: `-a`) |

## API-Endpunkte

| Methode | Pfad | Beschreibung |
|---|---|---|
| GET | `/` | Startseite mit Suchfeld |
| GET | `/departures?station=Zürich+HB` | Abfahrten für eine Station |
| GET | `/health` | Health-Check Endpunkt |
