#!/bin/sh

# stop on error
set -eu

# primary database
PRIMARY_DB_HOST="${DB_HOST:-postgres-primary}"
PRIMARY_DB_PORT="${DB_PORT:-5432}"

# wait for database
python /opt/studyroom/scripts/wait_for_tcp.py "${PRIMARY_DB_HOST}" "${PRIMARY_DB_PORT}" 180

# run migrations
python manage.py migrate --noinput

# collect static files
python manage.py collectstatic --noinput

# django health check
python manage.py check
