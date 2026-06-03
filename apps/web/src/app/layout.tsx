import "./globals.css";
import { Sora, Inter, JetBrains_Mono } from "next/font/google";
const sora = Sora({ subsets: ["latin"], variable: "--font-sora", weight: ["600","800"] });
const inter = Inter({ subsets: ["latin"], variable: "--font-inter" });
const mono = JetBrains_Mono({ subsets: ["latin"], variable: "--font-mono" });
export const metadata = { title: "better-microservices — pick your stack", description: "Pick the services your startup needs and copy the scaffold command." };
export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en" className={`dark ${sora.variable} ${inter.variable} ${mono.variable}`}>
      <body>{children}</body>
    </html>
  );
}
