import { Hero } from "@/components/Hero";
import { ServicesShowcase } from "@/components/ServicesShowcase";
import { Footer } from "@/components/Footer";

export default function Home() {
  return (
    <>
      <main className="mx-auto max-w-6xl px-6">
        <Hero />
        <div className="flex justify-center pb-12">
          <a
            href="/new"
            className="inline-flex items-center gap-2 rounded-lg bg-brand-gradient px-6 py-3 font-semibold text-white shadow transition-opacity hover:opacity-90"
          >
            Build your stack →
          </a>
        </div>
        <ServicesShowcase />
      </main>
      <Footer />
    </>
  );
}
