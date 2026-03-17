#!/bin/sh

# stop on error
set -eu

# keep the primary database target explicit
PRIMARY_DB_HOST="${DB_HOST:-postgres-primary}"
PRIMARY_DB_PORT="${DB_PORT:-5432}"

# wait for the primary database before running django setup work
python /opt/studyroom/scripts/wait_for_tcp.py "${PRIMARY_DB_HOST}" "${PRIMARY_DB_PORT}" 180

# apply the django schema changes on the primary database
python manage.py migrate --noinput

# collect static files for the edge nginx container
python manage.py collectstatic --noinput

# keep a final django config check in the init step
python manage.py check
