# @compliance-core/core

**Domain + application layer for `compliance-core` — pure TypeScript, zero I/O.**

This is the heart of the hexagonal architecture: the inner hexagon. It models
KYC/KYB/AML/sanctions/audit logic and orchestrates use cases through **ports**,
with no knowledge of gRPC, databases, HTTP, or any specific provider. Adapters
(server, persistence, provider SDKs) live in sibling packages and depend on this
one — never the reverse.

- **Package:** `@compliance-core/core` · **License:** BUSL-1.1 · ESM (`"type": "module"`)
- **Runtime deps:** [`zod`](https://zod.dev) (validation at the boundary only).

## What it contains

| Layer | `src/` path | Responsibility |
|---|---|---|
| **Domain** | `domain/` | Entities, value objects, domain services, events, errors — the rules. |
| **Application** | `app/` | Commands, queries, ports, and middleware that orchestrate the domain. |

### Domain (`./domain`)

- **Value objects** — `UUID`, `Hex32`, `ISODateTime`, `Jurisdiction`, `Decimal`,
  `PIIString`, `TaxId`, `DocumentRef`. Self-validating, immutable.
- **Entities** — `Identity`, `BusinessEntity` (with UBO tracking),
  `VerificationSession`, `SanctionsMatch`, `ComplianceEvent`, `AuditEntry`.
- **Domain services** — `AuditChainService` (append-only, SHA-256-chained audit
  log), `VerificationStateMachine`, plus `canonicalJson` and `sha256Hex` helpers
  used to make the audit hash deterministic.
- **Events** + typed domain **errors**.

### Application (`./app`)

- **Commands** — `StartVerification`, `CompleteVerification`, `ScreenSanctions`,
  `RefreshSanctionsLists`, `AppendAuditEvent`.
- **Queries** — `GetVerificationStatus` / `ListVerifications`,
  `GetSanctionsMatches`, `VerifyAuditIntegrity` / `ExportAuditLog`.
- **Ports** — the dependency-inversion contracts the service needs: audit log,
  clock, event bus, idempotency, identity verification, logger, metrics,
  provider credential vault, sanctions screening, secrets store, tracing,
  verification repository. Each port ships a `__contract__` test suite and a
  `__fakes__` in-memory implementation for use-case tests.
- **Middleware** — auth, idempotency, metrics, tracing, and a PII redactor,
  composed around command/query handlers.

## How it's used in the service

Each use case is a class that receives its ports as `Deps` (constructor or
`execute(input, deps)`), so adapters inject real implementations while tests
inject the bundled fakes:

```ts
import { ScreenSanctions } from "@compliance-core/core/app";
import { Jurisdiction } from "@compliance-core/core/domain";

// In the gRPC server adapter, deps are wired to real ports;
// in unit tests, to the __fakes__ implementations.
const result = await new ScreenSanctions(deps).execute({ /* … */ });
```

Public entry points:

- `@compliance-core/core` — re-exports everything (`app` + `domain`).
- `@compliance-core/core/domain` — domain-only.
- `@compliance-core/core/app` — use cases, ports, middleware.

## Develop

```bash
pnpm --filter @compliance-core/core build       # tsc → dist/
pnpm --filter @compliance-core/core typecheck    # tsc --noEmit
pnpm --filter @compliance-core/core test         # vitest (contracts + use cases)
```

See the service design spec:
[`docs/superpowers/specs/2026-04-16-compliance-core-design.md`](../../docs/superpowers/specs/2026-04-16-compliance-core-design.md).
