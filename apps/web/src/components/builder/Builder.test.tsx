import { describe, it, expect } from "vitest";
import { render, screen, fireEvent } from "@testing-library/react";
import { Builder } from "./Builder";

describe("Builder", () => {
  it("reflects the project name and option picks in the live command", () => {
    render(<Builder />);

    // Project name flows into the compiled CLI command.
    fireEvent.change(screen.getByTestId("project-name"), {
      target: { value: "acme" },
    });
    expect(screen.getByTestId("command").textContent).toContain(
      "create-better-microservices acme",
    );

    // Gateway is off by default — selecting the card adds the --gateway flag.
    expect(screen.getByTestId("command").textContent).not.toContain("--gateway");
    fireEvent.click(screen.getByText("API Gateway"));
    expect(screen.getByTestId("command").textContent).toContain("--gateway");
  });
});
