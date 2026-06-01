"""OpenCVVideoStreamAdapter — VideoStreamPort over OpenCV (cloud/batch).

Decodes an RTSP/file/device source into VideoFrames. The Jetson edge counterpart
(GStreamerJetsonAdapter, apply Phase 4) uses hardware-accelerated NVDEC decode.

Scaffold stub: imports cv2 lazily so the package imports without OpenCV present;
the decode loop raises NotImplementedError until apply Phase 3/4.
"""

from __future__ import annotations

from typing import TYPE_CHECKING

from vision_core.application.ports import VideoStreamPort
from vision_core.domain.value_objects import VideoFrame

if TYPE_CHECKING:
    from collections.abc import AsyncIterator


class OpenCVVideoStreamAdapter(VideoStreamPort):
    async def _iter(self, source: str, frame_stride: int) -> AsyncIterator[VideoFrame]:
        raise NotImplementedError(
            "OpenCVVideoStreamAdapter is a scaffold stub. Install extra "
            "'rest'/'cloud' (opencv-python-headless) and implement decode + "
            "frame sampling in apply Phase 3."
        )
        # Real loop: cap = cv2.VideoCapture(source); read frames; honor stride;
        # yield VideoFrame(content=jpeg_bytes, frame_index=i, timestamp_ms=...)
        if False:  # pragma: no cover - documents the generator contract
            yield VideoFrame(content=b"", frame_index=0, timestamp_ms=0.0, width=0, height=0)

    def frames(
        self, source: str, *, frame_stride: int = 0
    ) -> AsyncIterator[VideoFrame]:
        return self._iter(source, frame_stride)
