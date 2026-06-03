import { Hero } from "@/components/Hero";
import { ServicesShowcase } from "@/components/ServicesShowcase";
import { Footer } from "@/components/Footer";
export default function Home() {
  return (
    <>
      <main className="mx-auto max-w-6xl px-6">
        <Hero />
        <ServicesShowcase />
      </main>
      <Footer />
    </>
  );
}
