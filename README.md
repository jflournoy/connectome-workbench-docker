# Connectome Workbench

A Dockerfile that sets up the HCP [Connectome Workbench](https://humanconnectome.org/software/connectome-workbench) (via [NeuroDebian](https://neuro.debian.net/pkgs/connectome-workbench.html)) on top of [linuxserver/webtop](https://docs.linuxserver.io/images/docker-webtop/) (Ubuntu 24.04 + XFCE), accessible through your browser.

## Quick start (docker compose)

```
cp .env.example .env        # then edit to taste (see Configuration below)
docker compose up -d --build
```

Then open **http://127.0.0.1:3000** (or `https://127.0.0.1:3001` for HTTPS).

## Launching Connectome Workbench

Once the desktop loads in your browser, launch `wb_view` either way:

- **Apps menu:** click the menu icon in the top-left corner of the desktop → **Science** → **Connectome Workbench**.
- **Terminal:** right-click the desktop → **Open Terminal Here** (or use the terminal icon in the taskbar) → type `wb_view` and hit enter.

Your host data mount is at `/data` inside the container — point Workbench's file browser there to load scenes, CIFTI files, etc.

Other useful commands:

```
docker compose logs -f      # watch output
docker compose down         # stop and remove
docker compose pull         # update the webtop base image
docker compose up -d --build  # rebuild on top of a fresh base
```

## Configuration

Settings live in `.env` (copied from `.env.example`). All have sensible defaults — only override what you need.

| Variable | Default | Purpose |
| --- | --- | --- |
| `HTTP_PORT` | `3000` | Host port mapped to the container's HTTP web UI |
| `HTTPS_PORT` | `3001` | Host port mapped to the container's HTTPS web UI |
| `DATA_DIR` | `./data` | Host path mounted at `/data` inside the container |
| `PUID` | `1000` | Numeric user ID the desktop runs as — set to `$(id -u)` so files written to `/data` are owned by you |
| `PGID` | `1000` | Numeric group ID — set to `$(id -g)` |
| `TZ` | `America/New_York` | Container timezone (IANA format, e.g. `Europe/Berlin`) |

Example: run on non-default ports with a specific dataset directory:

```
HTTP_PORT=8080
HTTPS_PORT=8443
DATA_DIR=/mnt/hcp/tutorial
```

## Running without compose

```
docker run -d --rm \
  -p 3000:3000 -p 3001:3001 \
  -v /dev/shm:/dev/shm \
  -v /path/to/your/data:/data \
  --name cwb \
  connectome-workbench:latest
```

Tutorial data: the [HCP Tutorial dataset](https://balsa.wustl.edu/study/kN3mg) is a good first thing to point `/data` at.

## Notes

- The webtop terminal has passwordless `sudo`. Don't expose the container to untrusted networks without setting `CUSTOM_USER` and `PASSWORD` env vars — see the [webtop docs](https://docs.linuxserver.io/images/docker-webtop/).
- `PUID`/`PGID` in `.env` should match your host user (`id -u` / `id -g`) so files written to `/data` are owned by you.
