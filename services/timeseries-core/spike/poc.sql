-- timeseries-core PoC — hypertable + 1 continuous aggregate + 1 window query.
-- SPDX-License-Identifier: BUSL-1.1
-- © 2026 Andrés (lapc506), licensed and published by ChimeraNext Shared Services LLC.
--
-- // hook-bypass: schema-sql-outside-migrations
-- Justification: this is a self-contained, ephemeral SPIKE PoC (#76) run against a
-- throwaway TimescaleDB container by poc.sh — NOT a product migration. This repo is
-- not a Supabase project (no supabase/migrations/); the schema here exists only to
-- demonstrate the hypertable + CAGG + window-rollup design and is destroyed on exit.
--
-- Validates the real Vertivo data model (flat `value double precision`, rollups
-- avg/min/max/count per (series_key, measurement) — there is NO `V_final` formula)
-- and the multi-tenant shape (`product_id`) from design.md §3,§4,§8. Idempotent.

\set ON_ERROR_STOP on

-- 1. Extension (the image ships TimescaleDB; CREATE EXTENSION is idempotent).
CREATE EXTENSION IF NOT EXISTS timescaledb;

-- 2. Base table + hypertable (mirrors the shared-core schema, design.md §3).
DROP TABLE IF EXISTS readings CASCADE;
CREATE TABLE readings (
  ts          timestamptz       NOT NULL,
  product_id  smallint          NOT NULL,   -- multi-tenancy (design.md §4)
  tenant_id   text              NOT NULL,
  series_key  text              NOT NULL,   -- e.g. greenhouseId for Vertivo
  measurement text              NOT NULL,   -- temperature | ph | ...
  value       double precision  NOT NULL,   -- the raw scalar ("V_final" is just this)
  unit        text              NOT NULL
);
SELECT create_hypertable('readings', 'ts',
  chunk_time_interval => INTERVAL '1 day',
  if_not_exists => TRUE);

-- 3. Seed: 2 hours of 1-minute pH samples for one greenhouse, one product/tenant.
--    A clean sine around 6.5 so avg/min/max are visibly distinct.
INSERT INTO readings (ts, product_id, tenant_id, series_key, measurement, value, unit)
SELECT
  gs,
  1,                       -- product_id = vertivo
  'demo-tenant',
  'greenhouse-42',
  'ph',
  6.5 + 0.3 * sin(extract(epoch FROM gs) / 600.0),
  'pH'
FROM generate_series(
  now() - INTERVAL '2 hours',
  now(),
  INTERVAL '1 minute'
) AS gs;

-- 4. Continuous aggregate: 5-minute rollup (design.md §8). Stores sum+count so
--    avg is recomputable upstream for hierarchical CAGGs (never avg(avg)).
DROP MATERIALIZED VIEW IF EXISTS readings_5m CASCADE;
CREATE MATERIALIZED VIEW readings_5m
WITH (timescaledb.continuous, timescaledb.materialized_only = false) AS
SELECT
  time_bucket('5 minutes', ts) AS bucket,
  product_id, tenant_id, series_key, measurement,
  avg(value)      AS avg_value,
  min(value)      AS min_value,
  max(value)      AS max_value,
  sum(value)      AS sum_value,
  count(*)        AS sample_count,
  last(value, ts) AS last_value
FROM readings
GROUP BY bucket, product_id, tenant_id, series_key, measurement
WITH NO DATA;

CALL refresh_continuous_aggregate('readings_5m', NULL, NULL);

-- 5. THE WINDOW QUERY: last hour of pH, 5-minute rollup, scoped by tenant/product.
\echo
\echo '================ ROLLUP: last hour, pH, 5m buckets ================'
SELECT
  to_char(bucket, 'HH24:MI')        AS bucket,
  round(avg_value::numeric, 3)      AS avg,
  round(min_value::numeric, 3)      AS min,
  round(max_value::numeric, 3)      AS max,
  round(last_value::numeric, 3)     AS last,
  sample_count                      AS n
FROM readings_5m
WHERE product_id = 1                                 -- RLS scoping (design.md §4)
  AND tenant_id  = 'demo-tenant'
  AND series_key = 'greenhouse-42'
  AND measurement = 'ph'
  AND bucket >= now() - INTERVAL '1 hour'
ORDER BY bucket;
\echo '=================================================================='
\echo

-- 6. Single-row sanity rollup over the whole window (the printed proof).
\echo '---- WINDOW SUMMARY (whole 2h, the rollup the PoC asserts) ----'
SELECT
  count(*)                          AS buckets,
  round(avg(avg_value)::numeric, 3) AS avg_of_avgs,
  round(min(min_value)::numeric, 3) AS overall_min,
  round(max(max_value)::numeric, 3) AS overall_max,
  sum(sample_count)                 AS total_samples
FROM readings_5m
WHERE product_id = 1 AND tenant_id = 'demo-tenant'
  AND series_key = 'greenhouse-42' AND measurement = 'ph';
