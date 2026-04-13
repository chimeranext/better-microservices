# marketplace-core

Production-ready TypeScript library for marketplace orchestration. Designed as a shared dependency for any startup building a marketplace — rental, retail, service, or peer-to-peer.

**This library contains NO domain-specific business logic.** All domain graphs, transaction sagas, and payment integrations live inside each project's own monorepo.

Stack: TypeScript, gRPC, Zod validation, Starknet.js (optional traceability).

## What it provides

- **Product catalog** — Products, Variants, Collections with flexible attribute schemas
- **Storefront API** — Public-facing queries with NO authentication required
- **Schema registry** — JSON Schema validation per domain (27 fields for rental, ingredients for pet food, etc.)
- **Inventory management** — TRACK (retail), SINGLE (rental), UNTRACK (service), CAPACITY (bounded service)
- **Availability rules** — ALWAYS, CALENDAR, DATE_RANGE, EXPIRABLE, SEASONAL
- **Traceability** — Hash-chain (PostgreSQL) or blockchain (Madara/Starknet) via pluggable adapters
- **Reputation** — Vendor/buyer ratings with configurable scoring
- **Media management** — Images, videos, documents with S3-compatible storage
- **Geo search** — Location-based product discovery with radius queries
- **SEO** — Open Graph tags for WhatsApp/Facebook link previews

## What it does NOT provide

- Orders / Contracts / Bookings (each project implements its own transaction saga)
- Payments (Kindo SINPE, Stripe, crypto — each project chooses)
- Chat / Messaging
- KYC / Identity verification
- Push notifications
- Tax reporting (TRIBU-CR, ISR — each project integrates)

## Projects using marketplace-core

| Project | Marketplace Type | Product | Inventory | Fulfillment | Traceability |
|---------|-----------------|---------|-----------|-------------|-------------|
| **HabitaNexus** | Rental | Property Listing | SINGLE | IN_PERSON + ONGOING | Hash-chain (expediente) |
| **AltruPets** | Retail | Pet Supplies | TRACK | PHYSICAL | Hash-chain |
| **Vertivolatam** | Retail B2B2C | Hortalizas | TRACK | PHYSICAL + IN_PERSON | Madara/Starknet |
| **AduaNext** | Service | Vetted Sourcers | CAPACITY | IN_PERSON + DIGITAL | Hash-chain |
| **Keiko** | Service | Tutors | UNTRACK | IN_PERSON + DIGITAL | Starknet Appchain |
| **MeshCommerceChain** | Retail Multi-tenant | Store Items | TRACK | PHYSICAL + IN_PERSON | Madara/Starknet |

## Architecture

Hexagonal Architecture (Ports & Adapters) following [Herberto Graca's Explicit Architecture](https://herbertograca.com/2017/11/16/explicit-architecture-01-ddd-hexagonal-onion-clean-cqrs-how-i-put-it-all-together/).

```
marketplace-core/
├── proto/
│   └── marketplace_core.proto          # 7 gRPC services, ~100 message types
├── src/
│   ├── domain/
│   │   ├── entities/                   # Product, Variant, Collection, Vendor, Storefront
│   │   ├── value-objects/              # Money, GeoLocation, SEO, AvailabilityRule (Zod schemas)
│   │   ├── services/                   # CatalogService, SearchService
│   │   └── ports/                      # 10 ports (see below)
│   ├── shared-kernel/
│   │   ├── events.ts                   # Domain events
│   │   └── types.ts                    # Enums
│   └── index.ts                        # Public API
├── appchain/
│   ├── contracts/                      # Cairo smart contracts (shared)
│   │   ├── supply_chain.cairo          # ISO 22005 + ISO 28000 traceability
│   │   └── product_registry.cairo      # On-chain product catalog
│   └── config/
│       └── marketplace.toml.template   # Madara appchain config template
├── tests/
├── docs/
│   ├── references/                     # ISO standards (22005, 22000, 28000, 28004-2)
│   └── design/                         # Architecture decisions
├── package.json
└── tsconfig.json
```

## Ports

| Port | Purpose | Example Adapters |
|------|---------|-----------------|
| **ProductRepository** | CRUD + search | PostgreSQL, MongoDB |
| **SearchEngine** | Full-text + faceted + geo | Meilisearch, Elasticsearch, pgvector |
| **MediaStorage** | Upload/serve media | S3, R2, GCS |
| **SchemaRegistry** | JSON Schema validation | In-memory, PostgreSQL |
| **TransactionPort** | Confirm/cancel transactions | RentalAdapter, PurchaseAdapter, BookingAdapter |
| **InventoryPort** | Reserve/release/adjust stock | PostgreSQL, Redis |
| **PaymentGatewayPort** | Charge/refund/escrow | Kindo, Stripe, Starknet |
| **TraceabilityPort** | Supply chain tracking | HashChainAdapter (PostgreSQL), MadaraAdapter (Starknet) |
| **ReputationPort** | Ratings and reviews | PostgreSQL, Starknet reputation contract |
| **EventBus** | Domain event publishing | NATS, RabbitMQ, Redis Streams |

## gRPC Services

| Service | Auth | Purpose |
|---------|------|---------|
| `MarketplaceAdmin` | Required | Vendor operations: products, variants, collections, storefronts |
| `MarketplaceStorefront` | **None** | Public browsing: search, browse, view products — no account needed |
| `MarketplaceTransaction` | Required | Confirm/cancel/status — adapter-driven |
| `MarketplaceInventory` | Required | Reserve/release/adjust inventory |
| `MarketplaceTraceability` | Required | Record origin, transfers, verify chain |
| `MarketplaceReputation` | Required | Submit ratings, get reputation scores |

## Standards Compliance

Supply chain traceability follows:
- **ISO 22005:2007** — Traceability in feed and food chain
- **ISO 22000:2018** — Food safety management systems
- **ISO 28000:2022** — Security management systems for the supply chain
- **ISO 28004-2** — Implementation guide for small/medium operations

## Install

```bash
npm install @lapc506/marketplace-core
```

## License

MIT — same as [agentic-core](https://github.com/lapc506/agentic-core).
