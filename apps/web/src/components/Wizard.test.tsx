import { describe, it, expect } from "vitest";
import { render, screen, fireEvent } from "@testing-library/react";
import { Wizard } from "./Wizard";

describe("Wizard", () => {
  it("renders the command on the review step", () => {
    render(<Wizard />);
    fireEvent.click(screen.getByText("Next")); // → Infra
    fireEvent.click(screen.getByText("Next")); // → Addons
    fireEvent.click(screen.getByText("Next")); // → Review
    expect(screen.getByTestId("command").textContent).toContain("npx create-better-microservices");
  });
});
