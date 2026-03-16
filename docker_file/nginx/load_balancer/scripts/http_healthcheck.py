#!/usr/bin/env python

# keep the script dependency-free so it works in the slim python image
import sys

# use urllib from the standard library for lightweight http probes
import urllib.request


# keep the usage validation explicit so docker health check failures are easier to diagnose
if len(sys.argv) != 4:
    # keep the usage message short and actionable
    print("Usage: http_healthcheck.py <host> <port> <path>")
    # keep invalid usage as a failing exit code
    sys.exit(1)


# keep the target host configurable from the command line
target_host = sys.argv[1]

# keep the target port configurable from the command line
target_port = sys.argv[2]

# keep the target path configurable from the command line
target_path = sys.argv[3]

# keep the local health check url explicit for easier debugging
healthcheck_url = f"http://{target_host}:{target_port}{target_path}"


try:
    # keep the timeout short so unhealthy containers fail quickly
    with urllib.request.urlopen(healthcheck_url, timeout=5) as response:
        # keep only successful http status codes as healthy
        if 200 <= response.status < 400:
            # keep success as a clean exit for docker health checks
            sys.exit(0)
except Exception:
    # fall through to the explicit failing exit code below
    pass


# keep all request failures as unhealthy results
sys.exit(1)
