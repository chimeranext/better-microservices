"""Unit tests for the real (non-stub) MLOps-tier logic.

Covers the Vertivo MQTT capture-topic parser and the HITL new-data retrain gate —
the pure pieces of the 3-tier topology that are exercised before any broker,
KServe runtime, or MinIO bucket exists.
"""

from __future__ import annotations

from vision_core.adapters.secondary.minio_active_learning_adapter import should_retrain
from vision_core.adapters.secondary.mqtt_capture_ingest_adapter import (
    parse_capture_topic,
)


def test_parse_capture_topic_full() -> None:
    t = parse_capture_topic("vertivo/1/greenhouse/42/capture/photo")
    assert t is not None
    assert t.user_id == "1"
    assert t.greenhouse_id == "42"
    assert t.category == "capture"
    assert t.type == "photo"


def test_parse_capture_topic_no_type() -> None:
    t = parse_capture_topic("vertivo/7/greenhouse/9/status")
    assert t is not None
    assert t.category == "status"
    assert t.type is None


def test_parse_capture_topic_rejects_foreign() -> None:
    assert parse_capture_topic("acme/1/site/2/sensor/temp") is None
    assert parse_capture_topic("vertivo/1/zone/2/x") is None
    assert parse_capture_topic("too/short") is None


def test_should_retrain_gate() -> None:
    assert should_retrain(50, threshold=50) is True
    assert should_retrain(51, threshold=50) is True
    assert should_retrain(49, threshold=50) is False
    assert should_retrain(0, threshold=50) is False
