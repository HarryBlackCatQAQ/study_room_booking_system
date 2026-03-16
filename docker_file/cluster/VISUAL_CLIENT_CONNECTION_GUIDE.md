# Database Visual Client Connection Guide

## 1. First conclusion

- `TinyRDM` is a `Redis` client, not a `PostgreSQL` client.
- If you use `TinyRDM` to connect to `PostgreSQL`, the connection will fail by design.
- `PostgreSQL` should be connected with tools such as `pgAdmin`、`DBeaver`、`DataGrip`、`Navicat`、`TablePlus`.
- `Redis` should be connected with tools such as `TinyRDM`、`Redis Insight`、`Another Redis Desktop Manager`.

## 2. Current Docker database topology

### PostgreSQL read-write separation

- Primary: `studyroom_postgres_primary`
- Read Replica 1: `studyroom_postgres_replica_1`
- Read Replica 2: `studyroom_postgres_replica_2`

### Redis

- Channel Redis: `studyroom_redis_channel`
- Redis Cluster Node 1: `studyroom_redis_cluster_node_1`
- Redis Cluster Node 2: `studyroom_redis_cluster_node_2`
- Redis Cluster Node 3: `studyroom_redis_cluster_node_3`
- Redis Cluster Node 4: `studyroom_redis_cluster_node_4`
- Redis Cluster Node 5: `studyroom_redis_cluster_node_5`
- Redis Cluster Node 6: `studyroom_redis_cluster_node_6`

## 3. A very important connection rule

- If your visual client runs directly on your Mac host, `Host` must use `127.0.0.1`.
- Do not use Docker internal service names such as `postgres-primary`、`postgres-replica-1`、`redis-cluster-node-1` in host-side desktop clients.
- The reason is simple: those service names only work inside the Docker network.
- If you later run a visual client in another Docker container on the same network, then you can use Docker service names.

## 4. PostgreSQL connection parameters

### 4.1 Primary database

| Item | Value |
| --- | --- |
| Connection name | `studyroom-postgres-primary` |
| Host | `127.0.0.1` |
| Port | `5012` |
| Database | `studyroom` |
| Username | `studyuser` |
| Password | `study123456` |
| Role | Read + Write |
| SSL Mode | `Disable` |

### 4.2 Read replica 1

| Item | Value |
| --- | --- |
| Connection name | `studyroom-postgres-replica-1` |
| Host | `127.0.0.1` |
| Port | `5014` |
| Database | `studyroom` |
| Username | `studyuser` |
| Password | `study123456` |
| Role | Read Only |
| SSL Mode | `Disable` |

### 4.3 Read replica 2

| Item | Value |
| --- | --- |
| Connection name | `studyroom-postgres-replica-2` |
| Host | `127.0.0.1` |
| Port | `5015` |
| Database | `studyroom` |
| Username | `studyuser` |
| Password | `study123456` |
| Role | Read Only |
| SSL Mode | `Disable` |

## 5. PostgreSQL client setup steps

### 5.1 pgAdmin / DBeaver / DataGrip / Navicat / TablePlus general steps

1. Create a new connection.
2. Select `PostgreSQL`.
3. Fill in `Host`、`Port`、`Database`、`Username`、`Password` with the values above.
4. If the client has an `SSL` option, set it to `Disable`.
5. Click `Test Connection` first.
6. Save the connection after the test succeeds.

### 5.2 pgAdmin extra note

- `Maintenance database` can use `postgres` or `studyroom`.
- After connecting, browse the actual business tables under `Schemas -> public -> Tables`.

### 5.3 DBeaver extra note

- In the driver page, keep the default `PostgreSQL` driver.
- If DBeaver asks whether to download the driver, click confirm.
- If the connection fails on the first try, open the driver properties and keep SSL disabled.

### 5.4 DataGrip extra note

- `User` is `studyuser`.
- `Database` is `studyroom`.
- `URL` can be filled automatically, or use `jdbc:postgresql://127.0.0.1:5012/studyroom`.
- The two read replicas only differ by port: `5014` and `5015`.

## 6. PostgreSQL connection verification SQL

### 6.1 Check whether the current node is primary or replica

```sql
select pg_is_in_recovery();
```

- Return `false`: this node is the primary database.
- Return `true`: this node is a read replica.

### 6.2 Check whether the current session is read only

```sql
show transaction_read_only;
```

### 6.3 Check core data volume

```sql
select 'users' as table_name, count(*) as total from users_user
union all
select 'bookings' as table_name, count(*) as total from bookings_booking
union all
select 'reviews' as table_name, count(*) as total from reviews_review;
```

## 7. Redis connection parameters

### 7.1 Redis channel instance

| Item | Value |
| --- | --- |
| Connection name | `studyroom-redis-channel` |
| Mode | `Standalone` |
| Host | `127.0.0.1` |
| Port | `5013` |
| Password | `studyredis123456` |
| Database index | `0` |

### 7.2 Redis Cluster

| Item | Value |
| --- | --- |
| Connection name | `studyroom-redis-cluster` |
| Mode | `Cluster` |
| Password | `studyredis123456` |
| Seed Node 1 | `127.0.0.1:7001` |
| Seed Node 2 | `127.0.0.1:7002` |
| Seed Node 3 | `127.0.0.1:7003` |
| Seed Node 4 | `127.0.0.1:7004` |
| Seed Node 5 | `127.0.0.1:7005` |
| Seed Node 6 | `127.0.0.1:7006` |

## 8. TinyRDM setup steps

### 8.1 What TinyRDM can and cannot do

- TinyRDM can connect to `Redis`.
- TinyRDM cannot connect to `PostgreSQL`.
- If you want to see `PostgreSQL` tables, switch to `pgAdmin` or `DBeaver`.

### 8.2 Connect TinyRDM to the channel Redis

1. Create a new connection.
2. Select `Standalone`.
3. Fill in `Host = 127.0.0.1`.
4. Fill in `Port = 5013`.
5. Fill in `Password = studyredis123456`.
6. Save and connect.

### 8.3 Connect TinyRDM to the Redis Cluster

1. Create a new connection.
2. Select `Cluster Mode`.
3. Fill in `Password = studyredis123456`.
4. Add at least one seed node such as `127.0.0.1:7001`.
5. If the client allows multiple seed nodes, add `7001` to `7006` all together.
6. Save and connect.

### 8.4 If your TinyRDM shows only part of the keys

- This usually means you connected a cluster node in `Standalone` mode.
- Recreate the connection in `Cluster Mode`.
- If you only inspect a single cluster node in standalone mode, you will only see the hash slots owned by that node.

## 9. Redis Insight / Another Redis Desktop Manager setup steps

### 9.1 Connect to channel Redis

- Use `Standalone` mode.
- Host: `127.0.0.1`
- Port: `5013`
- Password: `studyredis123456`

### 9.2 Connect to Redis Cluster

- Use `Cluster` mode.
- Seed node can start from `127.0.0.1:7001`.
- If the UI supports multiple nodes, add `127.0.0.1:7001` to `127.0.0.1:7006`.
- Password remains `studyredis123456`.

## 10. Common failure reasons

### 10.1 TinyRDM cannot connect to PostgreSQL

- This is expected.
- TinyRDM is not a PostgreSQL client.

### 10.2 You used the wrong host

- If your GUI is running on your Mac host, use `127.0.0.1`.
- Do not use `postgres-primary` or `redis-cluster-node-1`.

### 10.3 SSL was enabled by the GUI by default

- The current Docker compose does not configure PostgreSQL TLS certificates.
- Set PostgreSQL client SSL mode to `Disable`.

### 10.4 You are trying to write on a replica

- Ports `5014` and `5015` are read replicas.
- Insert, update, and delete operations can fail there by design.
- Write operations must go to `5012`.

### 10.5 Redis Cluster connected in the wrong mode

- `5013` is standalone Redis for Channels.
- `7001` to `7006` are Redis Cluster nodes.
- Standalone mode and cluster mode cannot be mixed.

## 11. One-click connection profile list

### PostgreSQL

- `studyroom-postgres-primary`: `127.0.0.1:5012`
- `studyroom-postgres-replica-1`: `127.0.0.1:5014`
- `studyroom-postgres-replica-2`: `127.0.0.1:5015`

### Redis

- `studyroom-redis-channel`: `127.0.0.1:5013`
- `studyroom-redis-cluster`: `127.0.0.1:7001,7002,7003,7004,7005,7006`

## 12. Current verified port status

- `127.0.0.1:5012` is open
- `127.0.0.1:5013` is open
- `127.0.0.1:5014` is open
- `127.0.0.1:5015` is open
- `127.0.0.1:7001` is open
- `127.0.0.1:7002` is open
- `127.0.0.1:7003` is open
- `127.0.0.1:7004` is open
- `127.0.0.1:7005` is open
- `127.0.0.1:7006` is open

## 13. Reference links

- TinyRDM official site: <https://redis.tinycraft.cc/>
- TinyRDM GitHub: <https://github.com/tiny-craft/tiny-rdm>
