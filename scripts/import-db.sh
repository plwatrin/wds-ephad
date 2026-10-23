#!/usr/bin/env bash
set -euo pipefail
file="${1:-}"
if [[ -z "$file" || ! -f "$file" ]]; then
  echo "Usage: $0 backups/prieure.sql" >&2
  exit 1
fi
echo "Import into the LOCAL database only. Current local WordPress tables may be overwritten."
read -r -p "Type IMPORT to proceed: " answer
[[ "$answer" == "IMPORT" ]] || { echo "Cancelled"; exit 1; }
docker compose up -d db wordpress
docker compose exec -T db sh -c 'exec mariadb -u"$MARIADB_USER" -p"$MARIADB_PASSWORD" "$MARIADB_DATABASE"' < "$file"
echo "SQL import completed. Then run: make urls"
