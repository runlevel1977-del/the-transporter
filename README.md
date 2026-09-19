# The Transporter

Docker-App für UGREEN-NAS: Übertragungen, Wake & Sync, Backup, Explorer.

YAML und Image liegen auf GitHub. Kein UGREEN-Entwicklerkonto, keine `.upk`.

**Anleitung zum Weitergeben:** [INSTALL.txt](INSTALL.txt) · [Hilfe](docs/help.md) · [Datenschutz](docs/privacy.md)

## Installieren

Von **Windows PowerShell:**

```powershell
ssh BENUTZER@NAS-IP
```

Danach im gleichen Fenster (jetzt NAS). CPU prüfen:

```bash
uname -m
```

- `x86_64` → AMD64-Datei
- `aarch64` → ARM64-Datei

```bash
sudo mkdir -p /volume1/docker/the-transporter
cd /volume1/docker/the-transporter
sudo curl -fL -o docker-compose.yml \
  https://raw.githubusercontent.com/runlevel1977-del/the-transporter/main/docker-compose.yml
```

Image (eine Zeile, passend zur CPU):

```bash
# AMD64
sudo curl -fL -o /tmp/the-transporter.tar \
  https://github.com/runlevel1977-del/the-transporter/releases/download/v0.2.0/the-transporter-0.2.0-amd64.tar

# ARM64
sudo curl -fL -o /tmp/the-transporter.tar \
  https://github.com/runlevel1977-del/the-transporter/releases/download/v0.2.0/the-transporter-0.2.0-arm64.tar
```

```bash
sudo docker load -i /tmp/the-transporter.tar
sudo docker compose -f /volume1/docker/the-transporter/docker-compose.yml up -d
```

Browser: `http://NAS-IP:21011`

Nur Volume 1: in der YAML die Zeile `- /volume2:/volume2` löschen.

Läuft die Transporter-UPK schon auf 21011: in der YAML `21011` durch `21012` ersetzen.

Die UGOS-Docker-Oberfläche („Projekt erstellen“) lehnt Host-Netz und privileged ab. Deshalb per Compose starten, nicht über die GUI.

Oder automatisch (erkennt AMD/ARM selbst):

```bash
curl -fsSL https://raw.githubusercontent.com/runlevel1977-del/the-transporter/main/install.sh | sh
```

## Stoppen

```bash
sudo docker compose -f /volume1/docker/the-transporter/docker-compose.yml down
```

## Hinweis

Der Container braucht vollen Volume-Zugriff und privileged (Wake-on-LAN). Nur auf dem eigenen NAS testen.
