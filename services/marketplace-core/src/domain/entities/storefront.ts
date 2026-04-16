import { randomUUID } from "node:crypto";
import { AggregateRoot } from "../../shared-kernel/aggregate-root.js";
import { InvariantViolationError } from "../../shared-kernel/errors.js";

const SLUG_RE = /^[a-z0-9]+(?:-[a-z0-9]+)*$/;

export interface CreateStorefrontInput {
  vendorId: string;
  slug: string;
  name: string;
  schemaRef: string;
  theme?: Record<string, unknown>;
  locale?: string;
}

export interface StorefrontData {
  id: string;
  vendorId: string;
  slug: string;
  name: string;
  schemaRef: string;
  theme: Record<string, unknown>;
  locale: string;
  published: boolean;
  createdAt: string;
  updatedAt: string;
}

export class Storefront extends AggregateRoot {
  private constructor(
    id: string,
    readonly vendorId: string,
    readonly slug: string,
    private _name: string,
    private _schemaRef: string,
    private _theme: Record<string, unknown>,
    private _locale: string,
    private _published: boolean,
    readonly createdAt: string,
    private _updatedAt: string,
  ) {
    super(id);
  }

  static create(input: CreateStorefrontInput): Storefront {
    if (input.vendorId.trim().length === 0) {
      throw new InvariantViolationError("Storefront vendorId cannot be empty");
    }
    if (!SLUG_RE.test(input.slug)) {
      throw new InvariantViolationError("Storefront slug must match /^[a-z0-9]+(?:-[a-z0-9]+)*$/", {
        slug: input.slug,
      });
    }
    if (input.name.trim().length === 0) {
      throw new InvariantViolationError("Storefront name cannot be empty");
    }
    if (input.schemaRef.trim().length === 0) {
      throw new InvariantViolationError("Storefront schemaRef cannot be empty");
    }

    const now = new Date().toISOString();
    return new Storefront(
      randomUUID(),
      input.vendorId,
      input.slug,
      input.name,
      input.schemaRef,
      input.theme ?? {},
      input.locale ?? "en",
      false,
      now,
      now,
    );
  }

  static restore(data: StorefrontData): Storefront {
    return new Storefront(
      data.id,
      data.vendorId,
      data.slug,
      data.name,
      data.schemaRef,
      { ...data.theme },
      data.locale,
      data.published,
      data.createdAt,
      data.updatedAt,
    );
  }

  get name(): string {
    return this._name;
  }

  get schemaRef(): string {
    return this._schemaRef;
  }

  get theme(): Readonly<Record<string, unknown>> {
    return this._theme;
  }

  get locale(): string {
    return this._locale;
  }

  get published(): boolean {
    return this._published;
  }

  get updatedAt(): string {
    return this._updatedAt;
  }

  rename(newName: string): void {
    if (newName.trim().length === 0) {
      throw new InvariantViolationError("Storefront name cannot be empty");
    }
    this._name = newName;
    this.touch();
  }

  changeSchema(newSchemaRef: string): void {
    if (newSchemaRef.trim().length === 0) {
      throw new InvariantViolationError("Storefront schemaRef cannot be empty");
    }
    this._schemaRef = newSchemaRef;
    this.touch();
  }

  updateTheme(theme: Record<string, unknown>): void {
    this._theme = { ...theme };
    this.touch();
  }

  setLocale(locale: string): void {
    if (locale.trim().length === 0) {
      throw new InvariantViolationError("Storefront locale cannot be empty");
    }
    this._locale = locale;
    this.touch();
  }

  publish(): void {
    if (this._published) return;
    this._published = true;
    this.touch();
  }

  unpublish(): void {
    if (!this._published) return;
    this._published = false;
    this.touch();
  }

  toData(): StorefrontData {
    return {
      id: this.id,
      vendorId: this.vendorId,
      slug: this.slug,
      name: this._name,
      schemaRef: this._schemaRef,
      theme: { ...this._theme },
      locale: this._locale,
      published: this._published,
      createdAt: this.createdAt,
      updatedAt: this._updatedAt,
    };
  }

  private touch(): void {
    this._updatedAt = new Date().toISOString();
  }
}
