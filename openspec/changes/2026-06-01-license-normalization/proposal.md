# License Normalization — one BSL 1.1 policy across all 6 services

**Date:** 2026-06-01
**Owner:** Andrés (andres@dojocoding.io)
**Status:** Design approved — implemented on branch `chore/license-normalization`
**Domain:** `platform`
**Tracking issue:** TBD (`service:cross-repo`) — sub-project #2 of the monorepo foundation.

---

## Why (Problem)

After the monorepo consolidation (sub-project #1), the 6 services carried
**inconsistent and incomplete** licensing:

- **`agentic-core`** and **`marketplace-core`** had **no `LICENSE` file** at all,
  and their manifests declared **`MIT`** (`marketplace-core/package.json`,
  `agentic-core/pyproject.toml`) — contradicting the source-available product
  intent of the `-core` ecosystem.
- **`compliance-core` / `filing-core` / `invoice-core`** carried a verbose BSL 1.1
  template with **Licensor = an individual (Luis Andrés Peña Castillo + National
  ID)**, **Change License = Non-Profit OSL 3.0**, and a **relative** Change Date
  ("FIVE years from publish").
- **`payments-core`** carried a **different, shorter** BSL 1.1 summary with
  **Change License = Apache 2.0**, a **fixed** Change Date (2031-04-18 = +5y), and
  a **factually wrong "Siblings"** note claiming `marketplace-core` uses MIT and
  `agentic-core`/`invoice-core` are the only BSL siblings.

This fragmentation creates legal ambiguity (who is the licensor?), inconsistent
reuse terms (two different Change Licenses, two different Change Date horizons),
and SPDX drift between `LICENSE` files and package manifests.

## What (Decision)

Adopt **one uniform Business Source License 1.1 policy** for **all 6 services**,
with per-service parameters substituted from a single template:

| Parameter | Normalized value |
|---|---|
| **Licensor** (BSL party) | **ChimeraNext Shared Services LLC** |
| **Intellectual author / copyright** | **Andrés (Luis Andrés Peña Castillo, GitHub: lapc506, andres@dojocoding.io)** |
| **Licensed Work** | the service name (`<service>`), Version 0.0.1 or later |
| **Change License** | **Non-Profit Open Software License ("Non-Profit OSL") 3.0** (uniform) |
| **Change Date** | **5 years** from each service's first publicly available distribution (first commit), fixed per service |
| **Additional Use Grant** | standard BSL non-compete production-use grant (generic, polyglot/third-party safe) |
| **SPDX in manifest** | `BUSL-1.1` |

Concrete per-service Change Dates and the full parameter table live in
[`design.md`](./design.md).

## Scope

**In scope:**
- Write/normalize `services/<svc>/LICENSE.md` for **all 6** services from one template.
- Add BSL 1.1 to the two services that had none (`agentic-core`, `marketplace-core`).
- Set `license` = SPDX `BUSL-1.1` in every `package.json` / `pyproject.toml`.
- Fix `marketplace-core/package.json` `files` array (`LICENSE` → `LICENSE.md`) and
  its stale `author`.

**Out of scope:**
- Per-file SPDX headers in source files (future chore).
- A repo-root umbrella `LICENSE` (each service keeps its own per project.md).
- THIRD-PARTY-NOTICES generation (the template references it; population is later).

## Owner confirmations required

1. **Licensor entity** "ChimeraNext Shared Services LLC" — assumed a real/forming
   legal entity that holds publishing rights. Confirm exact legal name & that it is
   the correct BSL party (vs. the individual author).

The Change License (**Non-Profit OSL 3.0**) and Change Date horizon (**5 years**)
were set explicitly by the owner: preserve the original spirit of the 3 services
that were already BSL, and apply that same template uniformly to `agentic-core`,
`marketplace-core`, and `payments-core` (the latter reverts from its drifted
Apache 2.0 / fixed-2031 parameters).

## References

- ADR: [`design.md`](./design.md)
- Tasks: [`tasks.md`](./tasks.md)
- Parent change: `openspec/changes/2026-05-31-monorepo-foundation/` (scope item #2)
