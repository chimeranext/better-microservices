# OpenSpec — Active Changes

Living index of decision records for `better-microservices`. Governance:
[`project.md`](./project.md).

## Active Changes

| Change | Domain | Records | Status |
|---|---|---|---|
| [`2026-05-31-monorepo-foundation`](./changes/2026-05-31-monorepo-foundation/) | `platform` | proposal · design · tasks | **Shipped 2026-06-01** (tracking [#1](https://github.com/chimeranext/better-microservices/issues/1)) |
| [`2026-06-01-license-normalization`](./changes/2026-06-01-license-normalization/) | all services | proposal · design · tasks | **Merged 2026-06-01** (BSL 1.1, Non-Profit OSL 3.0 +5y, ChimeraNext Shared Services LLC) |
| [`2026-06-01-docs-site`](./changes/2026-06-01-docs-site/) | `common` | proposal · design · tasks | **Merged 2026-06-01** (README-first tabs + Common; gated: enable GitHub Pages) |
| [`2026-06-01-landing-configurator`](./changes/2026-06-01-landing-configurator/) | `platform` | proposal · design · tasks | Modeled — pending implementation |
| [`2026-06-01-vision-core`](./changes/2026-06-01-vision-core/) | `vision-core` | proposal · design · tasks | **Merged 2026-06-01** — scaffold (7th service; serves vertivolatam) |
| [`2026-06-01-geospatial-core`](./changes/2026-06-01-geospatial-core/) | `geospatial-core` | proposal · design · tasks | **Merged 2026-06-01** — scaffold (8th service; serves habitanexus) |
| [`2026-06-01-vertivo-nvidia-physical-ai`](./changes/2026-06-01-vertivo-nvidia-physical-ai/) | `vision-core` + Vertivo | proposal · design · tasks | Research spike (2 digital twins + SDG + Inception/Marketplace path) |

## Roadmap (sub-projects)

Each sub-project becomes its own OpenSpec change as it is designed.

| # | Sub-project | Change id | Status |
|---|---|---|---|
| 1 | Monorepo foundation | `2026-05-31-monorepo-foundation` | ✅ Shipped |
| 2 | Per-service licenses | `2026-06-01-license-normalization` | ✅ Shipped |
| 3 | Turborepo pipeline | `TBD` | Not started |
| 4 | Docs site (MkDocs + common + Pages) | `2026-06-01-docs-site` | ✅ Merged (⚠️ enable Pages) |
| 5 | OpenSpec enforcement hooks | `TBD` | Not started |
| 6 | Landing page (Shadcn configurator) | `2026-06-01-landing-configurator` | 🟡 Modeled |
| 7 | `create-better-microservices` CLI | `TBD` | Not started (split from #6) |

## Adding a new change

1. `mkdir openspec/changes/YYYY-MM-DD-slug`
2. Add the records the decision warrants (`proposal.md` = PDR, `design.md` = ADR,
   `tasks.md` = checklist). See [`project.md`](./project.md) for when each is needed.
3. Open/link a GitHub issue with the matching `service:*` label.
4. Add a row to the **Active Changes** table above.
