#!/usr/bin/env bash
set -euo pipefail
if [[ ! -f .env ]]; then echo "Run make init and edit .env first." >&2; exit 1; fi
set -a
# shellcheck disable=SC1091
source .env
set +a
: "${WP_BASE_URL:?Set WP_BASE_URL}"
: "${WP_ADMIN_USER:?Set WP_ADMIN_USER}"
: "${WP_ADMIN_PASSWORD:?Set WP_ADMIN_PASSWORD}"
: "${WP_ADMIN_EMAIL:?Set WP_ADMIN_EMAIL}"
if [[ "$WP_BASE_URL" != http://localhost:* ]]; then
  echo "Local installation only: set WP_BASE_URL=http://localhost:<port>." >&2
  exit 1
fi
docker compose up -d db wordpress
docker compose --profile tools run --rm wpcli core multisite-install \
  --url="$WP_BASE_URL" --title="WDS EHPAD" --admin_user="$WP_ADMIN_USER" \
  --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" \
  --skip-email
echo "Installed. Next: make network-sites"
