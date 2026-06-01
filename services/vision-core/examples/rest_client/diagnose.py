"""Example: diagnose a plant image via the vision-core REST facade.

Agrio-style image-upload ergonomics. Run the REST app first:
    make run-rest      # uvicorn on :8080
Then:
    python examples/rest_client/diagnose.py path/to/leaf.jpg
"""

from __future__ import annotations

import sys

import httpx  # part of the 'cloud'/'rest' extras


def main(image_path: str, base_url: str = "http://localhost:8080") -> None:
    with open(image_path, "rb") as fh:
        files = {"image": (image_path, fh, "image/jpeg")}
        data = {"task": "disease", "crop_hint": "lettuce"}
        resp = httpx.post(f"{base_url}/v1/segment", files=files, data=data, timeout=30)
    resp.raise_for_status()
    seg = resp.json()
    print(f"model_version       : {seg['model_version']}")
    print(f"affected_area_percent: {seg['affected_area_percent']:.1f}%")
    print(f"severity            : {seg['severity']}")
    for m in seg["masks"]:
        print(f"  - {m['class_name']} ({m['confidence']:.2f}) on {m['anatomical_part']}")


if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else "leaf.jpg")
