# Makefile Standalone Refactor — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Refactor the standalone/docker-compose section of `Makefile` to follow `dev-<recurso>-<verbo>` convention, add `bootstrap-standalone`, add ANSI-colored structured `help`, and preserve old target names as silent aliases.

**Architecture:** Single-file refactor of the repo-root `Makefile`. New targets live alongside the existing Minikube section. Old targets are converted to one-liner alias rules pointing to the new ones. The `help` recipe is rewritten to use ANSI color variables and reorders existing content.

**Tech Stack:** GNU Make, Bash, Podman Compose, Flutter (Linux desktop), netcat (`nc`), `timeout`.

**Spec:** `docs/specs/superpowers/specs/2026-04-23-makefile-standalone-refactor-design.md`

---

## File Structure

**Files modified:**
- `Makefile` (repo root)

**Files created:** None.

**Tests:** No unit tests. Each task ends with a behavioral verification step — running a `make` command (often `make -n` for dry-run) and checking the output against an expected value.

---

## Task 1: Add ANSI color variables and prerequisite check

**Files:**
- Modify: `Makefile` — add color block after line 20 (before `# --- Phony ---`)

- [ ] **Step 1: Verify tooling prerequisites**

Run the following commands and confirm each prints a version or a path (failure means the plan can't execute — halt and report):

```bash
which make && make --version | head -1
which podman && podman --version
which flutter && flutter --version | head -1
which nc
which timeout
```

Expected: each produces output, no "not found".

- [ ] **Step 2: Open `Makefile` and locate the insertion point**

Read lines 1-24 of `Makefile`. The section `# --- Variables ---` ends with the `HELM_VALUES_DEV` variable around line 17. The `K8S_DEPS_DIR` and `SCRIPTS_DIR` variables follow around lines 19-20. The block `# --- Phony ---` begins near line 22.

Insert the new color variables **between `SCRIPTS_DIR` (line 20) and the `# --- Phony ---` comment (line 22)**.

- [ ] **Step 3: Insert color variables**

Use `Edit` to change:

```make
K8S_DEPS_DIR   = k8s/dependencies
SCRIPTS_DIR    = infrastructure/scripts

# --- Phony -------------------------------------------------------------------
```

to:

```make
K8S_DEPS_DIR   = k8s/dependencies
SCRIPTS_DIR    = infrastructure/scripts

# --- ANSI colors -------------------------------------------------------------

BLUE   := \033[36m
GREEN  := \033[32m
YELLOW := \033[33m
RED    := \033[31m
NC     := \033[0m

# --- Standalone / Flutter ----------------------------------------------------

STANDALONE_IMAGE ?= agentic-core
UI_DIR           := ui
UI_BINARY        := $(UI_DIR)/build/linux/x64/release/bundle/agent_studio

# --- Phony -------------------------------------------------------------------
```

- [ ] **Step 4: Verify Makefile still parses**

Run: `make -n help`
Expected: prints the existing help text (still the old plain version), exits 0, no "missing separator" or parse errors.

- [ ] **Step 5: Commit**

```bash
git add Makefile
git commit -m "$(cat <<'EOF'
build(make): add ANSI color vars and standalone path vars

Preparation for the standalone mode refactor: color palette matching
altrupets and path variables for the Flutter desktop binary.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

## Task 2: Add `dev-backend-*` family

**Files:**
- Modify: `Makefile` — add new targets inside the existing "STANDALONE AGENT STUDIO" section (around line 280); update `.PHONY` block at top.

- [ ] **Step 1: Update `.PHONY` to include new backend targets**

Locate the `.PHONY:` block (around lines 24-38). Change the existing line:

```make
	build-web build-docker up down clean \
```

to add new backend entries on a new continuation line:

```make
	build-web build-docker up down clean \
	dev-backend-build dev-backend-up dev-backend-down dev-backend-destroy \
	dev-backend-logs dev-backend-status dev-backend-wait \
```

- [ ] **Step 2: Locate the standalone section**

Read lines 280-305 of `Makefile`. Find the block:

```make
# =============================================================================
# STANDALONE AGENT STUDIO (docker compose, no K8s)
# =============================================================================

build-web:
	cd ui && flutter pub get && flutter build web --release

build-docker: build-web
	podman build -t agentic-core -f deployment/docker/Dockerfile .
```

- [ ] **Step 3: Insert `dev-backend-*` targets between the section header and `build-web`**

Use `Edit` to replace:

```make
# =============================================================================
# STANDALONE AGENT STUDIO (docker compose, no K8s)
# =============================================================================

build-web:
	cd ui && flutter pub get && flutter build web --release
```

with:

```make
# =============================================================================
# STANDALONE — Backend (docker-compose)
# =============================================================================
#
# NOTE: In standalone mode, `dev-backend-*` targets operate the compose stack.
# In Kubernetes mode, `dev-deploy`/`dev-build` operate the same service via Helm.
# Same "backend" resource, two deployment homes.

dev-backend-build: build-web ## Build agentic-core image (flutter web + podman build)
	@echo "$(BLUE)Building agentic-core image...$(NC)"
	podman build -t $(STANDALONE_IMAGE) -f deployment/docker/Dockerfile .
	@echo "$(GREEN)✓ Image built: $(STANDALONE_IMAGE)$(NC)"

dev-backend-up: ## Start compose stack (detached)
	@echo "$(BLUE)Starting compose stack...$(NC)"
	podman compose up -d
	@echo "$(GREEN)✓ Compose stack started$(NC)"

dev-backend-down: ## Stop compose stack (preserve volumes)
	podman compose down
	@echo "$(GREEN)✓ Compose stack stopped$(NC)"

dev-backend-destroy: ## Stop compose stack and remove volumes
	podman compose down -v
	@echo "$(GREEN)✓ Compose stack destroyed (volumes removed)$(NC)"

dev-backend-logs: ## Tail compose logs
	podman compose logs -f

dev-backend-status: ## Show compose service status
	@podman compose ps

dev-backend-wait: ## Wait for backend WebSocket port (:8765) up to 60s
	@echo "$(BLUE)Waiting for backend on :8765 (max 60s)...$(NC)"
	@timeout 60 bash -c 'until nc -z localhost 8765 2>/dev/null; do sleep 1; done' \
		|| { echo "$(RED)✗ Backend not ready after 60s$(NC)"; exit 1; }
	@echo "$(GREEN)✓ Backend ready$(NC)"

# --- Legacy web-bundle target (used as dep by dev-backend-build) -------------

build-web:
	cd ui && flutter pub get && flutter build web --release
```

- [ ] **Step 4: Verify Makefile parses and new targets are visible**

Run: `make -n dev-backend-status`
Expected: prints `podman compose ps` (the recipe body) and exits 0. No parse errors.

Run: `make -n dev-backend-wait`
Expected: prints the three echo/timeout commands from the recipe, exits 0.

- [ ] **Step 5: Verify `dev-backend-status` executes correctly**

Run: `make dev-backend-status`
Expected: either prints a compose service table or prints nothing (if compose isn't up). Should NOT error. Exit code 0.

- [ ] **Step 6: Commit**

```bash
git add Makefile
git commit -m "$(cat <<'EOF'
build(make): add dev-backend-* family for standalone compose

Introduces dev-backend-build/up/down/destroy/logs/status/wait targets
that operate the docker-compose stack following the
dev-<recurso>-<verbo> convention declared in the file header.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

## Task 3: Add `dev-desktop-*` family

**Files:**
- Modify: `Makefile` — add new targets after `dev-backend-*` section; update `.PHONY`.

- [ ] **Step 1: Update `.PHONY` to include new desktop targets**

Locate the `.PHONY:` block and add a new continuation line after the `dev-backend-*` line added in Task 2:

```make
	dev-backend-logs dev-backend-status dev-backend-wait \
	dev-desktop-build dev-desktop-launch dev-desktop-launch-dev dev-desktop-clean \
```

- [ ] **Step 2: Locate insertion point**

Read the Makefile section after the `build-web:` recipe added at the end of Task 2. Find the existing block:

```make
build-docker: build-web
	podman build -t agentic-core -f deployment/docker/Dockerfile .
```

(This block still exists from the original file — we haven't touched it yet.)

Insert the new `dev-desktop-*` section **between `build-web` and `build-docker`**.

- [ ] **Step 3: Insert `dev-desktop-*` targets**

Use `Edit` to replace:

```make
build-web:
	cd ui && flutter pub get && flutter build web --release

build-docker: build-web
	podman build -t agentic-core -f deployment/docker/Dockerfile .
```

with:

```make
build-web:
	cd ui && flutter pub get && flutter build web --release

# =============================================================================
# STANDALONE — Desktop App (Flutter Linux native)
# =============================================================================

dev-desktop-build: ## Build Flutter Linux release
	@cd $(UI_DIR) && flutter pub get && flutter build linux --release
	@echo "$(GREEN)✓ Desktop build ready: $(UI_BINARY)$(NC)"

dev-desktop-launch: ## Run the compiled release binary (requires dev-desktop-build first)
	@if [ ! -x $(UI_BINARY) ]; then \
		echo "$(RED)✗ Binary not found at $(UI_BINARY)$(NC)"; \
		echo "  Run 'make dev-desktop-build' first."; \
		exit 1; \
	fi
	@echo "$(GREEN)Launching Agent Studio (release)$(NC)"
	@./$(UI_BINARY)

dev-desktop-launch-dev: ## Launch Flutter Linux with hot reload
	@cd $(UI_DIR) && flutter pub get && flutter run -d linux

dev-desktop-clean: ## flutter clean for the UI
	@cd $(UI_DIR) && flutter clean
	@echo "$(GREEN)✓ Flutter build artifacts cleaned$(NC)"

build-docker: build-web
	podman build -t agentic-core -f deployment/docker/Dockerfile .
```

- [ ] **Step 4: Verify parse + dry-run**

Run: `make -n dev-desktop-clean`
Expected: prints `cd ui && flutter clean` and the echo, exits 0.

Run: `make -n dev-desktop-build`
Expected: prints the flutter pub get/build commands, exits 0.

- [ ] **Step 5: Verify the missing-binary guard works**

Check that `$(UI_BINARY)` does not exist (or temporarily rename it if it does):

```bash
test ! -x ui/build/linux/x64/release/bundle/agent_studio && echo "binary absent" || echo "binary present"
```

Then run: `make dev-desktop-launch`
Expected: prints `✗ Binary not found at ui/build/linux/x64/release/bundle/agent_studio` followed by `  Run 'make dev-desktop-build' first.`, exit code 1.

If the binary already exists from a previous build, skip this check — the guard is a trivial `[ -x ]` test and doesn't need verification when the file is present.

- [ ] **Step 6: Commit**

```bash
git add Makefile
git commit -m "$(cat <<'EOF'
build(make): add dev-desktop-* family for Flutter Linux native

Targets for building and launching the native Flutter desktop app.
dev-desktop-launch includes a guard against running a missing binary.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

## Task 4: Add `bootstrap-standalone`

**Files:**
- Modify: `Makefile` — add target near the existing `bootstrap-dev` (line 113); update `.PHONY`.

- [ ] **Step 1: Update `.PHONY` to include bootstrap-standalone**

Locate the `.PHONY:` block. Find the line:

```make
.PHONY: help proto test lint typecheck \
	bootstrap-dev \
```

Change to:

```make
.PHONY: help proto test lint typecheck \
	bootstrap-dev bootstrap-standalone \
```

- [ ] **Step 2: Locate insertion point near `bootstrap-dev`**

Read lines 109-121 of `Makefile`. The `bootstrap-dev` recipe ends around line 120. Insert `bootstrap-standalone` immediately after it.

- [ ] **Step 3: Insert `bootstrap-standalone`**

Use `Edit` to replace:

```make
bootstrap-dev: dev-minikube-start dev-secret-create dev-deps-deploy dev-deps-wait dev-build dev-deploy ## Full local cluster setup
	@echo ""
	@echo "=== agentic-core cluster ready ==="
	@echo ""
	@echo "  Run:  make dev-port-forward"
	@echo "  Then: ws://localhost:8765  (WebSocket)"
	@echo "        localhost:50051      (gRPC)"
	@echo ""
```

with:

```make
bootstrap-dev: dev-minikube-start dev-secret-create dev-deps-deploy dev-deps-wait dev-build dev-deploy ## Full local cluster setup (Minikube)
	@echo ""
	@echo "$(GREEN)=== agentic-core cluster ready ===$(NC)"
	@echo ""
	@echo "  Run:  make dev-port-forward"
	@echo "  Then: ws://localhost:8765  (WebSocket)"
	@echo "        localhost:50051      (gRPC)"
	@echo ""

bootstrap-standalone: dev-backend-build dev-backend-up dev-backend-wait ## Compose stack + Flutter desktop (hot reload)
	@echo ""
	@echo "$(GREEN)=== Backend stack ready ===$(NC)"
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

- [ ] **Step 4: Verify dry-run shows the correct orchestration**

Run: `make -n bootstrap-standalone`
Expected output contains, in order:
1. `podman build -t agentic-core ...` (from dev-backend-build)
2. `podman compose up -d` (from dev-backend-up)
3. `timeout 60 bash -c 'until nc -z localhost 8765 ...` (from dev-backend-wait)
4. Echo lines about backend stack ready
5. A recursive `make dev-desktop-launch-dev` invocation

Exit code 0.

- [ ] **Step 5: Commit**

```bash
git add Makefile
git commit -m "$(cat <<'EOF'
build(make): add bootstrap-standalone turnkey target

One-command path from clean workspace to a live Flutter desktop
dev session with compose backend running. Parallels bootstrap-dev
for the standalone deployment mode.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

## Task 5: Convert old targets to silent aliases

**Files:**
- Modify: `Makefile` — remove original `build-docker`, `up`, `down`, `clean-compose`, `build-desktop`, `desktop`, `desktop-dev` recipes; replace with one-line alias declarations.

- [ ] **Step 1: Locate the legacy recipes**

Read the Makefile section that now contains (roughly — exact position shifts due to earlier tasks):

```make
build-docker: build-web
	podman build -t agentic-core -f deployment/docker/Dockerfile .

images-pull: ## Pull all third-party container images required by docker-compose (run after `podman system prune`)
	podman pull docker.io/falkordb/falkordb:latest
	podman pull docker.io/library/redis:7-alpine
	podman pull docker.io/pgvector/pgvector:pg16

up: build-docker
	podman compose up -d
	@echo "Agent Studio running at http://localhost:8765"

down:
	podman compose down

clean-compose:
	podman compose down -v
	podman rmi agentic-core 2>/dev/null || true
	rm -rf ui/build/

# --- Desktop App (Linux) ---

build-desktop:
	cd ui && flutter build linux --release

desktop: build-docker
	@echo "Starting backend services..."
	podman compose up -d
	@echo "Waiting for backend..."
	@sleep 3
	@echo "Launching Agent Studio Desktop..."
	cd ui && ./build/linux/x64/release/bundle/agent_studio

desktop-dev:
	@echo "Starting backend services..."
	podman compose up -d
	@echo "Launching Flutter Desktop (hot reload)..."
	cd ui && flutter run -d linux
```

- [ ] **Step 2: Replace with aliases (keep `images-pull` untouched)**

Use `Edit` to replace the block above with:

```make
# --- Legacy aliases (point to dev-backend-* / dev-desktop-* equivalents) -----

build-docker: dev-backend-build
up: dev-backend-up
down: dev-backend-down
clean-compose: dev-backend-destroy
build-desktop: dev-desktop-build
desktop: dev-desktop-launch
desktop-dev: dev-desktop-launch-dev

images-pull: ## Pull all third-party container images required by docker-compose (run after `podman system prune`)
	podman pull docker.io/falkordb/falkordb:latest
	podman pull docker.io/library/redis:7-alpine
	podman pull docker.io/pgvector/pgvector:pg16
```

**Important:** these alias rules have NO recipe — they only declare a dependency on the new target. When the user runs `make up`, Make sees `up` depends on `dev-backend-up` and runs the new target. The `up` target itself has nothing to do.

- [ ] **Step 3: Verify `.PHONY` still lists all aliases**

Check that the `.PHONY` block (near the top of the Makefile) still contains: `build-web build-docker up down clean build-desktop desktop desktop-dev clean-compose`. These should already be present from the original file. If any are missing, add them.

- [ ] **Step 4: Verify aliases resolve correctly**

Run: `make -n up`
Expected: prints the recipe body of `dev-backend-up` (i.e., the echo + `podman compose up -d`).

Run: `make -n desktop-dev`
Expected: prints the recipe body of `dev-desktop-launch-dev` (the `cd ui && flutter pub get && flutter run -d linux`).

Run: `make -n build-desktop`
Expected: prints the recipe body of `dev-desktop-build`.

- [ ] **Step 5: Commit**

```bash
git add Makefile
git commit -m "$(cat <<'EOF'
build(make): convert legacy standalone targets to aliases

up, down, desktop, desktop-dev, build-docker, build-desktop,
clean-compose now delegate to their dev-backend-* / dev-desktop-*
counterparts. Preserves muscle memory without maintaining duplicate
recipes.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

## Task 6: Rewrite the `help` recipe with colors and new structure

**Files:**
- Modify: `Makefile` — replace the entire `help:` recipe (lines 44-86 originally).

- [ ] **Step 1: Locate the current `help` recipe**

Read the Makefile. Find the section:

```make
# =============================================================================
# HELP (default target)
# =============================================================================

help: ## Show this help
	@echo ""
	@echo "  agentic-core — AI Agent Orchestration Library"
	@echo "  =============================================="
	...
```

- [ ] **Step 2: Replace the `help` recipe body**

Use `Edit` to replace the entire `help:` recipe (from the line `help: ## Show this help` through to the line `@echo ""` that precedes `# =============================================================================` for the next section).

Replace with:

```make
help: ## Show this help
	@echo ""
	@echo "$(BLUE)╔════════════════════════════════════════════════════════════════╗$(NC)"
	@echo "$(BLUE)║        agentic-core — AI Agent Orchestration Library            ║$(NC)"
	@echo "$(BLUE)╚════════════════════════════════════════════════════════════════╝$(NC)"
	@echo ""
	@echo "$(GREEN)Quick Start:$(NC)"
	@echo "  $(YELLOW)Standalone (Flutter desktop + compose):$(NC)"
	@echo "    make bootstrap-standalone"
	@echo ""
	@echo "  $(YELLOW)Kubernetes (Minikube):$(NC)"
	@echo "    make bootstrap-dev"
	@echo ""
	@echo "$(GREEN)DEV - Development:$(NC)"
	@echo "  $(YELLOW)test$(NC)              Run unit tests"
	@echo "  $(YELLOW)lint$(NC)              Run ruff linter"
	@echo "  $(YELLOW)typecheck$(NC)         Run mypy strict"
	@echo "  $(YELLOW)proto$(NC)             Regenerate gRPC stubs"
	@echo ""
	@echo "$(GREEN)DEV - Standalone Backend (docker-compose):$(NC)"
	@echo "  $(YELLOW)dev-backend-build$(NC)      Build image (flutter web + podman build)"
	@echo "  $(YELLOW)dev-backend-up$(NC)         Start compose stack"
	@echo "  $(YELLOW)dev-backend-down$(NC)       Stop compose stack"
	@echo "  $(YELLOW)dev-backend-destroy$(NC)    Stop + remove volumes"
	@echo "  $(YELLOW)dev-backend-logs$(NC)       Tail compose logs"
	@echo "  $(YELLOW)dev-backend-status$(NC)     Show compose ps"
	@echo "  $(YELLOW)dev-backend-wait$(NC)       Wait for WS port (:8765) ready"
	@echo ""
	@echo "$(GREEN)DEV - Desktop App (Flutter Linux):$(NC)"
	@echo "  $(YELLOW)dev-desktop-build$(NC)          flutter build linux --release"
	@echo "  $(YELLOW)dev-desktop-launch$(NC)         Run compiled release binary"
	@echo "  $(YELLOW)dev-desktop-launch-dev$(NC)     flutter run -d linux (hot reload)"
	@echo "  $(YELLOW)dev-desktop-clean$(NC)          flutter clean"
	@echo ""
	@echo "$(GREEN)DEV - Minikube Cluster:$(NC)"
	@echo "  $(YELLOW)dev-minikube-start$(NC)       Start Minikube cluster"
	@echo "  $(YELLOW)dev-minikube-stop$(NC)        Pause cluster"
	@echo "  $(YELLOW)dev-minikube-destroy$(NC)     Delete cluster"
	@echo "  $(YELLOW)dev-minikube-status$(NC)      Show cluster status"
	@echo ""
	@echo "$(GREEN)DEV - Dependencies (Redis, PostgreSQL+pgvector, FalkorDB):$(NC)"
	@echo "  $(YELLOW)dev-deps-deploy$(NC)     Deploy all dependencies"
	@echo "  $(YELLOW)dev-deps-destroy$(NC)    Remove all dependencies"
	@echo "  $(YELLOW)dev-deps-status$(NC)     Show dependency pod status"
	@echo "  $(YELLOW)dev-deps-wait$(NC)       Wait for all deps to be ready"
	@echo ""
	@echo "$(GREEN)DEV - Build & Deploy K8s:$(NC)"
	@echo "  $(YELLOW)dev-build$(NC)              Build image into Minikube"
	@echo "  $(YELLOW)dev-deploy$(NC)             Helm install agentic-core"
	@echo "  $(YELLOW)dev-deploy-upgrade$(NC)     Helm upgrade after rebuild"
	@echo "  $(YELLOW)dev-deploy-destroy$(NC)     Helm uninstall"
	@echo ""
	@echo "$(GREEN)DEV - Access & Observability:$(NC)"
	@echo "  $(YELLOW)dev-port-forward$(NC)       Forward WS:8765 + gRPC:50051"
	@echo "  $(YELLOW)dev-port-forward-stop$(NC)  Kill background port-forward"
	@echo "  $(YELLOW)dev-logs$(NC)               Tail agentic-core logs"
	@echo "  $(YELLOW)dev-logs-deps$(NC)          Tail dependency logs"
	@echo "  $(YELLOW)dev-status$(NC)             Full cluster status"
	@echo ""
	@echo "$(GREEN)Bootstrap:$(NC)"
	@echo "  $(YELLOW)bootstrap-standalone$(NC)   Compose + Flutter desktop (hot reload)"
	@echo "  $(YELLOW)bootstrap-dev$(NC)          Minikube + deps + build + deploy"
	@echo ""
	@echo "$(GREEN)Cleanup:$(NC)"
	@echo "  $(YELLOW)dev-clean$(NC)              Destroy K8s cluster + images"
	@echo "  $(YELLOW)dev-backend-destroy$(NC)    Destroy compose + volumes"
	@echo ""
```

- [ ] **Step 3: Verify help renders with colors**

Run: `make help`
Expected: output contains the new box-drawing header, colored section titles (`Quick Start:`, `DEV - Standalone Backend`, etc.), colored target names, and all items listed. Colors are visible in a standard terminal.

If the terminal doesn't render colors (e.g., when piping to a file), the ANSI escape codes will appear as literal characters — that's normal, not a bug. Confirm with `make help | cat -v` if needed.

- [ ] **Step 4: Verify default goal still resolves**

Run: `make` (no arguments)
Expected: same output as `make help`. The `.DEFAULT_GOAL := help` line (or the fact that `help` is the first non-phony target declared with a recipe) ensures this.

If `make` without arguments does not print help, add at the very end of the Makefile:

```make
.DEFAULT_GOAL := help
```

Note: current Makefile relies on `help` being the first real target. If the ordering of tasks in this plan has shifted that, adding `.DEFAULT_GOAL` is the fix.

- [ ] **Step 5: Commit**

```bash
git add Makefile
git commit -m "$(cat <<'EOF'
build(make): rewrite help with ANSI colors and new structure

Reorganizes help output by section (Standalone first, then Minikube)
and adds ANSI colors matching the altrupets pattern. Quick Start
block at top shows the two main entry points (bootstrap-standalone,
bootstrap-dev).

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

## Task 7: End-to-end verification

**Files:** None modified — this task only verifies.

- [ ] **Step 1: Lint Makefile — no parse errors on any known target**

Run:

```bash
for target in help test lint typecheck proto \
              bootstrap-dev bootstrap-standalone \
              dev-minikube-start dev-minikube-stop dev-minikube-destroy dev-minikube-status \
              dev-deps-deploy dev-deps-destroy dev-deps-status dev-deps-wait \
              dev-build dev-deploy dev-deploy-upgrade dev-deploy-destroy \
              dev-port-forward dev-port-forward-stop dev-logs dev-logs-deps dev-status dev-clean \
              dev-backend-build dev-backend-up dev-backend-down dev-backend-destroy \
              dev-backend-logs dev-backend-status dev-backend-wait \
              dev-desktop-build dev-desktop-launch dev-desktop-launch-dev dev-desktop-clean \
              up down build-docker build-desktop desktop desktop-dev clean-compose \
              build-web images-pull \
              docs-site docs-specs docs tui tui-build; do
    make -n "$target" >/dev/null 2>&1 && echo "ok  $target" || echo "FAIL $target"
done
```

Expected: every target prints `ok`. If any `FAIL`, investigate before continuing.

**Caveat:** some targets may print `FAIL` in dry-run if they use shell substitutions that require runtime evaluation. This is acceptable for targets like `dev-port-forward-stop` that check for `.port-forward.pid`. What matters is NO parse errors in the Makefile itself. If you see `make: *** missing separator`, the Makefile is broken and must be fixed.

- [ ] **Step 2: Run `make help` and visually confirm structure**

Run: `make help`
Visually confirm:
- Box-drawing header shows
- Colors render (or ANSI codes visible if terminal doesn't support color)
- Sections appear in this order: Quick Start, DEV - Development, DEV - Standalone Backend, DEV - Desktop App, DEV - Minikube Cluster, DEV - Dependencies, DEV - Build & Deploy K8s, DEV - Access & Observability, Bootstrap, Cleanup
- All 18 new dev-backend-*/dev-desktop-* targets are listed

- [ ] **Step 3: Dry-run the full bootstrap-standalone**

Run: `make -n bootstrap-standalone 2>&1 | head -30`
Expected: sequence shows
1. `podman build -t agentic-core -f deployment/docker/Dockerfile .` (from dev-backend-build via build-web)
2. `podman compose up -d` (from dev-backend-up)
3. `timeout 60 bash -c 'until nc -z localhost 8765 2>/dev/null; do sleep 1; done' ...` (from dev-backend-wait)
4. Echo about backend stack ready
5. A `make dev-desktop-launch-dev` sub-invocation

- [ ] **Step 4: Live smoke test (optional but recommended)**

If you have `flutter`, `podman`, `nc`, and `timeout` installed and want to actually run the full flow:

```bash
make bootstrap-standalone
```

Expected:
- Podman builds the image (first time is slow)
- Compose starts (redis, postgres, falkordb, agentic-core)
- `dev-backend-wait` returns within ~60s with `✓ Backend ready`
- Flutter opens a Linux window showing the Agent Studio UI
- Hot reload keybindings (`r`, `R`, `q`) work inside the `flutter run` session

If any step fails, the error message should identify which phase broke. Common failures: `podman` not running (fix: `systemctl --user start podman`), `flutter` not on PATH (fix: install or add to PATH), `:8765` already bound (fix: `make dev-backend-down` or kill the conflicting process).

- [ ] **Step 5: Verify aliases still work**

Run:

```bash
make -n up      | head -5     # should show dev-backend-up body
make -n desktop | head -5     # should show dev-desktop-launch body
make -n build-docker | head -5  # should show dev-backend-build body
```

Each should print the new target's recipe, not an error.

- [ ] **Step 6: No commit needed for this task**

This task is verification-only. If all steps passed, proceed to final self-review. If any failed, return to the relevant task and fix.

---

## Self-Review Checklist (run after all tasks written)

### Spec coverage

Go through each section of the spec and confirm a task covers it:

| Spec section | Covered by |
|---|---|
| Decision 1: A + C scope | All tasks collectively |
| Decision 2: `dev-desktop-*` naming | Task 3 |
| Decision 3: `dev-backend-*` naming | Task 2 |
| Decision 4: Dev-friendly bootstrap (B) | Task 4 |
| Decision 5: Silent aliases (C) | Task 5 |
| Target inventory — dev-backend-* | Task 2 |
| Target inventory — dev-desktop-* | Task 3 |
| Aliases | Task 5 |
| Help structure (colors, sections) | Tasks 1 + 6 |
| New variables | Task 1 |
| `dev-backend-wait` recipe | Task 2 |
| `dev-desktop-launch` guard | Task 3 |
| `bootstrap-standalone` choreography | Task 4 |
| `.PHONY` updates | Tasks 1-5 (each adds its own phony entries) |

**No gaps.**

### Placeholder scan

Search the plan body for: "TBD", "TODO", "implement later", "fill in", "appropriate error handling", "similar to task". No matches found.

### Type consistency

- Variable names: `STANDALONE_IMAGE`, `UI_DIR`, `UI_BINARY` — used consistently across Tasks 1, 2, 3.
- Target names: `dev-backend-*`, `dev-desktop-*` — used consistently across Tasks 2-6.
- Colors: `$(BLUE)`, `$(GREEN)`, `$(YELLOW)`, `$(RED)`, `$(NC)` — defined in Task 1, used consistently in Tasks 2, 3, 4, 6.

**Consistent.**
