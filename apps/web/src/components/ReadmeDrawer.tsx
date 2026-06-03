"use client";
import { useEffect, useState } from "react";
import ReactMarkdown from "react-markdown";
import { Sheet, SheetContent, SheetHeader, SheetTitle } from "@/components/ui";
import { readmeRawUrl, docsUrl } from "@/lib/readme";

export function ReadmeDrawer({ slug, onClose }: { slug: string | null; onClose: () => void }) {
  const [md, setMd] = useState<string>("");
  const [err, setErr] = useState(false);
  useEffect(() => {
    if (!slug) return;
    setMd(""); setErr(false);
    fetch(readmeRawUrl(slug)).then((r) => (r.ok ? r.text() : Promise.reject()))
      .then(setMd).catch(() => setErr(true));
  }, [slug]);
  return (
    <Sheet open={!!slug} onOpenChange={(o) => !o && onClose()}>
      <SheetContent className="w-full overflow-y-auto sm:max-w-xl">
        <SheetHeader><SheetTitle className="font-mono text-brand-tertiary">{slug}</SheetTitle></SheetHeader>
        {err ? (
          <p className="mt-4 text-sm text-muted-foreground">README not available yet (repo is private until launch). <a className="text-brand-secondary" href={slug ? docsUrl(slug) : "#"}>Full docs ↗</a></p>
        ) : (
          <article className="prose prose-invert prose-sm mt-4 max-w-none">
            <ReactMarkdown>{md || "Loading…"}</ReactMarkdown>
            {slug && <a className="text-brand-secondary" href={docsUrl(slug)}>Full docs ↗</a>}
          </article>
        )}
      </SheetContent>
    </Sheet>
  );
}
