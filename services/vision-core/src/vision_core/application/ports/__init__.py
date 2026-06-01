"""Application ports — the abstract boundary of vision-core.

Driven (secondary) ports the application depends on; adapters implement them.
Domain/application code imports ONLY these ABCs, never a concrete adapter.

See openspec/changes/2026-06-01-vision-core/design.md section 1.
"""

from __future__ import annotations

from abc import ABC, abstractmethod
from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from collections.abc import AsyncIterator

    from vision_core.domain.entities import ModelDescriptor
    from vision_core.domain.value_objects import (
        Image,
        ModelFamily,
        Segmentation,
        Task,
        VideoFrame,
    )


class SegmentationModelPort(ABC):
    """*What* a model outputs: an Image/VideoFrame -> a Segmentation.

    The model-family abstraction. Implemented by UltralyticsYOLOAdapter and
    RFDETRAdapter. Decoupled from *where* inference runs (InferencePort).
    """

    family: ModelFamily

    @abstractmethod
    async def segment(self, image: Image, *, model: ModelDescriptor) -> Segmentation:
        """Segment a single still image."""

    @abstractmethod
    async def segment_frame(
        self, frame: VideoFrame, *, model: ModelDescriptor
    ) -> Segmentation:
        """Segment a single decoded video frame."""

    @abstractmethod
    async def warm(self, model: ModelDescriptor) -> None:
        """Load/JIT/allocate the engine so the first request is not cold."""


class InferencePort(ABC):
    """*Where/how* the math runs.

    Local in-process (Jetson TensorRT/cuDNN) vs remote (KServe/Triton in the
    cluster). Lets the cloud serving runtime change without touching model code.
    """

    @abstractmethod
    async def run(self, payload: bytes, *, model_id: str) -> bytes:
        """Execute raw inference; returns serialized model output."""

    @abstractmethod
    async def is_local(self) -> bool:
        """True for edge/in-process; False for remote cluster serving."""


class VideoStreamPort(ABC):
    """Open a stream and yield decoded frames with sampling/backpressure."""

    @abstractmethod
    def frames(
        self, source: str, *, frame_stride: int = 0
    ) -> AsyncIterator[VideoFrame]:
        """Yield decoded frames from an RTSP/file/device source.

        ``frame_stride`` = 0 means adaptive (motion/keyframe gated).
        """


class ModelRegistryPort(ABC):
    """Resolve/pull/promote model versions per crop; record aiModelVersion."""

    @abstractmethod
    async def resolve(self, *, crop: str, task: Task) -> ModelDescriptor:
        """Best registered model for a crop+task (falls back to generic)."""

    @abstractmethod
    async def list_models(self, *, task: Task | None = None) -> list[ModelDescriptor]:
        ...

    @abstractmethod
    async def promote(self, model: ModelDescriptor) -> None:
        """Promote a Kubeflow-trained version that passed the eval gate."""
