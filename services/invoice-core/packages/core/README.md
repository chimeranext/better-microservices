# @lapc506/invoice-core-core

**Domain + application layer for `invoice-core` — pure TypeScript, zero I/O.**

The inner hexagon of the hexagonal architecture: multi-country electronic
invoicing logic (Costa Rica v4.4 + México retenciones + Colombia retención en la
fuente) modelled with no dependency on gRPC, persistence, or the
[`@dojocoding/hacienda-sdk`](https://github.com/DojoCodingLabs/hacienda-cr).
Adapters depend on this package; it depends on nothing in the service.

- **Package:** `@lapc506/invoice-core-core` · ESM (`"type": "module"`)
- **Runtime deps:** [`zod`](https://zod.dev) (boundary validation).
- **Build:** [`tsup`](https://tsup.egoist.dev) (see `tsup.config.ts`).

## What it contains

| Layer | `src/` path | Responsibility |
|---|---|---|
| **Domain** | `domain/` | Value objects and rules for invoicing. |
| **Application** | `app/` | Use cases orchestrating the domain (ports defined here as the service grows). |

### Domain value objects (`./domain`)

Self-validating, immutable building blocks for the 7 CR invoice types,
withholding certificates, and donation receipts:

- **`Money`** — amount (`Decimal`) + ISO-4217 currency restricted to the
  Fase-1 set (`CRC`, `USD`, `EUR`, `MXN`, `COP`); enforces same-currency
  add/sub.
- **`Decimal`** — fixed-precision arithmetic (no float drift in tax math).
- **`TaxId`** — jurisdiction-aware identifiers: CR (`FISICA`, `JURIDICA`,
  `DIMEX`, `NITE`), MX (`RFC`), CO (`NIT`), plus a generic `PASSPORT` fallback.
- **`Jurisdiction`**, **`CountryCode`**, **`UnitCode`** (UN/CEFACT units),
  **`ISODate`** / **`ISODateTime`**, **`UUID`**, and **`PIIString`** (guards
  personally-identifiable data from accidental logging).

Every value object ships a colocated `*.spec.ts` (vitest).

> The package is in **pre-alpha scaffold**: the `domain/index.ts` and
> `app/index.ts` barrels currently export `{}` while value objects land
> incrementally per the Fase-1 plan. Import the concrete files directly until
> the barrels are populated.

## How it's used in the service

```ts
import { Money } from "@lapc506/invoice-core-core/domain/value-objects/money.js";
import { Decimal } from "@lapc506/invoice-core-core/domain/value-objects/decimal.js";

const line = Money.of(Decimal.of("1000.00"), "CRC");
const total = line.add(Money.of(Decimal.of("130.00"), "CRC")); // 1130.00 CRC
```

Public entry points (subpath exports):

- `@lapc506/invoice-core-core` — root barrel.
- `@lapc506/invoice-core-core/domain` — domain layer.
- `@lapc506/invoice-core-core/app` — use cases.

The gRPC server adapter and the `hacienda-sdk` adapter consume these types to
build, validate, and serialize documents; tests use them directly.

## Develop

```bash
pnpm --filter @lapc506/invoice-core-core build       # tsup → dist/
pnpm --filter @lapc506/invoice-core-core typecheck    # tsc --noEmit
pnpm --filter @lapc506/invoice-core-core test         # vitest
```

See the service design spec:
[`docs/superpowers/specs/2026-04-16-invoice-core-design.md`](../../docs/superpowers/specs/2026-04-16-invoice-core-design.md).
