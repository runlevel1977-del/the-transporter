#!/bin/sh
# The Transporter — Image + Compose von GitHub, dann starten.
set -e
DIR=/volume1/docker/the-transporter
VER=0.2.4
BASE=https://github.com/runlevel1977-del/the-transporter
RAW=https://raw.githubusercontent.com/runlevel1977-del/the-transporter/main

arch=$(uname -m)
case "$arch" in
  x86_64) cpu=amd64 ;;
  aarch64|arm64) cpu=arm64 ;;
  *)
    echo "Unbekannte CPU: $arch (erwartet x86_64 oder aarch64)"
    exit 1
    ;;
esac

sudo mkdir -p "$DIR"
cd "$DIR"

if [ ! -f "$DIR/docker-compose.yml" ]; then
  sudo curl -fsSL -o "$DIR/docker-compose.yml" "$RAW/docker-compose.yml"
else
  echo "YAML vorhanden — Port und übrige Anpassungen bleiben."
fi

sudo curl -fsSL -o "$DIR/patch-volumes.sh" "$RAW/patch-volumes.sh"
sudo sh "$DIR/patch-volumes.sh" "$DIR/docker-compose.yml"

sudo curl -fL -o /tmp/the-transporter-${VER}.tar "$BASE/releases/download/v${VER}/the-transporter-${VER}-${cpu}.tar"
sudo docker load -i /tmp/the-transporter-${VER}.tar
sudo rm -f /tmp/the-transporter-${VER}.tar
sudo sed -i "s|image: the-transporter:.*|image: the-transporter:${VER}|" "$DIR/docker-compose.yml"
sudo sed -i '/docker.sock/d' "$DIR/docker-compose.yml"
sudo docker compose -f "$DIR/docker-compose.yml" up -d
echo "The Transporter ($cpu): http://NAS-IP:21011"
