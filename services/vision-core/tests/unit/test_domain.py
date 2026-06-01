"""Unit tests for pure domain logic (AreaQuantifier, SeverityScorer, finalize)."""

from __future__ import annotations

import pytest

from vision_core.domain import AreaQuantifier, SeverityScorer, finalize
from vision_core.domain.value_objects import (
    BoundingBox,
    Image,
    Mask,
    Segmentation,
    Severity,
)


def _mask(w: float, h: float) -> Mask:
    return Mask(
        class_name="powdery_mildew",
        class_id=1,
        confidence=0.9,
        box=BoundingBox(x=0.1, y=0.1, w=w, h=h),
        anatomical_part="leaf",
    )


def test_area_quantifier_empty_is_zero() -> None:
    assert AreaQuantifier().quantify(()) == 0.0


def test_area_quantifier_caps_at_100() -> None:
    masks = (_mask(0.9, 0.9), _mask(0.9, 0.9))
    assert AreaQuantifier().quantify(masks) == 100.0


def test_area_quantifier_proportional() -> None:
    # one 0.2 x 0.5 box => 10% area
    assert AreaQuantifier().quantify((_mask(0.2, 0.5),)) == pytest.approx(10.0)


@pytest.mark.parametrize(
    ("area", "expected"),
    [
        (0.0, Severity.NONE),
        (2.0, Severity.LOW),
        (10.0, Severity.MODERATE),
        (30.0, Severity.HIGH),
        (80.0, Severity.CRITICAL),
    ],
)
def test_severity_scorer_buckets(area: float, expected: Severity) -> None:
    assert SeverityScorer().score(area) == expected


def test_finalize_enriches_area_and_severity() -> None:
    raw = Segmentation(masks=(_mask(0.2, 0.5),), image_width=640, image_height=640)
    result = finalize(raw)
    assert result.affected_area_percent == pytest.approx(10.0)
    assert result.severity == Severity.MODERATE


def test_image_requires_content_or_url() -> None:
    with pytest.raises(ValueError):
        Image()
    assert Image(url="https://x/y.jpg").url == "https://x/y.jpg"
