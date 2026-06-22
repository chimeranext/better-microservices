#!/usr/bin/env bash
# =============================================================================
# timeseries-core PoC (spike #76)
# SPDX-License-Identifier: BUSL-1.1
# © 2026 Andrés (lapc506), licensed and published by ChimeraNext Shared Services LLC.
#
# Spins up a throwaway TimescaleDB container, applies poc.sql (hypertable +
# 1 continuous aggregate + 1 window query), prints a rollup, then tears down.
# Exit 0 on success. Reproducible: `bash services/timeseries-core/spike/poc.sh`.
#
# If no container runtime is available, prints how to run it and exits 0 with a
# clear "NOT RUN (environment)" banner — so CI without Docker does not fail the
# spike, while a dev box runs it for real.
# =============================================================================
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
SQL="$HERE/poc.sql"
IMAGE="${TS_IMAGE:-timescale/timescaledb:latest-pg16}"
CONTAINER="timeseries-core-poc"
PORT="${TS_PORT:-55432}"
PGPASSWORD="poc"            # ephemeral throwaway container only — never a real secret
DB="poc"

# --- pick a container runtime -------------------------------------------------
RUNTIME=""
if command -v podman >/dev/null 2>&1 && podman info >/dev/null 2>&1; then
  RUNTIME="podman"
elif command -v docker >/dev/null 2>&1 && docker info >/dev/null 2>&1; then
  RUNTIME="docker"
fi

if [ -z "$RUNTIME" ]; then
  cat <<EOF

==================================================================
  timeseries-core PoC — NOT RUN (environment)
==================================================================
No working podman/docker runtime detected. To run this PoC:

  1. Install podman or docker (and start the daemon).
  2. Re-run:  bash services/timeseries-core/spike/poc.sh

What it does (see poc.sql):
  - starts $IMAGE
  - creates the 'readings' hypertable (multi-tenant: product_id/tenant_id)
  - creates the 'readings_5m' continuous aggregate (avg/min/max/last/count)
  - runs a windowed rollup query and prints the result
==================================================================
EOF
  exit 0
fi

echo ">> runtime: $RUNTIME   image: $IMAGE   port: $PORT"

cleanup() {
  echo ">> cleanup: removing container $CONTAINER"
  $RUNTIME rm -f "$CONTAINER" >/dev/null 2>&1 || true
}
trap cleanup EXIT

# --- start TimescaleDB --------------------------------------------------------
# Note: the image restarts the server once during first-boot to load
# shared_preload_libraries=timescaledb. We wait for the SECOND "ready to accept
# connections" so CREATE EXTENSION is not interrupted by that restart.
$RUNTIME rm -f "$CONTAINER" >/dev/null 2>&1 || true
echo ">> starting $CONTAINER ..."
$RUNTIME run -d --name "$CONTAINER" \
  -e POSTGRES_PASSWORD="$PGPASSWORD" \
  -e POSTGRES_DB="$DB" \
  -p "${PORT}:5432" \
  "$IMAGE" -c shared_preload_libraries=timescaledb >/dev/null

# --- wait for readiness (require 2 "ready" lines: init + post-restart) --------
echo -n ">> waiting for TimescaleDB (init + restart) "
READY=0
for i in $(seq 1 90); do
  COUNT="$($RUNTIME logs "$CONTAINER" 2>&1 | grep -c 'database system is ready to accept connections' || true)"
  if [ "${COUNT:-0}" -ge 2 ] && $RUNTIME exec "$CONTAINER" pg_isready -U postgres -d "$DB" >/dev/null 2>&1; then
    READY=1
    echo " ready."
    break
  fi
  echo -n "."
  sleep 1
done
if [ "$READY" -ne 1 ]; then
  echo
  echo "!! TimescaleDB did not become ready in 90s" >&2
  $RUNTIME logs "$CONTAINER" 2>&1 | tail -20 >&2
  exit 1
fi
# small settle margin after the post-restart ready line
sleep 2

# --- apply the PoC SQL --------------------------------------------------------
echo ">> applying poc.sql ..."
$RUNTIME exec -i "$CONTAINER" psql -v ON_ERROR_STOP=1 -U postgres -d "$DB" < "$SQL"

echo
echo ">> PoC OK — hypertable + continuous aggregate + window rollup validated."
exit 0
