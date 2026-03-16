#!/bin/sh

# stop on the first command failure so partial initialization does not continue
set -eu

# keep the primary postgres host explicit and configurable from compose
PRIMARY_DB_HOST="${DB_HOST:-postgres-primary}"

# keep the primary postgres port explicit and configurable from compose
PRIMARY_DB_PORT="${DB_PORT:-5432}"

# wait until the primary postgres node accepts tcp connections
python /opt/studyroom/scripts/wait_for_tcp.py "${PRIMARY_DB_HOST}" "${PRIMARY_DB_PORT}" 180

# run django migrations once against the primary database before app replicas start
python manage.py migrate --noinput

# collect django static files into the shared volume so nginx can serve them directly
python manage.py collectstatic --noinput

# run django system checks once so container startup fails early on configuration errors
python manage.py check
