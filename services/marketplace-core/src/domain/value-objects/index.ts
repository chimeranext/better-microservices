export { MoneySchema, createMoney, addMoney } from "./money.js";
export type { Money } from "./money.js";
export { GeoLocationSchema } from "./geo-location.js";
export type { GeoLocation } from "./geo-location.js";

export { z } from "zod";

// --- SEO ---

import { z } from "zod";

export const SEOSchema = z.object({
  title: z.string(),
  description: z.string(),
  ogImage: z.string().optional(),
  canonicalUrl: z.string().optional(),
});
export type SEO = z.infer<typeof SEOSchema>;

// --- Contact ---

export const ContactSchema = z.object({
  phone: z.string(),
  email: z.string().email().optional(),
  whatsapp: z.string().optional(),
});
export type Contact = z.infer<typeof ContactSchema>;

// --- Option ---

export const OptionSchema = z.object({
  name: z.string(),
  value: z.string(),
});
export type Option = z.infer<typeof OptionSchema>;

// --- Availability ---

export enum AvailabilityType {
  ALWAYS = "ALWAYS",
  CALENDAR = "CALENDAR",
  DATE_RANGE = "DATE_RANGE",
  EXPIRABLE = "EXPIRABLE",
  SEASONAL = "SEASONAL",
}

export const TimeSlotSchema = z.object({
  dayOfWeek: z.number().min(1).max(7),
  startTime: z.string(),
  endTime: z.string(),
  timezone: z.string(),
});
export type TimeSlot = z.infer<typeof TimeSlotSchema>;

export const SeasonSchema = z.object({
  name: z.string(),
  startMonth: z.number().min(1).max(12),
  endMonth: z.number().min(1).max(12),
});
export type Season = z.infer<typeof SeasonSchema>;

export const AvailabilityRuleSchema = z.object({
  type: z.nativeEnum(AvailabilityType),
  schedule: z.array(TimeSlotSchema).optional(),
  startDate: z.string().optional(),
  endDate: z.string().optional(),
  expiryDate: z.string().optional(),
  shelfLifeDays: z.number().optional(),
  bestBefore: z.string().optional(),
  seasons: z.array(SeasonSchema).optional(),
  blackoutDates: z.array(z.string()).optional(),
  leadTimeHours: z.number().optional(),
});
export type AvailabilityRule = z.infer<typeof AvailabilityRuleSchema>;
