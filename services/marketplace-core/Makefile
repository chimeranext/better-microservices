# marketplace-core Makefile
#
# Single entry point for local development. Mirrors the pattern used across
# sibling repos (agentic-core, aduanext, vertivolatam/monorepo, altrupets,
# habitanexus) so devs get consistent muscle memory across projects.
#
# Naming convention: <verb>-<resource> for simple local targets,
# env-<resource>-<verb> for envionment-scoped targets (dev-*, ci-*).
# New targets MUST document themselves via the ## comment — `make help`
# auto-generates from them.

SHELL := /bin/bash
.DEFAULT_GOAL := help

# Load .env if it exists (silently — devs without .env can still run many targets).
ifneq (,$(wildcard ./.env))
    include .env
    export
endif

# Prefer podman to stay aligned with sibling repos. Override with `COMPOSE=docker compose`
# if the local machine doesn't have podman-compose installed.
COMPOSE ?= podman compose
CONTAINER_ENGINE ?= podman

POSTGRES_USER ?= marketplace
POSTGRES_DB ?= marketplace_core
POSTGRES_PORT ?= 5432
MEILI_PORT ?= 7700

IMAGE_NAME ?= ghcr.io/lapc506/marketplace-core
IMAGE_TAG ?= dev

# ── Images ───────────────────────────────────────────────────────────
.PHONY: images-pull
images-pull: ## Pull third-party images required by docker-compose (run after `podman system prune`)
	$(CONTAINER_ENGINE) pull docker.io/library/postgres:16-alpine
	$(CONTAINER_ENGINE) pull docker.io/getmeili/meilisearch:v1.11

# ── Compose lifecycle ────────────────────────────────────────────────
.PHONY: up
up: ## Start postgres + meilisearch (server comes online in #5 via `up-server`)
	$(COMPOSE) up -d postgres meilisearch
	@echo ""
	@echo "postgres:    localhost:$(POSTGRES_PORT)"
	@echo "meilisearch: http://localhost:$(MEILI_PORT)"

.PHONY: up-server
up-server: ## Start full stack including marketplace-core server (requires built image)
	$(COMPOSE) --profile server up -d

.PHONY: down
down: ## Stop all compose services (preserves volumes)
	$(COMPOSE) down

.PHONY: reset
reset: ## DESTRUCTIVE: stop + drop volumes + recreate
	$(COMPOSE) down -v
	$(COMPOSE) up -d postgres meilisearch

.PHONY: logs
logs: ## Tail compose logs
	$(COMPOSE) logs -f --tail=100

.PHONY: ps
ps: ## Show compose service status
	$(COMPOSE) ps

# ── Database ─────────────────────────────────────────────────────────
.PHONY: db-psql
db-psql: ## Open psql shell to local postgres
	@PGPASSWORD="$${POSTGRES_PASSWORD:-marketplace_dev}" psql \
		-h localhost -p $(POSTGRES_PORT) -U $(POSTGRES_USER) -d $(POSTGRES_DB)

# ── Seeds ────────────────────────────────────────────────────────────
SEED_DIR ?= db/seeds

define run_seed
	@echo "[seed] applying $(1)"
	@PGPASSWORD="$${POSTGRES_PASSWORD:-marketplace_dev}" psql -v ON_ERROR_STOP=1 \
		-h localhost -p $(POSTGRES_PORT) -U $(POSTGRES_USER) -d $(POSTGRES_DB) \
		-f $(SEED_DIR)/$(1).sql
endef

.PHONY: seed-vertivo
seed-vertivo: ## Seed 20 Vertivo hortalizas
	$(call run_seed,vertivo)

.PHONY: seed-habitanexus
seed-habitanexus: ## Seed 10 HabitaNexus rentals
	$(call run_seed,habitanexus)

.PHONY: seed-altrupets
seed-altrupets: ## Seed 30 AltruPets pet supplies
	$(call run_seed,altrupets)

.PHONY: seed-all
seed-all: seed-vertivo seed-habitanexus seed-altrupets ## Apply all three seeds

# ── Container builds ─────────────────────────────────────────────────
.PHONY: build-docker
build-docker: ## Build the marketplace-core container image
	$(CONTAINER_ENGINE) build \
		-t $(IMAGE_NAME):$(IMAGE_TAG) \
		-f deployment/docker/Dockerfile \
		.

# ── Node library ─────────────────────────────────────────────────────
.PHONY: install
install: ## npm ci (reproducible install from lockfile)
	npm ci

.PHONY: build
build: ## Build the TypeScript library (tsup → dist/)
	npm run build

.PHONY: test
test: ## Run vitest once
	npm test

.PHONY: test-coverage
test-coverage: ## Run vitest with v8 coverage
	npm run test:coverage

.PHONY: lint
lint: ## Biome check (src + tests)
	npm run lint

.PHONY: lint-fix
lint-fix: ## Biome check --write (auto-fix)
	npm run lint:fix

.PHONY: typecheck
typecheck: ## tsc --noEmit
	npm run typecheck

.PHONY: verify
verify: typecheck lint test build ## Full local CI pipeline

.PHONY: clean
clean: ## Remove build artifacts + coverage
	rm -rf dist coverage .tsbuildinfo

# ── Flutter UI ───────────────────────────────────────────────────────
UI_DIR ?= ui

.PHONY: ui-install
ui-install: ## flutter pub get in ui/
	cd $(UI_DIR) && flutter pub get

.PHONY: ui-proto
ui-proto: ## Regenerate Dart gRPC code from proto/
	mkdir -p $(UI_DIR)/lib/generated
	protoc --dart_out=grpc:$(UI_DIR)/lib/generated -Iproto proto/marketplace_core.proto

.PHONY: ui-analyze
ui-analyze: ## flutter analyze
	cd $(UI_DIR) && flutter analyze

.PHONY: ui-test
ui-test: ## flutter test
	cd $(UI_DIR) && flutter test

.PHONY: ui-build
ui-build: ## flutter build linux
	cd $(UI_DIR) && flutter build linux --release

.PHONY: ui-run
ui-run: ## flutter run -d linux
	cd $(UI_DIR) && flutter run -d linux

.PHONY: ui-clean
ui-clean: ## flutter clean + pub get
	cd $(UI_DIR) && flutter clean && flutter pub get

.PHONY: ui-verify
ui-verify: ui-analyze ui-test ui-build ## Full UI local CI pipeline

# ── Help ─────────────────────────────────────────────────────────────
.PHONY: help
help: ## Print this help
	@echo ""
	@echo "marketplace-core — Developer Makefile"
	@echo ""
	@echo "Usage: make <target>"
	@echo ""
	@awk 'BEGIN {FS = ":.*?## "} \
		/^[a-zA-Z0-9_-]+:.*?## / { printf "  \033[36m%-16s\033[0m %s\n", $$1, $$2 }' \
		$(MAKEFILE_LIST)
	@echo ""
