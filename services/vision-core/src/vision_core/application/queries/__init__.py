"""Application queries — read-side use cases."""

from __future__ import annotations

from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from vision_core.application.ports import ModelRegistryPort
    from vision_core.domain.entities import ModelDescriptor
    from vision_core.domain.value_objects import Task


class ListModelsHandler:
    def __init__(self, registry: ModelRegistryPort) -> None:
        self._registry = registry

    async def handle(self, *, task: Task | None = None) -> list[ModelDescriptor]:
        return await self._registry.list_models(task=task)


class GetModelForCropHandler:
    def __init__(self, registry: ModelRegistryPort) -> None:
        self._registry = registry

    async def handle(self, *, crop: str, task: Task) -> ModelDescriptor:
        return await self._registry.resolve(crop=crop, task=task)
