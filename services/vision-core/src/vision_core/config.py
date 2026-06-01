"""Configuration — all via env vars with the ``VISION_`` prefix."""

from __future__ import annotations

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_prefix="VISION_", env_nested_delimiter="__")

    # Deployment tier (design.md sections 2/3 — 3-tier phased topology):
    #   "cloud" -> Phase 1: KServe Triton (detection) + vLLM (diagnosis), the
    #              authoritative tier where HITL/active-learning retraining lives.
    #   "edge"  -> Phase 2: Jetson Orin runs detection in-greenhouse; the VLM
    #              STAYS cloud (called only on low-confidence escalations).
    tier: str = "cloud"

    grpc_port: int = 50051
    rest_port: int = 8080
    health_port: int = 9090

    # Detection runtime. Edge: in-process TensorRT/cuDNN. Cloud: KServe Triton URL.
    inference_local: bool = True
    kserve_url: str = ""          # Triton detection InferenceService (Tier 1/2)

    # VLM diagnosis runtime — ALWAYS CLOUD (Tier 1), never edge-local.
    vllm_url: str = ""            # vLLM InferenceService (Qwen-VL / LLaVA)

    # NVIDIA build.nvidia.com hosted NIM endpoints — the fastest Phase-1 path to
    # REAL inference with NO local GPU (call hosted Triton/VLM NIMs). SERVER-SIDE
    # ONLY — never expose in any client/web. Per environment the value is a secret:
    #   staging    -> the "internal_staging" key
    #   production -> the "public_prod" key (still backend-only despite the name)
    # NEVER commit the value; inject via env/secret. See SECRETS.md.
    nvidia_api_key: str = ""      # VISION_NVIDIA_API_KEY — bearer for NIM endpoints
    nvidia_base_url: str = "https://integrate.api.nvidia.com/v1"

    # Object storage (MinIO/S3 via s3fs) — the data backbone for weights,
    # COCO-style datasets, and captures (the KServe/Katib/KFP s3fs workaround).
    minio_endpoint: str = "http://minio.vision-core.svc:9000"
    minio_access_key: str = ""
    minio_secret_key: str = ""

    # MQTT (EMQX) capture ingest — Vertivo orchestrator contract bridge.
    mqtt_broker_url: str = "mqtt://emqx-listeners:1883"

    # Escalate detections below this confidence to the cloud VLM diagnosis tier.
    low_confidence_threshold: float = 0.45

    # HITL: accumulated agronomist corrections that trip a new-data retrain.
    retrain_after_corrections: int = 50


def load_settings() -> Settings:
    return Settings()
