from django.conf import settings
from django.db import DEFAULT_DB_ALIAS, connections

from .state import (
    get_force_primary_database_reads,
    get_next_read_replica_alias,
    is_database_routing_context_active,
)


# Keep framework-critical tables on the primary database to avoid stale permission or session reads.
PRIMARY_ONLY_APP_LABELS = {
    "admin",
    "auth",
    "contenttypes",
    "sessions",
}


class PrimaryReplicaRouter:
    # Route read queries to replicas when the request context allows it.
    def db_for_read(self, model, **hints):
        # If read replicas are not configured, always use the primary database.
        if not getattr(settings, "DB_READ_REPLICA_ALIASES", ()):
            return DEFAULT_DB_ALIAS

        # Keep Django framework tables on the primary database.
        if model._meta.app_label in PRIMARY_ONLY_APP_LABELS:
            return DEFAULT_DB_ALIAS

        # Keep non-request workloads such as websocket consumers and management commands on the primary database.
        if not is_database_routing_context_active():
            return DEFAULT_DB_ALIAS

        # Keep unsafe requests on the primary database to avoid read-after-write replica lag.
        if get_force_primary_database_reads():
            return DEFAULT_DB_ALIAS

        # Keep reads inside atomic transactions on the primary database.
        if connections[DEFAULT_DB_ALIAS].in_atomic_block:
            return DEFAULT_DB_ALIAS

        # Otherwise send the read query to the next configured replica.
        return get_next_read_replica_alias(settings.DB_READ_REPLICA_ALIASES)

    # Route every write query to the primary database.
    def db_for_write(self, model, **hints):
        return DEFAULT_DB_ALIAS

    # Allow relations across primary and replica aliases for the same project models.
    def allow_relation(self, obj1, obj2, **hints):
        return True

    # Only run schema migrations on the primary database.
    def allow_migrate(self, db, app_label, model_name=None, **hints):
        configured_aliases = {DEFAULT_DB_ALIAS, *getattr(settings, "DB_READ_REPLICA_ALIASES", ())}

        if db in configured_aliases:
            return db == DEFAULT_DB_ALIAS

        return None
