import { describe, it, expect } from "vitest";
import { render, screen, fireEvent } from "@testing-library/react";
import { Wizard } from "./Wizard";

describe("Wizard", () => {
  it("renders the command on the review step", () => {
    render(<Wizard />);
    fireEvent.change(screen.getByTestId("project-name"), { target: { value: "acme" } });
    fireEvent.click(screen.getByText("Next")); // → Infra
    fireEvent.click(screen.getByText("Next")); // → Addons
    fireEvent.click(screen.getByText("Next")); // → Review
    const command = screen.getByTestId("command").textContent;
    expect(command).toContain("npx create-better-microservices");
    expect(command).toContain("create-better-microservices acme");
  });
});
