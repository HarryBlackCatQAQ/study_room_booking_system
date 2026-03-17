# public server docker stack

## 1. what this stack includes

- `nginx-load-balancer`: the only public entry container
- `frontend-app`: the built react frontend container
- `backend-app-1` and `backend-app-2`: two django containers behind nginx
- `java-recommendation-service`: the java grpc service
- `go-availability-service`: the go grpc service
- `postgres-primary`, `postgres-replica-1`, `postgres-replica-2`: the postgresql read-write split cluster
- `redis-cluster-node-1` to `redis-cluster-node-6`: the redis cluster

## 2. why this fits the current code

- the frontend still talks to `/api/` through nginx
- django still uses `backend/config/database/router.py` for read-write separation
- django still uses `backend/config/cache/redis_cluster.py` for redis cluster access
- the java and go services still stay internal and are only called by django through grpc

## 3. files you need

- compose file: `docker_file/public_server/docker-compose.yml`
- env template: `docker_file/public_server/.env.example`
- nginx config: `docker_file/public_server/nginx/templates/studyroom.conf.template`
- backend scripts: `docker_file/public_server/scripts`

## 4. first-time setup

```bash
cd docker_file/public_server
cp .env.example .env
```

If you want to keep the current project defaults, the generated `.env` already matches:

- domain: `ttz3305012.uk`
- frontend public api base url: `http://ttz3305012.uk`
- database user and passwords from the current project files
- redis password from the current project files

If you still want to change anything later, edit `.env` and replace at least these values:

- `NGINX_SERVER_NAME`
- `ALLOWED_HOSTS`
- `CORS_ALLOWED_ORIGINS`
- `CSRF_TRUSTED_ORIGINS`
- `SECRET_KEY`
- `POSTGRESQL_PASSWORD`
- `POSTGRESQL_POSTGRES_PASSWORD`
- `POSTGRESQL_REPLICATION_PASSWORD`
- `REDIS_PASSWORD`

## 5. start the full public stack

```bash
cd docker_file/public_server
docker compose up -d --build
```

## 6. check the stack

```bash
cd docker_file/public_server
docker compose ps
docker compose logs -f nginx-load-balancer
```

## 7. stop the stack

```bash
cd docker_file/public_server
docker compose down
```

## 8. notes

- this stack only publishes nginx to the host
- postgresql, redis, django, and grpc stay on internal docker networks
- the django admin entry stays on `/manage/` because that is how the current project routes it
- the default public domain in this deployment directory is `ttz3305012.uk`
- if you want secure cookies, first terminate https in nginx and then set `SESSION_COOKIE_SECURE=True` and `CSRF_COOKIE_SECURE=True`
