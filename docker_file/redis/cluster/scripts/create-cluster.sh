#!/bin/sh

# stop on error
set -e

# redis-cli password
export REDISCLI_AUTH="${REDIS_PASSWORD}"

# all cluster nodes
CLUSTER_NODES="redis-cluster-node-1:7001 redis-cluster-node-2:7002 redis-cluster-node-3:7003 redis-cluster-node-4:7004 redis-cluster-node-5:7005 redis-cluster-node-6:7006"

# wait for all nodes
for node in ${CLUSTER_NODES}; do
  # split host and port
  host="$(echo "${node}" | cut -d: -f1)"
  port="$(echo "${node}" | cut -d: -f2)"

  # wait until this node responds
  until redis-cli -h "${host}" -p "${port}" ping >/dev/null 2>&1; do
    sleep 2
  done
done

# skip if the cluster already exists
if redis-cli -h redis-cluster-node-1 -p 7001 cluster info 2>/dev/null | grep -q "cluster_state:ok"; then
  exit 0
fi

# create 3 masters and 3 replicas
yes yes | redis-cli --cluster create ${CLUSTER_NODES} --cluster-replicas 1
