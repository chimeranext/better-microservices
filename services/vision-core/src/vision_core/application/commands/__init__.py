"""Application commands — write-side use cases."""

from __future__ import annotations

from typing import TYPE_CHECKING

from vision_core.domain import finalize
from vision_core.domain.value_objects import ModelFamily, Segmentation

if TYPE_CHECKING:
    from collections.abc import AsyncIterator

    from vision_core.application.ports import (
        ModelRegistryPort,
        SegmentationModelPort,
        VideoStreamPort,
    )
    from vision_core.domain.value_objects import Image, Task

# Tier defaults from design.md section 2: edge = YOLO-seg, cloud = RF-DETR-seg.
EDGE_DEFAULT_FAMILY = ModelFamily.YOLO_SEG
CLOUD_DEFAULT_FAMILY = ModelFamily.RFDETR_SEG


class SegmentImageHandler:
    """Segment one still image, enrich with area/severity, stamp model version."""

    def __init__(
        self,
        models: dict[ModelFamily, SegmentationModelPort],
        registry: ModelRegistryPort,
    ) -> None:
        self._models = models
        self._registry = registry

    async def handle(
        self,
        image: Image,
        *,
        task: Task,
        crop_hint: str = "",
        model_pref: ModelFamily | None = None,
        trace_id: str | None = None,
    ) -> Segmentation:
        descriptor = await self._registry.resolve(crop=crop_hint, task=task)
        family = model_pref or descriptor.family
        port = self._models[family]
        raw = await port.segment(image, model=descriptor)
        result = finalize(raw)
        return Segmentation(
            masks=result.masks,
            image_width=result.image_width,
            image_height=result.image_height,
            affected_area_percent=result.affected_area_percent,
            severity=result.severity,
            model_version=descriptor.id,
            image_ref=image.url,
            trace_id=trace_id,
        )


class SegmentVideoHandler:
    """Stream-segment a video: sample frames, segment each, yield results."""

    def __init__(
        self,
        models: dict[ModelFamily, SegmentationModelPort],
        registry: ModelRegistryPort,
        stream: VideoStreamPort,
    ) -> None:
        self._models = models
        self._registry = registry
        self._stream = stream

    async def handle(
        self,
        source: str,
        *,
        task: Task,
        crop_hint: str = "",
        model_pref: ModelFamily | None = None,
        frame_stride: int = 0,
        trace_id: str | None = None,
    ) -> AsyncIterator[Segmentation]:
        descriptor = await self._registry.resolve(crop=crop_hint, task=task)
        family = model_pref or descriptor.family
        port = self._models[family]
        async for frame in self._stream.frames(source, frame_stride=frame_stride):
            raw = await port.segment_frame(frame, model=descriptor)
            result = finalize(raw)
            yield Segmentation(
                masks=result.masks,
                image_width=result.image_width,
                image_height=result.image_height,
                affected_area_percent=result.affected_area_percent,
                severity=result.severity,
                model_version=descriptor.id,
                trace_id=trace_id,
            )
