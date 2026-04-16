import { randomUUID } from "node:crypto";
import { AggregateRoot } from "../../shared-kernel/aggregate-root.js";
import { InvariantViolationError } from "../../shared-kernel/errors.js";
import { CollectionType } from "../../shared-kernel/types.js";

const SLUG_RE = /^[a-z0-9]+(?:-[a-z0-9]+)*$/;

export interface CreateCollectionInput {
  vendorId: string;
  title: string;
  slug: string;
  type: CollectionType;
  description?: string;
  productIds?: string[];
}

export interface CollectionData {
  id: string;
  vendorId: string;
  title: string;
  slug: string;
  type: CollectionType;
  description: string;
  productIds: string[];
  createdAt: string;
  updatedAt: string;
}

export class Collection extends AggregateRoot {
  private constructor(
    id: string,
    readonly vendorId: string,
    private _title: string,
    readonly slug: string,
    readonly type: CollectionType,
    private _description: string,
    private _productIds: string[],
    readonly createdAt: string,
    private _updatedAt: string,
  ) {
    super(id);
  }

  static create(input: CreateCollectionInput): Collection {
    if (input.vendorId.trim().length === 0) {
      throw new InvariantViolationError("Collection vendorId cannot be empty");
    }
    if (input.title.trim().length === 0) {
      throw new InvariantViolationError("Collection title cannot be empty");
    }
    if (!SLUG_RE.test(input.slug)) {
      throw new InvariantViolationError("Collection slug must match /^[a-z0-9]+(?:-[a-z0-9]+)*$/", {
        slug: input.slug,
      });
    }
    if (input.type === CollectionType.SMART && (input.productIds?.length ?? 0) > 0) {
      throw new InvariantViolationError(
        "Smart collections must not specify productIds at creation (they are computed)",
      );
    }

    const now = new Date().toISOString();
    return new Collection(
      randomUUID(),
      input.vendorId,
      input.title,
      input.slug,
      input.type,
      input.description ?? "",
      input.type === CollectionType.MANUAL ? (input.productIds ?? []) : [],
      now,
      now,
    );
  }

  static restore(data: CollectionData): Collection {
    return new Collection(
      data.id,
      data.vendorId,
      data.title,
      data.slug,
      data.type,
      data.description,
      [...data.productIds],
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

  get productIds(): readonly string[] {
    return this._productIds;
  }

  get updatedAt(): string {
    return this._updatedAt;
  }

  rename(newTitle: string): void {
    if (newTitle.trim().length === 0) {
      throw new InvariantViolationError("Collection title cannot be empty");
    }
    this._title = newTitle;
    this.touch();
  }

  describe(description: string): void {
    this._description = description;
    this.touch();
  }

  addProduct(productId: string): void {
    this.assertManual("addProduct");
    if (productId.trim().length === 0) {
      throw new InvariantViolationError("productId cannot be empty");
    }
    if (this._productIds.includes(productId)) return;
    this._productIds.push(productId);
    this.touch();
  }

  removeProduct(productId: string): void {
    this.assertManual("removeProduct");
    const idx = this._productIds.indexOf(productId);
    if (idx === -1) return;
    this._productIds.splice(idx, 1);
    this.touch();
  }

  toData(): CollectionData {
    return {
      id: this.id,
      vendorId: this.vendorId,
      title: this._title,
      slug: this.slug,
      type: this.type,
      description: this._description,
      productIds: [...this._productIds],
      createdAt: this.createdAt,
      updatedAt: this._updatedAt,
    };
  }

  private touch(): void {
    this._updatedAt = new Date().toISOString();
  }

  private assertManual(op: string): void {
    if (this.type !== CollectionType.MANUAL) {
      throw new InvariantViolationError(
        `Cannot ${op} on a ${this.type} collection — only MANUAL collections accept explicit product membership`,
        { collectionId: this.id, type: this.type },
      );
    }
  }
}
