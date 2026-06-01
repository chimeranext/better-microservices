# Centralized docs site — Tasks

> Implementation checklist for [`proposal.md`](./proposal.md) / [`design.md`](./design.md).
> Branch: `docs/mkdocs-site`. `$ROOT` = repo root of `chimeranext/better-microservices`.

## Status (2026-06-01)

- ✅ Site builds locally (`mkdocs build` → exit 0, 6 service tabs + Common rendered).
- 🚧 **GATED** — enabling GitHub Pages in repo Settings (owner-only).

## Phase 0 — Inventory (done)

- [x] Enumerate `services/<name>/docs/` for all 6 services.
- [x] Confirm `eventbus-broker-analysis.md` is byte-identical across 5 services
      (md5 `5fe13714947fcbb60e7ce68248dca9eb`).
- [x] Read reference site `habitanexus/monorepo/docs/site/` (mkdocs.yml,
      requirements.txt, content/index.md, stylesheets, javascripts).
- [x] Reuse navs from `agentic-core/docs/site/mkdocs.yml` and
      `payments-core/docs/mkdocs.yml`.

## Phase 1 — Aggregation (done)

- [x] Decide strategy → **symlinks** (ADR §1).
- [x] Create `docs/site/content/<service>` → `../../../services/<service>/docs`
      relative symlinks (6).
- [x] Verify symlinks resolve from the build dir.

## Phase 2 — Site config (done)

- [x] `docs/site/mkdocs.yml` — Material, `language: es`, custom palette,
      `navigation.tabs` + `tabs.sticky` + `sections`, mermaid superfence, full
      pymdownx set, `search.lang: es`, retargeted `site_url`/`repo_*`/`edit_uri`.
- [x] `nav:` = Inicio + 6 service sections (sub-entries) + Common.
- [x] `exclude_docs` for built sites, per-service configs, broken symlinks, and
      the 5 duplicated eventbus copies.
- [x] `docs/site/requirements.txt` (copied from habitanexus reference).

## Phase 3 — Content (done)

- [x] `content/index.md` — landing with 6-service table + navigation help.
- [x] `content/stylesheets/better-microservices.css` (renamed + indigo palette).
- [x] `content/javascripts/mermaid-init.mjs` (rebranded colors).
- [x] `content/common/index.md` — defines "Common".
- [x] `content/common/eventbus-broker-analysis.md` — consolidated copy with
      `provenance` front-matter + admonition (md5 + 5 origin paths).

## Phase 4 — CI (done)

- [x] `.github/workflows/docs.yml` — install requirements, `mkdocs build`,
      `upload-pages-artifact` + `deploy-pages` on `main`.

## Phase 5 — Verify (done)

- [x] `pip install -r docs/site/requirements.txt` (venv) succeeds.
- [x] `mkdocs build -f docs/site/mkdocs.yml` → exit 0. Only 3 INFO/WARNING items,
      all from pre-existing upstream broken links (documented, not edited).
- [x] Built site has top-level dirs: `agentic-core`, `compliance-core`,
      `filing-core`, `invoice-core`, `marketplace-core`, `payments-core`,
      `common`; Common publishes the single eventbus page.

## Phase 6 — Ship

- [x] `git add -A` + commit on `docs/mkdocs-site`.
- [x] `git push -u origin docs/mkdocs-site`.
- [ ] Open PR → review → merge to `main` (do **not** merge directly).

## 🚧 GATED — owner-only follow-up

- [ ] **Enable GitHub Pages**: repo **Settings → Pages → Build and deployment →
      Source: "GitHub Actions"**. Restricted to the repo owner; cannot be done
      from a workflow or `gh` by a non-admin. Until enabled, the `deploy` job's
      `actions/deploy-pages` step fails even though `build` is green.
