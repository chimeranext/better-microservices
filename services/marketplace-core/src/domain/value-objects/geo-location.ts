import { z } from "zod";

export const GeoLocationSchema = z.object({
  lat: z.number().min(-90).max(90),
  lng: z.number().min(-180).max(180),
  address: z.string(),
  city: z.string(),
  state: z.string(),
  country: z.string().length(2, "Country must be ISO 3166-1 alpha-2"),
  postalCode: z.string().optional(),
});

export type GeoLocation = z.infer<typeof GeoLocationSchema>;
