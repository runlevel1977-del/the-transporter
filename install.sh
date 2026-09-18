#!/bin/sh
# The Transporter — Image + Compose von GitHub, dann starten.
set -e
DIR=/volume1/docker/the-transporter
VER=0.2.0
BASE=https://github.com/runlevel1977-del/the-transporter
sudo mkdir -p "$DIR"
cd "$DIR"
sudo curl -fsSL -o docker-compose.yml "$BASE/raw/main/docker-compose.yml"
sudo curl -fL -o /tmp/the-transporter-${VER}.tar "$BASE/releases/download/v${VER}/the-transporter-${VER}.tar"
sudo docker load -i /tmp/the-transporter-${VER}.tar
sudo rm -f /tmp/the-transporter-${VER}.tar
sudo docker compose up -d
echo "The Transporter: http://NAS-IP:21011"
