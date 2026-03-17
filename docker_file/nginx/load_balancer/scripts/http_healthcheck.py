#!/usr/bin/env python

# standard library only
import sys

import urllib.request


# usage
if len(sys.argv) != 4:
    print("Usage: http_healthcheck.py <host> <port> <path>")
    sys.exit(1)


# target
target_host = sys.argv[1]
target_port = sys.argv[2]
target_path = sys.argv[3]
healthcheck_url = f"http://{target_host}:{target_port}{target_path}"


try:
    # use a short timeout
    with urllib.request.urlopen(healthcheck_url, timeout=5) as response:
        if 200 <= response.status < 400:
            sys.exit(0)
except Exception:
    pass


# any failure means unhealthy
sys.exit(1)
