"""Runtime entrypoint — ``python -m vision_core.runtime``.

Composition root: build adapters per tier, wire handlers, start the gRPC server
(and REST app). Scaffold prints the resolved config and exits; the real boot
sequence is wired in apply Phase 3.
"""

from __future__ import annotations

import structlog

from vision_core.config import load_settings

logger = structlog.get_logger(__name__)


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
    )
    # apply Phase 3: build the tier adapters per settings.tier —
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
