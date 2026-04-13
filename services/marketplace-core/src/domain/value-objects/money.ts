import { z } from "zod";

export const MoneySchema = z.object({
  amount: z.string().regex(/^\d+(\.\d{1,2})?$/, "Amount must be a decimal string"),
  currency: z.string().length(3, "Currency must be ISO 4217 (3 chars)"),
});

export type Money = z.infer<typeof MoneySchema>;

export function createMoney(amount: string, currency: string): Money {
  return MoneySchema.parse({ amount, currency });
}

export function addMoney(a: Money, b: Money): Money {
  if (a.currency !== b.currency) {
    throw new Error(`Cannot add different currencies: ${a.currency} vs ${b.currency}`);
  }
  const sum = (parseFloat(a.amount) + parseFloat(b.amount)).toFixed(2);
  return { amount: sum, currency: a.currency };
}
