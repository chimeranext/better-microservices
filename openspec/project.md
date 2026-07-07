# better-microservices — OpenSpec Project Governance

> **Source of truth** for how decisions are recorded, tracked, and shipped in this
> monorepo. Convention shared across the ChimeraNext monorepos.

## Overview

`better-microservices` is a monorepo of source-available, independently-selectable
microservices. Any startup can pick the services it needs. Each service keeps its
own license and lifecycle, but they share one repo, one docs site, one issue
tracker, and **one decision-record convention** (this document).

- **Remote (canonical):** `github.com/chimeranext/better-microservices`
- **Tracker:** GitHub Issues on the same repo (the 6 origin repos on `lapc506` are
  archived; their issues are consolidated here — see `service:*` labels).
- **Docs site:** Material for MkDocs (GitHub Pages) — one tab per service + `common`.

## Spec Domains

Every change belongs to exactly one **domain**. Domains map 1:1 to a GitHub
`service:*` label so an OpenSpec change and its tracking issue stay aligned.

| Domain | Label | Stack | Status |
|---|---|---|---|
| `agentic-core` | `service:agentic-core` | Python + Go (TUI) + Dart (UI) | Active |
| `compliance-core` | `service:compliance-core` | Node (pnpm) | Pre-alpha (Fase 1) |
| `filing-core` | `service:filing-core` | Node (skeleton) | **Deferred → 2027** |
| `invoice-core` | `service:invoice-core` | Node (pnpm) | Pre-alpha (Fase 1) |
| `marketplace-core` | `service:marketplace-core` | Node + appchain + Flutter | Active |
| `payments-core` | `service:payments-core` | Node (pnpm) | Skeleton + adapters |
| `vision-core` | `service:vision-core` | Python (hexagonal) | Scaffold (phytopathology vision/MLOps: 3-tier OpenMV/KServe-Triton+vLLM/Jetson, Kubeflow+s3fs, HITL; serves vertivolatam's vertivo_server) |
| `geospatial-core` | `service:geospatial-core` | Python (hexagonal) | Scaffold (remote-sensing land-use; serves habitanexus) |
| `common` | `service:common` | — (cross-service docs/contracts) | Active |
| `platform` | `service:cross-repo` | — (eventbus, sidecar, gRPC Health, OTel) | Active |

`common` and `platform` are non-deployable domains. `common` disambiguates
elements shared across services (e.g. the eventbus broker analysis). `platform`
owns cross-service contracts (sidecar standards, EventBus adapter, gRPC Health v1).

## SOP / PDR / ADR — Governance Distinction

| Artifact | Question it answers | Lives in | File |
|---|---|---|---|
| **PDR** (Product Decision Record) | *What* we build, for whom, *why* | `openspec/changes/<id>/` | `proposal.md` |
| **ADR** (Architecture Decision Record) | *What* technology, *how*, why this approach | `openspec/changes/<id>/` | `design.md` |
| **SOP** (Standard Operating Procedure) | *How we operate* a shipped capability | `docs/site/content/.../common/` | MkDocs page |

A change needs **only the records it warrants**:
- Pure architecture decision → `design.md` only.
- Deferred product decision → `proposal.md` only.
- Standard feature → full triple (`proposal.md` + `design.md` + `tasks.md`).

## Change Lifecycle: `propose → apply → archive`

1. **Propose** — create `openspec/changes/<change-id>/` with the warranted records.
   Open (or link) a GitHub issue with the matching `service:*` label. For
   cross-domain changes, label `service:cross-repo` too.
2. **Apply** — implement via a branch + PR. Keep `tasks.md` checkboxes current.
3. **Archive** — when shipped, consolidate the spec into
   `openspec/specs/<capability>/spec.md` and replace the change folder with a
   single `archived.md` pointer: `Archived → openspec/specs/<capability>/spec.md @ <merge-sha>`.

## Change Naming Convention

- **Pattern:** `YYYY-MM-DD-slug` (the date is the **decision date**, not the impl date).
- **`slug`:** kebab-case, describes the **problem/decision**, not the implementation.
  - ✅ `2026-05-31-monorepo-foundation`
  - ❌ `2026-05-31-run-filter-repo`
- **Monthly variant** `YYYY-MM-slug` is acceptable to group related decisions.
- No sequential `ADR-0001` numbering — identity = date + slug.

## Label Taxonomy

Adopted from `agentic-core` (the most mature of the 6 origin repos), plus an
orthogonal `service:*` dimension. Applied in the GitHub sidebar, **never in the
issue body**.

- **`service:*`** — domain ownership (see table above) + `service:cross-repo`.
- **`type:*`** — `bug` · `chore` · `feature` · `improvement` · `spike` · `design`.
- **`size:*`** — `XS` · `S` · `M` · `L` · `XL` (`XL` = decompose, never apply).
- **`priority:*`** — `must` · `should` · `could` (absorbs `priority/p0`, `(P0/P1/P2)`).
- **`component:*`** — `transport` · `domain` · `application` · `proto` · `postgres`
  · `grpc` · `rest` · `observability` · `vault` · `signature` · `queue` · `inbound`
  · `infra` · `security` · `testing` · `docs`.
- **`scope:*`** — domain-specific provider areas preserved from origin repos
  (`ondato` · `persona` · `ofac` · `hacienda-cr` · `helm` · `ci` …).
- **`security:*`** — `pii` · `audit` · `credentials` · `signature` (cross-cutting).
- **`status:deferred`** — work approved but not active (e.g. all of `filing-core`).
- **`flag:*`** — `blocked` · `help-wanted` · `quick-win` · `epic`.

Per-service roadmaps (Fase 1–N) are tracked as **GitHub Milestones per service**,
not labels.

## When to Create a Change

Create an OpenSpec change when a decision: (a) changes a public contract or data
model, (b) chooses one technology/approach over alternatives, (c) defines or defers
a product capability, or (d) is cross-domain. Routine bugfixes and chores do not
need a change — just an issue.

## Decision Records Location Enforcement

New dated decision records MUST be created under `openspec/changes/`. Writing dated
`.md` files to `docs/superpowers/specs/`, `docs/decisions/`, `docs/adr/`, or
`docs/architecture-decisions/` is an anti-pattern (those folders are legacy staging
and superseded by OpenSpec). A PreToolUse hook enforces this — see the
`2026-05-31-openspec-hooks` change (sub-project #5).
