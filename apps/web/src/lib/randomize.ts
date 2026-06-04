import { defaultModel, type WizardModel } from "./wizard";
import { selectableServices } from "./services";
import { categories, type Category } from "./categories";

const pick = <T>(arr: T[], rand: () => number): T =>
  arr[Math.min(arr.length - 1, Math.floor(rand() * arr.length))];

/**
 * Build a random but always-valid WizardModel.
 *
 * - Each single-choice category gets a random option applied.
 * - `services` gets a random non-empty subset of the selectable (non-disabled)
 *   services, so filing-core is never selected.
 * - `addons` gets a random subset.
 * - `name` is left at the default.
 *
 * Deterministic when `rand` is injected.
 */
export function randomModel(rand: () => number = Math.random): WizardModel {
  let m: WizardModel = { ...defaultModel };

  // Random non-empty subset of selectable services.
  const slugs = selectableServices.map((s) => s.slug);
  let services = slugs.filter(() => rand() < 0.5);
  if (services.length === 0) services = [pick(slugs, rand)];
  m = { ...m, services };

  // Random subset of addons.
  const addonOpts = categories.find((c) => c.id === "addons")!.options;
  for (const o of addonOpts) {
    if (rand() < 0.5 && !o.isSelected(m)) m = { ...m, ...o.apply(m) };
  }

  // Each single-choice category: pick + apply one option.
  const singles: Category[] = categories.filter((c) => c.mode === "single");
  for (const c of singles) {
    const opt = pick(c.options, rand);
    m = { ...m, ...opt.apply(m) };
  }

  return m;
}
