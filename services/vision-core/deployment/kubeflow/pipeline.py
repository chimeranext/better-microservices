"""Kubeflow Pipelines — vision-core MLOps retraining DAG.

Encodes the owner-decided stack (openspec design.md section 6):

    Dask (parallel preprocessing)
      -> Katib (HPO)
        -> Training Operator (PyTorchJob, DDP multi-GPU)
          -> export (ONNX -> TensorRT for the Jetson edge engine)
            -> register + KServe deploy (Triton detection / vLLM diagnosis)

CRITICAL s3fs WORKAROUND (ISS/Kubeflow case study): KServe, Katib and the Training
Operator's PyTorchJob do NOT integrate with KFP's native artifact I/O. Every
component therefore reads/writes model weights + COCO-style datasets DIRECTLY from
MinIO/S3 via ``s3fs`` — KFP passes only the s3:// URIs (strings), never the bytes.

HITL / ACTIVE LEARNING (NOT RLHF): a low-confidence inference is corrected by an
agronomist; the corrected annotation lands in the MinIO dataset; this pipeline is
re-triggered by a new-data / drift / schedule rule (``retrain_trigger`` below).

KServe deploy needs EXPLICIT admin ServiceAccount perms — see
deployment/k8s/rbac.yaml.

This is a SCAFFOLD: @component bodies are placeholders. Fleshing them out (real
Dask cluster, Katib Experiment, PyTorchJob CR, KServe apply) is apply Phase 5.
Requires the 'cloud' extra (kfp). Run authoring: `python deployment/kubeflow/pipeline.py`.
"""

from __future__ import annotations

# kfp is an optional ('cloud') dependency; guard so the repo imports without it.
try:
    from kfp import compiler, dsl
except ImportError:  # pragma: no cover
    compiler = None  # type: ignore[assignment]
    dsl = None  # type: ignore[assignment]


# All data movement is via s3:// URIs read/written with s3fs — never KFP
# artifacts. Components take and return plain strings (the MinIO refs).
if dsl is not None:

    @dsl.component(base_image="python:3.12-slim", packages_to_install=["s3fs"])
    def preprocess_dask(dataset_uri: str, out_uri: str) -> str:
        """Dask parallel preprocessing/augmentation of a COCO-seg dataset.

        Reads ``dataset_uri`` and writes the train/val splits to ``out_uri``,
        both via s3fs against MinIO. Returns the prepared dataset s3:// ref.
        """
        raise NotImplementedError("apply Phase 5: Dask cluster + s3fs I/O")

    @dsl.component(base_image="python:3.12-slim")
    def katib_hpo(dataset_uri: str, family: str) -> str:
        """Launch a Katib Experiment to tune LR/augment/anchor hyperparameters.

        Katib trials read the dataset from MinIO via s3fs (NOT KFP inputs) and
        write metrics back; returns the best-hyperparameters s3:// ref.
        """
        raise NotImplementedError("apply Phase 5: Katib Experiment CR")

    @dsl.component(base_image="python:3.12-slim")
    def train_pytorchjob(
        dataset_uri: str, hparams_uri: str, family: str, crop: str
    ) -> str:
        """Submit a Training-Operator PyTorchJob (DDP multi-GPU) to fine-tune.

        The PyTorchJob workers load the dataset + checkpoints from MinIO via
        s3fs and write the trained weights back to MinIO. Returns the weights
        s3:// ref. (Training Operator does not use KFP artifact passing.)
        """
        raise NotImplementedError("apply Phase 5: PyTorchJob CR, DDP, s3fs")

    @dsl.component(base_image="python:3.12-slim")
    def evaluate(weights_uri: str) -> float:
        """Return mask mAP (read eval set from MinIO via s3fs); gates promotion."""
        raise NotImplementedError("apply Phase 5")

    @dsl.component(base_image="python:3.12-slim")
    def export_engine(weights_uri: str) -> str:
        """Export ONNX -> TensorRT FP16/INT8 for the Phase-2 Jetson edge engine."""
        raise NotImplementedError("apply Phase 5")

    @dsl.component(base_image="python:3.12-slim")
    def register_and_deploy(weights_uri: str, engine_uri: str, crop: str) -> str:
        """Register the version and KServe-deploy the Triton InferenceService.

        Needs the vision-core-kserve-deployer Role (rbac.yaml). The registry id
        becomes Vertivo's aiModelVersion. storageUri points at the MinIO weights.
        """
        raise NotImplementedError("apply Phase 5: KServe apply (RBAC required)")

    @dsl.pipeline(
        name="vision-core-crop-finetune",
        description=(
            "Dask -> Katib -> PyTorchJob(DDP) -> export -> register+KServe, all "
            "MinIO/s3fs-backed. Retrained by the HITL active-learning trigger."
        ),
    )
    def finetune_pipeline(
        dataset_uri: str = "s3://vision-core-datasets/lettuce/raw/",
        prepared_uri: str = "s3://vision-core-datasets/lettuce/prepared/",
        crop: str = "lettuce",
        family: str = "rfdetr_seg",
        map_gate: float = 0.45,
    ) -> None:
        ds = preprocess_dask(dataset_uri=dataset_uri, out_uri=prepared_uri)
        hp = katib_hpo(dataset_uri=ds.output, family=family)
        w = train_pytorchjob(
            dataset_uri=ds.output, hparams_uri=hp.output, family=family, crop=crop
        )
        score = evaluate(weights_uri=w.output)
        with dsl.If(score.output >= map_gate, name="passes-map-gate"):
            eng = export_engine(weights_uri=w.output)
            register_and_deploy(weights_uri=w.output, engine_uri=eng.output, crop=crop)


def retrain_trigger(
    pending_corrections: int,
    *,
    threshold: int = 50,
    drift_detected: bool = False,
    scheduled: bool = False,
) -> bool:
    """HITL / active-learning retrain rule. Pure — unit-testable without a cluster.

    A retrain fires when EITHER enough agronomist corrections accumulated in the
    MinIO dataset (new-data), OR a drift monitor flagged distribution shift, OR a
    schedule (CronWorkflow) fired. Mirrors
    ``minio_active_learning_adapter.should_retrain`` for the new-data path.
    """
    return pending_corrections >= threshold or drift_detected or scheduled


def main() -> None:
    if compiler is None:  # pragma: no cover
        raise RuntimeError("Install the 'cloud' extra: pip install '.[cloud]'")
    compiler.Compiler().compile(
        pipeline_func=finetune_pipeline,
        package_path="vision-core-crop-finetune.yaml",
    )


if __name__ == "__main__":
    main()
