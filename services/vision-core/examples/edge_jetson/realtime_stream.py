"""Example: real-time edge segmentation of the greenhouse camera stream (Jetson).

Sketches the SegmentVideoHandler wiring with the YOLO edge adapter + local
inference. Real run needs the 'edge'+'yolo'/'rfdetr' extras and a TensorRT engine
(apply Phase 3/4). Low-confidence frames escalate to the cloud RF-DETR path.
"""

from __future__ import annotations

import asyncio

from vision_core.adapters.secondary.local_fs_model_registry_adapter import (
    LocalFsModelRegistryAdapter,
)
from vision_core.adapters.secondary.opencv_video_stream_adapter import (
    OpenCVVideoStreamAdapter,
)
from vision_core.adapters.secondary.ultralytics_yolo_adapter import (
    UltralyticsYOLOAdapter,
)
from vision_core.application.commands import SegmentVideoHandler
from vision_core.domain.value_objects import ModelFamily, Task


async def main(stream_uri: str = "rtsp://greenhouse-cam/stream") -> None:
    handler = SegmentVideoHandler(
        models={ModelFamily.YOLO_SEG: UltralyticsYOLOAdapter()},
        registry=LocalFsModelRegistryAdapter(default_family=ModelFamily.YOLO_SEG),
        stream=OpenCVVideoStreamAdapter(),  # GStreamerJetsonAdapter on-device
    )
    async for seg in handler.handle(stream_uri, task=Task.DISEASE, crop_hint="lettuce"):
        print(seg.severity, seg.affected_area_percent, seg.model_version)


if __name__ == "__main__":
    asyncio.run(main())
