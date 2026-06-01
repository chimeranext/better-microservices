"""UltralyticsYOLOAdapter — SegmentationModelPort over Ultralytics YOLO-seg.

Edge/latency default (design.md section 2). CNN, tiny, fastest segmentation,
mature TensorRT path on Jetson.

LICENSING: the ``ultralytics`` package is **AGPL-3.0**. Shipping it in a
commercial edge product may require an Ultralytics Enterprise license or trigger
copyleft. This is an owner decision — see openspec tasks.md. RF-DETR (Apache-2.0)
is the licensing-clean drop-in alternative behind the same port.

Scaffold stub: methods raise NotImplementedError. Real impl (apply Phase 3) loads
a ``YOLO('*-seg.pt'/'.engine')`` model and maps Ultralytics ``Results`` (masks,
boxes, names, conf) onto domain ``Segmentation``.
"""

from __future__ import annotations

from typing import TYPE_CHECKING

from vision_core.application.ports import SegmentationModelPort
from vision_core.domain.value_objects import ModelFamily

if TYPE_CHECKING:
    from vision_core.domain.entities import ModelDescriptor
    from vision_core.domain.value_objects import Image, Segmentation, VideoFrame

_NOT_IMPL = (
    "UltralyticsYOLOAdapter is a scaffold stub. Install extra 'yolo' "
    "(AGPL-3.0 — see LICENSE.md) and implement in apply Phase 3."
)


class UltralyticsYOLOAdapter(SegmentationModelPort):
    family = ModelFamily.YOLO_SEG

    def __init__(self, *, device: str = "cuda", half: bool = True) -> None:
        # device='cuda' + half=True => FP16 TensorRT-friendly path on Jetson.
        self._device = device
        self._half = half

    async def segment(self, image: Image, *, model: ModelDescriptor) -> Segmentation:
        raise NotImplementedError(_NOT_IMPL)

    async def segment_frame(
        self, frame: VideoFrame, *, model: ModelDescriptor
    ) -> Segmentation:
        raise NotImplementedError(_NOT_IMPL)

    async def warm(self, model: ModelDescriptor) -> None:
        raise NotImplementedError(_NOT_IMPL)
