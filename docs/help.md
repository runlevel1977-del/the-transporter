# The Transporter — Hilfe

Docker-App für UGREEN-NAS: Explorer, Übertragungen, Wake & Sync, Backup.

**Support:** [Issues](https://github.com/runlevel1977-del/the-transporter/issues) · runlevel1977@posteo.de  
**Windows-Werkzeug:** [Ugreen NAS Admin](https://github.com/runlevel1977-del/UgreenNASAdmin)

## Installation

Siehe [INSTALL.txt](../INSTALL.txt). Start per SSH und `docker compose`, nicht über die UGOS-Docker-GUI.

Browser: `http://NAS-IP:21011` (oder `:21012`, wenn die Transporter-UPK den Port 21011 schon nutzt).

## Bedienung

1. **Verbindungen** — dieses NAS ist schon da. Weitere Geräte per SMB (Host, Freigabe, Benutzer, Passwort). MAC nur für Wake-on-LAN.
2. **Explorer** — zwei Fenster, kopieren / verschieben / löschen, neuer Ordner, Größen.
3. **Übertragungen** — Quelle → Ziel, Sync oder Move, optional Zeitplan.
4. **Wake & Sync** — Ziel mit MAC wird bei Bedarf geweckt, dann synchronisiert.
5. **Backup** — Archive (`.tar.gz`) am Ziel ablegen. Zeitplan wie bei Wake. Optional Passwortschutz.
6. **Zeitpläne** — Jobs ein- und ausschalten.
7. **Protokolle** — Start, Ende und übertragene Menge.
8. **Update** — unten links. Prüft GitHub und zeigt, ob eine neuere Version da ist. Installieren bleibt per SSH (`docker load`), kein Selbst-Update über den Docker-Socket.

## Hinweise

- Host-Netz und privileged sind nötig (Volumes, Wake-on-LAN).
- Bei der Installation bindet `patch-volumes.sh` alle gemounteten NAS-Volumes (`/volume1` … `/volume8`) ein. Extra-Zeilen in der YAML sind nicht nötig.
- Jobs und Passwörter liegen in `state.json` im Docker-Datenordner.
- Beim ersten Öffnen ein Passwort setzen. Danach nur mit diesem Passwort.
- Ordner mit `@` (z. B. `@docker`, `@eadir`) sind sichtbar, aber nur lesbar. Overlay/Proc in `@docker` wird nicht durchwandert.
- Läuft die Transporter-UPK parallel mit denselben Zeitplänen, starten Jobs doppelt.
