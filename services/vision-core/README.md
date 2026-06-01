# vision-core

Real-time + batch **image & video segmentation for AgTech** — crop/plant disease
identification, pest detection, plant-species ID, and crop monitoring. Built as a
shared, source-available microservice in the `better-microservices` monorepo, and
designed primarily to power the **[vertivolatam](https://github.com/vertivolatam/monorepo)
(Vertivo)** autonomous-greenhouse product.

> **vision-core contains NO product-specific business logic.** It returns generic
> pixel-accurate segmentation; the consuming product (Vertivo) maps results onto
> its own domain (e.g. `DiseaseDetection` rows + treatment recommendations) — the
> same boundary rule `agentic-core` follows.

**Target deployment:** **NVIDIA Jetson edge** (cuDNN / TensorRT) for real-time
per-frame monitoring + **Kubeflow ML pipelines on Kubernetes** for batch sweeps,
authoritative diagnosis, and crop-specific retraining.

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

**Default per tier** (see [ADR §2](../../openspec/changes/2026-06-01-vision-core/design.md)):

- **Edge (Jetson, real-time):** **YOLO26-seg** — tiny + fastest. *Licensing
  caveat: AGPL-3.0; an owner decision for commercial edge ship.*
- **Cloud (Kubeflow, accuracy):** **RF-DETR-Seg** — higher mask accuracy on small
  lesions, **Apache-2.0** (commercially clean). Also the licensing-safe drop-in on
  the edge.

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

### The four ports

| Port | Role | Adapters |
|---|---|---|
| `SegmentationModelPort` | *what* a model outputs (Image → Segmentation) | `UltralyticsYOLOAdapter`, `RFDETRAdapter` |
| `InferencePort` | *where* it runs (Jetson TensorRT vs cloud KServe) | `LocalTensorRTAdapter`, `KServeInferenceAdapter` |
| `VideoStreamPort` | decode a stream → frames, with sampling | `OpenCVVideoStreamAdapter`, `GStreamerJetsonAdapter` |
| `ModelRegistryPort` | resolve/pull/promote models per crop | `LocalFsModelRegistryAdapter`, `KubeflowModelRegistryAdapter` |

## Quickstart

```bash
cd services/vision-core
python3.12 -m venv .venv && source .venv/bin/activate
pip install -e ".[dev]"

pytest -q          # domain logic is real and passes (16 passed)
make proto         # generate gRPC stubs from proto/vision/v1/vision.proto
make lint          # ruff
make typecheck     # mypy
```

> **Scaffold status:** the domain (area/severity quantification, model-registry
> resolution) is **real and tested**. Model adapters and the gRPC/REST servers are
> **stubs that raise `NotImplementedError`** — inference is wired in apply Phase 3.
> See [`tasks.md`](../../openspec/changes/2026-06-01-vision-core/tasks.md).

## vertivolatam integration

Vertivo's Serverpod backend (`apps/vertivo_server/lib/src/phytopathology/`)
already persists `DiseaseDetection` / `PestIdentification` /
`NutritionalDeficiency` but has no engine to produce them. vision-core is that
engine. A `Segmentation` maps **1:1** onto a `DiseaseDetection`:

| `vision.v1` field | Vertivo `DiseaseDetection` | Produced by |
|---|---|---|
| `masks[].class_name` | `diseaseName` / `diseaseType` | model labels |
| `masks[].confidence` | `confidence` | model score |
| `affected_area_percent` | `affectedAreaPercent` | `AreaQuantifier` |
| `severity` | `severity` | `SeverityScorer` |
| `masks[].anatomical_part` | `anatomicalParts` | label taxonomy |
| `image_ref` | `imageUrl` | passthrough |
| `model_version` | `aiModelVersion` | `ModelRegistryPort` |

**Contract** — gRPC `vision.v1.SegmentationService`
([`proto/vision/v1/vision.proto`](./proto/vision/v1/vision.proto)):

- `SegmentImage(SegmentImageRequest) → SegmentImageResponse` — unary (uploads,
  snapshots).
- `SegmentVideo(SegmentVideoRequest) → stream SegmentationResponse` — real-time
  edge.
- `ListModels` / `GetModelForCrop` / `HealthCheck` (gRPC Health v1).
- **REST mirror** `POST /v1/segment` (multipart upload) for the mobile app /
  dashboard — Agrio-style ergonomics.

Vertivo owns the mapping from a generic `class_name` to its disease taxonomy and
the choice of `TreatmentRecommendation`. See
[`examples/grpc_client/segment_image.py`](./examples/grpc_client/segment_image.py).

## Edge / cloud deployment

| | **Edge — NVIDIA Jetson** | **Cloud — Kubeflow on k8s** |
|---|---|---|
| Trigger | real-time, per-frame, at the greenhouse | batch sweeps, authoritative re-check, retraining |
| Model | YOLO26-seg (TensorRT FP16/INT8) | RF-DETR-Seg (KServe/Triton) |
| Why | no network round-trip, autonomy, privacy | heavy models, GPU pooling, reproducible retraining |
| cuDNN | underlies the TensorRT engine | underlies server-GPU inference |

Edge does **real-time triage** (flag a suspect frame fast); cloud does
**authoritative diagnosis + retraining**. Low-confidence edge results escalate to
the cloud RF-DETR path. This mirrors the NVIDIA AgTech pattern (SeeTree on Jetson
TX2, Bilberry weed-recognition on Jetson, GPU cloud for training).

- **Jetson:** [`deployment/jetson/`](./deployment/jetson/) (Dockerfile + notes).
- **Cloud:** [`deployment/k8s/`](./deployment/k8s/) (Deployment + KServe
  InferenceService).
- **Training:** [`deployment/kubeflow/pipeline.py`](./deployment/kubeflow/pipeline.py)
  — crop-specific fine-tuning DAG (ingest → preprocess → train → eval gate →
  export TensorRT → register → promote → sync to edge).

## Layout

```
services/vision-core/
  README.md  LICENSE.md  AGENTS.md  Makefile  pyproject.toml  package.json
  proto/vision/v1/vision.proto          # the vertivolatam contract
  src/vision_core/
    domain/                             # pure: Image, Mask, Segmentation, quantifiers
    application/{ports,commands,queries}/  # 4 ports + handlers
    adapters/primary/{grpc,rest}/       # gRPC server + FastAPI facade
    adapters/secondary/                 # YOLO, RF-DETR, registry, video-stream
    config.py  runtime.py
  tests/{unit,integration,e2e}/
  deployment/{docker,jetson,kubeflow,k8s}/
  examples/{grpc_client,rest_client,edge_jetson}/
```

## Decision records

- PDR (what / why): [`openspec/changes/2026-06-01-vision-core/proposal.md`](../../openspec/changes/2026-06-01-vision-core/proposal.md)
- ADR (architecture + model verdict + matrix): [`design.md`](../../openspec/changes/2026-06-01-vision-core/design.md)
- Tasks / owner decisions: [`tasks.md`](../../openspec/changes/2026-06-01-vision-core/tasks.md)
