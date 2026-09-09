# Agent guidance — better-microservices

Repo-level instructions for Cursor, Claude Code, and other agents working in this
repository. Prefer this file over inventing workspace layouts under the parent
`chimeranext/` folder (that folder is **not** a git root).

Per-service notes may still live under `services/*/AGENTS.md`; this root file
owns **workspace / worktree** conventions for the monorepo as a whole.

## Git worktrees (mandatory when parallel)

When more than one branch/PR is active, or the primary checkout is dirty, use an
isolated worktree — never ad-hoc sibling folders under `../chimeranext/`.

**Canonical paths (inside this repo):**

| Harness | Path |
| --- | --- |
| Cursor / generic agents | `.agents/worktrees/<slug>` |
| Claude Code / `/make-no-mistakes:implement` | `.claude/worktrees/<issue-id>` |
| Manual fallback | `.worktrees/<slug>` |

**Create:**

```bash
mkdir -p .agents/worktrees
git worktree add .agents/worktrees/<slug> -b <branch> <base-ref>
cd .agents/worktrees/<slug>
```

**Rules:**

- One worktree per issue/agent; do not `git switch` the primary tree to steal a branch.
- Slug = short kebab case (`fix-mkdocs-site-url`, `APP-1234-widget`).
- Every mutation: `cd` to the worktree path first.
- Remove worktrees after merge (HITL) — `git worktree remove .agents/worktrees/<slug>`.

**Forbidden:** `../better-microservices-og`, or any flat sibling directory under
`chimeranext/` — those are accidental, not convention.
