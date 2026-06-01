import { z } from "zod";
import { InvariantViolationError } from "../../shared-kernel/errors.js";

export const MoneySchema = z.object({
  amount: z.string().regex(/^\d+(\.\d{1,2})?$/, "Amount must be a decimal string"),
  currency: z.string().length(3, "Currency must be ISO 4217 (3 chars)"),
});

export type Money = z.infer<typeof MoneySchema>;

export function createMoney(amount: string, currency: string): Money {
  return MoneySchema.parse({ amount, currency });
}

export function zeroMoney(currency: string): Money {
  return createMoney("0", currency);
}

function assertSameCurrency(a: Money, b: Money, op: string): void {
  if (a.currency !== b.currency) {
    throw new InvariantViolationError(
      `Cannot ${op} different currencies: ${a.currency} vs ${b.currency}`,
      { op, lhs: a.currency, rhs: b.currency },
    );
  }
}

export function addMoney(a: Money, b: Money): Money {
  assertSameCurrency(a, b, "add");
  const sum = (Number.parseFloat(a.amount) + Number.parseFloat(b.amount)).toFixed(2);
  return { amount: sum, currency: a.currency };
}

export function subtractMoney(a: Money, b: Money): Money {
  assertSameCurrency(a, b, "subtract");
  const result = Number.parseFloat(a.amount) - Number.parseFloat(b.amount);
  if (result < 0) {
    throw new InvariantViolationError("Money subtraction would yield negative amount", {
      a: a.amount,
      b: b.amount,
      currency: a.currency,
    });
  }
  return { amount: result.toFixed(2), currency: a.currency };
}

export function compareMoney(a: Money, b: Money): -1 | 0 | 1 {
  assertSameCurrency(a, b, "compare");
  const diff = Number.parseFloat(a.amount) - Number.parseFloat(b.amount);
  if (diff < 0) return -1;
  if (diff > 0) return 1;
  return 0;
}
