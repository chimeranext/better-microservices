"""VllmDiagnosisAdapter — VlmDiagnosisPort over KServe vLLM (ALWAYS CLOUD).

Tier-1 VLM DIAGNOSIS runtime: a KServe InferenceService backed by the vLLM
runtime serving a vision-language model (Qwen-VL / LLaVA). Turns an image (+
optional detection context from the Triton tier) into disease type + name,
severity, and free-text agronomic rationale. Too heavy for edge — stays cloud
even in Phase 2, where it is called ONLY on low-confidence escalations.

Scaffold stub: methods raise NotImplementedError. Real impl (apply Phase 3) sends
an OpenAI-compatible chat/completions multimodal request to the vLLM KServe
endpoint with a structured-output prompt and parses the JSON diagnosis.
"""

from __future__ import annotations

from typing import TYPE_CHECKING

from vision_core.application.ports import VlmDiagnosisPort

if TYPE_CHECKING:
    from vision_core.domain.value_objects import Diagnosis, Image, Segmentation

_NOT_IMPL = (
    "VllmDiagnosisAdapter is a scaffold stub. Point VISION_VLLM_URL at the vLLM "
    "InferenceService and implement in apply Phase 3."
)


class VllmDiagnosisAdapter(VlmDiagnosisPort):
    def __init__(self, *, vllm_url: str = "", model: str = "Qwen2-VL-7B") -> None:
        self._vllm_url = vllm_url
        self._model = model

    async def diagnose(
        self, image: Image, *, detection_context: Segmentation | None = None
    ) -> Diagnosis:
        raise NotImplementedError(_NOT_IMPL)
