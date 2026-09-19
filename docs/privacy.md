# The Transporter — Datenschutzerklärung

**Anbieter:** Ivica Kampic / Runlevel  
**E-Mail:** runlevel1977@posteo.de  
**Anschrift:** Ivica Kampic, Runlevel, Leipziger Str. 33, 89537 Giengen, Deutschland  
**Stand:** 19. September 2026

The Transporter läuft lokal auf deinem UGREEN-NAS. Runlevel betreibt keine Cloud und erhält deine Dateien nicht.

## Was gespeichert wird

Nur auf dem NAS, im Datenordner der App (`state.json`):

- SMB-Geräte: Name, Host, Freigabe, Benutzer, Passwort, optionale MAC-Adresse
- Jobs (Übertragung, Wake & Sync, Backup): Pfade, Zeitpläne, optionales Archiv-Passwort
- Protokolle: Start/Ende von Jobs, übertragene Menge — keine Passwörter

Es gibt keine Übermittlung an Runlevel. Dateien werden nur dorthin kopiert, wo du Quelle und Ziel selbst setzt (NAS-Volumes oder SMB-Geräte im LAN).

Beim ersten Öffnen kannst du der Speicherung von Zugangsdaten zustimmen oder ablehnen. Ablehnen: lokale Kopien funktionieren weiter, SMB- und Archiv-Passwörter bleiben leer.

## Rechte (DSGVO)

Auskunft, Berichtigung, Löschung, Einschränkung, Widerspruch, Datenübertragbarkeit, Beschwerde bei einer Aufsichtsbehörde. Daten löschen: Jobs/Geräte in der App entfernen oder den Docker-Datenordner bzw. den Container löschen.

Kontakt: runlevel1977@posteo.de
