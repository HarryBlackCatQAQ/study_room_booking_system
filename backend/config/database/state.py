from contextvars import ContextVar


# Keep a request-scoped flag so read replicas are only used inside managed HTTP request flows.
_database_routing_context_is_active = ContextVar(
    "database_routing_context_is_active",
    default=False,
)

# Keep a request-scoped flag so unsafe requests can force all reads back to the primary database.
_force_primary_database_reads = ContextVar(
    "force_primary_database_reads",
    default=False,
)

# Keep a request-scoped cursor so read replicas can be used in a simple round-robin order.
_read_replica_cursor = ContextVar(
    "read_replica_cursor",
    default=0,
)


# Mark the current execution context as eligible for replica routing.
def activate_database_routing_context():
    return _database_routing_context_is_active.set(True)


# Restore the previous routing context state after the request finishes.
def restore_database_routing_context(token):
    _database_routing_context_is_active.reset(token)


# Expose whether the current execution context is inside managed request routing.
def is_database_routing_context_active():
    return _database_routing_context_is_active.get()


# Mark whether reads should stay on the primary database for the current request.
def set_force_primary_database_reads(value):
    return _force_primary_database_reads.set(value)


# Restore the previous primary-read flag after the request finishes.
def restore_force_primary_database_reads(token):
    _force_primary_database_reads.reset(token)


# Expose whether reads should stay on the primary database right now.
def get_force_primary_database_reads():
    return _force_primary_database_reads.get()


# Reset the round-robin cursor when a new request starts or finishes.
def reset_read_replica_cursor():
    _read_replica_cursor.set(0)


# Pick the next read replica alias using a simple round-robin sequence.
def get_next_read_replica_alias(replica_aliases):
    current_cursor = _read_replica_cursor.get()
    alias = replica_aliases[current_cursor % len(replica_aliases)]
    _read_replica_cursor.set((current_cursor + 1) % len(replica_aliases))
    return alias
