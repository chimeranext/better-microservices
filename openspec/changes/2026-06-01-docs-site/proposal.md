# Centralized docs site — one Material-for-MkDocs site for all 6 services + Common

**Date:** 2026-06-01
**Owner:** Andrés (hello@chimeranext.dev)
**Status:** Implemented on branch `docs/mkdocs-site` — pending review/merge
**Domain:** `platform` (cross-service); touches `common`
**Tracking issue:** sub-project #4 of `2026-05-31-monorepo-foundation`

---

## Why (Problem)

The monorepo foundation (`2026-05-31-monorepo-foundation`) consolidated 6 repos
but left documentation **fragmented**:

- Each service documents itself in isolation. Only `agentic-core` (full
  `docs/site/`) and `payments-core` (`docs/mkdocs.yml`) had a real site; the rest
  ship loose `superpowers/` specs and plans with no browsable entry point.
- Cross-service material is **duplicated and ambiguous**. The eventbus broker
  analysis (`eventbus-broker-analysis.md`) exists **byte-for-byte identical**
  (md5 `5fe13714947fcbb60e7ce68248dca9eb`) in **five** services'
  `docs/architecture/` — reading any one copy gives no hint that it is shared, and
  editing one silently diverges the rest.
- There is no single URL a startup evaluating better-microservices can visit to
  compare services side by side.

`openspec/project.md` already commits to the target shape:
> Docs site: Material for MkDocs (GitHub Pages) — one tab per service + `common`.

## What (Decision)

Build **one** Material-for-MkDocs site at `docs/site/`, mirroring the
HabitaNexus reference site (Material, Spanish, `navigation.tabs` + sticky +
sections, custom palette, mermaid via superfences, the same pymdownx set, search
in `es`), published to GitHub Pages at
`https://chimeranext.github.io/better-microservices/`.

Top-level navigation:

- **Inicio** (Home) — docs landing with a 6-service table + navigation help.
- **One tab per service** — `agentic-core`, `compliance-core`, `filing-core`,
  `invoice-core`, `marketplace-core`, `payments-core` — each with sub-sections
  derived from that service's own `docs/`.
- **Common** — cross-service material, starting with the consolidated
  `eventbus-broker-analysis.md` (with explicit provenance).

Aggregation strategy (see `design.md`): **per-service symlinks** from
`docs/site/content/<service>/` → `services/<service>/docs/`. No content is
copied or duplicated; each service's `docs/` stays the single source of truth.

The duplicated eventbus analysis is the **one exception**: it is consolidated as
a single physical file under `content/common/`, and the five per-service copies
are excluded from the published site via `exclude_docs`.

## Scope

**In scope**
- `docs/site/mkdocs.yml`, `requirements.txt`, `content/` (index, common,
  stylesheets, javascripts, service symlinks).
- `.github/workflows/docs.yml` — build + deploy to GitHub Pages.
- This OpenSpec change (`proposal.md` + `design.md` + `tasks.md`).

**Out of scope**
- Enabling GitHub Pages in repo Settings (owner-gated; cannot be automated — see
  `tasks.md`).
- Rewriting or fixing upstream per-service doc content (e.g. broken relative
  links in `marketplace-core/design/schema-extensions.md`). Documented, not
  edited.
- Per-service standalone sites (`agentic-core/docs/site`, `payments-core` site)
  are left in place as source; their pages are reused via symlink.

## Risks / Trade-offs

- **Symlinks on checkout.** Git stores symlinks fine; MkDocs follows them by
  default. The agentic-core subtree already contains two **pre-existing broken
  absolute symlinks** (`specs/superpowers/specs/*`) pointing to local paths —
  excluded via `exclude_docs`, not "fixed".
- **Strict mode off.** The build does not use `--strict` because upstream
  `schema-extensions.md` links to `../../schemas/*.json` files outside the docs
  tree. Documented in the workflow.
