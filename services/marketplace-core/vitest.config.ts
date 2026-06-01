import { defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    globals: false,
    environment: "node",
    include: ["tests/**/*.test.ts", "src/**/*.test.ts"],
    coverage: {
      provider: "v8",
      reporter: ["text", "lcov", "html"],
      include: ["src/**/*.ts"],
      exclude: [
        "src/generated/**",
        "src/**/*.test.ts",
        "src/index.ts",
        // Pure type declarations — TypeScript erases them, nothing to cover.
        "src/domain/ports/**",
        "src/shared-kernel/events.ts",
        // I/O orchestration — covered by integration tests in a follow-up PR.
        "src/main.ts",
        "src/adapters/primary/grpc/server.ts",
        "src/adapters/secondary/meilisearch-engine.ts",
        "src/infrastructure/postgres/pool.ts",
        "src/infrastructure/postgres/migrate.ts",
      ],
      thresholds: {
        statements: 100,
        branches: 95,
        functions: 100,
        lines: 100,
      },
      reportsDirectory: "coverage",
    },
  },
});
