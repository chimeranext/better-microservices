"""Adapters — concrete implementations of ports.

Primary (driving): gRPC, REST/FastAPI. Secondary (driven): Ultralytics YOLO,
RF-DETR, model registry, video stream. Adapters may import frameworks; domain
and application never import adapters.
"""
