#!/bin/sh
# Bindet alle gemounteten NAS-Volumes (/volume1 … /volume8) in die Compose-YAML.
# Nur echte Mountpoints — fehlende Volumes werden nicht angelegt.
set -e

FILE=${1:-/volume1/docker/the-transporter/docker-compose.yml}

if [ "$(id -u)" -ne 0 ]; then
  exec sudo sh "$0" "$FILE"
fi

if [ ! -f "$FILE" ]; then
  echo "Keine docker-compose.yml: $FILE" >&2
  exit 1
fi

list_nas_volumes() {
  i=1
  while [ "$i" -le 8 ]; do
    mp="/volume$i"
    if [ -r /proc/mounts ] && awk -v p="$mp" '$2==p { found=1; exit } END { exit !found }' /proc/mounts; then
      printf '%s ' "$i"
    elif command -v mountpoint >/dev/null 2>&1 && mountpoint -q "$mp"; then
      printf '%s ' "$i"
    fi
    i=$((i + 1))
  done
}

VOLS=$(list_nas_volumes)
VOLS=$(printf '%s' "$VOLS" | tr -s ' ' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

if [ -z "$VOLS" ]; then
  echo "Keine gemounteten /volume1 … /volume8 gefunden — YAML unverändert."
  exit 0
fi

tmp="${FILE}.tmp.$$"
awk -v VOLS="$VOLS" '
function is_vol_bind(s) {
  return s ~ /^[ \t]*-[ \t]*\/volume[1-8]:\/volume[1-8][ \t]*$/
}
{
  raw = $0
  sub(/\r$/, "", raw)
  if (is_vol_bind(raw)) next
  print raw
  if (!done && raw ~ /^[ \t]*volumes:[ \t]*$/) {
    n = split(VOLS, a, /[ \t]+/)
    for (i = 1; i <= n; i++) {
      if (a[i] ~ /^[1-8]$/) {
        print "      - /volume" a[i] ":/volume" a[i]
      }
    }
    done = 1
  }
}
END {
  if (!done) {
    exit 2
  }
}
' "$FILE" > "$tmp"

if [ ! -s "$tmp" ]; then
  rm -f "$tmp"
  echo "YAML-Patch fehlgeschlagen." >&2
  exit 1
fi

mv "$tmp" "$FILE"

out=""
for n in $VOLS; do
  out="$out /volume$n"
done
echo "Volumes eingebunden:$out"
