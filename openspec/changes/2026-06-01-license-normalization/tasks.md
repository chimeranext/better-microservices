# License Normalization — Tasks

> Implementation checklist for [`proposal.md`](./proposal.md) / [`design.md`](./design.md).
> Sub-project #2 of `2026-05-31-monorepo-foundation`.

## Status (2026-06-01)

- ✅ Re-verified license state of all 6 services.
- ✅ Normalized 4 existing BSL files + added BSL to the 2 that had none.
- ✅ SPDX `BUSL-1.1` set in every manifest.
- ✅ OpenSpec change authored.
- ⏳ Owner confirmation of Licensor entity + Apache 2.0 + 4y horizon (see proposal).

## Phase 0 — Audit (done)

- [x] Verify `services/<svc>/LICENSE` and `LICENSE.md` for all 6.
  - compliance / filing / invoice → BSL 1.1 (Non-Profit OSL 3.0, 5y, individual licensor).
  - payments-core → BSL 1.1 (Apache 2.0, fixed 2031-04-18, short form, stale Siblings note).
  - agentic-core / marketplace-core → **no LICENSE file**; manifests declared MIT.
- [x] Extract parameters from the 4 originals; record inconsistencies in `design.md`.

## Phase 1 — Normalize the existing 4

- [x] `services/compliance-core/LICENSE.md` — Licensor → company, author → Andrés, Apache 2.0, Change Date 2030-04-16.
- [x] `services/filing-core/LICENSE.md` — same template, Change Date 2030-04-16.
- [x] `services/invoice-core/LICENSE.md` — same template, Change Date 2030-04-16.
- [x] `services/payments-core/LICENSE.md` — replace short form with uniform template, Change Date 2030-04-18; drop inaccurate "Siblings" note.

## Phase 2 — Add BSL to the 2 unlicensed services

- [x] `services/agentic-core/LICENSE.md` — new, Change Date 2030-03-25; polyglot/third-party header.
- [x] `services/marketplace-core/LICENSE.md` — new, Change Date 2030-04-13; polyglot/third-party header.

## Phase 3 — Manifest SPDX

- [x] `services/agentic-core/pyproject.toml` — `license = "BUSL-1.1"` (was MIT).
- [x] `services/agentic-core/package.json` — add `"license": "BUSL-1.1"`.
- [x] `services/compliance-core/package.json` — already `BUSL-1.1` (no change).
- [x] `services/filing-core/package.json` — add `"license": "BUSL-1.1"`.
- [x] `services/invoice-core/package.json` — add `"license": "BUSL-1.1"`.
- [x] `services/marketplace-core/package.json` — `BUSL-1.1` (was MIT); `files[] LICENSE → LICENSE.md`; fix `author`.
- [x] `services/payments-core/package.json` — `BSL-1.1` → `BUSL-1.1`.

## Phase 4 — Ship

- [x] `git add -A` + commit (Co-Authored-By trailer).
- [x] `git push -u origin chore/license-normalization`.
- [ ] Open PR; **do not merge to `main`** until owner confirms the 3 flagged parameters.
