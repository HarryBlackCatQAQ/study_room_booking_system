# keep the backend runtime on python 3.13 to match the local development environment
FROM python:3.13-slim

# keep python output unbuffered and avoid `.pyc` noise inside the container
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# keep the backend application root consistent across scripts and compose files
WORKDIR /app

# copy the backend dependency manifest first so docker layer caching works well
COPY backend/requirements.txt /tmp/requirements.txt

# install the backend python dependencies used by django, daphne, and grpc
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# copy the full django backend source code into the container image
COPY backend /app

# copy the shared backend startup and health scripts into a stable path
COPY docker_file/nginx/load_balancer/scripts /opt/studyroom/scripts

# keep the helper shell scripts executable for compose commands
RUN chmod +x /opt/studyroom/scripts/run-init.sh /opt/studyroom/scripts/start-backend.sh

# document the internal daphne listening port used by nginx upstreams
EXPOSE 8000

# keep the default container command aligned with the backend app service startup
CMD ["/bin/sh", "/opt/studyroom/scripts/start-backend.sh"]
