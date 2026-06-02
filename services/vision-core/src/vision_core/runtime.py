"""Runtime entrypoint — ``python -m vision_core.runtime``.

Composition root: build adapters per tier, wire handlers, start the gRPC server
(and REST app). Scaffold prints the resolved config and exits; the real boot
sequence is wired in apply Phase 3.
"""

from __future__ import annotations

from typing import TYPE_CHECKING

import structlog

from vision_core.adapters.secondary.nim_inference_adapter import NimInferenceAdapter
from vision_core.config import load_settings

if TYPE_CHECKING:
    from vision_core.application.ports import InferencePort
    from vision_core.config import Settings

logger = structlog.get_logger(__name__)


def build_inference_port(settings: Settings) -> InferencePort:
    """Select the ``InferencePort`` for the current tier (composition root).

    Phase 1 (no local GPU): when ``nvidia_api_key`` is set, use the hosted NIM
    endpoint (NimInferenceAdapter) — REAL inference reachable WITHOUT a local GPU.
    Edge (Phase 2): an in-process TensorRT adapter (``inference_local``) — wired
    in apply Phase 3. Falls back to NIM as the cloud default when a key is present.
    """
    if not settings.inference_local and settings.nvidia_api_key:
        return NimInferenceAdapter.from_settings(settings)
    # Edge in-process TensorRT InferencePort is wired in apply Phase 3.
    raise NotImplementedError(
        "No InferencePort configured for this tier. Set VISION_NVIDIA_API_KEY "
        "(and VISION_INFERENCE_LOCAL=false) to use the hosted NIM cloud path, or "
        "wire the edge TensorRT adapter in apply Phase 3."
    )


def main() -> None:
    settings = load_settings()
    logger.info(
        "vision-core boot (scaffold)",
        tier=settings.tier,
        grpc_port=settings.grpc_port,
        rest_port=settings.rest_port,
        inference_local=settings.inference_local,
        kserve_url=settings.kserve_url,
        vllm_url=settings.vllm_url,
        minio_endpoint=settings.minio_endpoint,
        nim_cloud_inference=bool(settings.nvidia_api_key),
    )
    # apply Phase 3: build the tier adapters per settings.tier —
    #   InferencePort -> NimInferenceAdapter (Phase-1 hosted NIM, no GPU) |
    #                    TensorRT (edge); see build_inference_port() above,
    #   ObjectStoragePort -> S3fsObjectStorageAdapter (MinIO),
    #   DetectionRuntimePort -> TritonDetectionAdapter (cloud) | TensorRT (edge),
    #   VlmDiagnosisPort -> VllmDiagnosisAdapter (always cloud),
    #   CaptureIngestPort -> MqttCaptureIngestAdapter,
    #   ActiveLearningPort -> MinioActiveLearningAdapter, + registry + stream;
    # construct SegmentImage/SegmentVideo/DiagnoseImage/SubmitCapture/
    # SubmitCorrection handlers; asyncio.run(serve()).
    logger.info(
        "scaffold runtime — inference not yet wired; see openspec "
        "2026-06-01-vision-core tasks.md Phase 3"
    )


if __name__ == "__main__":
    main()
