# --- Build stage ---
FROM golang:1.22-alpine AS builder

WORKDIR /build
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o app .

# --- Runtime stage ---
FROM alpine:3.19

RUN apk --no-cache add ca-certificates tzdata
ENV TZ=Europe/Zurich

WORKDIR /app
COPY --from=builder /build/app .

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost:8080/health || exit 1

ENTRYPOINT ["./app"]
