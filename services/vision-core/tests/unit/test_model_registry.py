"""Unit tests for LocalFsModelRegistryAdapter resolution logic."""

from __future__ import annotations

import pytest

from vision_core.adapters.secondary.local_fs_model_registry_adapter import (
    LocalFsModelRegistryAdapter,
)
from vision_core.domain.entities import ModelDescriptor
from vision_core.domain.value_objects import ModelFamily, Task


async def test_resolve_falls_back_to_default_family() -> None:
    reg = LocalFsModelRegistryAdapter(default_family=ModelFamily.RFDETR_SEG)
    model = await reg.resolve(crop="unknown", task=Task.DISEASE)
    assert model.family == ModelFamily.RFDETR_SEG
    assert model.license == "Apache-2.0"


async def test_resolve_prefers_crop_specific() -> None:
    lettuce = ModelDescriptor(
        id="rf-detr-seg-l@vertivo-lettuce-2026.06",
        family=ModelFamily.RFDETR_SEG,
        task=Task.DISEASE,
        version="2026.06",
        crop_scope=("lettuce",),
        license="Apache-2.0",
    )
    reg = LocalFsModelRegistryAdapter()
    await reg.promote(lettuce)
    model = await reg.resolve(crop="Lettuce", task=Task.DISEASE)
    assert model.id == lettuce.id


async def test_list_models_filters_by_task() -> None:
    reg = LocalFsModelRegistryAdapter()
    disease = await reg.list_models(task=Task.DISEASE)
    assert disease
    assert all(m.task == Task.DISEASE for m in disease)


async def test_resolve_raises_without_any_model() -> None:
    reg = LocalFsModelRegistryAdapter(catalog=())
    with pytest.raises(LookupError):
        await reg.resolve(crop="x", task=Task.PEST)
