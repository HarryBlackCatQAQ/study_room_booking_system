# Nginx Load Balancer Setup

## 1. What this stack does

- This stack starts `1` nginx load balancer container.
- This stack starts `3` replicated Django ASGI backend containers.
- This stack starts `1` Java gRPC recommendation service container.
- This stack starts `1` Go gRPC availability service container.
- Nginx load balances `/api/` requests across the three backend containers.
- Nginx also proxies `/ws/` websocket traffic for the support chat feature.
- Nginx serves the built React frontend directly.
- Nginx serves Django collected static files directly.

## 2. Why this implementation fits the current project

- It keeps the existing Django business code unchanged.
- It reuses the current PostgreSQL read-write separation implementation.
- It reuses the current Redis Cluster and standalone channel Redis implementation.
- It now dockerizes the Java and Go computation microservices as internal gRPC services.
- It keeps all new deployment logic inside `docker_file/nginx/load_balancer`.
- It keeps Java and Go outside database access, exactly as your project currently expects.

## 3. Deployment prerequisites

- The PostgreSQL read-write separation stack must already be running.
- The Redis Cluster stack must already be running.
- The external docker networks used by those stacks must already exist:
  - `cluster_default`
  - `cluster_redis_cluster_net`

## 4. Main files

- Compose file: `docker_file/nginx/load_balancer/docker-compose.yml`
- Backend image: `docker_file/nginx/load_balancer/backend.Dockerfile`
- Nginx image: `docker_file/nginx/load_balancer/nginx.Dockerfile`
- Nginx config: `docker_file/nginx/load_balancer/nginx/nginx.conf`
- Nginx site template: `docker_file/nginx/load_balancer/nginx/templates/studyroom.conf.template`
- Backend init script: `docker_file/nginx/load_balancer/scripts/run-init.sh`
- Backend start script: `docker_file/nginx/load_balancer/scripts/start-backend.sh`

## 5. Start the stack

```bash
cd docker_file/nginx/load_balancer
docker compose up -d --build
```

## 6. Stop the stack

```bash
cd docker_file/nginx/load_balancer
docker compose down
```

## 7. Access addresses

- Frontend and load balancer entry: `http://127.0.0.1:8088`
- Django admin through nginx: `http://127.0.0.1:8088/admin/`
- API through nginx: `http://127.0.0.1:8088/api/`
- WebSocket through nginx: `ws://127.0.0.1:8088/ws/support/student/`
- Internal Java gRPC service: `java-recommendation-service:5101`
- Internal Go gRPC service: `go-availability-service:5102`

## 8. Validation ideas

- Open `http://127.0.0.1:8088` in the browser.
- Refresh the page several times and inspect nginx logs.
- Call `/api/rooms/` several times and inspect backend container logs.
- Open support chat and verify `/ws/` traffic upgrades successfully.

## 9. Notes

- This stack uses `Daphne` instead of `runserver`.
- This stack does not require business view changes.
- This stack exposes only nginx to the host.
- The three backend containers stay internal behind nginx.
- The Java and Go gRPC services also stay internal behind the docker application network.
