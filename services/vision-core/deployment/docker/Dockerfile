# vision-core — cloud/CPU image for the gRPC + REST API (no GPU).
# Use deployment/jetson/Dockerfile for edge; KServe for GPU model serving.
FROM python:3.12-slim AS builder
WORKDIR /app
COPY pyproject.toml README.md ./
COPY src/ src/
COPY proto/ proto/
RUN pip install --no-cache-dir build && \
    python -m build --wheel && \
    pip install --no-cache-dir "dist/vision_core-0.1.0-py3-none-any.whl[rest,cloud]"

FROM python:3.12-slim
COPY --from=builder /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY --from=builder /app/src /app/src
WORKDIR /app
ENV PYTHONPATH=/app/src
ENV VISION_TIER=cloud
ENV VISION_DEFAULT_FAMILY=rfdetr_seg
EXPOSE 50051 8080 9090
RUN useradd -r -s /bin/false appuser && chown -R appuser /app
USER appuser
ENTRYPOINT ["python", "-m", "vision_core.runtime"]
