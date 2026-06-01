"""TritonDetectionAdapter — DetectionRuntimePort over KServe Triton (cloud).

Tier-1 authoritative DETECTION runtime: a KServe InferenceService backed by the
Triton runtime serving YOLO26 / RF-DETR (boxes/masks/confidence). The cloud
default. The edge counterpart (Phase 2) is a TensorRT in-process adapter on
Jetson Orin; both sit behind DetectionRuntimePort so the call site is identical.

Scaffold stub: methods raise NotImplementedError. Real impl (apply Phase 3) posts
the image to the KServe v2 (KFServing) inference endpoint and maps the Triton
output tensors onto a domain Segmentation. Model weights load from MinIO via the
KServe storageUri (see deployment/k8s/kserve-triton-detection.yaml).
"""

from __future__ import annotations

from typing import TYPE_CHECKING

from vision_core.application.ports import DetectionRuntimePort

if TYPE_CHECKING:
    from vision_core.domain.value_objects import Image, Segmentation

_NOT_IMPL = (
    "TritonDetectionAdapter is a scaffold stub. Point VISION_KSERVE_URL at the "
    "Triton InferenceService and implement in apply Phase 3."
)


class TritonDetectionAdapter(DetectionRuntimePort):
    def __init__(self, *, kserve_url: str = "", local: bool = False) -> None:
        self._kserve_url = kserve_url
        self._local = local

    async def detect(self, image: Image, *, model_id: str) -> Segmentation:
        raise NotImplementedError(_NOT_IMPL)

    async def is_local(self) -> bool:
        return self._local
