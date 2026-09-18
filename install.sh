#!/bin/sh
# The Transporter — Image + Compose von GitHub, dann starten.
set -e
DIR=/volume1/docker/the-transporter
VER=0.2.0
BASE=https://github.com/runlevel1977-del/the-transporter

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
sudo curl -fsSL -o docker-compose.yml "$BASE/raw/main/docker-compose.yml"
sudo curl -fL -o /tmp/the-transporter-${VER}.tar "$BASE/releases/download/v${VER}/the-transporter-${VER}-${cpu}.tar"
sudo docker load -i /tmp/the-transporter-${VER}.tar
sudo rm -f /tmp/the-transporter-${VER}.tar
sudo docker compose -f "$DIR/docker-compose.yml" up -d
echo "The Transporter ($cpu): http://NAS-IP:21011"
