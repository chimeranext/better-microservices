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


class CaptureKind(StrEnum):
    """How a greenhouse capture was produced (capture phasing, design.md s.4)."""

    TIMELAPSE_PHOTO = "timelapse_photo"   # Phase 1 default — disease evolves slowly
    MOTION_BURST = "motion_burst"         # Phase 2 — OpenMV-triggered insect burst
    ON_DEMAND = "on_demand"               # operator/agronomist requested


@dataclass(frozen=True)
class Capture:
    """A greenhouse capture submitted for inference (CaptureIngestPort).

    Mirrors the Vertivo Raspberry orchestrator's MQTT message shape: it carries
    an object-storage ``image_ref`` (MinIO/S3), NOT raw bytes — the orchestrator
    uploads the OpenMV high-res photo and sends the ref over the constrained link.
    ``user_id`` / ``greenhouse_id`` come from the topic
    ``vertivo/{user_id}/greenhouse/{greenhouse_id}/...``. The usual CALLER is
    vertivo_server (Serverpod), which received the MQTT event first.
    """

    device_id: str          # orchestrator id "{hostname}-{mac:012x}"
    user_id: str
    greenhouse_id: str
    plant_id: int           # -> Vertivo DiseaseDetection.plantId
    kind: CaptureKind
    image_ref: str          # s3://minio/captures/...
    timestamp_unix: float   # orchestrator time.time() epoch seconds
    mime_type: str = "image/jpeg"
    crop_hint: str | None = None
    pretrigger_confidence: float = 0.0   # Tier-0 on-camera FOMO pre-trigger score
    trace_id: str | None = None


@dataclass(frozen=True)
class Diagnosis:
    """VLM diagnosis result (VlmDiagnosisPort).

    Maps onto Vertivo's DiseaseDetection text/severity fields — see
    openspec/changes/2026-06-01-vision-core/design.md section 5.
    """

    disease_type: str = ""        # -> Vertivo diseaseType
    disease_name: str = ""        # -> Vertivo diseaseName
    severity: str = ""            # -> Vertivo severity
    confidence: float = 0.0       # -> Vertivo confidence
    diagnosis_text: str = ""      # free-text agronomic rationale (VLM prose)
    recommended_action: str = ""  # hint -> Vertivo TreatmentRecommendation
    anatomical_parts: tuple[str, ...] = field(default_factory=tuple)
    model_version: str = ""       # VLM id -> Vertivo aiModelVersion
    trace_id: str | None = None


@dataclass(frozen=True)
class Correction:
    """An agronomist HITL correction (ActiveLearningPort).

    The corrected ground truth is written back to the MinIO COCO-style dataset
    and may trip the Kubeflow retrain rule.
    """

    capture_id: str
    agronomist_id: str              # -> Vertivo confirmedBy
    corrected_masks: tuple[Mask, ...]
    corrected_disease_name: str = ""
    corrected_severity: str = ""
    notes: str = ""                 # -> Vertivo notes
    trace_id: str | None = None
