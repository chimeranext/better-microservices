# @better-microservices/web

The **better-microservices** landing + configurator: a Next.js (App Router, static-exported)
"pick your microservices" site whose core is a 4-step wizard that compiles a copyable
`npx create-better-microservices …` command, with a README-first drawer per service.

## Develop

From the repo root (pnpm workspace):

```bash
corepack pnpm install
corepack pnpm --filter @better-microservices/web dev     # http://localhost:3000
corepack pnpm --filter @better-microservices/web build   # static export → apps/web/out/
corepack pnpm --filter @better-microservices/web test    # vitest run
```

Or from `apps/web/`:

```bash
pnpm dev        # next dev
pnpm build      # next build (output: "export")
pnpm test       # vitest run
npx vitest run  # run the suite directly
```

## Architecture

The wizard's **pure logic** lives in unit-tested `src/lib/*` modules; the React/Shadcn
components in `src/components/*` consume them. Wizard state is mirrored to the URL for
shareable configs.

Modules to edit when changing behavior:

| File | Responsibility |
| --- | --- |
| `src/lib/services.ts` | The 6 configurable services (`filing-core` disabled "2027"). |
| `src/lib/wizard.ts` | `WizardModel` type + `defaultModel`. |
| `src/lib/command.ts` | `compileCommand(model)` → the `npx create-better-microservices …` string. |
| `src/lib/url-state.ts` | `encodeState` / `decodeState` — model ⇄ query string. |
| `src/lib/deps.ts` | `dependencyHints(services)` — marketplace→payments warn, agentic→payments suggest. |
| `src/lib/readme.ts` | `readmeRawUrl(slug)` / `docsUrl(slug)` for the README drawer. |

Each `src/lib/*` module with logic has a colocated `*.test.ts`; the wizard has a
component smoke test (`src/components/Wizard.test.tsx`). Run all with `npx vitest run`.

Shadcn primitives are imported from the **barrel** `@/components/ui` (deep imports are
blocked by a PreToolUse hook).

## Deploy — TODOs

This app is `output: "export"` (a fully static site in `apps/web/out/`), so it can ship
to either target:

- **GitHub Pages** — same host as the docs site (`chimeranext.github.io/better-microservices/`).
  Would need a workflow that uploads `apps/web/out/` as a Pages artifact. Note the existing
  `docs.yml` already owns the `pages` concurrency group and serves MkDocs; co-hosting the
  configurator there needs a path/subpath decision (and `basePath` in `next.config.mjs`).
- **Vercel** — point a Vercel project at `apps/web` (framework auto-detected). Zero-config
  for the static export; gets preview URLs per PR.

Pick one before launch. (No deploy target is wired yet — only build + test run in CI; see
`.github/workflows/web.yml`.)

### README drawer needs the repo public

The per-service README drawer fetches the raw README from
`raw.githubusercontent.com/chimeranext/better-microservices/main/services/<slug>/README.md`.
While the repo is **private**, that fetch 404s and the drawer falls back to the
"README not available yet (repo private)" message + a link to the docs site
(`docsUrl(slug)`). Once the repo is public the live README renders automatically — no
code change required.
