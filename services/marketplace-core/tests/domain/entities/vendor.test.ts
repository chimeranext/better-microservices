import { describe, expect, it } from "vitest";
import { Vendor } from "../../../src/domain/entities/vendor.js";
import { InvariantViolationError } from "../../../src/shared-kernel/errors.js";
import { VerificationStatus } from "../../../src/shared-kernel/types.js";

const base = { slug: "vertivo", name: "Vertivo LATAM" };

describe("Vendor.create", () => {
  it("creates with UNVERIFIED status", () => {
    const v = Vendor.create(base);
    expect(v.verificationStatus).toBe(VerificationStatus.UNVERIFIED);
    expect(v.contact).toBeUndefined();
    expect(v.updatedAt).toBe(v.createdAt);
  });

  it("rejects bad slug + empty name", () => {
    expect(() => Vendor.create({ ...base, slug: "BAD" })).toThrow(InvariantViolationError);
    expect(() => Vendor.create({ ...base, name: "" })).toThrow(InvariantViolationError);
  });
});

describe("Vendor state transitions", () => {
  it("submitForVerification → PENDING; second call while VERIFIED throws", () => {
    const v = Vendor.create(base);
    v.submitForVerification();
    expect(v.verificationStatus).toBe(VerificationStatus.PENDING);
    v.verify();
    expect(v.verificationStatus).toBe(VerificationStatus.VERIFIED);
    expect(() => v.submitForVerification()).toThrow(InvariantViolationError);
  });

  it("verify + revokeVerification + updateContact", () => {
    const v = Vendor.create(base);
    v.verify();
    expect(v.verificationStatus).toBe(VerificationStatus.VERIFIED);
    v.revokeVerification();
    expect(v.verificationStatus).toBe(VerificationStatus.UNVERIFIED);
    v.updateContact({ phone: "+50612345678", email: "hola@vertivolatam.com" });
    expect(v.contact?.email).toBe("hola@vertivolatam.com");
    v.updateContact(undefined);
    expect(v.contact).toBeUndefined();
  });

  it("rename validates", () => {
    const v = Vendor.create(base);
    v.rename("Vertivo CR");
    expect(v.name).toBe("Vertivo CR");
    expect(() => v.rename("")).toThrow(InvariantViolationError);
  });

  it("restore + toData roundtrip, with and without contact", () => {
    const withContact = Vendor.create({
      ...base,
      contact: { phone: "+50600000000" },
    });
    const dataWith = withContact.toData();
    expect(Vendor.restore(dataWith).toData()).toEqual(dataWith);

    const withoutContact = Vendor.create(base);
    const dataWithout = withoutContact.toData();
    expect(dataWithout.contact).toBeUndefined();
    expect(Vendor.restore(dataWithout).toData()).toEqual(dataWithout);
  });
});
