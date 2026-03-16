# Storage Cluster Setup

## PostgreSQL read-write separation

- Use `docker_file/database/cluster/docker-compose.yml` to start one primary node and two read replicas.
- The primary node is exposed on `5012`.
- The read replica nodes are exposed on `5014` and `5015`.
- Django writes stay on the primary node and safe HTTP reads can be routed to the replicas.

## Redis cache cluster

- Use `docker_file/redis/cluster/docker-compose.yml` to start a six-node Redis Cluster for cache traffic.
- The cache cluster nodes are exposed on `7001` to `7006`.
- A dedicated standalone Redis instance is still exposed on `5013` for the existing Channels websocket layer.
- Django cache traffic uses the Redis Cluster backend and websocket traffic keeps using the standalone channel Redis.

## Backend environment example

- Use `backend/.env.cluster.example` as the reference when you want the local Django process to talk to the Docker storage cluster.
- The example keeps the current project ports and adds the address remap needed for Redis Cluster replies when Django runs outside Docker.

## Visual client connection guide

- Use `docker_file/cluster/VISUAL_CLIENT_CONNECTION_GUIDE.md` when you want to connect `PostgreSQL` and `Redis` from `pgAdmin`、`DBeaver`、`DataGrip`、`Navicat`、`TablePlus`、`TinyRDM` or similar desktop tools.

## Nginx load balancer

- Use `docker_file/nginx/load_balancer/docker-compose.yml` to start one `Nginx` load balancer and three replicated `Django ASGI` backend containers.
- Use `docker_file/nginx/load_balancer/README.md` when you want the full deployment steps and access addresses for the dockerized load balancer stack.
