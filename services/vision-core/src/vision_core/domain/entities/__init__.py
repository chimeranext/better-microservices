"""Domain entities — pure, zero external imports."""

from __future__ import annotations

from dataclasses import dataclass, field
from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from vision_core.domain.value_objects import ModelFamily, Task


@dataclass
class ModelDescriptor:
    """A registered, resolvable segmentation model version.

    The ``id`` (e.g. ``rf-detr-seg-l@vertivo-lettuce-2026.06``) is what flows
    into Vertivo's ``DiseaseDetection.aiModelVersion``.
    """

    id: str
    family: ModelFamily
    task: Task
    version: str
    crop_scope: tuple[str, ...] = field(default_factory=tuple)
    license: str = ""   # "Apache-2.0" | "AGPL-3.0" | "Enterprise"


@dataclass
class SegmentationJob:
    """A unit of segmentation work over an image or a video stream."""

    job_id: str
    task: Task
    crop_hint: str | None = None
    model_pref: ModelFamily | None = None
    trace_id: str | None = None
