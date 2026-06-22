# Tasks — timeseries-core spike (decision + PoC) & deferred extraction epic

**Date:** 2026-06-21
**Domain:** `timeseries-core`
**Change:** `2026-06-21-timeseries-core`
**Status:** Spike DONE (decision = defer extraction). Extraction tasks below are **deferred**
until ≥2 triggers fire (see `proposal.md` §What, G1–G4).

---

## 0. Spike (this change) — DONE

- [x] Read trigger spec (Vertivo `2026-06-21-timescaledb-timeseries`), eventbus doc, peer `*-core`
- [x] Answer the 4 investigation questions (`design.md` §1)
- [x] Decision recorded: **defer extraction**; ship Vertivo Option 3 now (`proposal.md`)
- [x] Architecture designed: hypertable + hierarchical CAGGs + per-tenant compression/retention (`design.md` §3,§8)
- [x] Multi-tenancy strategy: `product_id` + RLS, filtered `drop_chunks` (`design.md` §4)
- [x] Dual-ingress split documented: bus (domain metrics) vs MQTT/EMQX direct + OTLP (`design.md` §5)
- [x] "Coupling with Decision 1" analysis: does NOT push to Kafka; Kafka = future trigger (`design.md` §6)
- [x] Query contract drafted in Protobuf (`proto/timeseries/v1/timeseries.proto`, `design.md` §7)
- [x] Strangler-fig extraction plan, 4 fases (`design.md` §9)
- [x] Minimal PoC: `spike/poc.sh` (TimescaleDB + hypertable + 1 CAGG + 1 window query → rollup)

## 1. Extraction triggers — watch (no code; review gate)

- [ ] **G1** — ≥2 real consumers with production-path code on the same series (candidate: `digitaltwin-core` graduating from research)
- [ ] **G2** — sustained ingest > ~50–100 msg/s AND storage ceiling crossed (e.g. PVC > ~70 % hot despite 7-day compression)
- [ ] **G3** — divergent retention/ops/compliance between consumers over the same series
- [ ] **G4** — a second consumer needs the same rollups and starts re-deriving them
- [ ] Re-open the extraction epic only when **≥2** of G1–G4 hold

## 2. Service scaffold (DEFERRED — on trigger)

- [ ] `services/timeseries-core/` hexagonal skeleton (`src/timeseries_core/{domain,application,adapters/{primary,secondary},config}`)
- [ ] `pyproject.toml` (SPDX `BUSL-1.1`, `psycopg[binary]` as `[db]` extra; grpcio/grpcio-tools)
- [ ] Codegen gRPC stubs from `proto/timeseries/v1/timeseries.proto` (buf.build as source of truth)
- [ ] Ports: `TimeSeriesStorePort`, `RollupPolicyPort`, `RetentionAdminPort`
- [ ] Value objects: `Reading`, `SeriesKey`, `TimeWindow`, `Resolution`, `MeasurementType`, `Rollup`
- [ ] `README.md` (README-first), `LICENSE.md` (BUSL-1.1), `deployment/k8s/` (namespace + SQL job)

## 3. Storage adapters (DEFERRED)

- [ ] `TimescaleStoreAdapter` (psycopg3) — `write_readings`, `query_rollup`, `get_latest`
- [ ] `TimescaleAdminAdapter` — `create_hypertable`, hierarchical CAGGs, compression/retention, filtered `drop_chunks`
- [ ] Hierarchical CAGGs: `1m` from raw (store `sum`+`count`), `5m`/`1h`/`1d` upstream; `materialized_only=false` on `1m`
- [ ] RLS policy: `product_id = current_setting('app.product')`

## 4. Dual ingress (DEFERRED)

- [ ] JetStream durable consumer (channel a — domain metrics, Protobuf)
- [ ] EMQX `sensor/#` subscriber (channel b — high-freq telemetry)
- [ ] OTLP exporter for ingest observability → Prometheus (NOT the business hypertable)

## 5. Query API (DEFERRED)

- [ ] gRPC `TimeSeriesQuery` server (`QueryWindow`, `QueryWindowStream`, `GetLatest`, `ListMetrics`)
- [ ] REST mirror (charts); range→CAGG selection heuristic
- [ ] gRPC Health v1 (platform standard)

## 6. Strangler cutover from Vertivo (DEFERRED — see `design.md` §9)

- [ ] Fase 2: `TimeSeriesStorePort` façade in `vertivo_server` → local TimescaleDB
- [ ] Fase 3: swap adapter behind façade → gRPC client to `timeseries-core`
- [ ] Fase 4: retire local hypertable/CAGGs/SQL job
- [ ] Canonical rollup migrated to the service; façade never recomputes
- [ ] Run `/make-no-mistakes:audit-strangler` over `vertivo_server` during Fases 2–4

## 7. Owner decisions (blockers — review gate)

- [ ] Confirm `service:timeseries-core` label + `openspec/project.md` domain row (`status:deferred`)
- [ ] Approve PR for this spike (do NOT push without relay)
- [ ] Decide whether `digitaltwin-core` is the G1 mover and whether it co-locates with this service
- [ ] Decide whether to add `last(value, ts)` to the rollups (recommended)
