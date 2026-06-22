# timeseries-core PoC (spike #76)

Minimal, reproducible proof that the ADR's storage design works: a TimescaleDB
**hypertable** + one **continuous aggregate** + one **windowed rollup query**,
scoped by `product_id`/`tenant_id` (multi-tenancy), over the *real* Vertivo data
shape (a flat `value double precision` — there is **no `V_final` formula**).

> Source-available under **BUSL-1.1**. © 2026 Andrés (lapc506), licensed and
> published by ChimeraNext Shared Services LLC.

## Run it

```bash
bash services/timeseries-core/spike/poc.sh
```

Requires a working **podman** or **docker** runtime. The script:

1. Starts a throwaway `timescale/timescaledb` container (auto-detects podman/docker).
2. Applies [`poc.sql`](./poc.sql): creates the `readings` hypertable, seeds 2 hours
   of 1-minute pH samples, creates the `readings_5m` continuous aggregate
   (`avg/min/max/last/count`, storing `sum`+`count` for correct hierarchical
   `avg`), and runs a 5-minute windowed rollup query.
3. Prints the rollup and a window summary, then tears the container down.

Exit `0` on success. If **no container runtime** is available, it prints how to run
it and exits `0` with a `NOT RUN (environment)` banner — so CI without Docker does
not fail the spike.

Overrides: `TS_IMAGE`, `TS_PORT`.

## Verified result (podman, this environment)

```
================ ROLLUP: last hour, pH, 5m buckets ================
 bucket |  avg  |  min  |  max  | last  | n
--------+-------+-------+-------+-------+---
 03:00  | 6.520 | 6.460 | 6.579 | 6.579 | 5
 03:05  | 6.660 | 6.608 | 6.708 | 6.708 | 5
 ...
---- WINDOW SUMMARY (whole 2h) ----
 buckets | avg_of_avgs | overall_min | overall_max | total_samples
---------+-------------+-------------+-------------+---------------
      25 |       6.503 |       6.200 |       6.800 |           121
```

The sine-wave seed (6.5 ± 0.3) produces visibly distinct avg/min/max per bucket,
proving the aggregation pipeline end-to-end.

## What it validates vs the ADR

| ADR element | PoC line |
|---|---|
| Hypertable (`create_hypertable`, 1-day chunks) | `poc.sql` §2 |
| Multi-tenancy (`product_id`/`tenant_id` + scoped query) | `poc.sql` §2,§5 |
| Continuous aggregate (5m rollup, `materialized_only=false`) | `poc.sql` §4 |
| Rollups `avg/min/max/count` (+ recommended `last`) | `poc.sql` §4 |
| `sum`+`count` stored for hierarchical `avg` (no `avg(avg)`) | `poc.sql` §4 |
| Windowed rollup query (range → CAGG) | `poc.sql` §5 |

It does **not** cover hierarchical CAGGs beyond one level, compression/retention
policies, RLS enforcement, or ingestion — those are designed in `design.md` and
deferred to the extraction epic (this is a spike PoC, not the service).
