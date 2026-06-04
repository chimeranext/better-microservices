"use client";
import { useEffect, useState } from "react";
import { Tabs, TabsList, TabsTrigger, TabsContent } from "@/components/ui";
import { categories } from "@/lib/categories";
import { decodeState, encodeState } from "@/lib/url-state";
import { randomModel } from "@/lib/randomize";
import { defaultModel, type WizardModel } from "@/lib/wizard";
import { ReadmeDrawer } from "@/components/ReadmeDrawer";
import { BuilderSidebar } from "./BuilderSidebar";
import { CategorySection } from "./CategorySection";

function projectTree(model: WizardModel): string {
  // Project-tree preview rendered in the PREVIEW tab.
  return [
    `${model.name}/`,
    "  services/",
    ...model.services.map((s) => `    ${s}/  (submodule)`),
    model.gateway ? "  apps/gateway/" : "",
    "  packages/common/",
    model.orchestration !== "k8s-helm" ? "  docker-compose.yml" : "",
    model.orchestration !== "docker-compose" ? "  helm/" : "",
    "  turbo.json  pnpm-workspace.yaml",
  ]
    .filter(Boolean)
    .join("\n");
}

export function Builder() {
  const [model, setModel] = useState<WizardModel>(defaultModel);
  const [readme, setReadme] = useState<string | null>(null);

  useEffect(() => {
    setModel(decodeState(new URLSearchParams(window.location.search)));
  }, []);
  useEffect(() => {
    const qs = encodeState(model);
    const url = qs ? `?${qs}` : window.location.pathname;
    window.history.replaceState(null, "", url);
  }, [model]);

  const patch = (p: Partial<WizardModel>) => setModel((m) => ({ ...m, ...p }));

  return (
    <div className="grid gap-8 lg:grid-cols-[320px_1fr]">
      <BuilderSidebar
        model={model}
        patch={patch}
        onRandomize={() => setModel(randomModel())}
        onReset={() => setModel(defaultModel)}
        onShare={() => navigator.clipboard.writeText(window.location.href)}
      />

      <main>
        <Tabs defaultValue="configure">
          <TabsList>
            <TabsTrigger value="configure">CONFIGURE</TabsTrigger>
            <TabsTrigger value="preview">PREVIEW</TabsTrigger>
          </TabsList>

          <TabsContent value="configure" className="space-y-8">
            {categories.map((c) => (
              <CategorySection
                key={c.id}
                category={c}
                model={model}
                patch={patch}
                onViewReadme={setReadme}
              />
            ))}
          </TabsContent>

          <TabsContent value="preview" className="space-y-4">
            <pre className="overflow-x-auto rounded-lg border border-border bg-muted p-4 font-mono text-xs text-muted-foreground">
              {projectTree(model)}
            </pre>
            <p className="text-sm text-muted-foreground">
              Docs for your picks:{" "}
              {model.services.map((s) => (
                <a
                  key={s}
                  className="mr-3 text-brand-secondary hover:underline"
                  href={`https://chimeranext.github.io/better-microservices/${s}/`}
                >
                  {s} ↗
                </a>
              ))}
            </p>
          </TabsContent>
        </Tabs>
      </main>

      <ReadmeDrawer slug={readme} onClose={() => setReadme(null)} />
    </div>
  );
}
