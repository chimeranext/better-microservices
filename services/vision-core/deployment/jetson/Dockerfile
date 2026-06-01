# vision-core — NVIDIA Jetson edge image (real-time YOLO26-seg, TensorRT/cuDNN).
#
# Base on NVIDIA L4T (JetPack 5+) so tensorrt + cuDNN + cuda come from the BSP.
# tensorrt / pycuda are NOT installed from PyPI — they ship with JetPack on-device.
#
# Build ON a Jetson (or with buildx --platform linux/arm64):
#   docker build -f deployment/jetson/Dockerfile -t vision-core:jetson .
#
# Licensing: the default edge model (Ultralytics YOLO-seg) is AGPL-3.0. For a
# commercial edge product, either obtain an Ultralytics Enterprise license or set
# VISION_DEFAULT_FAMILY=rfdetr_seg (Apache-2.0). See LICENSE.md / openspec design.md.

ARG L4T_TAG=r35.4.1
FROM nvcr.io/nvidia/l4t-pytorch:${L4T_TAG}-pth2.0-py3

WORKDIR /app

# System deps for GStreamer hardware decode (NVDEC) used by the Jetson stream adapter.
RUN apt-get update && apt-get install -y --no-install-recommends \
        python3-pip libgstreamer1.0-0 gstreamer1.0-plugins-bad \
    && rm -rf /var/lib/apt/lists/*

COPY pyproject.toml README.md ./
COPY src/ src/
COPY proto/ proto/

# Install vision-core with the edge extra. Choose 'yolo' (AGPL) or 'rfdetr' (Apache).
ARG MODEL_EXTRA=rfdetr
RUN pip3 install --no-cache-dir ".[edge,${MODEL_EXTRA}]"

ENV PYTHONPATH=/app/src
ENV VISION_TIER=edge
ENV VISION_INFERENCE_LOCAL=true
ENV VISION_DEFAULT_FAMILY=rfdetr_seg
ENV VISION_GRPC_PORT=50051

EXPOSE 50051 8080 9090
ENTRYPOINT ["python3", "-m", "vision_core.runtime"]
