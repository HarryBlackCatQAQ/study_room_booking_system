from urllib.parse import urlparse

from django.core.cache.backends.base import DEFAULT_TIMEOUT
from django.core.cache.backends.redis import RedisCache, RedisSerializer
from django.utils.functional import cached_property
from django.utils.module_loading import import_string
from redis.cluster import ClusterNode, RedisCluster


# Build a Redis Cluster address remap function from a simple environment string.
def build_address_remap(address_remap_rules):
    # Ignore empty remap rules so the default client behavior stays unchanged.
    if not address_remap_rules:
        return None

    # Keep the parsed remap rules in a dictionary keyed by the announced node address.
    parsed_rules = {}

    # Split the raw rule list and ignore empty items.
    for raw_rule in [item.strip() for item in str(address_remap_rules).split(",") if item.strip()]:
        # Split one rule into source and target addresses.
        source_address, target_address = raw_rule.split("=")

        # Split the source address into host and port.
        source_host, source_port = source_address.rsplit(":", 1)

        # Split the target address into host and port.
        target_host, target_port = target_address.rsplit(":", 1)

        # Store the remap rule in normalized tuple form.
        parsed_rules[(source_host, int(source_port))] = (target_host, int(target_port))

    # Return the callback expected by redis-py.
    def address_remap(address):
        return parsed_rules.get(address, address)

    return address_remap


# Parse one Redis startup node URL into host, port, and shared connection options.
def parse_cluster_server(server):
    # Normalize plain host:port values into redis URLs before parsing.
    normalized_server = server if "://" in server else f"redis://{server}"

    # Parse the normalized URL.
    parsed_server = urlparse(normalized_server)

    # Build the cluster node object used by redis-py.
    startup_node = ClusterNode(
        host=parsed_server.hostname or "127.0.0.1",
        port=parsed_server.port or 6379,
    )

    # Build the shared connection options extracted from the URL.
    connection_options = {
        "username": parsed_server.username,
        "password": parsed_server.password,
        "ssl": parsed_server.scheme == "rediss",
    }

    return startup_node, connection_options


class RedisClusterCacheClient:
    # Initialize the Redis Cluster client wrapper used by Django's cache backend.
    def __init__(self, servers, serializer=None, **options):
        # Keep the configured startup node list.
        self._servers = [server for server in servers if server]

        # Resolve a serializer import path when one is provided as a string.
        if isinstance(serializer, str):
            serializer = import_string(serializer)

        # Instantiate callable serializers so the cache client can use them directly.
        if callable(serializer):
            serializer = serializer()

        # Fall back to Django's default Redis serializer when no custom serializer is provided.
        self._serializer = serializer or RedisSerializer()

        # Keep the raw client options for the lazy client initialization step.
        self._options = options

    # Build the shared Redis Cluster client only when the cache is first used.
    @cached_property
    def client(self):
        # Parse every configured startup node URL.
        parsed_servers = [parse_cluster_server(server) for server in self._servers]

        # Extract the startup node objects from the parsed server metadata.
        startup_nodes = [startup_node for startup_node, _ in parsed_servers]

        # Copy the raw options so they can be adjusted safely.
        client_options = dict(self._options)

        # Convert the optional address remap string into a callback.
        address_remap = build_address_remap(client_options.pop("address_remap", ""))

        # Remove the serializer option before passing the options to redis-py.
        client_options.pop("serializer", None)

        # Merge the shared connection options from the first configured node.
        if parsed_servers:
            first_connection_options = parsed_servers[0][1]
            client_options.update(
                {
                    key: value
                    for key, value in first_connection_options.items()
                    if value is not None
                }
            )

        # Add the remap callback only when one is configured.
        if address_remap is not None:
            client_options["address_remap"] = address_remap

        # Build the shared Redis Cluster client instance.
        return RedisCluster(
            startup_nodes=startup_nodes,
            **client_options,
        )

    # Return the shared cluster client for both reads and writes.
    def get_client(self, key=None, *, write=False):
        return self.client

    # Add a value only if the key does not exist.
    def add(self, key, value, timeout):
        client = self.get_client(key, write=True)
        value = self._serializer.dumps(value)

        if timeout == 0:
            if ret := bool(client.set(key, value, nx=True)):
                client.delete(key)
            return ret

        return bool(client.set(key, value, ex=timeout, nx=True))

    # Get a single cached value.
    def get(self, key, default):
        client = self.get_client(key)
        value = client.get(key)
        return default if value is None else self._serializer.loads(value)

    # Set a single cached value.
    def set(self, key, value, timeout):
        client = self.get_client(key, write=True)
        value = self._serializer.dumps(value)

        if timeout == 0:
            client.delete(key)
        else:
            client.set(key, value, ex=timeout)

    # Refresh or persist a cached value timeout.
    def touch(self, key, timeout):
        client = self.get_client(key, write=True)

        if timeout is None:
            return bool(client.persist(key))

        return bool(client.expire(key, timeout))

    # Delete a single cached value.
    def delete(self, key):
        client = self.get_client(key, write=True)
        return bool(client.delete(key))

    # Get multiple cached values without requiring the keys to share a single cluster slot.
    def get_many(self, keys):
        client = self.get_client(None)
        values = client.mget_nonatomic(list(keys))
        return {
            key: self._serializer.loads(value)
            for key, value in zip(keys, values)
            if value is not None
        }

    # Check whether a key exists.
    def has_key(self, key):
        client = self.get_client(key)
        return bool(client.exists(key))

    # Increment a numeric cached value.
    def incr(self, key, delta):
        client = self.get_client(key, write=True)

        if not client.exists(key):
            raise ValueError("Key '%s' not found." % key)

        return client.incr(key, delta)

    # Set multiple cached values across the cluster without requiring a single slot.
    def set_many(self, data, timeout):
        client = self.get_client(None, write=True)
        serialized_data = {key: self._serializer.dumps(value) for key, value in data.items()}
        client.mset_nonatomic(serialized_data)

        if timeout is not None:
            for key in data:
                client.expire(key, timeout)

    # Delete multiple cached values.
    def delete_many(self, keys):
        client = self.get_client(None, write=True)
        client.delete(*keys)

    # Clear the cluster cache.
    def clear(self):
        client = self.get_client(None, write=True)
        cleared_results = []

        for node in client.get_nodes():
            if getattr(node, "server_type", None) == "primary":
                cleared_results.append(bool(client.flushdb(target_nodes=[node])))

        return all(cleared_results) if cleared_results else False


class RedisClusterCache(RedisCache):
    # Replace Django's default Redis cache client with the Redis Cluster-aware client.
    def __init__(self, server, params):
        super().__init__(server, params)
        self._class = RedisClusterCacheClient

    # Keep Django's timeout handling while preserving the cache backend contract.
    def get_backend_timeout(self, timeout=DEFAULT_TIMEOUT):
        return super().get_backend_timeout(timeout)
