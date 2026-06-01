"""MqttCaptureIngestAdapter — CaptureIngestPort over the Vertivo MQTT contract.

The Raspberry orchestrator (Vertivo's CUSTOM orchestrator, NOT generic OpenPLC)
publishes to EMQX on topics shaped like
``vertivo/{user_id}/greenhouse/{greenhouse_id}/...`` with JSON payloads carrying
``device_id`` / ``timestamp`` / ``value`` (see vertivolatam raspberry
``src/networking/mqtt.py`` and ``MqttTopics`` in vertivo_server). The usual flow
routes through vertivo_server (Serverpod), which ingests the MQTT event and calls
vision-core's gRPC ``CaptureIngestService``; this adapter is the direct
backend-bypass bridge for dev/edge.

The ``parse_capture_topic`` helper below is REAL and tested — it decodes the
orchestrator's topic into (user_id, greenhouse_id, category, type), matching the
``MqttTopics.parse`` logic on the Vertivo side. The ``submit`` queueing is the
stub (apply Phase 3 wires it to the inference queue + ObjectStoragePort).
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import TYPE_CHECKING

from vision_core.application.ports import CaptureIngestPort

if TYPE_CHECKING:
    from vision_core.domain.value_objects import Capture

# Capture sub-topic the orchestrator publishes greenhouse photos/bursts on,
# alongside the existing sensor/command/status categories.
CAPTURE_CATEGORY = "capture"


@dataclass(frozen=True)
class CaptureTopic:
    """Decoded Vertivo capture topic segments."""

    user_id: str
    greenhouse_id: str
    category: str          # sensor | command | status | capture
    type: str | None       # e.g. "photo" | "burst"


def parse_capture_topic(topic: str) -> CaptureTopic | None:
    """Decode ``vertivo/{user_id}/greenhouse/{greenhouse_id}/{category}/{type}``.

    Mirrors vertivo_server ``MqttTopics.parse``. Returns None on a non-matching
    topic. Pure + tested so the orchestrator contract is exercised before any
    broker exists.
    """
    parts = topic.split("/")
    if len(parts) < 5:
        return None
    if parts[0] != "vertivo" or parts[2] != "greenhouse":
        return None
    user_id, greenhouse_id = parts[1], parts[3]
    if not user_id or not greenhouse_id:
        return None
    return CaptureTopic(
        user_id=user_id,
        greenhouse_id=greenhouse_id,
        category=parts[4],
        type=parts[5] if len(parts) > 5 else None,
    )


class MqttCaptureIngestAdapter(CaptureIngestPort):
    def __init__(self, *, broker_url: str = "mqtt://emqx-listeners:1883") -> None:
        self._broker_url = broker_url

    async def submit(self, capture: Capture) -> str:
        raise NotImplementedError(
            "MqttCaptureIngestAdapter.submit is a scaffold stub. Wire the EMQX "
            "subscription + inference queue in apply Phase 3."
        )
