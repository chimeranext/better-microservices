# @compliance-core/proto

**Generated TypeScript types and gRPC service definitions for the
`compliance.v1` API.**

This package is the single typed surface over the `.proto` contract that
`compliance-core` exposes. Consumers (`@compliance-core/server`, backend SDKs,
other services calling compliance) import message types and service definitions
from here instead of reaching into generated-code layout.

- **Package:** `@compliance-core/proto` · **private** · ESM (`"type": "module"`)
- **Deps:** [`@bufbuild/protobuf`](https://github.com/bufbuild/protobuf-es) 2.x,
  [`@connectrpc/connect`](https://connectrpc.com) 2.x.

## What it contains

A single barrel (`src/index.ts`) that re-exports **only** from `src/generated/**`.
The generated output is produced by `pnpm proto:gen` (buf + `protoc-gen-es`) from
the service's `.proto` sources under
[`proto/compliance/v1/`](../../proto/compliance/v1):

| Proto file | gRPC service | Covers |
|---|---|---|
| `common.proto` | — | Shared messages/enums: `UUID`, `PIIString`, `Hex32`, `Jurisdiction`, `SubjectRef`, `ProviderCode`. |
| `admin.proto` | `ComplianceAdmin` | Verification lifecycle: start / status / decision. |
| `screening.proto` | `ComplianceScreening` | Sanctions/PEP screening, matches, risk bands. |
| `aml.proto` | `ComplianceAML` | Transaction risk, suspicious-activity flags, SAR export. |
| `audit.proto` | `ComplianceAudit` | Append-only audit events + integrity verification + export. |
| `whistle.proto` | `ComplianceWhistle` | Whistleblower report submission and triage. |
| `health.proto` | `ComplianceHealth` | Provider health, list freshness, circuit-breaker status. |

> **Generated code is not committed.** On a fresh checkout `src/generated/` is
> absent and the barrel exports `{}` so that `pnpm build` and `typecheck` succeed
> offline without buf plugins being network-reachable. CI's proto-lint job fails
> if committed output ever drifts from the `.proto` sources.

## How it's used in the service

```ts
// After `pnpm proto:gen`, the server adapter wires concrete handlers to the
// generated service definitions:
import { ComplianceScreening } from "@compliance-core/proto";
// register ComplianceScreening with the Connect/gRPC router…
```

Because everything funnels through this one barrel, swapping the transport
(e.g. Connect-ES → grpc-js-native) changes only this package, not its consumers.

## Develop

```bash
pnpm --filter @compliance-core/proto build       # tsc → dist/
pnpm --filter @compliance-core/proto typecheck
pnpm --filter @compliance-core/proto clean        # rm -rf dist src/generated
# Regenerate from .proto sources (buf + protoc-gen-es):
pnpm proto:gen
```

See the service design spec:
[`docs/superpowers/specs/2026-04-16-compliance-core-design.md`](../../docs/superpowers/specs/2026-04-16-compliance-core-design.md).
