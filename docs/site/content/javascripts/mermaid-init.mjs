// Mermaid diagram initialization with better-microservices brand colors
document.addEventListener("DOMContentLoaded", () => {
  if (typeof mermaid !== "undefined") {
    mermaid.initialize({
      startOnLoad: true,
      theme: "base",
      themeVariables: {
        primaryColor: "#3949ab",
        primaryTextColor: "#fff",
        primaryBorderColor: "#283593",
        lineColor: "#5b6178",
        secondaryColor: "#f59e0b",
        tertiaryColor: "#06b6d4",
        fontFamily: "Inter, sans-serif",
      },
    });
  }
});
