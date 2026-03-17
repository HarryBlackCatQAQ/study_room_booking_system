#!/bin/sh

# stop on error
set -eu

# keep the primary database target explicit
PRIMARY_DB_HOST="${DB_HOST:-postgres-primary}"
PRIMARY_DB_PORT="${DB_PORT:-5432}"

# keep one redis cluster bootstrap node explicit for startup checks
REDIS_BOOTSTRAP_HOST="${REDIS_BOOTSTRAP_HOST:-redis-cluster-node-1}"
REDIS_BOOTSTRAP_PORT="${REDIS_BOOTSTRAP_PORT:-7001}"

# keep the backend port explicit for gunicorn
APP_PORT="${BACKEND_APP_PORT:-8000}"

# wait for the primary database before starting gunicorn
python /opt/studyroom/scripts/wait_for_tcp.py "${PRIMARY_DB_HOST}" "${PRIMARY_DB_PORT}" 180

# wait for one redis cluster node before serving requests
python /opt/studyroom/scripts/wait_for_tcp.py "${REDIS_BOOTSTRAP_HOST}" "${REDIS_BOOTSTRAP_PORT}" 120

# wait for the java grpc dependency
JAVA_GRPC_TARGET="${JAVA_RECOMMENDATION_GRPC_TARGET:-java-recommendation-service:5101}"
JAVA_GRPC_HOST="${JAVA_GRPC_TARGET%:*}"
JAVA_GRPC_PORT="${JAVA_GRPC_TARGET##*:}"
python /opt/studyroom/scripts/wait_for_tcp.py "${JAVA_GRPC_HOST}" "${JAVA_GRPC_PORT}" 120

# wait for the go grpc dependency
GO_GRPC_TARGET="${GO_AVAILABILITY_GRPC_TARGET:-go-availability-service:5102}"
GO_GRPC_HOST="${GO_GRPC_TARGET%:*}"
GO_GRPC_PORT="${GO_GRPC_TARGET##*:}"
python /opt/studyroom/scripts/wait_for_tcp.py "${GO_GRPC_HOST}" "${GO_GRPC_PORT}" 120

# start the production django wsgi server
exec gunicorn config.wsgi:application \
    --bind "0.0.0.0:${APP_PORT}" \
    --workers "${GUNICORN_WORKERS:-3}" \
    --threads "${GUNICORN_THREADS:-2}" \
    --timeout "${GUNICORN_TIMEOUT:-120}"
