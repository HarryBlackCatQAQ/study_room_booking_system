#!/bin/sh

# stop on the first command failure so unhealthy app containers exit quickly
set -eu

# keep the primary postgres host explicit and configurable from compose
PRIMARY_DB_HOST="${DB_HOST:-postgres-primary}"

# keep the primary postgres port explicit and configurable from compose
PRIMARY_DB_PORT="${DB_PORT:-5432}"

# keep the backend app port explicit and configurable from compose
APP_PORT="${BACKEND_APP_PORT:-8000}"

# wait until the primary postgres node accepts tcp connections before starting daphne
python /opt/studyroom/scripts/wait_for_tcp.py "${PRIMARY_DB_HOST}" "${PRIMARY_DB_PORT}" 180

# start the django asgi application server that handles both http and websocket traffic
exec daphne -b 0.0.0.0 -p "${APP_PORT}" config.asgi:application
