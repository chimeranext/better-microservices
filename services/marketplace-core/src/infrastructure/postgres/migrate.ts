import { readFile, readdir } from "node:fs/promises";
import { join } from "node:path";
import type { Pool } from "pg";

/**
 * Very small migration runner: reads every *.sql file from `dir` in filename
 * order and executes its contents inside a single transaction. Good enough
 * for a spike — production will want a proper migration tracking table.
 */
export async function runMigrations(pool: Pool, dir: string): Promise<string[]> {
  const files = (await readdir(dir)).filter((f) => f.endsWith(".sql")).sort();
  const applied: string[] = [];
  const client = await pool.connect();
  try {
    await client.query("BEGIN");
    for (const file of files) {
      const sql = await readFile(join(dir, file), "utf-8");
      await client.query(sql);
      applied.push(file);
    }
    await client.query("COMMIT");
  } catch (err) {
    await client.query("ROLLBACK");
    throw err;
  } finally {
    client.release();
  }
  return applied;
}
