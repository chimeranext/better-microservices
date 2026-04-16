# Changelog

All notable changes to `@lapc506/marketplace-core` are recorded here.
Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
versioning follows [SemVer](https://semver.org/).

## [0.1.0] — 2026-04-16

First usable release. Ships the Standalone Storefront spike —
one Flutter binary renders hortalizas (Vertivo), rental properties
(HabitaNexus), and pet supplies (AltruPets) by swapping
`MERCHANT_SCHEMA_URL`.

### Added

- **CI + tooling** (#10) — tsup + biome + vitest + GH Actions with
  matrix Node 20.11 / 22, coverage artifacts, release workflow.
- **Infrastructure** (#11) — docker-compose (postgres:16 + meilisearch
  v1.11 with healthchecks), Dockerfile, Makefile with 20+ targets
  (`images-pull`, `up`, `down`, `db-psql`, `build-docker`, etc.).
- **Domain layer** (#12) — 5 aggregates (Product, Variant, Collection,
  Vendor, Storefront) with invariant guards + domain events +
  `AggregateRoot` base. Money value-object strengthened with
  `zeroMoney`, `subtractMoney`, `compareMoney`.  `DomainError`
  hierarchy (Invariant, Validation, NotFound, Conflict).  Ports split
  into 10 cohesive files with a barrel export.  100% coverage.
- **Adapters + gRPC server** (#13) — `PostgresProductRepository` with
  cursor pagination over `(created_at DESC, id)`; `MeilisearchEngine`
  with idempotent index bootstrap; `InMemorySchemaRegistry` that
  loads schemas from disk. `MarketplaceStorefront` gRPC service wires
  `BrowseProducts`, `GetProductDetail`, `SearchProducts`; the remaining
  RPCs return `UNIMPLEMENTED` with a "lands in a follow-up" pointer.
  `main.ts` boots migrations → meili index → schema registry → gRPC
  server with SIGTERM/SIGINT shutdown. Proto fix: added
  `ListCollectionsRequest`.
- **Flutter storefront scaffold** (#14) — Linux desktop app under
  `ui/` with Riverpod + go_router + grpc 5.1 + protobuf 6. Three
  screens (Browse, Search, ProductDetail) wired via gRPC to the server.
  Makefile adds `ui-install`, `ui-proto`, `ui-analyze`, `ui-test`,
  `ui-build`, `ui-run`, `ui-clean`, `ui-verify`.
- **JSON Schema-driven renderer** (#15) — the core spike. One widget
  map for `x-ui-hint` (geo, sensor, color, money, badge, image,
  image-gallery, url), `format` (date, date-time, uri), `enum`, and
  base types. `x-ui-order`, `x-ui-browse-fields`, `x-ui-unit`,
  `x-ui-currency`, `x-ui-true-label`, `x-ui-false-label` extensions.
  Schema registry provider reads `file://` or `https://`. Three
  reference schemas (`schemas/vertivolatam/hortalizas.v1.json`,
  `schemas/habitanexus/property.v1.json`,
  `schemas/altrupets/pet-supply.v1.json`). 43 widget tests.
- **Seed data** (#16) — 20 Vertivo hortalizas, 10 HabitaNexus rentals,
  30 AltruPets pet supplies, plus `make seed-vertivo` /
  `seed-habitanexus` / `seed-altrupets` / `seed-all`. Idempotent
  inserts, deterministic UUIDs via `uuid_generate_v5`. Schema
  validation test suite covering structural + semantic consistency.
- **Docs** (this PR) — `docs/design/standalone-mode.md`,
  `docs/design/json-schema-renderer.md`,
  `docs/design/schema-extensions.md`. README gains a Standalone Demo
  section.

### Known limits

- `MarketplaceAdmin`, `MarketplaceTransaction`, `MarketplaceInventory`,
  `MarketplaceTraceability`, `MarketplaceReputation` services declared
  in the proto but **not implemented** — each belongs in a focused
  follow-up PR.
- Four storefront RPCs return `UNIMPLEMENTED`: `ListCollections`,
  `GetCollection`, `GetStorefront`, `GetVendorProfile`. The UI can
  still render browse + detail views without them.
- **No integration tests against live compose** — the adapters are
  unit-tested with mocks; a follow-up PR will add a compose-backed
  test suite with `testcontainers` or GH Actions services.
- **No Flutter CI** — local `make ui-verify` is the gate for UI work.
  `actions/setup-flutter` needs a version-matrix decision first.
- **Placeholder UI widgets** for images, URLs, sensor charts, and
  map pins. Real `cached_network_image`, `url_launcher`, and chart
  libraries come behind feature flags in a follow-up.

[0.1.0]: https://github.com/lapc506/marketplace-core/releases/tag/v0.1.0
