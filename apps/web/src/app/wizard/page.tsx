import Link from "next/link";
import { Wizard } from "@/components/Wizard";

export const metadata = {
  title: "better-microservices — wizard (legacy)",
  description: "Legacy 4-step wizard, preserved for reference.",
};

export default function WizardPage() {
  return (
    <main className="mx-auto max-w-6xl px-6 py-8">
      <div className="flex flex-col gap-1">
        <Link href="/" className="font-mono text-sm font-semibold text-foreground">
          better-microservices
        </Link>
        <p className="text-sm text-muted-foreground">
          Legacy 4-step wizard — preserved for reference. The main builder lives at /.
        </p>
      </div>
      <Wizard />
    </main>
  );
}
