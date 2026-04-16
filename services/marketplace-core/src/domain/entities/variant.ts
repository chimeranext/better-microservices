import { randomUUID } from "node:crypto";
import { AggregateRoot } from "../../shared-kernel/aggregate-root.js";
import { InvariantViolationError } from "../../shared-kernel/errors.js";
import type { VariantCreated } from "../../shared-kernel/events.js";
import type { InventoryPolicy } from "../../shared-kernel/types.js";
import type { Money } from "../value-objects/index.js";

const SKU_RE = /^[A-Z0-9]+(?:-[A-Z0-9]+)*$/;

export interface CreateVariantInput {
  productId: string;
  sku: string;
  price: Money;
  inventoryPolicy: InventoryPolicy;
  options?: Record<string, string>;
}

export interface VariantData {
  id: string;
  productId: string;
  sku: string;
  price: Money;
  inventoryPolicy: InventoryPolicy;
  options: Record<string, string>;
  createdAt: string;
  updatedAt: string;
}

export class Variant extends AggregateRoot {
  private constructor(
    id: string,
    readonly productId: string,
    readonly sku: string,
    private _price: Money,
    private _inventoryPolicy: InventoryPolicy,
    private _options: Record<string, string>,
    readonly createdAt: string,
    private _updatedAt: string,
  ) {
    super(id);
  }

  static create(input: CreateVariantInput): Variant {
    if (input.productId.trim().length === 0) {
      throw new InvariantViolationError("Variant productId cannot be empty");
    }
    Variant.assertSku(input.sku);

    const id = randomUUID();
    const now = new Date().toISOString();
    const variant = new Variant(
      id,
      input.productId,
      input.sku,
      input.price,
      input.inventoryPolicy,
      input.options ?? {},
      now,
      now,
    );

    const event: VariantCreated = {
      eventId: randomUUID(),
      eventType: "VariantCreated",
      aggregateId: id,
      timestamp: now,
      metadata: {},
      productId: input.productId,
      variantId: id,
      price: input.price.amount,
      currency: input.price.currency,
    };
    variant.recordEvent(event);

    return variant;
  }

  static restore(data: VariantData): Variant {
    return new Variant(
      data.id,
      data.productId,
      data.sku,
      { ...data.price },
      data.inventoryPolicy,
      { ...data.options },
      data.createdAt,
      data.updatedAt,
    );
  }

  get price(): Money {
    return this._price;
  }

  get inventoryPolicy(): InventoryPolicy {
    return this._inventoryPolicy;
  }

  get options(): Readonly<Record<string, string>> {
    return this._options;
  }

  get updatedAt(): string {
    return this._updatedAt;
  }

  reprice(newPrice: Money): void {
    this._price = newPrice;
    this.touch();
  }

  changePolicy(policy: InventoryPolicy): void {
    this._inventoryPolicy = policy;
    this.touch();
  }

  toData(): VariantData {
    return {
      id: this.id,
      productId: this.productId,
      sku: this.sku,
      price: { ...this._price },
      inventoryPolicy: this._inventoryPolicy,
      options: { ...this._options },
      createdAt: this.createdAt,
      updatedAt: this._updatedAt,
    };
  }

  private touch(): void {
    this._updatedAt = new Date().toISOString();
  }

  private static assertSku(sku: string): void {
    if (!SKU_RE.test(sku)) {
      throw new InvariantViolationError("Variant SKU must match /^[A-Z0-9]+(?:-[A-Z0-9]+)*$/", {
        sku,
      });
    }
  }
}
