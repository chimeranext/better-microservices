# OpenSpec — Active Changes

Living index of decision records for `better-microservices`. Governance:
[`project.md`](./project.md).

## Active Changes

| Change | Domain | Records | Status |
|---|---|---|---|
| [`2026-05-31-monorepo-foundation`](./changes/2026-05-31-monorepo-foundation/) | `platform` | proposal · design · tasks | Design approved — pending implementation |

## Roadmap (sub-projects)

Each sub-project becomes its own OpenSpec change as it is designed.

| # | Sub-project | Change id | Status |
|---|---|---|---|
| 1 | Monorepo foundation | `2026-05-31-monorepo-foundation` | Design approved |
| 2 | Per-service licenses | `TBD` | Not started |
| 3 | Turborepo pipeline | `TBD` | Not started |
| 4 | Docs site (MkDocs + common + Pages) | `TBD` | Not started |
| 5 | OpenSpec enforcement hooks | `TBD` | Not started |
| 6 | Landing page (Shadcn selector) | `TBD` | Not started |

## Adding a new change

1. `mkdir openspec/changes/YYYY-MM-DD-slug`
2. Add the records the decision warrants (`proposal.md` = PDR, `design.md` = ADR,
   `tasks.md` = checklist). See [`project.md`](./project.md) for when each is needed.
3. Open/link a GitHub issue with the matching `service:*` label.
4. Add a row to the **Active Changes** table above.
