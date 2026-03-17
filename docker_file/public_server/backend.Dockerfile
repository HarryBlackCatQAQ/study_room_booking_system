# keep the backend runtime on python 3.13 to match the current project
FROM python:3.13-slim

# keep python output unbuffered and avoid `.pyc` noise in the container
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# keep the backend application root explicit
WORKDIR /app

# copy the backend dependency manifest first for better docker cache reuse
COPY backend/requirements.txt /tmp/requirements.txt

# install the backend dependencies and the production wsgi server
RUN pip install --no-cache-dir -r /tmp/requirements.txt \
    && pip install --no-cache-dir gunicorn

# copy the full django backend source code into the image
COPY backend /app

# copy the shared backend startup helpers into a stable path
COPY docker_file/public_server/scripts /opt/studyroom/scripts

# keep the helper shell scripts executable
RUN chmod +x /opt/studyroom/scripts/run-backend-init.sh /opt/studyroom/scripts/start-backend.sh

# document the internal backend listening port
EXPOSE 8000

# keep the default command aligned with the backend app services
CMD ["/bin/sh", "/opt/studyroom/scripts/start-backend.sh"]
