import Link from "next/link";
import { Builder } from "@/components/builder/Builder";

export const metadata = {
  title: "better-microservices — builder",
  description: "Configure your microservices stack and copy the scaffold command.",
};

export default function NewPage() {
  return (
    <div className="min-h-screen">
      <header className="border-b border-border">
        <div className="mx-auto flex max-w-6xl items-center px-6 py-4">
          <Link href="/" className="font-mono text-sm font-semibold text-foreground">
            better-microservices
          </Link>
        </div>
      </header>
      <main className="mx-auto max-w-6xl px-6 py-8">
        <Builder />
      </main>
    </div>
  );
}
