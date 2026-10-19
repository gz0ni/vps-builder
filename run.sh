#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

if [[ ! -f .env ]]; then
  echo "Файл .env не найден. Скопируйте .env.example в .env и заполните значения." >&2
  exit 1
fi

set -a
# Strip CRLF: .env may be edited on Windows
tmp="$(mktemp "${TMPDIR:-/tmp}/vps-builder.XXXXXX")"
trap 'rm -f "$tmp"' EXIT
tr -d '\r' < .env > "$tmp"
source "$tmp"
set +a
rm -f "$tmp"
trap - EXIT

: "${VPS_HOST:?VPS_HOST не задан в .env}"
: "${VPS_USER:?VPS_USER не задан в .env}"
: "${VPS_PASSWORD:?VPS_PASSWORD не задан в .env}"
: "${DOMAIN_NAME:?DOMAIN_NAME не задан в .env}"
: "${ADMIN_EMAIL:?ADMIN_EMAIL не задан в .env}"
: "${NODE_SECRET_KEY:?NODE_SECRET_KEY не задан в .env}"

exec ansible-playbook -i hosts.ini playbook.yml "$@"
