import { services } from "@/lib/services";
import { Card, Badge } from "@/components/ui";
export function ServicesShowcase() {
  return (
    <section className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
      {services.map((s) => (
        <Card key={s.slug} className="p-5">
          <div className="flex items-center justify-between">
            <h3 className="font-mono text-sm text-brand-tertiary">{s.slug}</h3>
            {s.disabled && <Badge variant="secondary">{s.disabled}</Badge>}
          </div>
          <p className="mt-2 text-sm text-muted-foreground">{s.blurb}</p>
          <p className="mt-3 text-xs text-muted-foreground">{s.stack}</p>
        </Card>
      ))}
    </section>
  );
}
