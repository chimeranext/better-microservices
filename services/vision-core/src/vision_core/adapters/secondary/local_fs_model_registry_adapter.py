"""LocalFsModelRegistryAdapter — ModelRegistryPort over a local manifest.

A minimal, working registry for dev/edge: resolves crop+task to a model id from
an in-memory/JSON manifest and falls back to a generic model. The cloud
counterpart (KubeflowModelRegistryAdapter) talks to the Kubeflow registry and is
fed by the training pipeline (apply Phase 5).
"""

from __future__ import annotations

from vision_core.application.ports import ModelRegistryPort
from vision_core.domain.entities import ModelDescriptor
from vision_core.domain.value_objects import ModelFamily, Task

# Seed catalog. Per-crop fine-tuned versions are appended by the Kubeflow
# pipeline on promotion (ModelVersionPromoted). Defaults follow design.md s.2:
# generic edge -> YOLO-seg (AGPL-3.0); generic cloud -> RF-DETR-seg (Apache-2.0).
_SEED: tuple[ModelDescriptor, ...] = (
    ModelDescriptor(
        id="yolo26-seg-n@generic-2026.06",
        family=ModelFamily.YOLO_SEG,
        task=Task.DISEASE,
        version="2026.06",
        crop_scope=(),
        license="AGPL-3.0",
    ),
    ModelDescriptor(
        id="rf-detr-seg-l@generic-2026.06",
        family=ModelFamily.RFDETR_SEG,
        task=Task.DISEASE,
        version="2026.06",
        crop_scope=(),
        license="Apache-2.0",
    ),
)


class LocalFsModelRegistryAdapter(ModelRegistryPort):
    def __init__(
        self,
        catalog: tuple[ModelDescriptor, ...] = _SEED,
        *,
        default_family: ModelFamily = ModelFamily.RFDETR_SEG,
    ) -> None:
        self._catalog = list(catalog)
        self._default_family = default_family

    async def resolve(self, *, crop: str, task: Task) -> ModelDescriptor:
        crop_l = (crop or "").lower()
        # Prefer a model fine-tuned for this crop + task.
        for m in self._catalog:
            if m.task == task and crop_l and crop_l in (c.lower() for c in m.crop_scope):
                return m
        # Fall back to a generic model of the default family for this task.
        for m in self._catalog:
            if m.task == task and m.family == self._default_family and not m.crop_scope:
                return m
        # Last resort: any model for the task.
        for m in self._catalog:
            if m.task == task:
                return m
        raise LookupError(f"No registered model for task={task}")

    async def list_models(self, *, task: Task | None = None) -> list[ModelDescriptor]:
        if task is None:
            return list(self._catalog)
        return [m for m in self._catalog if m.task == task]

    async def promote(self, model: ModelDescriptor) -> None:
        self._catalog.append(model)
