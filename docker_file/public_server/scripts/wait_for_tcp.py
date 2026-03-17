#!/usr/bin/env python

# standard library only
import socket
import sys
import time


# usage
if len(sys.argv) not in {3, 4}:
    print("Usage: wait_for_tcp.py <host> <port> [timeout_seconds]")
    sys.exit(1)


# target
target_host = sys.argv[1]
target_port = int(sys.argv[2])
timeout_seconds = int(sys.argv[3]) if len(sys.argv) == 4 else 120
started_at = time.time()


# wait until the port is ready or the timeout is reached
while True:
    try:
        with socket.create_connection((target_host, target_port), timeout=3):
            print(f"TCP endpoint ready: {target_host}:{target_port}")
            sys.exit(0)
    except OSError:
        if time.time() - started_at >= timeout_seconds:
            print(f"Timed out waiting for TCP endpoint: {target_host}:{target_port}")
            sys.exit(1)

        print(f"Waiting for TCP endpoint: {target_host}:{target_port}")
        time.sleep(2)
