import { resolve } from "node:path";
import { startGrpcServer } from "./adapters/primary/grpc/server.js";
import { InMemorySchemaRegistry } from "./adapters/secondary/in-memory-schema-registry.js";
import { MeilisearchEngine } from "./adapters/secondary/meilisearch-engine.js";
import { PostgresProductRepository } from "./adapters/secondary/postgres-product-repository.js";
import { runMigrations } from "./infrastructure/postgres/migrate.js";
import { createPool } from "./infrastructure/postgres/pool.js";

/**
 * Standalone server entry point. Executed by the Dockerfile CMD and (in
 * development) via `node dist/main.js` or `tsx src/main.ts`.
 *
 * Wiring order is deliberate:
 *   1. Run DB migrations up — fail fast if the schema is wrong.
 *   2. Ensure the Meilisearch index exists + has filterable attrs.
 *   3. Pre-warm the schema registry so it's in memory before the first RPC.
 *   4. Bind + start the gRPC server.
 *   5. Install SIGTERM/SIGINT handlers for graceful drain.
 */
async function main(): Promise<void> {
  const env = process.env;
  const pool = createPool(env);

  const migrationsDir = env.MIGRATIONS_DIR ?? resolve(process.cwd(), "db", "migrations");
  const applied = await runMigrations(pool, migrationsDir);
  console.log(`[marketplace-core] migrations applied: ${applied.join(", ") || "(none)"}`);

  const search = MeilisearchEngine.fromEnv(env);
  await search.ensureIndex();
  console.log("[marketplace-core] meilisearch index ready");

  const schemasDir = env.SCHEMAS_DIR ?? resolve(process.cwd(), "schemas");
  // Registry boot is best-effort: #6 (PR-4) ships the schemas. Until then we
  // want the server to come up with an empty registry rather than crash loop.
  let registry: InMemorySchemaRegistry;
  try {
    registry = await InMemorySchemaRegistry.fromDirectory(schemasDir);
  } catch (err) {
    console.warn(
      `[marketplace-core] schema registry dir not found at ${schemasDir} — starting empty`,
      err instanceof Error ? err.message : err,
    );
    registry = InMemorySchemaRegistry.fromSeed([]);
  }
  void registry;

  const repository = new PostgresProductRepository(pool);
  const grpc = await startGrpcServer({
    repository,
    search,
    host: env.GRPC_HOST ?? "0.0.0.0",
    port: Number.parseInt(env.GRPC_PORT ?? "50051", 10),
  });
  console.log(`[marketplace-core] gRPC server listening on ${grpc.address}`);

  const shutdown = async (signal: string): Promise<void> => {
    console.log(`[marketplace-core] received ${signal}, shutting down...`);
    await grpc.shutdown();
    await pool.end();
    console.log("[marketplace-core] shutdown complete");
    process.exit(0);
  };
  process.on("SIGTERM", () => {
    void shutdown("SIGTERM");
  });
  process.on("SIGINT", () => {
    void shutdown("SIGINT");
  });
}

// Only run main() when executed directly, not when imported for tests.
if (import.meta.url === `file://${process.argv[1]}`) {
  main().catch((err) => {
    console.error("[marketplace-core] fatal:", err);
    process.exit(1);
  });
}

export { main };
