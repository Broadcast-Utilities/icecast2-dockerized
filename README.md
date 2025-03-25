# Icecast2 Dockerized

A lightweight, configurable Docker image for running [Icecast2](https://icecast.org/) — a free, open-source streaming media server — in a containerized environment.

This image is suitable for development, testing, and lightweight production scenarios where simple audio streaming is needed.

## 📦 Features

- Based on Ubuntu 20.04 (Focal)
- Icecast2 installed without unnecessary packages (`--no-install-recommends`)
- Dynamic configuration via environment variables
- Supports custom startup scripts
- Exposes port `8000` by default

## 🚀 Getting Started

### 🔨 Build the Image

```bash
docker build -t icecast2dockerized:latest .
```

### ▶️ Run the Container

```bash
docker run -d \
  -e ICECAST_SOURCE_PASSWORD=sourcepass \
  -e ICECAST_ADMIN_PASSWORD=adminpass \
  -e ICECAST_RELAY_PASSWORD=relaypass \
  -e ICECAST_ADMIN_USERNAME=admin \
  -e ICECAST_ADMIN_EMAIL=admin@example.com \
  -e ICECAST_LOCATION="Amsterdam" \
  -e ICECAST_HOSTNAME="stream.example.com" \
  -p 8000:8000 \
  --name icecast2 \
  icecast2dockerized:latest
```

## ⚙️ Environment Variables

| Variable                 | Description                           | Default           |
|--------------------------|---------------------------------------|-------------------|
| `ICECAST_SOURCE_PASSWORD`| Source client password                | `hackme`          |
| `ICECAST_RELAY_PASSWORD` | Relay password                        | `hackme`          |
| `ICECAST_ADMIN_PASSWORD` | Admin interface password              | `hackme`          |
| `ICECAST_ADMIN_USERNAME` | Admin username                        | `admin`           |
| `ICECAST_ADMIN_EMAIL`    | Contact email                         | `icemaster@localhost` |
| `ICECAST_LOCATION`       | Station location                      | `Earth`           |
| `ICECAST_HOSTNAME`       | Public hostname                       | `localhost`       |
| `ICECAST_MAX_CLIENTS`    | Max number of simultaneous listeners  | `100`             |
| `ICECAST_MAX_SOURCES`    | Max number of source streams          | `2`               |

## 📁 Project Structure

```bash
.
├── Dockerfile             # Build instructions for the image
├── entrypoint.sh          # Container startup logic & config injection
├── xml-edit.sh            # Simple XML CLI tool for editing icecast.xml
└── README.md              # You're reading this!
```

## 📝 Notes

- The container logs are streamed using `tail -F /var/log/icecast2/error.log`. If the log file is not generated, check your Icecast configuration (`/etc/icecast2/icecast.xml`).
- The XML config is patched at runtime using `xml-edit.sh` (a minimal XML updater).
- By default, the server runs in the foreground inside the container. No systemd or background daemon mode is used.

## 📚 References

- [Icecast Official Site](https://icecast.org/)
- [Icecast Docs](https://icecast.org/docs/)

## 🧑‍💻 Maintainer

**Rik Visser**  
Broadcast Utilities  
📧 rik@broadcastutilities.nl  
🌐 [broadcastutilities.nl](https://broadcastutilities.nl)

## 🛡️ License

GPL v2.0 — see [LICENSE](LICENSE) for details.
