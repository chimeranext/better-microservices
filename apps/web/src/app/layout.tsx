import "./globals.css";
export const metadata = { title: "better-microservices", description: "Pick the services your startup needs." };
export default function RootLayout({ children }: { children: React.ReactNode }) {
  return <html lang="en" className="dark"><body>{children}</body></html>;
}
