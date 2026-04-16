import { Pool, type PoolConfig } from "pg";

/**
 * Build a pg connection pool from an environment-like object. Centralizing
 * this lets tests inject overrides without touching process.env globally.
 */
export function createPool(env: NodeJS.ProcessEnv = process.env): Pool {
  const config: PoolConfig = {
    host: env.POSTGRES_HOST ?? "localhost",
    port: Number.parseInt(env.POSTGRES_PORT ?? "5432", 10),
    user: env.POSTGRES_USER ?? "marketplace",
    password: env.POSTGRES_PASSWORD ?? "marketplace_dev",
    database: env.POSTGRES_DB ?? "marketplace_core",
    max: Number.parseInt(env.POSTGRES_POOL_MAX ?? "10", 10),
    idleTimeoutMillis: 30_000,
    connectionTimeoutMillis: 5_000,
  };
  return new Pool(config);
}
