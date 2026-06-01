"""Domain value objects — pure, immutable, zero external imports."""

from __future__ import annotations

from dataclasses import dataclass, field
from enum import StrEnum


class Task(StrEnum):
    """The AgTech segmentation task."""

    DISEASE = "disease"
    PEST = "pest"
    DEFICIENCY = "deficiency"
    SPECIES = "species"
    MONITORING = "monitoring"


class ModelFamily(StrEnum):
    """Segmentation model family behind SegmentationModelPort."""

    YOLO_SEG = "yolo_seg"        # Ultralytics YOLO-seg (edge default; AGPL-3.0)
    RFDETR_SEG = "rfdetr_seg"    # RF-DETR-Seg (cloud default; Apache-2.0)


class Severity(StrEnum):
    """Severity bucket derived from affected area + class."""

    NONE = "none"
    LOW = "low"
    MODERATE = "moderate"
    HIGH = "high"
    CRITICAL = "critical"


@dataclass(frozen=True)
class Image:
    """An image to segment. Bytes or a URL; at least one is required."""

    content: bytes | None = None
    url: str | None = None
    mime_type: str = "image/jpeg"

    def __post_init__(self) -> None:
        if not self.content and not self.url:
            raise ValueError("Image requires either content or url")


@dataclass(frozen=True)
class VideoFrame:
    """A single decoded frame pulled from a VideoStreamPort."""

    content: bytes
    frame_index: int
    timestamp_ms: float
    width: int
    height: int


@dataclass(frozen=True)
class BoundingBox:
    """Axis-aligned box, normalized to [0, 1]."""

    x: float
    y: float
    w: float
    h: float


@dataclass(frozen=True)
class Mask:
    """One segmented instance: class + score + pixel mask (polygon or RLE)."""

    class_name: str
    class_id: int
    confidence: float
    box: BoundingBox
    polygon: tuple[float, ...] = ()      # normalized contour [x0,y0,x1,y1,...]
    rle: bytes | None = None             # COCO RLE alternative
    anatomical_part: str | None = None   # leaf / stem / fruit / root ...


@dataclass(frozen=True)
class Segmentation:
    """The result of segmenting one image/frame.

    Maps 1:1 onto vertivolatam's DiseaseDetection fields — see
    openspec/changes/2026-06-01-vision-core/design.md section 5.
    """

    masks: tuple[Mask, ...]
    image_width: int
    image_height: int
    affected_area_percent: float = 0.0   # -> Vertivo affectedAreaPercent
    severity: Severity = Severity.NONE   # -> Vertivo severity
    model_version: str = ""              # -> Vertivo aiModelVersion
    image_ref: str | None = None         # -> Vertivo imageUrl
    trace_id: str | None = None


@dataclass(frozen=True)
class CropLabel:
    """A crop/species hint that routes to a per-crop fine-tuned model."""

    name: str
    aliases: tuple[str, ...] = field(default_factory=tuple)
