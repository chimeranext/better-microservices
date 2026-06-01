# ADR — Docs-site content aggregation & navigation

**Date:** 2026-06-01
**Domain:** `platform`
**Decision:** Single Material-for-MkDocs site; aggregate per-service docs via
**symlinks**; consolidate duplicated cross-service docs into **Common**.

---

## 1. Content-aggregation strategy

MkDocs renders only what lives under a single `docs_dir`. The six services keep
their docs in `services/<name>/docs/`. We need those pages under
`docs/site/content/` **without duplicating them**. Three options evaluated:

### Option A — `mkdocs-monorepo-plugin`

Each service ships its own `mkdocs.yml`; the root site `!include`s them.

- ➖ Requires **every** service to have a valid `mkdocs.yml` with a `nav`. Today
  only `agentic-core` and `payments-core` do; the other four ship only loose
  `superpowers/` specs. We'd have to author 4 new per-service `mkdocs.yml` files
  and keep their navs in sync — more surface, not less.
- ➖ The plugin namespaces nav and rewrites paths, which fights the
  "one tab per service, sub-sections from that service" goal and complicates the
  Common consolidation.
- ➖ Extra dependency + its own quirks (slug collisions, `!include` resolution).

### Option B — Symlinks `content/<service>` → `services/<service>/docs` ✅ CHOSEN

One `mkdocs.yml`; `content/<service>` is a relative symlink to the service's
`docs/`. MkDocs follows symlinks, so every service page is addressable as
`content/<service>/<path>` with **zero copies**.

- ➕ **Zero duplication.** The service `docs/` stays the single source of truth;
  editing there updates the site.
- ➕ **One nav, full control.** We hand-build `nav:` so each service tab gets
  exactly the sub-sections we want, in the order we want.
- ➕ No extra plugin; works with stock MkDocs + Material.
- ➖ Symlinks must survive checkout (they do in git) and the CI runner must use a
  real filesystem (GitHub `ubuntu-latest` does).
- ➖ Auto-discovery also pulls in noise (built `site/` output, `myst.yml`, broken
  symlinks). Handled with `exclude_docs`.

### Option C — Copy at build time

A pre-build step `cp -r services/*/docs content/`.

- ➖ Duplication on disk; risk of stale copies committed by accident.
- ➖ Needs a custom build step in every environment (local + CI) — exactly the
  drift we want to avoid.

### Decision

**Option B (symlinks).** It satisfies the explicit preference to avoid
duplication, needs no per-service `mkdocs.yml`, and keeps a single hand-authored
nav. The monorepo plugin (A) would force us to manufacture 4 missing per-service
configs purely to satisfy the plugin — strictly more maintenance for a worse nav.

### `exclude_docs` (noise filtering)

Symlink auto-discovery is filtered in `mkdocs.yml`:

| Excluded | Why |
|---|---|
| `agentic-core/site/site/` | agentic-core's **already-built** HTML/JSON site |
| `agentic-core/site/mkdocs.yml`, `payments-core/mkdocs.yml`, `payments-core/requirements.txt` | per-service standalone-site config, not pages |
| `agentic-core/specs/myst.yml` | MyST metadata, not a page |
| `agentic-core/specs/superpowers/` | **pre-existing broken absolute symlinks** in the repo |
| `*/architecture/eventbus-broker-analysis.md` (5 services, listed explicitly) | duplicated → consolidated into Common |

## 2. Cross-service "Common" consolidation

`eventbus-broker-analysis.md` is identical (md5 `5fe13714947fcbb60e7ce68248dca9eb`,
1048 lines) in `agentic-core`, `compliance-core`, `invoice-core`,
`marketplace-core`, `payments-core`. It is **inherently cross-service** — it
decides the broker that unites marketplace/payments/invoice/compliance plus the
gateway integrations and the Dart apps.

- One physical copy lives at `content/common/eventbus-broker-analysis.md`, with a
  `provenance` front-matter block + an admonition recording the md5 and the five
  origin paths.
- The five per-service copies are **excluded** from the build, so the site
  publishes the analysis exactly once, under **Common**.
- `content/common/index.md` defines what "Common" means (cross-service /
  duplicated / platform-contract material) and maps to the non-deployable
  `common` + `platform` domains from `openspec/project.md`.

Canonical edit-ownership of the consolidated doc is left to a future `platform`
PDR; until then, edit the Common copy and propagate.

## 3. Navigation structure

```
Inicio (index.md)
agentic-core
  Overview · Getting Started (Quick Start / Standalone / TUI)
  API Reference (REST / WebSocket / Ollama / A2A)
  Guides (Providers / Personas / SOUL.md)
  Architecture (Overview / Deployment)
  Specs & Plans (WhatsApp adapter, Phase-1 design+plan, Standalone backend,
                 Agent Studio, Flutter Web UI, Channel-config debug panel)
  Operations (Disaster Recovery / GitHub Workspace Setup / Nice-to-Have)
compliance-core
  Design Specification · Fase 1 Implementation Plan
filing-core
  Preliminary Design · Trigger + Skeleton Activation Plan
invoice-core
  Design Specification · Fase 1 Implementation Plan
marketplace-core
  Design (JSON Schema Renderer / ReputationPort / Schema Extensions / Standalone)
  References (ISO 22000 / 22005 / 28000 / 28004-2)
payments-core
  Overview · Governance (Overview/Rubric) · Architecture · Ports (Overview/Escrow)
  Adapters (Overview/Stripe/OnvoPay) · Integrations (Overview/Consumers/AduaNext)
  Donations & Crowdfunding · Security · API (Overview/Reference)
  References · Legal · Operations
Common
  Overview (index.md) · Bus de Eventos (consolidado)
```

### Per-service sub-tab → source mapping

| Tab | Sub-sections derived from |
|---|---|
| agentic-core | `docs/site/docs/*` (polished site), `docs/specs/whatsapp-adapter.md`, `docs/superpowers/{plans,specs}/*`, `docs/{disaster-recovery,github-workspace-setup-report,nice-to-have-features}.md` |
| compliance-core | `docs/superpowers/{specs,plans}/*` |
| filing-core | `docs/superpowers/{specs,plans}/*` |
| invoice-core | `docs/superpowers/{specs,plans}/*` |
| marketplace-core | `docs/design/*`, `docs/references/*` |
| payments-core | `docs/content/{index.md,docs/**}` (mirrors its prior standalone nav) |
| Common | consolidated `eventbus-broker-analysis.md` |

## 4. Theme parity with reference (habitanexus)

Same Material config, Spanish, `navigation.tabs` + `navigation.tabs.sticky` +
`navigation.sections`, custom palette (light/slate), mermaid via
`pymdownx.superfences` custom fence + `javascripts/mermaid-init.mjs`, identical
pymdownx extension set, `search.lang: es`. Renamed brand assets
`habitanexus.*` → `better-microservices.*`; palette changed to indigo/amber/cyan;
`site_name`/`site_url`/`repo_*`/`edit_uri`/`magiclink` retargeted to
`chimeranext/better-microservices`.

## 5. CI / Pages

`.github/workflows/docs.yml`: checkout (full history for git-date plugin) →
setup-python 3.12 → `pip install -r docs/site/requirements.txt` →
`mkdocs build` (not `--strict`; upstream `schema-extensions.md` has links to
out-of-tree `../../schemas/*.json`) → on `main`, `upload-pages-artifact` +
`deploy-pages`. Enabling Pages (Settings → Pages → Source: GitHub Actions) is
**owner-gated** and cannot be automated.
