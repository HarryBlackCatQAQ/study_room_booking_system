#!/usr/bin/env python

# keep the script dependency-free so it works in the slim python image
import socket

# keep command-line parsing simple and explicit
import sys

# keep a deterministic sleep loop for retry handling
import time


# keep the usage validation explicit so compose errors are easier to diagnose
if len(sys.argv) not in {3, 4}:
    # keep the usage message short and actionable
    print("Usage: wait_for_tcp.py <host> <port> [timeout_seconds]")
    # keep invalid usage as a failing exit code
    sys.exit(1)


# keep the target host configurable from the command line
target_host = sys.argv[1]

# keep the target port parsed as an integer for socket connections
target_port = int(sys.argv[2])

# keep the total timeout configurable while defaulting to two minutes
timeout_seconds = int(sys.argv[3]) if len(sys.argv) == 4 else 120

# keep the start time for timeout enforcement
started_at = time.time()


# keep retrying until the socket becomes reachable or the timeout expires
while True:
    try:
        # keep each probe connection short so retries stay responsive
        with socket.create_connection((target_host, target_port), timeout=3):
            # keep the success message explicit for docker logs
            print(f"TCP endpoint ready: {target_host}:{target_port}")
            # keep success as a clean exit
            sys.exit(0)
    except OSError:
        # stop retrying once the total timeout is exceeded
        if time.time() - started_at >= timeout_seconds:
            # keep the timeout failure message explicit for docker logs
            print(f"Timed out waiting for TCP endpoint: {target_host}:{target_port}")
            # keep timeout as a failing exit code
            sys.exit(1)

        # keep retry logging explicit so startup delays are easy to understand
        print(f"Waiting for TCP endpoint: {target_host}:{target_port}")

        # keep the retry interval short without spamming the logs too aggressively
        time.sleep(2)
