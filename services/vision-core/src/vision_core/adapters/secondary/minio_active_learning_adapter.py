"""MinioActiveLearningAdapter — ActiveLearningPort (HITL loop, NOT RLHF).

A low-confidence inference is surfaced to an agronomist who corrects the bounding
box / label. This adapter writes the corrected COCO-style annotation back to the
MinIO dataset (via ObjectStoragePort) and evaluates the retrain rule (new-data
count / drift / schedule). When the rule trips, the Kubeflow pipeline is invoked
to retrain on the enriched dataset (design.md section 6).

Scaffold stub: ``submit_correction`` raises NotImplementedError. The retrain-rule
predicate ``should_retrain`` is REAL and tested (pure new-data-count gate).
"""

from __future__ import annotations

from typing import TYPE_CHECKING

from vision_core.application.ports import ActiveLearningPort

if TYPE_CHECKING:
    from vision_core.application.ports import ObjectStoragePort
    from vision_core.domain.value_objects import Correction

# Number of accumulated corrections that trips a new-data retrain.
DEFAULT_RETRAIN_AFTER_N_CORRECTIONS = 50


def should_retrain(pending_corrections: int, *, threshold: int) -> bool:
    """New-data retrain gate. Pure + tested.

    Drift- and schedule-triggered retrains are evaluated elsewhere (a CronJob /
    a drift monitor); this is the active-learning new-data path.
    """
    return pending_corrections >= threshold


class MinioActiveLearningAdapter(ActiveLearningPort):
    def __init__(
        self,
        storage: ObjectStoragePort,
        *,
        dataset_prefix: str = "s3://vision-core-datasets/",
        retrain_after: int = DEFAULT_RETRAIN_AFTER_N_CORRECTIONS,
    ) -> None:
        self._storage = storage
        self._dataset_prefix = dataset_prefix
        self._retrain_after = retrain_after

    async def submit_correction(self, correction: Correction) -> tuple[str, bool]:
        raise NotImplementedError(
            "MinioActiveLearningAdapter.submit_correction is a scaffold stub. "
            "Write the COCO annotation via ObjectStoragePort and evaluate the "
            "retrain rule in apply Phase 3."
        )
