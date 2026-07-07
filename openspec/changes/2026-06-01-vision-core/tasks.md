# vision-core — Tasks

> Implementation checklist for [`proposal.md`](./proposal.md) (PDR) /
> [`design.md`](./design.md) (ADR). Branch: `chore/vision-core-mlops-update`.
> `$ROOT` = repo root of `chimeranext/better-microservices`.

## Status (2026-06-01, MLOps architecture update)

- ✅ Scaffold + MLOps architecture update on `chore/vision-core-mlops-update`.
- 🚧 Inference is **stubbed** (port ABCs + `NotImplementedError` adapters). The
      pure domain + the MQTT topic parser + the HITL retrain gate are **real and
      tested** (23 passed, 2 skipped). Apply phases below wire real inference.

## Phase 0 — Research (done)

- [x] Digest Kubeflow pipelines, RF-DETR→Jetson, RF-DETR & YOLO repos, arXiv
      2509.25164 / 2511.09554, NVIDIA AgTech + cuDNN, Agrio API.
- [x] Digest the **ISS/Kubeflow case study** s3fs/MinIO + KServe-RBAC insight.
- [x] Digest OpenMV Nicla Vision (Tier 0) + KServe vLLM/Triton runtimes.
- [x] **Full vertivolatam monorepo analysis** — apps, Serverpod domains, MQTT
      capture contract, `.spy.yaml` phytopathology models → §5 integration.
- [x] Record the model + **topology** decision matrices + verdicts in `design.md`.

## Phase 1 — OpenSpec change (done)

- [x] `proposal.md` (PDR), `design.md` (ADR), `tasks.md` — shared ChimeraNext OpenSpec convention
      (no YAML frontmatter; bold metadata under H1).

## Phase 2 — Scaffold (done)

- [x] README-first `README.md`, `pyproject.toml` (SPDX `BUSL-1.1`), `ruff.toml`,
      `package.json`, `LICENSE.md` (BSL 1.1).
- [x] Domain (`Image`, `VideoFrame`, `Mask`, `Segmentation`, `Capture`,
      `Diagnosis`, `Correction`, `CaptureKind`, entities, events,
      `AreaQuantifier`, `SeverityScorer`).
- [x] Application ports — original 4 (`SegmentationModelPort`, `VideoStreamPort`,
      `InferencePort`, `ModelRegistryPort`) **+ MLOps tier ports**
      (`ObjectStoragePort`, `DetectionRuntimePort`, `VlmDiagnosisPort`,
      `CaptureIngestPort`, `ActiveLearningPort`).
- [x] Secondary adapters (stubs): `UltralyticsYOLOAdapter`, `RFDETRAdapter`,
      `LocalFsModelRegistryAdapter`, `OpenCVVideoStreamAdapter`,
      `S3fsObjectStorageAdapter`, `TritonDetectionAdapter`,
      `VllmDiagnosisAdapter`, `MqttCaptureIngestAdapter` (with **real** topic
      parser), `MinioActiveLearningAdapter` (with **real** retrain gate).
- [x] `proto/vision/v1/vision.proto` — `SegmentationService` + `DiagnosisService`
      + `CaptureIngestService` + `ActiveLearningService`.
- [x] `tests/` — domain + MQTT parser + retrain gate real; adapter stubs assert
      `NotImplementedError`.
- [x] `deployment/`: `openmv/` (Tier 0), `jetson/` (Tier 2), `kubeflow/pipeline.py`
      (Dask→Katib→PyTorchJob→KServe + s3fs + HITL trigger), `k8s/`
      (`kserve-triton-detection.yaml`, `kserve-vllm-diagnosis.yaml`, `rbac.yaml`).
- [x] `examples/`: gRPC client, REST client, edge snippet.

## Phase 3 — Inference + data plane (apply, deferred)

- [ ] `S3fsObjectStorageAdapter` against MinIO (s3fs) — weights/datasets/captures.
- [ ] `TritonDetectionAdapter` against the Triton KServe v2 endpoint.
- [ ] `VllmDiagnosisAdapter` against the vLLM KServe endpoint (multimodal,
      structured output, detection-context grounding).
- [ ] `MqttCaptureIngestAdapter.submit` — EMQX subscription + inference queue.
- [ ] `MinioActiveLearningAdapter.submit_correction` — COCO write-back + trigger.
- [ ] Generate gRPC stubs (`make proto`) for the 4 services.
- [ ] `AreaQuantifier` / `SeverityScorer` real impls (align severity vocab to the
      `.spy.yaml` `mild/moderate/severe/critical`).

## Phase 4 — Cloud (Phase 1, authoritative) — Kubeflow + KServe (apply)

- [ ] Stand up MinIO + buckets (`captures`, `datasets`, `models`); creds secret.
- [ ] Apply `rbac.yaml` (KServe deployer Role + ServiceAccount + MinIO secret).
- [ ] Flesh out `pipeline.py`: Dask cluster, Katib Experiment, **PyTorchJob (DDP
      multi-GPU)** via Training Operator, eval/export, register + KServe deploy —
      all I/O via **s3fs** (NOT KFP artifacts).
- [ ] Deploy `kserve-triton-detection.yaml` + `kserve-vllm-diagnosis.yaml`.
- [ ] First per-crop fine-tune (lettuce/basil/tomato) on captured datasets.
- [ ] Wire the HITL active-learning loop end-to-end (low-conf → correct → retrain).

## Phase 5 — Edge (Phase 2) — Jetson Orin (apply, gated on supply + convergence)

- [ ] Build TensorRT FP16/INT8 engines (RF-DETR preferred) on JetPack 5+/cuDNN.
- [ ] `TensorRTDetectionAdapter` + `GStreamerJetsonAdapter` (motion-burst video).
- [ ] Edge model-sync from `ModelRegistryPort`; low-conf escalation to cloud vLLM.

## Phase 6 — vertivo_server integration (apply, cross-repo, deferred)

- [ ] In `vertivo_server`: add `grpc` + `protobuf` to `pubspec.yaml`; generate the
      **grpc-dart** client from `vision.proto` (`protoc --dart_out=grpc:`).
- [ ] `PhytopathologyEndpoint` → `VisionCoreClient` (gRPC) calling
      `segmentImage` / `diagnoseImage`; persist `DiseaseDetection` /
      `PestIdentification` / `NutritionalDeficiency` (mapping per design §5.3).
- [ ] Wire the downstream chain: detection → `Alert` (`alertType=phytopathology`)
      + `TreatmentRecommendation` + AI `Anomaly`.
- [ ] End-to-end: OpenMV capture → MQTT → vertivo_server → vision-core → persisted
      detection + alert + treatment.

## Phase 7 — Ship (this change)

- [x] `git add -A` + commit on `chore/vision-core-mlops-update`.
- [ ] `git push -u origin chore/vision-core-mlops-update`.
- [ ] Open PR → review → merge (do **not** merge directly).

## ⚠️ Owner decisions (gate before merge / before each phase)

- [ ] **Edge model license (Phase 2 ship):** RF-DETR (Apache-2.0, recommended
      default) vs YOLO26 (AGPL-3.0 → needs Ultralytics **Enterprise license**).
- [ ] **Serverpod ↔ vision-core transport:** generated **grpc-dart** client
      (recommended — typed + streaming) vs REST mirror via `package:http`.
- [ ] **VLM choice + size:** Qwen-VL vs LLaVA; param size vs GPU budget; whether
      to LoRA-adapt per crop.
- [ ] **Retrain-trigger thresholds:** new-data count `N`, drift metric/threshold,
      schedule cadence.
- [ ] Confirm `service:vision-core` label + GitHub Milestone (Fase 1) creation.
- [ ] Confirm vision-core row in `openspec/project.md` Spec Domains table.
