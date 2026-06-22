# timeseries-core — shared time-series capability: extract now, later, or never?

**Date:** 2026-06-21 (decision date)
**Owner:** Andrés (andres@dojocoding.io)
**Status:** Proposed — spike outcome (research + PoC), pending review
**Domain:** `timeseries-core` (proposed 9th service; proposed label `service:timeseries-core`)
**Primary (only real) consumer today:** `vertivo` (greenhouse sensor telemetry)
**Roadmap consumers (hypothetical):** `digitaltwin-core` (research-only), and — if/when they
grow a telemetry need — aduanext, altrupets, habitanexus, keikolatam
**Tracking issue:** #76 (`service:timeseries-core` + `type:spike`)
**Trigger / relation:** detonates from Vertivo's TimescaleDB decision
(OpenSpec `2026-06-21-timescaledb-timeseries`, repo `vertivolatam/monorepo`). That spec's
**Option 3** (decouple the hypertable storage from the Serverpod ORM) is the **strangler
seam** toward this service. This spike does **not** block Vertivo: Vertivo ships its local
seam; here we decide **if / when / how** to extract the shared service.

---

## Why (Problem)

Vertivo needs to persist sensor telemetry (MQTT → backend) as **time-series** and chose
TimescaleDB. Resolving the Serverpod↔TimescaleDB clash (Serverpod generates
`PRIMARY KEY (id)` only, but a hypertable requires the partitioning column `createdAt` in
every PK/UNIQUE) led to **Option 3: decouple storage from the ORM** — Serverpod still owns
the relational *shape* of `environmental_readings`; a separate, idempotent custom-SQL step
(run *after* Serverpod creates the table) converts it into a hypertable + continuous
aggregates + compression/retention policies. That solves the local problem, but opens a
bigger question: **if we are separating the storage layer anyway, isn't this a shared
platform capability?**

The owner confirmed it would **not** be a single consumer in principle: aduanext, altrupets,
habitanexus and keikolatam are also in the portfolio. That *could* make `timeseries-core` a
**horizontal capability** — the same mould as the existing `*-core` services (`vision-core`,
`geospatial-core`), and `vision-core` already has cross-product-consumption precedent from
Vertivo.

But the spike's evidence (below) tempers that: **today there is exactly one real
time-series consumer (Vertivo)**. The other four products' "metrics" are reputation, ratings
and discrete domain events — a *different domain*, not sensor/telemetry time-series sharing
the MQTT spine. The only plausible second consumer is `digitaltwin-core`, which is
**research-only (no code)** and would consume the *same* Vertivo series.

The coupling that makes this decision non-trivial: the
[`eventbus-broker-analysis.md`](../../../../../docs/site/content/common/eventbus-broker-analysis.md)
(Decision 1, broker). A cross-product `timeseries-core` **is an analytical sink** — and that
same doc lists *"a heavy data channel toward an analytical store"* as an **explicit signal to
revisit toward Kafka**. So this spike cannot be taken in isolation from the event-bus broker.

### Analogy

It is the difference between a **datalogger on each farm** (each product with its own
time-series table) vs a **central telemetry station** that every farm reports to and reads its
aggregated history from. The central station is only justified once several farms actually
report — which is *not* the case yet (one reports; the rest do not have the need).

## What (Decision)

**Do NOT extract `timeseries-core` now. Ship Vertivo's local seam (Option 3) now; defer the
extraction until ≥2 concrete trigger signals fire.**

Concretely, this PDR records:

1. **Decision = defer extraction.** With a single real consumer, a separate microservice is a
   premature **distributed monolith**: it pays network, gRPC contract, versioning, failure-mode
   and ops cost without the plurality of consumers that justifies it. The correct boundary
   today is **intra-process** (a `TimeSeriesStorePort` / façade inside `vertivo_server`), not
   inter-process (gRPC sidecar).

2. **Immediate action (Vertivo track, not this repo) = implement Option 3** — hypertable +
   continuous aggregates + compression/retention behind an idempotent custom-SQL job, fronted
   by a `TimeSeriesStorePort` façade. This delivers ~90 % of the value (decouple storage↔ORM)
   and makes the future extraction cheap (swap the adapter behind the façade) **without**
   committing to the service cost today. It is the reversible option.

3. **Extraction triggers (the gatillos)** — open the extraction epic only when **≥2** of:
   - **G1** — ≥2 *real* consumers (production-path code, not scaffolds) reading/writing the
     same series. Most likely mover: `digitaltwin-core` graduating from research to code with a
     `TimeSeriesStorePort` against the sensor series.
   - **G2** — sustained ingest > ~50–100 msg/s **and** the storage volume crossing an
     operational ceiling (e.g. PVC > ~70 % hot despite 7-day compression).
   - **G3** — divergent retention/ops/compliance between consumers over the *same* series
     (e.g. one product must keep raw > 1 year for traceability while another drops at 90 days).
   - **G4** — cross-product rollups: a second consumer needs the *same* `avg/min/max/count`
     rollups and starts re-deriving them, risking formula divergence.

4. **Design is specified now (so the extraction is cheap later)** — see `design.md`:
   hypertable + hierarchical continuous aggregates (1m/5m/1h/1d), per-tenant
   compression/retention, multi-tenancy (`product_id` + RLS), the dual-ingress split
   (event-bus for low-frequency domain metrics; MQTT/EMQX direct + OTLP for high-frequency
   telemetry), the Protobuf query contract, and the **"Coupling with Decision 1"** analysis
   (it does **not** push the broker to Kafka — the heavy load enters via MQTT direct, not the
   bus; NATS JetStream stays sufficient, Kafka remains a future trigger).

### What this is NOT

- It is **not** a green-light to build the service. It is a decision to *defer*, with a
  ready-to-execute design and explicit triggers.
- It does **not** choose the event-bus broker — it **aligns** with
  `eventbus-broker-analysis.md` (Decision 1 = NATS JetStream; Decision 2 = Protobuf) and does
  not contradict it.
- It does **not** modify Vertivo. Vertivo's Option 3 is a separate track in
  `vertivolatam/monorepo`; this spike only reads it.

## Impact

- **New (deferred) domain** `timeseries-core` in `openspec/project.md` (proposed
  `service:timeseries-core` label / domain row), marked `status:deferred` until a trigger fires.
- **No new deployable** today: the scaffold (`services/timeseries-core/`) holds the ADR + a
  reproducible **PoC** (`spike/poc.sh`) that validates the hypertable + 1 continuous aggregate
  + a window query, plus the Protobuf query contract draft (`proto/timeseries/v1/`).
- **Cross-service alignment:** the canonical rollup convention (`time_bucket` +
  `avg/min/max/count` per series key) MUST live in exactly one place. In Fases 1–2 that is
  Vertivo's local SQL job; in Fases 3–4 it migrates to `timeseries-core`. The façade only
  routes, never recomputes — otherwise Vertivo-local and the service drift (G4 /
  contract-drift anti-pattern).

## Open questions deferred to the extraction epic

- Exact chunk interval and per-tenant retention mechanism (native `add_retention_policy` is
  per-hypertable; per-product retention needs filtered `drop_chunks` jobs or schema-per-tenant
  — see `design.md` §Multi-tenancy).
- Whether `digitaltwin-core` is the trigger that promotes G1, and whether it co-locates with
  this service.
- Whether to add `last(value, ts)` to the rollups (recommended; not in Vertivo's current spec,
  which has only avg/min/max/count).
