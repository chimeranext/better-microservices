import { Builder } from "@/components/builder/Builder";
import { Footer } from "@/components/Footer";

export default function Home() {
  return (
    <>
      <main className="mx-auto max-w-6xl px-6 py-8">
        <section className="rounded-2xl border border-border bg-card p-8">
          <h1 className="bg-brand-gradient bg-clip-text text-4xl font-extrabold text-transparent sm:text-5xl">
            Pick the services your startup needs.
          </h1>
          <p className="mt-4 max-w-2xl text-muted-foreground">
            A curated set of production-grade microservices. Choose what you need — copy the scaffold command.
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
