"""Domain layer — pure Python, zero external imports, no async.

Contains the value objects, entities, events, and domain services that model
AgTech segmentation independently of any model framework or transport.
"""

from __future__ import annotations

from vision_core.domain.value_objects import Mask, Segmentation, Severity


class AreaQuantifier:
    """Derive ``affected_area_percent`` from segmentation masks.

    Pure domain logic. The pixel-accurate fraction of the plant that is
    affected — the figure whole-image classification and box detection cannot
    produce, and the reason segmentation is the core primitive.

    The scaffold stub computes a coarse bounding-box-area proxy; the real
    implementation rasterizes polygons / decodes RLE (apply Phase 3).
    """

    def quantify(self, masks: tuple[Mask, ...]) -> float:
        if not masks:
            return 0.0
        # Stub proxy: union upper bound via summed box areas, capped at 100%.
        total = sum(m.box.w * m.box.h for m in masks) * 100.0
        return min(total, 100.0)


class SeverityScorer:
    """Map affected area (+ class) to a coarse severity bucket. Pure."""

    def score(self, affected_area_percent: float) -> Severity:
        if affected_area_percent <= 0.0:
            return Severity.NONE
        if affected_area_percent < 5.0:
            return Severity.LOW
        if affected_area_percent < 20.0:
            return Severity.MODERATE
        if affected_area_percent < 50.0:
            return Severity.HIGH
        return Severity.CRITICAL


def finalize(segmentation: Segmentation) -> Segmentation:
    """Enrich a raw model Segmentation with derived area + severity."""

    area = AreaQuantifier().quantify(segmentation.masks)
    severity = SeverityScorer().score(area)
    return Segmentation(
        masks=segmentation.masks,
        image_width=segmentation.image_width,
        image_height=segmentation.image_height,
        affected_area_percent=area,
        severity=severity,
        model_version=segmentation.model_version,
        image_ref=segmentation.image_ref,
        trace_id=segmentation.trace_id,
    )
