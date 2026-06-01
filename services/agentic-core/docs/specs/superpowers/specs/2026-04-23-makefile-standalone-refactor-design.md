# Makefile Standalone Mode Refactor — Design

**Status:** Draft — pending implementation
**Date:** 2026-04-23
**Scope:** `Makefile` (repo root)

## Context

The repo has two deployment modes coexisting in a single Makefile:

1. **Minikube / K8s** — lines 88-278. Follows `dev-<recurso>-<verbo>` convention: `dev-minikube-start`, `dev-deps-deploy`, `dev-port-forward`, etc. Added in commit `a2836cc`.
2. **Standalone / docker-compose** — lines 280-324. Breaks the convention: `up`, `down`, `desktop`, `desktop-dev`, `build-web`, `build-docker`, `build-desktop`, `clean-compose`.

The Makefile header declares `dev-<recurso>-<verbo>` as the project convention (line 4), but the standalone section contradicts it. There is no `bootstrap-standalone` parallel to `bootstrap-dev`. There are no ANSI colors or structured `help` output.

Reference pattern: `altrupets/monorepo/Makefile` — same conventions, same color palette, same `bootstrap-*` structure.

## Goals

- Rename standalone targets to follow `dev-<recurso>-<verbo>`.
- Add ANSI colors + structured `help`.
- Add `bootstrap-standalone` — one command that builds the compose stack, waits for health, and launches Flutter desktop in hot-reload mode.
- Keep old target names as silent aliases (no deprecation warnings).

## Non-Goals

- Rewriting the Minikube section.
- Changing `docker-compose.yml` or the Dockerfile.
- Changing `proto`, `test`, `lint`, `typecheck`, `docs-*`, `tui*`, `images-pull`.
- Adding a Flutter web launch target (web bundle is served by the backend image at `:8080`; no separate launch needed).

## Design Decisions

| # | Question | Decision | Rationale |
|---|---|---|---|
| 1 | Scope of request | A + C (rename + bootstrap) | Current standalone works; pain is naming + lack of turnkey path. |
| 2 | Resource name for Flutter desktop app | `dev-desktop-*` | Descriptive (what it is), not product-branded. |
| 3 | Resource name for compose backend | `dev-backend-*` | Describes the role (backend service). |
| 4 | Scope of `bootstrap-standalone` | Dev-friendly (B) | Ends in `flutter run -d linux` hot reload — a walking skeleton, not an artifact. |
| 5 | Old target names | Silent aliases (C) | Zero-cost muscle memory protection; no deprecation noise. |

**Trade-off accepted in decision 3:** `dev-backend-*` describes a role while the existing `dev-minikube-*` describes a tool — mixing axes. If a future `dev-backend-deploy` for K8s is added, it will clash with the current `dev-deploy` (Helm). Documented in the Makefile header comment.

## Target Inventory

### Visible in `help`

**`dev-backend-*`** (compose backend):

| Target | Action |
|---|---|
| `dev-backend-build` | `flutter build web` → `podman build -t agentic-core -f deployment/docker/Dockerfile .` |
| `dev-backend-up` | `podman compose up -d` |
| `dev-backend-down` | `podman compose down` |
| `dev-backend-destroy` | `podman compose down -v` |
| `dev-backend-logs` | `podman compose logs -f` |
| `dev-backend-status` | `podman compose ps` |
| `dev-backend-wait` | Poll TCP `localhost:8765` with 60s timeout |

**`dev-desktop-*`** (Flutter Linux native):

| Target | Action |
|---|---|
| `dev-desktop-build` | `cd ui && flutter pub get && flutter build linux --release` |
| `dev-desktop-launch` | Guard binary exists → run `ui/build/linux/x64/release/bundle/agent_studio` |
| `dev-desktop-launch-dev` | `cd ui && flutter pub get && flutter run -d linux` |
| `dev-desktop-clean` | `cd ui && flutter clean` |

**Bootstrap:**

| Target | Action |
|---|---|
| `bootstrap-standalone` | `dev-backend-build` → `dev-backend-up` → `dev-backend-wait` → `$(MAKE) dev-desktop-launch-dev` |

### Silent aliases (not in `help`)

```
up            → dev-backend-up
down          → dev-backend-down
build-docker  → dev-backend-build
clean-compose → dev-backend-destroy
build-desktop → dev-desktop-build
desktop       → dev-desktop-launch
desktop-dev   → dev-desktop-launch-dev
```

**Preserved as-is:** `build-web` (stays as a top-level target; used as a dependency of `dev-backend-build`).

## Help Structure

Header uses the altrupets box-drawing style. Sections, in order:

1. Quick Start (Standalone + Minikube one-liners)
2. DEV - Development (`test`, `lint`, `typecheck`, `proto`)
3. DEV - Standalone Backend (`dev-backend-*`)
4. DEV - Desktop App (`dev-desktop-*`)
5. DEV - Minikube Cluster (`dev-minikube-*`)
6. DEV - Dependencies (`dev-deps-*`)
7. DEV - Build & Deploy K8s (`dev-build`, `dev-deploy`, ...)
8. DEV - Access & Observability (`dev-port-forward`, `dev-logs`, `dev-status`)
9. Bootstrap (`bootstrap-standalone`, `bootstrap-dev`)
10. Cleanup (`dev-clean`)

Section titles in `$(GREEN)`, target names in `$(YELLOW)`, descriptions in `$(BLUE)` or default.

ANSI color variables at the top of the file:

```make
BLUE   := \033[36m
GREEN  := \033[32m
YELLOW := \033[33m
RED    := \033[31m
NC     := \033[0m
```

## Implementation Details

### New variables (near existing ones)

```make
STANDALONE_IMAGE ?= agentic-core
UI_DIR           := ui
UI_BINARY        := $(UI_DIR)/build/linux/x64/release/bundle/agent_studio
```

### Key recipes

**`dev-backend-wait`** — TCP polling, no HTTP endpoint assumption:

```make
dev-backend-wait:
	@echo "$(BLUE)Waiting for backend on :8765 (max 60s)...$(NC)"
	@timeout 60 bash -c 'until nc -z localhost 8765 2>/dev/null; do sleep 1; done' \
		|| { echo "$(RED)✗ Backend not ready after 60s$(NC)"; exit 1; }
	@echo "$(GREEN)✓ Backend ready$(NC)"
```

**`dev-desktop-launch`** — guards against missing binary:

```make
dev-desktop-launch:
	@if [ ! -x $(UI_BINARY) ]; then \
		echo "$(RED)✗ Binary not found at $(UI_BINARY)$(NC)"; \
		echo "  Run 'make dev-desktop-build' first."; \
		exit 1; \
	fi
	@echo "$(GREEN)Launching Agent Studio (release)$(NC)"
	@./$(UI_BINARY)
```

**`bootstrap-standalone`** — invokes Flutter via `$(MAKE)` (not as prereq) to preserve a clean TTY for hot-reload keybindings:

```make
bootstrap-standalone: dev-backend-build dev-backend-up dev-backend-wait
	@echo ""
	@echo "$(GREEN)=== Backend stack ready ==="
	@echo "  HTTP: http://localhost:8080"
	@echo "  WS:   ws://localhost:8765"
	@echo ""
	@echo "$(YELLOW)Launching Flutter desktop in dev mode.$(NC)"
	@echo "$(YELLOW)Ctrl+C stops the UI — compose stays running.$(NC)"
	@echo ""
	@$(MAKE) dev-desktop-launch-dev
	@echo ""
	@echo "$(YELLOW)UI stopped. Run 'make dev-backend-down' to stop compose.$(NC)"
```

### `.PHONY` additions

```
bootstrap-standalone
dev-backend-build dev-backend-up dev-backend-down dev-backend-destroy
dev-backend-logs dev-backend-status dev-backend-wait
dev-desktop-build dev-desktop-launch dev-desktop-launch-dev dev-desktop-clean
```

Existing `.PHONY` entries for aliases (`up`, `down`, `build-docker`, `build-desktop`, `desktop`, `desktop-dev`, `clean-compose`) remain.

## Success Criteria

1. `make help` shows the new structure with ANSI colors and all sections.
2. `make bootstrap-standalone` on a clean workspace builds the image, brings up compose, waits for `:8765`, and opens a Flutter Linux window in hot-reload mode.
3. `make dev-desktop-launch` fails clearly when the binary is missing, telling the user to run `dev-desktop-build` first.
4. Old targets (`up`, `down`, `desktop`, `desktop-dev`, etc.) continue to work identically.
5. All Minikube targets and recipes remain functionally unchanged.

## Risks & Mitigations

| Risk | Mitigation |
|---|---|
| `nc` not installed on some systems | `nc` is part of `netcat` — ship alongside podman in any dev environment. Document in help if it bites. |
| `timeout` not portable (BSD/macOS) | Repo is Linux-only per existing `build-desktop` using `flutter build linux`. Acceptable. |
| Flutter `run -d linux` blocks `bootstrap-standalone` forever | Intentional — that's the dev loop. Ctrl+C exits Flutter; compose stays via `up -d`. Help message tells the user. |
| Compose already up when `bootstrap-standalone` runs | `podman compose up -d` is idempotent; no-op on already-running services. |
| Stale `agent_studio` binary after source changes | `dev-desktop-launch` does not rebuild. User must explicitly call `dev-desktop-build` first. Documented in the guard message. |
