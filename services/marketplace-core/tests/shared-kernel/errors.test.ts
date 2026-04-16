import { describe, expect, it } from "vitest";
import {
  ConflictError,
  DomainError,
  InvariantViolationError,
  NotFoundError,
  ValidationError,
} from "../../src/shared-kernel/errors.js";

describe("DomainError hierarchy", () => {
  it("InvariantViolationError carries code + context", () => {
    const err = new InvariantViolationError("bad", { where: "x" });
    expect(err).toBeInstanceOf(DomainError);
    expect(err).toBeInstanceOf(Error);
    expect(err.code).toBe("DOMAIN.INVARIANT_VIOLATION");
    expect(err.name).toBe("InvariantViolationError");
    expect(err.message).toBe("bad");
    expect(err.context).toEqual({ where: "x" });
  });

  it("ValidationError exposes fieldErrors", () => {
    const err = new ValidationError("invalid", [{ field: "email", message: "format" }]);
    expect(err.code).toBe("DOMAIN.VALIDATION");
    expect(err.fieldErrors).toEqual([{ field: "email", message: "format" }]);
  });

  it("NotFoundError + ConflictError each have stable codes", () => {
    expect(new NotFoundError("x").code).toBe("DOMAIN.NOT_FOUND");
    expect(new ConflictError("x").code).toBe("DOMAIN.CONFLICT");
  });

  it("errors are catchable as DomainError", () => {
    const sources: DomainError[] = [
      new InvariantViolationError("a"),
      new ValidationError("b", []),
      new NotFoundError("c"),
      new ConflictError("d"),
    ];
    for (const err of sources) {
      try {
        throw err;
      } catch (caught) {
        expect(caught).toBeInstanceOf(DomainError);
      }
    }
  });
});
