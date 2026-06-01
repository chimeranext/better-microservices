# Jetson edge deployment

Real-time per-frame segmentation on/near the Vertivo greenhouse robot.

## Why edge

- No network round-trip per frame (bandwidth at the greenhouse, autonomy, privacy).
- Mirrors the NVIDIA AgTech pattern: SeeTree (Jetson TX2 image processing),
  Bilberry (Jetson weed recognition, −92% chemicals). Edge does **real-time
  triage**; cloud does **authoritative diagnosis + retraining**.

## Stack

- **JetPack 5+** (L4T) → CUDA + **cuDNN** + **TensorRT** from the BSP.
- Default edge model: **YOLO26-seg n/s** (fastest; AGPL-3.0) or **RF-DETR-Seg**
  (Apache-2.0) — chosen via `--build-arg MODEL_EXTRA=` and `VISION_DEFAULT_FAMILY`.
- Export weights → ONNX → **TensorRT FP16/INT8 engine** for low-latency inference.
- **GStreamer/NVDEC** hardware video decode (`GStreamerJetsonAdapter`, apply Phase 4).

## Build & run

```bash
# On a Jetson (or buildx --platform linux/arm64):
docker build -f deployment/jetson/Dockerfile \
  --build-arg MODEL_EXTRA=rfdetr \      # rfdetr (Apache-2.0) | yolo (AGPL-3.0)
  -t vision-core:jetson .

docker run --runtime nvidia --network host \
  -e VISION_TIER=edge -e VISION_DEFAULT_FAMILY=rfdetr_seg \
  vision-core:jetson
```

## Escalation

Edge results below `VISION_LOW_CONFIDENCE_THRESHOLD` emit `LowConfidenceFlagged`
and escalate the frame to the cloud RF-DETR path for an authoritative diagnosis.

## Benchmark targets (apply Phase 4)

| Model | Engine | Target latency/frame |
|---|---|---|
| YOLO26-seg n | TensorRT FP16 | single-digit→tens of ms |
| RF-DETR-Seg n/s | TensorRT FP16 | tens of ms |

Measure on the target Jetson (Orin Nano/NX) and record in this README.
