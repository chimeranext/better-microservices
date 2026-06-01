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
