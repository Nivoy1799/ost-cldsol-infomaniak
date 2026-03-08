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

## Docker

```bash
docker build -t swiss-transport-board .
docker run -p 8080:8080 -e MEMCACHED_HOST=host.docker.internal:11211 swiss-transport-board
```

## Deployment auf Infomaniak Jelastic

### 1. Environment erstellen

1. Im Jelastic Dashboard → **New Environment**
2. **Docker Container** hinzufügen (Custom Image)
3. **Memcached** Node hinzufügen (aus den NoSQL-Optionen)
4. Environment benennen (z.B. `transport-board`)

### 2. Docker Image deployen

**Option A: Via Dockerfile (empfohlen)**
1. Repository-URL im Docker-Container konfigurieren
2. Oder: Image lokal bauen und in eine Registry pushen

**Option B: Via Git-Deployment**
1. Git-Repository im Jelastic Dashboard verbinden
2. Build-Kommando: `docker build -t app .`

### 3. Environment Variables setzen

Im Jelastic Dashboard unter dem Docker-Container:

```
PORT=8080
MEMCACHED_HOST=<memcached-node-ip>:11211
CACHE_TTL_SECONDS=30
```

Die interne IP des Memcached-Nodes findet sich im Jelastic Dashboard.

### 4. Health Check

```
GET /health → 200 OK {"status":"ok"}
```

## API-Endpunkte

| Methode | Pfad | Beschreibung |
|---|---|---|
| GET | `/` | Startseite mit Suchfeld |
| GET | `/departures?station=Zürich+HB` | Abfahrten für eine Station |
| GET | `/health` | Health-Check Endpunkt |
