#!/usr/bin/env bash
set -euo pipefail
docker compose up -d db wordpress
# The archived site may use both www and non-www URLs.
cli=(docker compose --profile tools run --rm wpcli)
"${cli[@]}" wp option update home 'http://localhost:8080'
"${cli[@]}" wp option update siteurl 'http://localhost:8080'
echo "Replace serialized URLs safely using WP-CLI (not raw SQL)."
"${cli[@]}" wp search-replace 'https://www.laresidenceleprieure.fr' 'http://localhost:8080' --all-tables-with-prefix --skip-columns=guid
"${cli[@]}" wp search-replace 'http://www.laresidenceleprieure.fr' 'http://localhost:8080' --all-tables-with-prefix --skip-columns=guid
"${cli[@]}" wp search-replace 'https://laresidenceleprieure.fr' 'http://localhost:8080' --all-tables-with-prefix --skip-columns=guid
"${cli[@]}" wp search-replace 'http://laresidenceleprieure.fr' 'http://localhost:8080' --all-tables-with-prefix --skip-columns=guid
echo "Done. Check site at http://localhost:8080 (WP_PORT must remain 8080 for this script)."
