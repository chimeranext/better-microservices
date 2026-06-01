# vision-core

**Phytopathology (pest & disease) vision + MLOps engine for autonomous indoor
HYDROPONIC greenhouses.** Detection (bounding boxes / masks / confidence) **plus**
VLM diagnosis (disease + severity + free-text), delivered as a **3-tier phased
MLOps topology** on Kubeflow. Built as a shared, source-available microservice in
the `better-microservices` monorepo, and designed to power the
**[vertivolatam](https://github.com/vertivolatam/monorepo) (Vertivo)** product.

> **vision-core contains NO product-specific business logic.** It returns generic
> segmentation + diagnosis; the consumer — Vertivo's **`vertivo_server`**
> (Serverpod 3.4.1, Dart) — maps results onto its own domain (`DiseaseDetection`
> rows + alerts + treatment recommendations). Same boundary rule `agentic-core`
> follows.

## 3-tier phased topology

- **Tier 0 — On-camera (OpenMV Nicla Vision), NOW.** Tiny on-sensor FOMO/tinyML
  pre-trigger ("is there something?") + high-res capture. Cheap/abundant —
  **sidesteps the NVIDIA Jetson Orin Nano scarcity**.
- **Tier 1 — Cloud (Phase 1, authoritative).** KServe with **two**
  InferenceServices: **Triton** (YOLO26 / RF-DETR detection) **+ vLLM** (a VLM,
  e.g. Qwen-VL/LLaVA, for text diagnosis). The VLM is **always cloud**. HITL /
  active-learning retraining lives here.
- **Tier 2 — Edge (Phase 2).** Jetson Orin runs lightweight **detection**
  in-greenhouse once models converge and Jetson supply recovers; the **VLM stays
  cloud** (low-confidence escalations only). RF-DETR (Apache-2.0) is the
  recommended shipped edge default.

**Capture phasing:** Phase 1 = time-lapse photos (disease evolves over hours/days
→ batch); Phase 2 = continuous/burst video for fast-moving insects (OpenMV motion
triggers). Photos default.

**MLOps stack (Kubeflow):** Dask (preprocess) → Katib (HPO) → Training Operator
(PyTorch DDP multi-GPU) → KServe deploy, with a first-class **`ObjectStoragePort`
(s3fs/MinIO)** as the data backbone — because KServe/Katib/PyTorchJob do **not**
use KFP's native artifact I/O (the ISS/Kubeflow s3fs workaround).

**License:** Business Source License 1.1 (`BUSL-1.1`) — see [`LICENSE.md`](./LICENSE.md).

---

## Why segmentation (not just classification or detection)

Vertivo's phytopathology backend persists, per detection, **how much** of the
plant is affected (`affectedAreaPercent`) and **which parts** are affected
(`anatomicalParts`). Whole-image **classification** ("this plant has powdery
mildew") cannot produce either. **Bounding-box detection** over-counts area
(boxes include healthy pixels). Only **instance/semantic segmentation** yields
pixel-accurate masks from which affected-area % and per-part involvement are
computed directly.

Segmentation is therefore the core primitive: detection falls out of it for free
(every mask has a box), and classification is the trivial reduction.

## What it does

| Task | Output |
|---|---|
| **Disease ID** | masks of lesions + class + confidence + affected-area % + severity |
| **Pest detection** | masks of pests + species/class + confidence |
| **Nutritional deficiency** | masks of deficiency patterns + class |
| **Plant-species ID** | species label per plant instance |
| **Crop monitoring** | per-frame health segmentation over a video stream |

…on **still images** (user-uploaded diagnosis photos, snapshots) and **video
streams** (real-time greenhouse camera, batch crop sweeps).

## Models

Two state-of-the-art segmentation-capable model families are supported behind one
port (`SegmentationModelPort`), so the choice is made at **deploy time**, not
baked in:

| | **Ultralytics YOLO-seg** (YOLO26/YOLO11) | **RF-DETR-Seg** (Roboflow) |
|---|---|---|
| Architecture | CNN, one-stage | DETR transformer (DINOv2) |
| Seg accuracy (COCO mask AP50:95) | up to ~47.0 | **up to 49.9** |
| Small lesions / cluttered canopy | good | **better** (transformer context) |
| Speed | **fastest** (≈2.1 ms/frame seg, T4 TRT) | competitive, heavier |
| Edge / Jetson fit | **excellent** (tiny, mature TRT) | good (TRT FP16, JetPack 5+) |
| License | **AGPL-3.0** / paid Enterprise | **Apache-2.0** (Nano→Large) |

Plus a **VLM tier** (vLLM/KServe, always cloud): a vision-language model
(Qwen-VL / LLaVA) turns an image + detection context into a human-readable
diagnosis (disease type/name, severity, free-text rationale) — the part a
zero-agronomy-knowledge user actually needs.

**Defaults** (see [ADR §2 / §2b](../../openspec/changes/2026-06-01-vision-core/design.md)):

- **Cloud detection (Phase 1):** **RF-DETR-Seg** (Apache-2.0) on Triton — higher
  mask accuracy on small lesions, commercially clean. YOLO26 also behind the port.
- **Edge detection (Phase 2):** **RF-DETR** recommended (Apache-2.0; avoids YOLO
  AGPL-3.0 / Ultralytics Enterprise on a commercial edge device).
- **Diagnosis (all phases):** **vLLM** — always cloud.

## Architecture

Explicit Architecture (Hexagonal + DDD), identical to `agentic-core`. All arrows
point inward; the domain has zero external imports; adapters implement ports.

```
Primary Adapters (gRPC, REST/FastAPI)   — call into →
  Application Layer (Commands, Queries, Ports)   — uses →
    Domain Layer (Image, Frame, Mask, Segmentation, AreaQuantifier, SeverityScorer)
  Application Layer   ← implemented by —
Secondary Adapters (UltralyticsYOLO, RF-DETR, ModelRegistry, VideoStream)
```

### Ports

| Port | Role | Adapters |
|---|---|---|
| `SegmentationModelPort` | *what* a model outputs (Image → Segmentation) | `UltralyticsYOLOAdapter`, `RFDETRAdapter` |
| `InferencePort` | *where* it runs (Jetson TensorRT vs cloud KServe) | `LocalTensorRTAdapter`, `KServeInferenceAdapter` |
| `VideoStreamPort` | decode a stream → frames, with sampling | `OpenCVVideoStreamAdapter`, `GStreamerJetsonAdapter` |
| `ModelRegistryPort` | resolve/pull/promote models per crop | `LocalFsModelRegistryAdapter`, `KubeflowModelRegistryAdapter` |
| **`ObjectStoragePort`** | MinIO/S3 via **s3fs** (weights · datasets · captures) | `S3fsObjectStorageAdapter` |
| **`DetectionRuntimePort`** | Tier-1/2 detection — Triton/KServe (cloud) / TensorRT (edge) | `TritonDetectionAdapter` |
| **`VlmDiagnosisPort`** | Tier-1 VLM diagnosis — vLLM/KServe (**always cloud**) | `VllmDiagnosisAdapter` |
| **`CaptureIngestPort`** | accept a capture from vertivo_server / MQTT bridge | `MqttCaptureIngestAdapter` |
| **`ActiveLearningPort`** | HITL — agronomist correction → MinIO → retrain | `MinioActiveLearningAdapter` |

## Quickstart

```bash
cd services/vision-core
python3.12 -m venv .venv && source .venv/bin/activate
pip install -e ".[dev]"

pytest -q          # domain + MQTT parser + retrain gate real (23 passed, 2 skipped)
make proto         # generate gRPC stubs from proto/vision/v1/vision.proto
make lint          # ruff
make typecheck     # mypy
```

> **Scaffold status:** the domain (area/severity quantification, model-registry
> resolution) is **real and tested**. Model adapters and the gRPC/REST servers are
> **stubs that raise `NotImplementedError`** — inference is wired in apply Phase 3.
> See [`tasks.md`](../../openspec/changes/2026-06-01-vision-core/tasks.md).

## vertivolatam integration

**The executor is `vertivo_server`** (Serverpod 3.4.1, Dart) — its
`PhytopathologyEndpoint` calls vision-core and persists results. The Raspberry
orchestrator is the **edge capture** layer (it publishes captures to EMQX), not
the caller. Full chain:

```
raspberry / OpenMV (capture) → MQTT (EMQX) → vertivo_server (Serverpod ingest)
  → vision-core gRPC (Triton detection + vLLM diagnosis)
    → vertivo_server persists DiseaseDetection / PestIdentification
      → alerts + treatment_recommendation
```

### Dart ↔ Python crossing

vision-core exposes gRPC `vision.v1`; `vertivo_server` (Dart) consumes it via a
**generated grpc-dart client** (`protoc --dart_out=grpc:` over the *same*
`vision.proto` — single source of truth), or via the **REST mirror** (`POST
/v1/segment`, `POST /v1/diagnose`) with `package:http`. grpc-dart is recommended
(typed + `SegmentVideo` streaming). The Dart pubspec does not yet depend on
grpc/protobuf — adding it is the Phase-6 integration task. See
[`design.md` §5](../../openspec/changes/2026-06-01-vision-core/design.md) for the
full architecture + the cross-language contract.

### Field mapping → `vertivo_server` `.spy.yaml`

| `vision.v1` field | Vertivo model field | Produced by |
|---|---|---|
| `masks[].class_name` | `DiseaseDetection.diseaseName`/`diseaseType` | Triton labels |
| `masks[].confidence` | `confidence` | Triton score |
| `affected_area_percent` | `affectedAreaPercent` | `AreaQuantifier` |
| `severity` | `severity` (`mild/moderate/severe/critical`) | `SeverityScorer` / VLM |
| `masks[].anatomical_part` | `anatomicalParts` | label taxonomy |
| `Diagnosis.disease_type` | `diseaseType` (`fungal/bacterial/…`) | **vLLM** |
| `Diagnosis.diagnosis_text` | `notes` | **vLLM** free-text |
| `Diagnosis.recommended_action` | seeds `TreatmentRecommendation` | **vLLM** |
| `image_ref` | `imageUrl` | passthrough (MinIO ref) |
| `model_version` | `aiModelVersion` | `ModelRegistryPort` |

### Contract surface — gRPC `vision.v1` ([proto](./proto/vision/v1/vision.proto))

- **`SegmentationService`** (Triton): `SegmentImage`, `SegmentVideo` (stream,
  Phase 2 bursts), `ListModels` / `GetModelForCrop` / `HealthCheck`.
- **`DiagnosisService`** (vLLM): `DiagnoseImage` — image + detection context →
  diagnosis.
- **`CaptureIngestService`**: `SubmitCapture` — MQTT capture ref ingest.
- **`ActiveLearningService`**: `SubmitCorrection` — HITL agronomist correction.
- **REST mirror** `POST /v1/segment`, `POST /v1/diagnose`.

`vertivo_server` owns the mapping to its disease taxonomy + the downstream
alert/treatment logic. See
[`examples/grpc_client/segment_image.py`](./examples/grpc_client/segment_image.py).

## Deployment — the 3 tiers

| | **Tier 0 — OpenMV (now)** | **Tier 1 — Cloud KServe (Phase 1)** | **Tier 2 — Edge Jetson (Phase 2)** |
|---|---|---|---|
| Job | FOMO pre-trigger + capture | Triton detection + **vLLM diagnosis** | lightweight detection |
| Why | cheap/abundant, dodges Orin scarcity | authoritative, centralizes data, retrains | low latency, bandwidth, resilience |
| VLM | — | **always here** | **stays cloud** |
| Dir | [`deployment/openmv/`](./deployment/openmv/) | [`deployment/k8s/`](./deployment/k8s/) | [`deployment/jetson/`](./deployment/jetson/) |

- **KServe:** `kserve-triton-detection.yaml` (Triton) +
  `kserve-vllm-diagnosis.yaml` (vLLM) + `rbac.yaml` (KServe-deploy
  ServiceAccount + MinIO creds — **KServe deploy needs explicit admin perms**).
- **Training (Kubeflow):** [`deployment/kubeflow/pipeline.py`](./deployment/kubeflow/pipeline.py)
  — **Dask → Katib → Training Operator (PyTorch DDP) → export TensorRT → register
  + KServe deploy**, all I/O via **s3fs/MinIO** (NOT KFP artifacts). Includes the
  **HITL active-learning retrain trigger** (new-data / drift / schedule).

The cloud-first (Phase 1) verdict + the Jetson-scarcity / data-centralization
rationale + the OpenMV Tier-0 bridge are in
[`design.md` §2b](../../openspec/changes/2026-06-01-vision-core/design.md).

## Layout

```
services/vision-core/
  README.md  LICENSE.md  AGENTS.md  Makefile  pyproject.toml  package.json
  proto/vision/v1/vision.proto          # the vertivolatam contract
  src/vision_core/
    domain/                             # pure: Image, Mask, Segmentation, quantifiers
    application/{ports,commands,queries}/  # 4 ports + handlers
    adapters/primary/{grpc,rest}/       # gRPC server + FastAPI facade
    adapters/secondary/                 # YOLO, RF-DETR, registry, video-stream,
                                        #   s3fs, Triton, vLLM, MQTT, active-learning
    config.py  runtime.py
  tests/{unit,integration,e2e}/
  deployment/{docker,openmv,jetson,kubeflow,k8s}/   # Tier 0 / Tier 2 / cloud
  examples/{grpc_client,rest_client,edge_jetson}/
```

## Decision records

- PDR (what / why): [`openspec/changes/2026-06-01-vision-core/proposal.md`](../../openspec/changes/2026-06-01-vision-core/proposal.md)
- ADR (architecture + model verdict + matrix): [`design.md`](../../openspec/changes/2026-06-01-vision-core/design.md)
- Tasks / owner decisions: [`tasks.md`](../../openspec/changes/2026-06-01-vision-core/tasks.md)
