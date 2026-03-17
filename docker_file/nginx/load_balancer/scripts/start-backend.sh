#!/bin/sh

# stop on error
set -eu

# primary database
PRIMARY_DB_HOST="${DB_HOST:-postgres-primary}"
PRIMARY_DB_PORT="${DB_PORT:-5432}"

# app port
APP_PORT="${BACKEND_APP_PORT:-8000}"

# wait for database
python /opt/studyroom/scripts/wait_for_tcp.py "${PRIMARY_DB_HOST}" "${PRIMARY_DB_PORT}" 180

# start daphne
exec daphne -b 0.0.0.0 -p "${APP_PORT}" config.asgi:application
