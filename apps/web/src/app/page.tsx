import { Builder } from "@/components/builder/Builder";
import { Footer } from "@/components/Footer";

export default function Home() {
  return (
    <>
      <main className="mx-auto max-w-6xl px-6 py-8">
        <section className="rounded-2xl border border-border bg-card p-8">
          <h1 className="bg-brand-gradient bg-clip-text text-4xl font-extrabold text-transparent sm:text-5xl">
            Pick the microservices your startup needs.
          </h1>
          <p className="mt-4 max-w-2xl text-muted-foreground">
            Production-grade <span className="font-mono text-brand-tertiary">gRPC</span> sidecars — each <span className="font-mono">-core</span> carries
            no domain logic, so your business stays in your own monorepo and one venture's incidents or schema drift
            never contaminate the rest. Pick what you need; copy the scaffold command.
          </p>
        </section>
        <div className="mt-8">
          <Builder />
        </div>
      </main>
      <Footer />
    </>
  );
}
