# AGENTS.md — Guide for AI Coding Assistants

How AI assistants (Claude Code, Cursor, Copilot) should work with vision-core.

## What this service is

Real-time + batch **image & video segmentation for AgTech** — crop/plant disease
identification, pest detection, plant-species ID, crop monitoring. Primary
consumer: the **vertivolatam (Vertivo)** product. Edge target: **NVIDIA Jetson**
(cuDNN/TensorRT). Cloud target: **Kubeflow on Kubernetes**. License: **BUSL-1.1**.

## Architecture

vision-core uses **Explicit Architecture** (Hexagonal + DDD), identical to
agentic-core. The dependency rule: all arrows point inward.

```
Primary Adapters (gRPC, REST/FastAPI)  -- call into -->
  Application Layer (Commands, Queries, Ports)  -- uses -->
    Domain Layer (Image, Frame, Mask, Segmentation, AreaQuantifier, ...)
  Application Layer  <-- implemented by --
Secondary Adapters (UltralyticsYOLO, RF-DETR, ModelRegistry, VideoStream)
```

**Never import concrete adapters in domain or application code.** Only port ABCs.

## The four ports (application/ports/)

- `SegmentationModelPort` — *what* a model outputs (Image -> Segmentation).
  Adapters: `UltralyticsYOLOAdapter`, `RFDETRAdapter`.
- `InferencePort` — *where* the math runs (local Jetson TensorRT vs remote KServe).
- `VideoStreamPort` — decode a stream into frames with sampling/backpressure.
- `ModelRegistryPort` — resolve/pull/promote models per crop; record `aiModelVersion`.

## Model choice (see openspec design.md section 2)

- **Edge default: YOLO26-seg** (tiny, fastest; **AGPL-3.0** — owner-gated for
  commercial edge ship).
- **Cloud default: RF-DETR-Seg** (higher accuracy on small lesions; **Apache-2.0**).

Both live behind `SegmentationModelPort`; choose at deploy time.

## Key conventions

- **Domain** (`domain/`): pure Python, zero external imports, no async.
- **Application** (`application/`): port ABCs + command/query handlers.
- **Adapters** (`adapters/`): may import frameworks. Primary = gRPC/REST;
  secondary = models/registry/stream.
- **Config**: env vars with `VISION_` prefix (`VISION_TIER=edge`).
- **Never commit weights** (`*.pt`, `*.onnx`, `*.engine`) — see `.gitignore`.
- Scaffold model/server methods raise `NotImplementedError`; real impl is apply
  Phase 3+ (see `openspec/changes/2026-06-01-vision-core/tasks.md`).

## Running

```bash
python3.12 -m venv .venv && source .venv/bin/activate
pip install -e ".[dev]"
pytest -q          # unit tests (domain logic is real and passes)
make proto         # regenerate gRPC stubs
make lint          # ruff
make typecheck     # mypy
```

## vertivolatam contract

gRPC `vision.v1.SegmentationService`. A `Segmentation` maps 1:1 onto Vertivo's
`DiseaseDetection` (`class_name`->diseaseName, `confidence`, `affected_area_percent`,
`severity`, `anatomical_part`->anatomicalParts, `model_version`->aiModelVersion).
vision-core returns generic segmentation; **Vertivo owns** the domain mapping.
