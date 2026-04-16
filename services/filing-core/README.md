# filing-core

TypeScript library for **presenting tax declarations** to authorities (TRIBU-CR, SAT MX, DIAN CO) — D-101, D-104, D-103, DIOT, Formulario 110, and equivalents across jurisdictions.

> **Status**: **APPROVED BUT DEFERRED TO YEAR 2 (2027)**.
>
> This spec is anticipatory. The immediate solution for the ecosystem is `invoice-core`'s `FilingDataExportPort` which pre-populates casillas for the contador to review manually in TRIBU-CR / SAT portals. `filing-core` activates when:
>
> 1. ≥ 2 startups explicitly request full filing automation, OR
> 2. Volume makes contador manual labor exceed USD 15k/year across the portfolio (whichever comes first).

## Why (eventually)

All 4 startups must file tax declarations annually / monthly. When automation becomes cost-effective, centralizing declaration assembly + submission + reconciliation in one sidecar avoids duplicating fiscal math and TRIBU-CR integration per backend.

Scored **5/5** on the governance rubric but gated on the trigger conditions above.

## What it WILL do (when active)

- Aggregate data from `invoice-core` (+ future `payroll-core`, `asset-core`).
- Calculate declaration values (depreciation, ISR brackets, deductions).
- Validate against authority schemas.
- Generate declaration file.
- **Submit with human-in-the-loop approval** (no auto-submit — tax filings are high-stakes).
- Track status + generate payment voucher + archive audit trail.

## What it will NOT do

- Emit electronic invoices (that's `invoice-core`).
- Internal accounting / ledger.
- Payroll.
- Inventory valuation.
- KYC / AML (that's `compliance-core`).

## Architecture (preliminary)

- **Hexagonal** (Explicit Architecture).
- **gRPC sidecar** (`:50081`) with dual deployment.
- **TypeScript 5.x strict** on Node 22 LTS.
- **18 ports** covering declaration repo, calculator, validator, tax authority submission, reminders, data sources, approval gateway, payment voucher, evidence archive.
- **Human-in-the-loop** invariant enforced via state machine (`AWAITING_APPROVAL` mandatory).

## Design specification

Full preliminary design (marked DEFERRED): [`docs/superpowers/specs/2026-04-16-filing-core-design.md`](docs/superpowers/specs/2026-04-16-filing-core-design.md)

The spec is to be re-reviewed annually to check whether the trigger has fired.

## Trigger monitoring

Monthly checks:

- How many startups have asked for automated filing vs pre-populated casillas?
- Contador hours spent on manual TRIBU-CR / SAT / DIAN operations per quarter?
- Any regulatory change making manual filing impractical?

When trigger fires, promote this spec to active roadmap + initiate Fase 1 build.

## Ecosystem

- [`agentic-core`](https://github.com/lapc506/agentic-core) — AI agent orchestration (Python, BSL 1.1).
- `marketplace-core` — product catalog + traceability (TypeScript, MIT).
- [`invoice-core`](https://github.com/lapc506/invoice-core) — multi-country e-invoicing (TypeScript, BSL 1.1).
- [`compliance-core`](https://github.com/lapc506/compliance-core) — KYC + AML + PoP (TypeScript, BSL 1.1).

## License

[Business Source License 1.1](LICENSE.md). Five-year conversion to Non-Profit OSL 3.0.
