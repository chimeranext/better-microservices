import { describe, expect, it } from "vitest";
import {
  addMoney,
  compareMoney,
  createMoney,
  subtractMoney,
  zeroMoney,
} from "../../../src/domain/value-objects/money.js";
import { InvariantViolationError } from "../../../src/shared-kernel/errors.js";

describe("money value object", () => {
  it("createMoney accepts valid amounts and currencies", () => {
    const m = createMoney("12.50", "USD");
    expect(m).toEqual({ amount: "12.50", currency: "USD" });
  });

  it("createMoney rejects invalid amounts and bad currencies", () => {
    expect(() => createMoney("12.5", "USD")).not.toThrow();
    expect(() => createMoney("abc", "USD")).toThrow();
    expect(() => createMoney("12.50", "US")).toThrow();
  });

  it("zeroMoney returns 0 with given currency", () => {
    expect(zeroMoney("EUR")).toEqual({ amount: "0", currency: "EUR" });
  });

  it("addMoney sums and preserves currency", () => {
    expect(addMoney(createMoney("1.25", "USD"), createMoney("2.75", "USD"))).toEqual({
      amount: "4.00",
      currency: "USD",
    });
  });

  it("addMoney rejects mismatched currencies", () => {
    expect(() => addMoney(createMoney("1", "USD"), createMoney("1", "EUR"))).toThrow(
      InvariantViolationError,
    );
  });

  it("subtractMoney works and refuses negative results", () => {
    expect(subtractMoney(createMoney("5.00", "USD"), createMoney("2.00", "USD"))).toEqual({
      amount: "3.00",
      currency: "USD",
    });
    expect(() => subtractMoney(createMoney("1.00", "USD"), createMoney("2.00", "USD"))).toThrow(
      InvariantViolationError,
    );
    expect(() => subtractMoney(createMoney("1.00", "USD"), createMoney("1.00", "EUR"))).toThrow(
      InvariantViolationError,
    );
  });

  it("compareMoney returns -1/0/1", () => {
    expect(compareMoney(createMoney("1", "USD"), createMoney("2", "USD"))).toBe(-1);
    expect(compareMoney(createMoney("2", "USD"), createMoney("2", "USD"))).toBe(0);
    expect(compareMoney(createMoney("3", "USD"), createMoney("2", "USD"))).toBe(1);
    expect(() => compareMoney(createMoney("1", "USD"), createMoney("1", "EUR"))).toThrow(
      InvariantViolationError,
    );
  });
});
