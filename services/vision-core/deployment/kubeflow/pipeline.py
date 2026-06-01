"""Kubeflow Pipelines stub — crop-specific fine-tuning loop for vision-core.

Models the retraining DAG from openspec design.md section 6:

    ingest -> preprocess/augment -> train (YOLO-seg | RF-DETR-seg)
        -> evaluate (mask-mAP gate) -> export (ONNX->TensorRT FP16/INT8)
        -> register (ModelRegistryPort) -> (manual gate) promote -> sync to edge

This is a SCAFFOLD: the @component bodies are placeholders. Fleshing them out
(real containers, Katib HPO, KServe serving) is apply Phase 5. Requires the
'cloud' extra (kfp). Each promoted version's id becomes Vertivo's aiModelVersion.

Run authoring: `python deployment/kubeflow/pipeline.py` compiles the YAML.
"""

from __future__ import annotations

# kfp is an optional ('cloud') dependency; guard so the repo imports without it.
try:
    from kfp import compiler, dsl
except ImportError:  # pragma: no cover
    compiler = None  # type: ignore[assignment]
    dsl = None  # type: ignore[assignment]


if dsl is not None:

    @dsl.component(base_image="python:3.12-slim")
    def ingest(dataset_uri: str) -> str:
        """Pull a labeled crop dataset (Roboflow/COCO-seg format) -> artifact."""
        raise NotImplementedError("apply Phase 5")

    @dsl.component(base_image="python:3.12-slim")
    def preprocess(dataset: str) -> str:
        """Augment + split (train/val) for crop-specific fine-tuning."""
        raise NotImplementedError("apply Phase 5")

    @dsl.component(base_image="python:3.12-slim")
    def train(dataset: str, family: str, crop: str) -> str:
        """Fine-tune YOLO-seg or RF-DETR-seg on the crop dataset -> weights."""
        raise NotImplementedError("apply Phase 5")

    @dsl.component(base_image="python:3.12-slim")
    def evaluate(weights: str) -> float:
        """Return mask mAP; the pipeline gates promotion on this."""
        raise NotImplementedError("apply Phase 5")

    @dsl.component(base_image="python:3.12-slim")
    def export_engine(weights: str) -> str:
        """Export ONNX -> TensorRT FP16/INT8 engine for Jetson edge."""
        raise NotImplementedError("apply Phase 5")

    @dsl.component(base_image="python:3.12-slim")
    def register(weights: str, engine: str, crop: str, family: str) -> str:
        """Register the version (ModelRegistryPort); id -> Vertivo aiModelVersion."""
        raise NotImplementedError("apply Phase 5")

    @dsl.pipeline(
        name="vision-core-crop-finetune",
        description="Crop-specific segmentation fine-tuning + edge engine export.",
    )
    def finetune_pipeline(
        dataset_uri: str,
        crop: str = "lettuce",
        family: str = "rfdetr_seg",
        map_gate: float = 0.45,
    ) -> None:
        ds = preprocess(dataset=ingest(dataset_uri=dataset_uri).output)
        w = train(dataset=ds.output, family=family, crop=crop)
        score = evaluate(weights=w.output)
        with dsl.If(score.output >= map_gate, name="passes-map-gate"):
            eng = export_engine(weights=w.output)
            register(weights=w.output, engine=eng.output, crop=crop, family=family)


def main() -> None:
    if compiler is None:  # pragma: no cover
        raise RuntimeError("Install the 'cloud' extra: pip install '.[cloud]'")
    compiler.Compiler().compile(
        pipeline_func=finetune_pipeline,
        package_path="vision-core-crop-finetune.yaml",
    )


if __name__ == "__main__":
    main()
