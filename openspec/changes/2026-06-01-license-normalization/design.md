# License Normalization — Architecture

**Issue:** TBD (`service:cross-repo`)
**Status:** Design approved 2026-06-01
**Depends on:** `2026-05-31-monorepo-foundation` (services must live under `services/`)
**PDR:** [`proposal.md`](./proposal.md)

## TL;DR

One BSL 1.1 template, six parameter sets. Licensor is the company
(**ChimeraNext Shared Services LLC**); the individual (**Andrés / lapc506**) is
credited as intellectual author / copyright holder. Change License is unified to
**Apache 2.0**; Change Date is **+4 years from each service's first publication**,
fixed per service. SPDX `BUSL-1.1` everywhere.

## Why a normalized policy (decision criteria)

The 4 pre-existing BSL files **did not agree**, so "keep the existing convention"
is not an option — there were two conventions:

| Source | Licensor | Change License | Change Date | Format |
|---|---|---|---|---|
| compliance / filing / invoice | individual + National ID | **Non-Profit OSL 3.0** | relative "FIVE years" | long MariaDB template |
| payments-core | individual | **Apache 2.0** | fixed `2031-04-18` (+5y) | short summary table |
| agentic / marketplace | — (MIT in manifest, no file) | — | — | none |

Because the Change License conflicts (Non-Profit OSL vs Apache) and the Change Date
horizon/format conflicts, a **normalized policy** is chosen per the owner's
delegated defaults: **Apache 2.0** (the more conventional, widely-tooled
permissive target; SPDX `Apache-2.0`) and a **4-year** Change Date measured from
each service's first publicly available distribution.

## Per-service parameter table

Change Date = first-commit date (preserved git history from origin repos) + 4 years.

| Service | First publication (first commit) | Change Date (+4y) | Licensor | Change License | SPDX (manifest) | Manifest |
|---|---|---|---|---|---|---|
| `agentic-core` | 2026-03-25 | **2030-03-25** | ChimeraNext Shared Services LLC | Apache-2.0 | `BUSL-1.1` | `pyproject.toml` (+ thin `package.json`) |
| `compliance-core` | 2026-04-16 | **2030-04-16** | ChimeraNext Shared Services LLC | Apache-2.0 | `BUSL-1.1` | `package.json` |
| `filing-core` | 2026-04-16 | **2030-04-16** | ChimeraNext Shared Services LLC | Apache-2.0 | `BUSL-1.1` | `package.json` |
| `invoice-core` | 2026-04-16 | **2030-04-16** | ChimeraNext Shared Services LLC | Apache-2.0 | `BUSL-1.1` | `package.json` |
| `marketplace-core` | 2026-04-13 | **2030-04-13** | ChimeraNext Shared Services LLC | Apache-2.0 | `BUSL-1.1` | `package.json` |
| `payments-core` | 2026-04-18 | **2030-04-18** | ChimeraNext Shared Services LLC | Apache-2.0 | `BUSL-1.1` | `package.json` |

Intellectual author / copyright credit for **all** services: **Andrés (Luis Andrés
Peña Castillo, GitHub: lapc506, andres@dojocoding.io)**.

## Template structure

A single `LICENSE.md` body (the long MariaDB-derived BSL 1.1 form used by 3 of the
4 originals, kept because it embeds the full Terms verbatim). Substituted tokens:

- `<service>` — Licensed Work name (per row above).
- Licensor block — names the **company** as Licensor and the **individual** as
  intellectual author/copyright holder.
- Change Date — the fixed date from the table.
- Change License — `Apache License, Version 2.0`.

The `payments-core` short-form summary and its inaccurate "Siblings" section are
**replaced** by the uniform long form (the old note wrongly stated
`marketplace-core` was MIT).

## Polyglot & third-party code handling

`agentic-core` (Python + Go + Dart) and `marketplace-core` (TS + appchain +
Flutter) are polyglot and may bundle third-party code. The grant is kept
**generic** so it is language-agnostic:

- The header explicitly states the service "may comprise multiple programming
  languages (a polyglot service)" and that **bundled third-party components remain
  under their own original licenses**, noted in per-file headers and/or a
  `THIRD-PARTY-NOTICES` file.
- The Additional Use Grant is the standard BSL non-compete production-use grant —
  it references "Licensor's paid version(s)" generically, with no language- or
  stack-specific assumptions, so it applies uniformly to Node, Python, Go, Dart,
  and on-chain components.
- BSL 1.1 governs **the original Licensed Work only**; it does not attempt to
  relicense third-party dependencies, which keeps the polyglot dependency trees
  compliant.

## SPDX note

SPDX short identifier for BSL 1.1 is **`BUSL-1.1`** (not `BSL-1.1`). `payments-core`
previously used the invalid `BSL-1.1`; it is corrected. The Change License Apache
2.0 maps to SPDX `Apache-2.0` (referenced in license text, not in the manifest
`license` field which describes the *current* license).

## Consequences

- Uniform, machine-readable licensing across the polyglot monorepo.
- Two services move from MIT (permissive) to BSL (source-available) — intended.
- Three services' Change License changes Non-Profit OSL 3.0 → Apache 2.0, and the
  Change Date horizon shortens 5y → 4y — **flagged for owner confirmation** (see
  proposal "Owner confirmations required").
