"""RFDETRAdapter — SegmentationModelPort over RF-DETR-Seg (Roboflow).

Cloud/accuracy default (design.md section 2). DETR transformer (DINOv2
backbone), higher mask accuracy and markedly better on small lesions / cluttered
canopies — the AgTech failure mode. **Apache-2.0** for Nano..Large, so it is
commercially clean for the managed cloud product and as the edge drop-in if the
YOLO Enterprise license is declined.

Scaffold stub: methods raise NotImplementedError. Real impl (apply Phase 3) loads
``RFDETRSegPreview``/exported TensorRT engine and maps predictions onto domain
``Segmentation``.
"""

from __future__ import annotations

from typing import TYPE_CHECKING

from vision_core.application.ports import SegmentationModelPort
from vision_core.domain.value_objects import ModelFamily

if TYPE_CHECKING:
    from vision_core.domain.entities import ModelDescriptor
    from vision_core.domain.value_objects import Image, Segmentation, VideoFrame

_NOT_IMPL = (
    "RFDETRAdapter is a scaffold stub. Install extra 'rfdetr' (Apache-2.0 for "
    "Nano..Large) and implement in apply Phase 3."
)


class RFDETRAdapter(SegmentationModelPort):
    family = ModelFamily.RFDETR_SEG

    def __init__(self, *, resolution: int = 704, half: bool = True) -> None:
        # Per-size input resolution (704 = Large). half=True => FP16 TensorRT.
        self._resolution = resolution
        self._half = half

    async def segment(self, image: Image, *, model: ModelDescriptor) -> Segmentation:
        raise NotImplementedError(_NOT_IMPL)

    async def segment_frame(
        self, frame: VideoFrame, *, model: ModelDescriptor
    ) -> Segmentation:
        raise NotImplementedError(_NOT_IMPL)

    async def warm(self, model: ModelDescriptor) -> None:
        raise NotImplementedError(_NOT_IMPL)
