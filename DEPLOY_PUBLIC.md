# 公网部署指南

这个项目不是普通的前后端两层结构，而是一个完整的多服务系统：

- 前端：`React + Vite`
- 后端：`Django + Daphne + Channels`
- 推荐服务：`Java gRPC`
- 可用时段服务：`Go gRPC`
- 缓存与 WebSocket：`Redis Cluster + 单独的 Redis channel`
- 数据库：`PostgreSQL 主从`
- 统一入口：`Nginx`

所以最适合它的公网部署方式，不是把前端单独丢到静态托管平台，而是使用一台 Linux 云服务器，用 Docker 把整套服务跑起来，再用域名和 HTTPS 对外提供访问。

## 1. 推荐部署路线

### 适合当前仓库的路线

使用仓库已经准备好的三套 compose：

1. `docker_file/database/cluster/docker-compose.yml`
2. `docker_file/redis/cluster/docker-compose.yml`
3. `docker_file/nginx/load_balancer/docker-compose.yml`

启动顺序：

1. 先启动 PostgreSQL 主从
2. 再启动 Redis 集群
3. 最后启动 Nginx + Django + Java + Go

### 为什么推荐这条路线

- 这条路线和当前代码最匹配
- 不需要重写业务逻辑
- 已经考虑了 `/api/`、`/ws/`、前端静态资源、Django static 的代理问题
- Java 和 Go 服务也已经被纳入容器编排

## 2. 服务器配置建议

因为你当前仓库会跑很多容器，所以不要买太低配置的机器。

### 最低建议

- 系统：`Ubuntu 22.04 LTS` 或 `Ubuntu 24.04 LTS`
- CPU：`4 vCPU`
- 内存：`8 GB`
- 磁盘：`60 GB SSD`

### 更稳妥的建议

- CPU：`4 vCPU` 或 `8 vCPU`
- 内存：`8 GB` 或 `16 GB`

如果你只是为了课程答辩、作品展示、低并发演示，这套架构其实偏重。后续可以再把它裁成单 PostgreSQL + 单 Redis + 单 Django 副本，那样成本会低很多。

## 3. 上线前你需要准备什么

你至少需要准备以下内容：

- 一台有公网 IP 的云服务器
- 一个你自己的域名
- 域名的 `A` 记录指向你的服务器公网 IP
- 服务器已经安装 Docker 和 Docker Compose 插件
- 代码已经上传到服务器

## 4. 在服务器上安装基础环境

下面以 Ubuntu 为例。

### 更新系统

```bash
sudo apt update
sudo apt upgrade -y
```

### 安装基础工具

```bash
sudo apt install -y git curl ca-certificates gnupg lsb-release nginx certbot python3-certbot-nginx
```

### 安装 Docker

如果服务器还没有 Docker，可以直接安装：

```bash
sudo apt install -y docker.io docker-compose-plugin
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER
```

执行完 `usermod` 后，重新登录一次服务器。

### 检查 Docker

```bash
docker --version
docker compose version
```

## 5. 把项目代码放到服务器

如果你用 Git：

```bash
git clone <你的仓库地址>
cd study_room_booking_system
```

如果你不是用 Git，也可以直接把项目目录上传到服务器，然后进入项目根目录。

## 6. 配置域名解析

在你的域名控制台添加 `A` 记录：

- 主机记录：`@`
- 记录值：你的服务器公网 IP

如果你要用子域名，也可以加：

- 主机记录：`www`
- 记录值：你的服务器公网 IP

确认解析生效后，再继续做 HTTPS。

## 7. 修改部署环境变量

你这个项目公网部署最关键的是 3 份环境变量文件：

1. `docker_file/database/cluster/.env`
2. `docker_file/redis/cluster/.env`
3. `docker_file/nginx/load_balancer/.env`

### 7.1 数据库环境变量

参考文件：

- `docker_file/database/cluster/.env.example`

你至少要修改这些内容：

- `POSTGRESQL_PASSWORD`
- `POSTGRESQL_POSTGRES_PASSWORD`
- `POSTGRESQL_REPLICATION_PASSWORD`

不要继续使用仓库里的默认弱密码。

### 7.2 Redis 环境变量

参考文件：

- `docker_file/redis/cluster/.env.example`

你至少要修改：

- `REDIS_PASSWORD`

### 7.3 应用层环境变量

参考文件：

- `docker_file/nginx/load_balancer/.env.example`

你至少要重点修改这些值：

```env
DJANGO_ENV=load_balancer
DEBUG=False
SECRET_KEY=换成你自己的超长随机字符串
NGINX_PUBLIC_PORT=8088
ALLOWED_HOSTS=127.0.0.1,localhost,你的域名,www.你的域名,nginx-load-balancer,studyroom_nginx_load_balancer
CORS_ALLOWED_ORIGINS=https://你的域名,https://www.你的域名
CSRF_TRUSTED_ORIGINS=https://你的域名,https://www.你的域名
USE_X_FORWARDED_HOST=True
USE_SECURE_PROXY_SSL_HEADER=True
SECURE_SSL_REDIRECT=False
SESSION_COOKIE_SECURE=True
CSRF_COOKIE_SECURE=True
DB_PASSWORD=和数据库 .env 保持一致
REDIS_URL=redis://:你的redis密码@redis-channel:6379/0
REDIS_CHANNEL_URL=redis://:你的redis密码@redis-channel:6379/0
REDIS_CHANNEL_HOSTS=redis://:你的redis密码@redis-channel:6379/0
REDIS_CLUSTER_NODES=redis://:你的redis密码@redis-cluster-node-1:7001,redis://:你的redis密码@redis-cluster-node-2:7002,redis://:你的redis密码@redis-cluster-node-3:7003,redis://:你的redis密码@redis-cluster-node-4:7004,redis://:你的redis密码@redis-cluster-node-5:7005,redis://:你的redis密码@redis-cluster-node-6:7006
```

### 7.4 `ALLOWED_HOSTS` 应该怎么写

如果你的域名是 `studyroom.example.com`，建议写成：

```env
ALLOWED_HOSTS=127.0.0.1,localhost,studyroom.example.com,www.studyroom.example.com,nginx-load-balancer,studyroom_nginx_load_balancer
```

### 7.5 `CORS_ALLOWED_ORIGINS` 应该怎么写

如果你最终让浏览器访问的是：

- `https://studyroom.example.com`

那么建议写成：

```env
CORS_ALLOWED_ORIGINS=https://studyroom.example.com,https://www.studyroom.example.com
```

### 7.6 `CSRF_TRUSTED_ORIGINS` 应该怎么写

如果你会通过 HTTPS 访问后台和接口，建议写成：

```env
CSRF_TRUSTED_ORIGINS=https://studyroom.example.com,https://www.studyroom.example.com
```

### 7.7 `SECRET_KEY` 怎么生成

你可以在服务器上生成一个随机值：

```bash
python3 - <<'PY'
import secrets
print(secrets.token_urlsafe(64))
PY
```

把输出结果填进 `SECRET_KEY=`。

## 8. 启动数据库集群

先进入数据库目录：

```bash
cd docker_file/database/cluster
docker compose up -d
```

检查状态：

```bash
docker compose ps
```

你应该能看到：

- `postgres-primary`
- `postgres-replica-1`
- `postgres-replica-2`

## 9. 启动 Redis 集群

进入 Redis 目录：

```bash
cd ../../redis/cluster
docker compose up -d
```

检查状态：

```bash
docker compose ps
```

你应该能看到：

- `redis-channel`
- `redis-cluster-node-1` 到 `redis-cluster-node-6`
- `redis-cluster-init`

## 10. 启动应用层

进入负载均衡目录：

```bash
cd ../nginx/load_balancer
docker compose up -d --build
```

检查状态：

```bash
docker compose ps
```

你应该能看到这些服务：

- `java-recommendation-service`
- `go-availability-service`
- `backend-init`
- `backend-app-1`
- `backend-app-2`
- `backend-app-3`
- `nginx-load-balancer`

## 11. 首次启动后必须做的检查

### 查看应用日志

```bash
cd docker_file/nginx/load_balancer
docker compose logs -f
```

如果只想看 Django：

```bash
docker logs -f studyroom_backend_app_1
```

### 检查能否通过 IP 访问

如果当前 `.env` 里是：

```env
NGINX_PUBLIC_PORT=8088
```

那么你可以先用浏览器访问：

```text
http://你的服务器IP:8088
```

如果这一层都打不开，先不要做 HTTPS，先把容器日志排查通。

## 12. 公网正式访问的推荐做法

我不建议直接把 Docker 里的 `8088` 暴露为最终公网地址。更稳妥的方式是：

1. Docker 里的项目继续跑在 `127.0.0.1:8088`
2. 服务器宿主机再安装一个 `Nginx`
3. 宿主机 Nginx 监听 `80/443`
4. 宿主机 Nginx 反代到 `127.0.0.1:8088`
5. 由宿主机 Nginx 申请 HTTPS 证书

这样更容易做证书续期，也更容易统一管理公网入口。

如果你希望 `8088` 完全不暴露到公网，可以把

- [docker_file/nginx/load_balancer/docker-compose.yml](/Users/mac/Desktop/workplace/windows_version/study_room_booking_system/study_room_booking_system/docker_file/nginx/load_balancer/docker-compose.yml)

里的端口映射改成：

```yaml
ports:
  - "127.0.0.1:${NGINX_PUBLIC_PORT}:80"
```

这样只有宿主机自己能访问 `8088`，外部只能通过 `80/443` 访问宿主机 Nginx。

## 13. 配置宿主机 Nginx 反向代理

先确保 Docker 中的应用端口是本机可访问的。你当前 compose 使用：

```env
NGINX_PUBLIC_PORT=8088
```

然后创建站点配置：

```bash
sudo nano /etc/nginx/sites-available/studyroom
```

填入下面内容，把域名替换成你自己的：

```nginx
server {
    listen 80;
    server_name studyroom.example.com www.studyroom.example.com;

    location / {
        proxy_pass http://127.0.0.1:8088;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}
```

启用站点：

```bash
sudo ln -s /etc/nginx/sites-available/studyroom /etc/nginx/sites-enabled/studyroom
sudo nginx -t
sudo systemctl reload nginx
```

## 14. 申请 HTTPS 证书

域名已经解析到服务器后，执行：

```bash
sudo certbot --nginx -d studyroom.example.com -d www.studyroom.example.com
```

成功后再访问：

```text
https://studyroom.example.com
```

## 15. 服务器防火墙设置

公网服务器只建议开放这些端口：

- `22` 或你自己的 SSH 端口
- `80`
- `443`

不要把这些端口对公网开放：

- `5012`
- `5013`
- `5014`
- `5015`
- `7001` 到 `7006`
- `8088`

如果你使用 `ufw`：

```bash
sudo ufw allow OpenSSH
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable
sudo ufw status
```

如果你在云厂商控制台也有安全组，同样只放行 `22/80/443`。

## 16. 创建 Django 管理员账号

如果你要登录 `/admin/`，需要创建 superuser：

```bash
docker exec -it studyroom_backend_app_1 python manage.py createsuperuser
```

## 17. 导入已有数据库数据

如果你要把本地已有数据迁移到公网，可以把 SQL 备份导入主库。

仓库里已经有一个备份文件：

- `backups/postgres/studyroom_pre_cluster_20260315_205734.sql`

导入示例：

```bash
docker exec -i studyroom_postgres_primary psql -U studyuser -d studyroom < backups/postgres/studyroom_pre_cluster_20260315_205734.sql
```

如果你已经在库里有表和数据，导入前先确认是否需要清空旧数据。

## 18. 如何验证部署成功

至少验证下面这些地址：

- 首页：`https://你的域名`
- Django admin：`https://你的域名/admin/`
- API：`https://你的域名/api/rooms/`
- WebSocket：前端打开支持聊天页面，检查是否能正常建立连接

### 容器检查命令

```bash
docker ps
```

### 实时日志

```bash
docker logs -f studyroom_nginx_load_balancer
docker logs -f studyroom_backend_app_1
docker logs -f studyroom_java_recommendation_service
docker logs -f studyroom_go_availability_service
```

## 19. 常见问题

### 1. 页面能打开，但接口 400 或 403

优先检查：

- `ALLOWED_HOSTS`
- `CORS_ALLOWED_ORIGINS`
- `DEBUG=False` 后是否还有旧配置残留

### 2. 页面能打开，但登录聊天失败

优先检查：

- 宿主机 Nginx 是否把 `Upgrade` 和 `Connection` 头透传了
- Docker 中的 `nginx-load-balancer` 是否正常运行
- Redis channel 是否正常

### 3. 前端能打开，但推荐功能不可用

优先检查：

- `java-recommendation-service` 容器是否存活
- `go-availability-service` 容器是否存活
- `JAVA_RECOMMENDATION_GRPC_TARGET`
- `GO_AVAILABILITY_GRPC_TARGET`

### 4. 数据库连不上

优先检查：

- `postgres-primary` 是否健康
- `DB_PASSWORD` 是否和数据库 `.env` 一致
- 先看 `backend-init` 容器日志

### 5. Redis Cluster 报错

优先检查：

- 六个节点是否全部启动
- `redis-cluster-init` 是否执行成功
- `REDIS_CLUSTER_NODES` 密码和端口是否匹配

## 20. 推荐你的实际操作顺序

如果你现在马上要上线，建议你按这个顺序做：

1. 先买一台 `Ubuntu` 云服务器
2. 先把域名解析到服务器
3. 在服务器上安装 `Docker`、`Nginx`、`Certbot`
4. 上传代码
5. 修改 3 份 `.env`
6. 启动数据库集群
7. 启动 Redis 集群
8. 启动应用层
9. 先用 `http://服务器IP:8088` 验证容器是否正常
10. 再配置宿主机 Nginx 反代
11. 最后申请 HTTPS 证书
12. 验证首页、登录、预订、聊天、推荐功能

## 21. 一句话结论

你这个项目已经具备“放到一台 Linux 服务器上，用 Docker 作为完整后端系统部署到公网”的基础条件。最稳妥的做法是：

- Docker 跑项目
- 宿主机 Nginx 做公网入口
- Certbot 申请 HTTPS
- 域名访问你的站点

如果你想继续下一步，可以直接让我帮你做两件事中的任意一件：

1. 我帮你把这套部署步骤进一步改成“你的真实域名 + 真实服务器”的可执行命令版
2. 我帮你把当前项目裁成一个更省钱、更容易上线的简化生产版
