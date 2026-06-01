"""Integration-test skeletons — model adapters (require model frameworks).

Marked skip until apply Phase 3 installs the 'yolo' / 'rfdetr' extras and real
weights. They assert the scaffold stubs raise NotImplementedError so the contract
surface is exercised even before models exist.
"""

from __future__ import annotations

import pytest

from vision_core.adapters.secondary.rfdetr_adapter import RFDETRAdapter
from vision_core.adapters.secondary.ultralytics_yolo_adapter import (
    UltralyticsYOLOAdapter,
)
from vision_core.domain.entities import ModelDescriptor
from vision_core.domain.value_objects import Image, ModelFamily, Task


def _descriptor(family: ModelFamily) -> ModelDescriptor:
    return ModelDescriptor(id="x", family=family, task=Task.DISEASE, version="0")


async def test_yolo_adapter_stub_raises() -> None:
    adapter = UltralyticsYOLOAdapter()
    with pytest.raises(NotImplementedError):
        await adapter.segment(
            Image(url="https://x/y.jpg"), model=_descriptor(ModelFamily.YOLO_SEG)
        )


async def test_rfdetr_adapter_stub_raises() -> None:
    adapter = RFDETRAdapter()
    with pytest.raises(NotImplementedError):
        await adapter.segment(
            Image(url="https://x/y.jpg"), model=_descriptor(ModelFamily.RFDETR_SEG)
        )


@pytest.mark.skip(reason="apply Phase 3: requires real weights + 'yolo' extra")
async def test_yolo_real_inference() -> None:  # pragma: no cover
    ...
