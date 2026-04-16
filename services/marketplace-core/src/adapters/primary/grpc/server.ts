import { resolve } from "node:path";
import { Server, ServerCredentials, loadPackageDefinition } from "@grpc/grpc-js";
import { loadSync } from "@grpc/proto-loader";
import type { ProductRepository, SearchEngine } from "../../../domain/ports/index.js";
import { createStorefrontServiceImpl } from "./storefront-service.js";

export interface GrpcServerDeps {
  repository: ProductRepository;
  search: SearchEngine;
  port?: number;
  host?: string;
  protoPath?: string;
}

export interface StartedGrpcServer {
  readonly server: Server;
  readonly address: string;
  shutdown(): Promise<void>;
}

/**
 * Starts a gRPC server wired with the `MarketplaceStorefront` service.
 * Returns an object whose `shutdown()` performs a graceful drain — callers
 * (src/main.ts) can bind it to SIGTERM/SIGINT handlers.
 */
export async function startGrpcServer(deps: GrpcServerDeps): Promise<StartedGrpcServer> {
  const host = deps.host ?? "0.0.0.0";
  const port = deps.port ?? 50051;
  const protoPath = deps.protoPath ?? resolve(process.cwd(), "proto", "marketplace_core.proto");

  const packageDefinition = loadSync(protoPath, {
    keepCase: true,
    longs: String,
    enums: Number,
    defaults: true,
    oneofs: true,
  });
  const loaded = loadPackageDefinition(packageDefinition) as unknown as {
    marketplace_core: {
      MarketplaceStorefront: { service: unknown };
    };
  };

  const server = new Server();
  server.addService(
    // biome-ignore lint/suspicious/noExplicitAny: proto-loader returns an untyped service descriptor
    loaded.marketplace_core.MarketplaceStorefront.service as any,
    // biome-ignore lint/suspicious/noExplicitAny: same reason — handlers are keyed by RPC name
    createStorefrontServiceImpl({ repository: deps.repository, search: deps.search }) as any,
  );

  const address = `${host}:${port}`;
  await new Promise<void>((accept, reject) => {
    server.bindAsync(address, ServerCredentials.createInsecure(), (err, boundPort) => {
      if (err) return reject(err);
      if (boundPort === 0) return reject(new Error(`Failed to bind ${address}`));
      accept();
    });
  });

  return {
    server,
    address,
    async shutdown(): Promise<void> {
      await new Promise<void>((accept) => {
        server.tryShutdown(() => accept());
      });
    },
  };
}
