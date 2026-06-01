"""Domain events — pure, zero external imports."""

from __future__ import annotations

from dataclasses import dataclass


@dataclass(frozen=True)
class SegmentationCompleted:
    job_id: str
    model_version: str
    mask_count: int
    affected_area_percent: float
    trace_id: str | None = None


@dataclass(frozen=True)
class LowConfidenceFlagged:
    """Edge result below threshold — escalate the frame to the cloud model."""

    job_id: str
    max_confidence: float
    threshold: float
    trace_id: str | None = None


@dataclass(frozen=True)
class ModelVersionPromoted:
    """A Kubeflow-trained version passed the eval gate and was promoted."""

    model_id: str
    version: str
    crop_scope: tuple[str, ...]


@dataclass(frozen=True)
class CaptureIngested:
    """A greenhouse capture was accepted for inference (Phase 1 photo / Phase 2 burst)."""

    capture_id: str
    greenhouse_id: str
    plant_id: int
    kind: str
    image_ref: str
    trace_id: str | None = None


@dataclass(frozen=True)
class DiagnosisCompleted:
    """The VLM tier produced a diagnosis for a capture."""

    capture_id: str
    disease_name: str
    severity: str
    confidence: float
    model_version: str
    trace_id: str | None = None


@dataclass(frozen=True)
class CorrectionSubmitted:
    """An agronomist submitted a HITL correction; it was written to the dataset."""

    capture_id: str
    agronomist_id: str
    dataset_ref: str
    trace_id: str | None = None


@dataclass(frozen=True)
class RetrainTriggered:
    """A correction / drift / schedule rule tripped a Kubeflow retrain."""

    reason: str            # "new_data" | "drift" | "schedule"
    dataset_ref: str
    crop_scope: tuple[str, ...] = ()
