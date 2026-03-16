#!/bin/sh

# stop the script as soon as any command fails
set -e

# share the redis password with redis-cli commands
export REDISCLI_AUTH="${REDIS_PASSWORD}"

# keep the cluster node list in one variable for reuse
CLUSTER_NODES="redis-cluster-node-1:7001 redis-cluster-node-2:7002 redis-cluster-node-3:7003 redis-cluster-node-4:7004 redis-cluster-node-5:7005 redis-cluster-node-6:7006"

# wait for every redis node to respond before creating the cluster
for node in ${CLUSTER_NODES}; do
  # split the node entry into host and port
  host="$(echo "${node}" | cut -d: -f1)"
  port="$(echo "${node}" | cut -d: -f2)"

  # poll the node until redis reports that it is ready
  until redis-cli -h "${host}" -p "${port}" ping >/dev/null 2>&1; do
    sleep 2
  done
done

# exit early when the cluster has already been created
if redis-cli -h redis-cluster-node-1 -p 7001 cluster info 2>/dev/null | grep -q "cluster_state:ok"; then
  exit 0
fi

# create the redis cluster with three masters and three replicas
yes yes | redis-cli --cluster create ${CLUSTER_NODES} --cluster-replicas 1
