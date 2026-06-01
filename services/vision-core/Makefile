.PHONY: help install dev proto test lint typecheck run-rest run-grpc docker-jetson clean

PY ?= python3.12

help:
	@echo "vision-core — make targets"
	@echo "  install      pip install -e ."
	@echo "  dev          pip install -e '.[dev]'"
	@echo "  proto        generate gRPC stubs from proto/vision/v1/vision.proto"
	@echo "  test         pytest"
	@echo "  lint         ruff check"
	@echo "  typecheck    mypy"
	@echo "  run-rest     uvicorn REST app (needs '.[rest]')"
	@echo "  docker-jetson  build the Jetson edge image"

install:
	$(PY) -m pip install -e .

dev:
	$(PY) -m pip install -e '.[dev]'

# Generates vision_pb2.py / vision_pb2_grpc.py into the generated/ package.
proto:
	$(PY) -m grpc_tools.protoc \
		-I proto \
		--python_out=src/vision_core/adapters/primary/grpc/generated \
		--grpc_python_out=src/vision_core/adapters/primary/grpc/generated \
		proto/vision/v1/vision.proto

test:
	$(PY) -m pytest -q

lint:
	$(PY) -m ruff check src tests

typecheck:
	$(PY) -m mypy src

run-rest:
	$(PY) -m uvicorn vision_core.adapters.primary.rest:create_app --factory --port 8080

run-grpc:
	$(PY) -m vision_core.runtime

docker-jetson:
	docker build -f deployment/jetson/Dockerfile -t vision-core:jetson .

clean:
	rm -rf .pytest_cache .ruff_cache .mypy_cache **/__pycache__ dist build *.egg-info
