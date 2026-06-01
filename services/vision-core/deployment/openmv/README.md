# Tier 0 — On-camera (OpenMV Nicla Vision), Phase 1 NOW

The cheapest, most abundant tier and the **bridge that sidesteps the NVIDIA Jetson
Orin Nano global scarcity**: a tiny on-sensor model runs *on the camera itself*.

## Role

- **Pre-trigger** ("is there something?") — a **FOMO / tinyML** detector runs on
  the OpenMV Nicla Vision MCU and decides, cheaply and continuously, whether a
  frame is worth a high-res capture. This avoids streaming/storing every frame.
- **High-res photo capture** — on a positive pre-trigger (or on the time-lapse
  schedule) the camera grabs a full-resolution photo.
- The Vertivo **Raspberry orchestrator** uploads that photo to **MinIO/S3** and
  publishes the *object-storage ref + metadata* (not the bytes) over MQTT on
  `vertivo/{user_id}/greenhouse/{greenhouse_id}/capture/{photo|burst}`. The
  `pretrigger_confidence` from the FOMO model rides along so the cloud tier can
  prioritize. vertivo_server (Serverpod) ingests the MQTT event and forwards the
  ref to vision-core's `CaptureIngestService`.

## Capture phasing

- **Phase 1 (now): time-lapse photos.** Disease evolves over hours/days, so batch
  inference on scheduled stills is sufficient and cheap.
- **Phase 2: continuous / burst video for insects** (fast movers). The OpenMV
  on-camera **motion trigger** fires short high-FPS bursts (`CAPTURE_KIND_MOTION_BURST`)
  that the cloud/edge detector processes; the VLM is consulted only on
  low-confidence detections.

## Why on-camera at all

- **Jetson scarcity:** Orin Nano supply is constrained globally. Pushing the
  cheap "is there something?" gate onto the abundant OpenMV MCU lets Phase 1 ship
  without waiting on Jetson, and keeps the expensive detector/VLM in the cloud.
- **Bandwidth:** the constrained greenhouse uplink carries refs + small captures,
  not video.

## Refs

- OpenMV Nicla Vision: https://openmv.io/products/arduino-nicla-vision
- OpenMV Python: https://github.com/openmv/openmv-python
- Object detection on OpenMV H7 Plus: https://github.com/raspizone/ObjectDetection_OpenMV_H7_Plus

## Status

Scaffold note only. The on-camera FOMO model, the capture firmware, and the
orchestrator's MinIO upload + MQTT publish live in the **vertivolatam raspberry**
app; vision-core only consumes the resulting capture refs. Wiring is apply Phase 2.
