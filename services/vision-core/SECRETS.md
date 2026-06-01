# vision-core — Secrets & NVIDIA API keys

> **Rule:** secret VALUES never live in git, in `.env.example`, in chat logs, or in
> code. Only **names** and **where they're stored** are documented here.

## The two NVIDIA API keys (build.nvidia.com, account `vertivolatam@gmail.com`)

| NVIDIA key name | Env (GitHub Environment) | Consumed by | Env var |
|---|---|---|---|
| `internal_staging` | `staging` | vision-core (dev/staging) | `VISION_NVIDIA_API_KEY` |
| `public_prod` | `production` | vision-core (production) | `VISION_NVIDIA_API_KEY` |

- These are **server-side bearer tokens** for hosted NIM endpoints
  (`https://integrate.api.nvidia.com/v1`). **Never** expose in any client/web bundle —
  `public_prod` is "public environment", NOT "publicly shareable".
- Format is `nvapi-...`. Rotate via build.nvidia.com → Settings → API Keys.

## Create the keys (build.nvidia.com → Settings → API Keys)
1. Sign in as `vertivolatam@gmail.com`, open **Settings → API Keys**.
2. **Generate API Key** → name it `internal_staging` → copy the value (shown once).
3. **Generate API Key** → name it `public_prod` → copy the value (shown once).

## Store the values (pick one; never paste into chat or `.env` in git)
- **GitHub Environment secrets (recommended for CI/CD):**
  `gh secret set VISION_NVIDIA_API_KEY --env staging` (paste when prompted), and
  `gh secret set VISION_NVIDIA_API_KEY --env production`.
- **Local dev:** put it in `services/vision-core/.env` (gitignored), or stage it via
  the `/make-no-mistakes:secret-input` flow and consume with `/secret-use`.
- **Kubernetes:** a `Secret` mounted as `VISION_NVIDIA_API_KEY` (per namespace/env).

## Other secrets
- `VISION_MINIO_ACCESS_KEY` / `VISION_MINIO_SECRET_KEY` — object storage; same rules.
