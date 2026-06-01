import { randomUUID } from "node:crypto";
import { AggregateRoot } from "../../shared-kernel/aggregate-root.js";
import { InvariantViolationError } from "../../shared-kernel/errors.js";
import type { ProductArchived, ProductListed } from "../../shared-kernel/events.js";
import { ProductStatus } from "../../shared-kernel/types.js";
import type { ProductData } from "../ports/product-repository.js";
import type { GeoLocation } from "../value-objects/index.js";

const SLUG_RE = /^[a-z0-9]+(?:-[a-z0-9]+)*$/;
const MAX_TITLE = 200;
const MAX_DESCRIPTION = 5000;

export interface CreateProductInput {
  vendorId: string;
  title: string;
  description: string;
  slug: string;
  productType: string;
  schemaRef: string;
  tags?: string[];
  attributes?: Record<string, unknown>;
  geo?: GeoLocation;
}

export class Product extends AggregateRoot {
  private constructor(
    id: string,
    readonly vendorId: string,
    private _title: string,
    private _description: string,
    readonly slug: string,
    private _status: ProductStatus,
    readonly productType: string,
    private _tags: string[],
    readonly schemaRef: string,
    private _attributes: Record<string, unknown>,
    private _geo: GeoLocation | undefined,
    readonly createdAt: string,
    private _updatedAt: string,
  ) {
    super(id);
  }

  static create(input: CreateProductInput): Product {
    Product.assertTitle(input.title);
    Product.assertDescription(input.description);
    Product.assertSlug(input.slug);
    Product.assertNonEmpty("vendorId", input.vendorId);
    Product.assertNonEmpty("productType", input.productType);
    Product.assertNonEmpty("schemaRef", input.schemaRef);

    const now = new Date().toISOString();
    return new Product(
      randomUUID(),
      input.vendorId,
      input.title,
      input.description,
      input.slug,
      ProductStatus.DRAFT,
      input.productType,
      input.tags ?? [],
      input.schemaRef,
      input.attributes ?? {},
      input.geo,
      now,
      now,
    );
  }

  static restore(data: ProductData): Product {
    return new Product(
      data.id,
      data.vendorId,
      data.title,
      data.description,
      data.slug,
      data.status,
      data.productType,
      [...data.tags],
      data.schemaRef,
      { ...data.attributes },
      data.geo,
      data.createdAt,
      data.updatedAt,
    );
  }

  get title(): string {
    return this._title;
  }

  get description(): string {
    return this._description;
  }

  get status(): ProductStatus {
    return this._status;
  }

  get tags(): readonly string[] {
    return this._tags;
  }

  get attributes(): Readonly<Record<string, unknown>> {
    return this._attributes;
  }

  get geo(): GeoLocation | undefined {
    return this._geo;
  }

  get updatedAt(): string {
    return this._updatedAt;
  }

  rename(newTitle: string): void {
    Product.assertTitle(newTitle);
    if (newTitle === this._title) return;
    this._title = newTitle;
    this.touch();
  }

  describe(newDescription: string): void {
    Product.assertDescription(newDescription);
    if (newDescription === this._description) return;
    this._description = newDescription;
    this.touch();
  }

  activate(): void {
    if (this._status === ProductStatus.ACTIVE) return;
    if (this._status === ProductStatus.ARCHIVED) {
      throw new InvariantViolationError("Cannot activate an archived product", {
        productId: this.id,
      });
    }
    this._status = ProductStatus.ACTIVE;
    this.touch();
    const event: ProductListed = {
      eventId: randomUUID(),
      eventType: "ProductListed",
      aggregateId: this.id,
      timestamp: this._updatedAt,
      metadata: {},
      vendorId: this.vendorId,
      productId: this.id,
      schemaRef: this.schemaRef,
    };
    this.recordEvent(event);
  }

  archive(reason: string): void {
    Product.assertNonEmpty("reason", reason);
    if (this._status === ProductStatus.ARCHIVED) return;
    this._status = ProductStatus.ARCHIVED;
    this.touch();
    const event: ProductArchived = {
      eventId: randomUUID(),
      eventType: "ProductArchived",
      aggregateId: this.id,
      timestamp: this._updatedAt,
      metadata: { reason },
      productId: this.id,
      reason,
    };
    this.recordEvent(event);
  }

  replaceTags(tags: string[]): void {
    this._tags = [...tags];
    this.touch();
  }

  setAttribute(key: string, value: unknown): void {
    Product.assertNonEmpty("key", key);
    this._attributes = { ...this._attributes, [key]: value };
    this.touch();
  }

  relocate(geo: GeoLocation | undefined): void {
    this._geo = geo;
    this.touch();
  }

  toData(): ProductData {
    return {
      id: this.id,
      vendorId: this.vendorId,
      title: this._title,
      description: this._description,
      slug: this.slug,
      status: this._status,
      productType: this.productType,
      tags: [...this._tags],
      schemaRef: this.schemaRef,
      attributes: { ...this._attributes },
      geo: this._geo,
      createdAt: this.createdAt,
      updatedAt: this._updatedAt,
    };
  }

  private touch(): void {
    this._updatedAt = new Date().toISOString();
  }

  private static assertTitle(title: string): void {
    if (title.trim().length === 0) {
      throw new InvariantViolationError("Product title cannot be empty");
    }
    if (title.length > MAX_TITLE) {
      throw new InvariantViolationError(`Product title exceeds ${MAX_TITLE} chars`, {
        length: title.length,
      });
    }
  }

  private static assertDescription(description: string): void {
    if (description.length > MAX_DESCRIPTION) {
      throw new InvariantViolationError(`Product description exceeds ${MAX_DESCRIPTION} chars`, {
        length: description.length,
      });
    }
  }

  private static assertSlug(slug: string): void {
    if (!SLUG_RE.test(slug)) {
      throw new InvariantViolationError("Product slug must match /^[a-z0-9]+(?:-[a-z0-9]+)*$/", {
        slug,
      });
    }
  }

  private static assertNonEmpty(field: string, value: string): void {
    if (value.trim().length === 0) {
      throw new InvariantViolationError(`Product ${field} cannot be empty`);
    }
  }
}
