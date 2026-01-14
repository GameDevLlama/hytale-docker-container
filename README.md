# Hytale Dedicated Server (Docker)

Minimal and clean Docker setup for running a **Hytale Dedicated Server** with optional AOT support.

This repository does **not** ship the server binaries.  
You must download them manually from the official Hytale documentation.

---

## Requirements

- Docker + Docker Compose
- A valid Hytale account (required for first-time authentication)
- Server files from Hytale

Official guide:  
https://support.hytale.com/hc/en-us/articles/45326769420827-Hytale-Server-Manual

---

## Repository Structure

```
.
├─ Dockerfile
├─ docker-compose.yml
├─ .dockerignore
├─ README.md
├─ HytaleServer.jar      # downloaded manually
└─ HytaleServer.aot      # optional but recommended
```

---

## Step 1: Download Server Files

Download the following files from the official Hytale server manual:

- `HytaleServer.jar`
- `HytaleServer.aot`

Place both files **next to the Dockerfile**:

```
HytaleServer.jar
HytaleServer.aot
```

---

## Step 2: Prepare Assets

The server requires an `Assets.zip` file.

Example host structure:
```
/docker/storage/hytale/
├─ data/
└─ assets/
   └─ Assets.zip
```

The assets file will be mounted read-only into the container.

---

## Step 3: Docker Compose Configuration

Example `docker-compose.yml`:

```yaml
services:
  hytale:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: hytale-server
    restart: unless-stopped
    stdin_open: true
    tty: true
    ports:
      - "5520:5520/udp"
    volumes:
      - /docker/storage/hytale/data:/data
      - /docker/storage/hytale/assets/Assets.zip:/assets/Assets.zip:ro
    environment:
      ASSETS_PATH: /assets/Assets.zip
      JAVA_OPTS: "-Dio.netty.transport.noNative=true"
      HYTALE_OPTS: ""
```

---

## Step 4: Start the Server

Build and start the container:

```bash
docker compose up -d --build
```

Check logs:

```bash
docker logs -f hytale-server
```

---

## Step 5: First-Time Authentication (IMPORTANT)

On first startup, the server requires authentication with your Hytale account.

Attach to the container:

```bash
docker attach hytale-server
```

Run inside the server console:

```text
/auth login device
```

Follow the displayed instructions to authenticate the server.

Detach safely using:

```
CTRL + P, CTRL + Q
```

---

## Environment Variables

| Variable | Description |
|--------|-------------|
| `ASSETS_PATH` | Path to `Assets.zip` inside container |
| `JAVA_OPTS` | Additional JVM flags |
| `HYTALE_OPTS` | Additional Hytale server flags |

---

## Data Persistence

All runtime data is stored in:

```
/data
```

This directory **must be mounted** to persist world data and configs.

---

## Notes

- The AOT cache (`HytaleServer.aot`) significantly improves startup performance
- Assets are mounted read-only by design
- This setup is intended for dedicated servers, not local testing

---

## Disclaimer

Hytale and all related assets are property of Hypixel Studios.  
This repository only provides a containerized runtime environment.


Have fun playing!! 🥳