"""Configuration — all via env vars with the ``VISION_`` prefix."""

from __future__ import annotations

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_prefix="VISION_", env_nested_delimiter="__")

    # Deployment tier picks the default model family (design.md section 2/3).
    # "edge" -> YOLO-seg on Jetson; "cloud" -> RF-DETR-seg on Kubeflow/KServe.
    tier: str = "cloud"

    grpc_port: int = 50051
    rest_port: int = 8080
    health_port: int = 9090

    # Edge: in-process TensorRT/cuDNN. Cloud: remote KServe endpoint URL.
    inference_local: bool = True
    kserve_url: str = ""

    # Escalate edge results below this confidence to the cloud model.
    low_confidence_threshold: float = 0.45


def load_settings() -> Settings:
    return Settings()
