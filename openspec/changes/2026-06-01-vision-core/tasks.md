# vision-core — Tasks

> Implementation checklist for [`proposal.md`](./proposal.md) (PDR) /
> [`design.md`](./design.md) (ADR). Branch: `chore/vision-core-scaffold`.
> `$ROOT` = repo root of `chimeranext/better-microservices`.

## Status (2026-06-01)

- ✅ Scaffold complete on branch `chore/vision-core-scaffold` (this change).
- 🚧 Inference is **stubbed** (port ABCs + `NotImplementedError` adapters) — no
      model weights, no running server. Apply phases below wire real inference.

## Phase 0 — Research (done)

- [x] Digest Kubeflow pipelines, RF-DETR→Jetson, RF-DETR & YOLO repos, arXiv
      2509.25164 / 2511.09554, NVIDIA AgTech + cuDNN, Agrio API.
- [x] Pull + summarize YouTube `MgbP5szEBDo` transcript (yt-dlp).
- [x] Study `vertivolatam/monorepo` phytopathology domain → integration contract.
- [x] Record model comparison matrix + verdict in `design.md` §2.

## Phase 1 — OpenSpec change (done)

- [x] `proposal.md` (PDR), `design.md` (ADR), `tasks.md` — dojo-os convention
      (no YAML frontmatter; bold metadata under H1).

## Phase 2 — Scaffold (done)

- [x] `services/vision-core/README.md` (README-first).
- [x] `pyproject.toml` (SPDX `BUSL-1.1`), `ruff.toml`, `package.json` (Turbo).
- [x] `LICENSE.md` — BSL 1.1, Change Date 2031-06-01, Change License Non-Profit
      OSL 3.0, Licensor ChimeraNext Shared Services LLC, author Andrés/lapc506.
- [x] Domain skeleton (`Image`, `VideoFrame`, `Mask`, `Segmentation`, entities,
      events, `AreaQuantifier`, `SeverityScorer`).
- [x] Application ports: `SegmentationModelPort`, `VideoStreamPort`,
      `InferencePort`, `ModelRegistryPort` + commands/queries.
- [x] Secondary adapters (stubs): `UltralyticsYOLOAdapter`, `RFDETRAdapter`,
      `LocalFsModelRegistryAdapter`, `OpenCVVideoStreamAdapter`.
- [x] Primary adapters: gRPC server stub + REST/FastAPI app.
- [x] `proto/vision/v1/vision.proto` — `SegmentationService` contract.
- [x] `tests/` skeleton (unit/integration/e2e).
- [x] `deployment/`: Jetson Dockerfile + notes, Kubeflow pipeline stub, k8s
      manifests (KServe + Deployment).
- [x] `examples/`: gRPC client, REST client, edge Jetson snippet.

## Phase 3 — Inference (apply, deferred)

- [ ] Implement `UltralyticsYOLOAdapter` against `ultralytics` (YOLO26-seg).
- [ ] Implement `RFDETRAdapter` against `rfdetr` (rf-detr-seg).
- [ ] Generate gRPC stubs (`make proto`) into `adapters/primary/grpc/generated/`.
- [ ] `AreaQuantifier` / `SeverityScorer` real implementations + unit tests.
- [ ] Wire `InferencePort` → `LocalTensorRTAdapter` + `KServeInferenceAdapter`.

## Phase 4 — Edge (apply, deferred)

- [ ] Build TensorRT FP16/INT8 engines on JetPack 5+/cuDNN; benchmark ms/frame.
- [ ] `GStreamerJetsonAdapter` hardware decode; real-time `SegmentVideo`.
- [ ] Edge model-sync from `ModelRegistryPort`.

## Phase 5 — Cloud / Kubeflow (apply, deferred)

- [ ] Flesh out `deployment/kubeflow/pipeline.py` (ingest→train→eval→export→
      register→promote); Katib HPO; KServe serving.
- [ ] `KubeflowModelRegistryAdapter` against the cluster registry.
- [ ] First per-crop fine-tune (lettuce/basil/tomato) on captured datasets.

## Phase 6 — vertivolatam integration (apply, cross-repo, deferred)

- [ ] In `vertivolatam` repo: Serverpod phytopathology → `vision.v1` gRPC client.
- [ ] Map `Segmentation` → `DiseaseDetection` / `PestIdentification` /
      `NutritionalDeficiency` rows (Vertivo-side, not here).
- [ ] End-to-end: greenhouse frame → vision-core → persisted detection.

## Phase 7 — Ship (this change)

- [x] `git add -A` + commit on `chore/vision-core-scaffold`.
- [ ] `git push -u origin chore/vision-core-scaffold`.
- [ ] Open PR → review → merge (do **not** merge directly).

## ⚠️ Owner decisions (gate before merge / before edge ship)

- [ ] **Edge model license:** ship **YOLO26-seg (AGPL-3.0)** on Vertivo commercial
      edge devices → needs Ultralytics **Enterprise license** or accept copyleft;
      **or** standardize the edge on **RF-DETR-Seg (Apache-2.0)** and drop YOLO.
      Affects the *shipped* default; the port supports both regardless.
- [ ] Confirm `service:vision-core` label + GitHub Milestone (Fase 1) creation.
- [ ] Confirm vision-core is added to `openspec/project.md` Spec Domains table
      (7th row) as a follow-up `platform` edit.
