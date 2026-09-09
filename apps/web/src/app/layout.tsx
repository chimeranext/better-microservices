import "./globals.css";
import type { Metadata } from "next";
import { Sora, Inter, JetBrains_Mono } from "next/font/google";

const sora = Sora({ subsets: ["latin"], variable: "--font-sora", weight: ["600", "800"] });
const inter = Inter({ subsets: ["latin"], variable: "--font-inter" });
const mono = JetBrains_Mono({ subsets: ["latin"], variable: "--font-mono" });

const title = "better-microservices — pick your stack";
const description = "Pick the services your startup needs and copy the scaffold command.";

const ogImage = {
  url: "/og.png",
  width: 1200,
  height: 630,
  alt: "better-microservices — pick your stack",
} as const;

export const metadata: Metadata = {
  metadataBase: new URL("https://microservices.chimeranext.dev"),
  title,
  description,
  applicationName: "better-microservices",
  keywords: ["microservices", "grpc", "sidecars", "scaffold", "startup", "ChimeraNext"],
  authors: [{ name: "Luis Andres Pena Castillo" }],
  openGraph: {
    title,
    description,
    url: "https://microservices.chimeranext.dev",
    siteName: "better-microservices",
    type: "website",
    images: [ogImage],
  },
  twitter: {
    card: "summary_large_image",
    title,
    description,
    images: [ogImage.url],
  },
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en" className={`dark ${sora.variable} ${inter.variable} ${mono.variable}`}>
      <body>{children}</body>
    </html>
  );
}
