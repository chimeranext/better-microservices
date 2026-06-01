"""Shared pytest fixtures for vision-core."""

from __future__ import annotations

import sys
from pathlib import Path

# Make src/ importable without an editable install.
_SRC = Path(__file__).resolve().parents[1] / "src"
if str(_SRC) not in sys.path:
    sys.path.insert(0, str(_SRC))
