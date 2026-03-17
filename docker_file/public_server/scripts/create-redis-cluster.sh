#!/bin/sh

# stop on error
set -eu

# keep redis-cli authenticated for every cluster command
export REDISCLI_AUTH="${REDIS_PASSWORD}"

# keep all redis cluster nodes explicit for the one-time init step
CLUSTER_NODES="redis-cluster-node-1:7001 redis-cluster-node-2:7002 redis-cluster-node-3:7003 redis-cluster-node-4:7004 redis-cluster-node-5:7005 redis-cluster-node-6:7006"

# wait until every redis node responds before attempting cluster creation
for node in ${CLUSTER_NODES}; do
    host="$(echo "${node}" | cut -d: -f1)"
    port="$(echo "${node}" | cut -d: -f2)"

    until redis-cli -h "${host}" -p "${port}" ping >/dev/null 2>&1; do
        sleep 2
    done
done

# skip the cluster creation if it already exists
if redis-cli -h redis-cluster-node-1 -p 7001 cluster info 2>/dev/null | grep -q "cluster_state:ok"; then
    exit 0
fi

# create 3 masters and 3 replicas for the redis cluster
redis-cli --cluster create ${CLUSTER_NODES} --cluster-replicas 1 --cluster-yes
