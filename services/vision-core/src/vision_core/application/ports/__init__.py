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
        Capture,
        Correction,
        Diagnosis,
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


# ---------------------------------------------------------------------------
# MLOps tier ports — the 3-tier phased topology (design.md sections 2/3).
# ---------------------------------------------------------------------------


class ObjectStoragePort(ABC):
    """First-class MinIO/S3 access via ``s3fs`` — the data backbone.

    CRITICAL workaround (ISS/Kubeflow case study, design.md section 6): KServe,
    Katib and PyTorchJob do NOT integrate with KFP's native artifact I/O, so
    every component reads/writes model weights + COCO-style datasets DIRECTLY
    from MinIO/S3 over ``s3fs``. This port is that boundary; adapters wrap an
    ``s3fs.S3FileSystem`` against the in-cluster MinIO endpoint.
    """

    @abstractmethod
    async def get_bytes(self, ref: str) -> bytes:
        """Read an object (e.g. ``s3://vision-core-captures/...``)."""

    @abstractmethod
    async def put_bytes(self, ref: str, data: bytes) -> None:
        """Write an object (capture, weight shard, dataset annotation)."""

    @abstractmethod
    async def exists(self, ref: str) -> bool:
        ...

    @abstractmethod
    async def list_prefix(self, prefix: str) -> list[str]:
        """List object refs under a prefix (dataset enumeration)."""


class DetectionRuntimePort(ABC):
    """Tier-1/2 DETECTION runtime — Triton on KServe (cloud) or TensorRT (edge).

    *Where* the structured-output detector runs. Returns a ``Segmentation``
    (boxes/masks/confidence). Cloud default: KServe Triton serving YOLO26 /
    RF-DETR. Edge (Phase 2): in-process TensorRT on Jetson Orin.
    """

    @abstractmethod
    async def detect(self, image: Image, *, model_id: str) -> Segmentation:
        """Run detection; return masks/boxes/confidence."""

    @abstractmethod
    async def is_local(self) -> bool:
        """True for in-greenhouse edge (Jetson); False for cloud KServe."""


class VlmDiagnosisPort(ABC):
    """Tier-1 VLM DIAGNOSIS runtime — vLLM on KServe. ALWAYS CLOUD.

    A vision-language model (Qwen-VL / LLaVA) turns an image (+ optional
    detection context) into a human-readable diagnosis. Too heavy for edge; on
    Tier-2 it is invoked ONLY for low-confidence detections escalated from the
    in-greenhouse detector (design.md section 3).
    """

    @abstractmethod
    async def diagnose(
        self, image: Image, *, detection_context: Segmentation | None = None
    ) -> Diagnosis:
        """Produce disease/severity/free-text diagnosis from an image."""


class CaptureIngestPort(ABC):
    """Accept a greenhouse capture submitted via vertivo_server / MQTT bridge.

    The capture references an object-storage ref (not raw bytes). Phase 1:
    time-lapse photos (batch). Phase 2: OpenMV motion-triggered insect bursts.
    """

    @abstractmethod
    async def submit(self, capture: Capture) -> str:
        """Queue a capture for inference; return a vision-core capture_id."""


class ActiveLearningPort(ABC):
    """HITL / active-learning loop (NOT RLHF).

    A low-confidence inference is surfaced to an agronomist who corrects the
    bounding box / label; the correction is written back to the MinIO COCO-style
    dataset (via ObjectStoragePort) and may trip the Kubeflow retrain rule
    (new-data / drift / schedule). Adapters return the dataset ref written and
    whether a retrain was triggered.
    """

    @abstractmethod
    async def submit_correction(self, correction: Correction) -> tuple[str, bool]:
        """Persist an agronomist correction; return (dataset_ref, retrain_triggered)."""
