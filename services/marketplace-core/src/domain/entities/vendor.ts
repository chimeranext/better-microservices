import { randomUUID } from "node:crypto";
import { AggregateRoot } from "../../shared-kernel/aggregate-root.js";
import { InvariantViolationError } from "../../shared-kernel/errors.js";
import { VerificationStatus } from "../../shared-kernel/types.js";
import type { Contact } from "../value-objects/index.js";

const SLUG_RE = /^[a-z0-9]+(?:-[a-z0-9]+)*$/;

export interface CreateVendorInput {
  slug: string;
  name: string;
  contact?: Contact;
}

export interface VendorData {
  id: string;
  slug: string;
  name: string;
  contact?: Contact;
  verificationStatus: VerificationStatus;
  createdAt: string;
  updatedAt: string;
}

export class Vendor extends AggregateRoot {
  private constructor(
    id: string,
    readonly slug: string,
    private _name: string,
    private _contact: Contact | undefined,
    private _verificationStatus: VerificationStatus,
    readonly createdAt: string,
    private _updatedAt: string,
  ) {
    super(id);
  }

  static create(input: CreateVendorInput): Vendor {
    if (!SLUG_RE.test(input.slug)) {
      throw new InvariantViolationError("Vendor slug must match /^[a-z0-9]+(?:-[a-z0-9]+)*$/", {
        slug: input.slug,
      });
    }
    if (input.name.trim().length === 0) {
      throw new InvariantViolationError("Vendor name cannot be empty");
    }

    const now = new Date().toISOString();
    return new Vendor(
      randomUUID(),
      input.slug,
      input.name,
      input.contact,
      VerificationStatus.UNVERIFIED,
      now,
      now,
    );
  }

  static restore(data: VendorData): Vendor {
    return new Vendor(
      data.id,
      data.slug,
      data.name,
      data.contact ? { ...data.contact } : undefined,
      data.verificationStatus,
      data.createdAt,
      data.updatedAt,
    );
  }

  get name(): string {
    return this._name;
  }

  get contact(): Contact | undefined {
    return this._contact;
  }

  get verificationStatus(): VerificationStatus {
    return this._verificationStatus;
  }

  get updatedAt(): string {
    return this._updatedAt;
  }

  rename(newName: string): void {
    if (newName.trim().length === 0) {
      throw new InvariantViolationError("Vendor name cannot be empty");
    }
    this._name = newName;
    this.touch();
  }

  updateContact(contact: Contact | undefined): void {
    this._contact = contact;
    this.touch();
  }

  submitForVerification(): void {
    if (this._verificationStatus === VerificationStatus.VERIFIED) {
      throw new InvariantViolationError("Vendor is already verified");
    }
    this._verificationStatus = VerificationStatus.PENDING;
    this.touch();
  }

  verify(): void {
    this._verificationStatus = VerificationStatus.VERIFIED;
    this.touch();
  }

  revokeVerification(): void {
    this._verificationStatus = VerificationStatus.UNVERIFIED;
    this.touch();
  }

  toData(): VendorData {
    return {
      id: this.id,
      slug: this.slug,
      name: this._name,
      contact: this._contact ? { ...this._contact } : undefined,
      verificationStatus: this._verificationStatus,
      createdAt: this.createdAt,
      updatedAt: this._updatedAt,
    };
  }

  private touch(): void {
    this._updatedAt = new Date().toISOString();
  }
}
