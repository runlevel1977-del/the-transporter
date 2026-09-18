# The Transporter

Docker-App für UGREEN-NAS: Übertragungen, Wake & Sync, Backup, Explorer.

Das Image liegt auf GitHub und wird beim Start gezogen. Kein UGREEN-Entwicklerkonto, keine `.upk`.

## Installieren (SSH auf dem NAS)

Nur **Volume 1** vorhanden? In der YAML die Zeile `- /volume2:/volume2` löschen.

```bash
sudo mkdir -p /volume1/docker/the-transporter
cd /volume1/docker/the-transporter
sudo curl -fsSL -o docker-compose.yml \
  https://raw.githubusercontent.com/runlevel1977-del/the-transporter/main/docker-compose.yml
sudo docker compose up -d
```

Browser: `http://NAS-IP:21011`

Die UGOS-Docker-Oberfläche („Projekt erstellen“) lehnt Host-Netz und privileged ab. Deshalb per Compose starten, nicht über die GUI.

## Stoppen

```bash
cd /volume1/docker/the-transporter
sudo docker compose down
```

## Hinweis

Der Container braucht vollen Volume-Zugriff und privileged (Wake-on-LAN). Nur auf dem eigenen NAS testen.
