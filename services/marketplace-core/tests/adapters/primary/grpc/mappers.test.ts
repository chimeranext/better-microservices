import { describe, expect, it } from "vitest";
import {
  domainFulfillmentToProto,
  productToProto,
  protoFulfillmentTypesToDomain,
  protoProductStatusToDomain,
} from "../../../../src/adapters/primary/grpc/mappers.js";
import type { ProductData } from "../../../../src/domain/ports/index.js";
import { FulfillmentType, ProductStatus } from "../../../../src/shared-kernel/types.js";

const product: ProductData = {
  id: "p-1",
  vendorId: "v-1",
  title: "Lettuce",
  description: "",
  slug: "lettuce",
  status: ProductStatus.ACTIVE,
  productType: "hortaliza",
  tags: ["fresh"],
  schemaRef: "schema://x",
  attributes: { ph: 6.2, organic: true },
  geo: {
    lat: 9.93,
    lng: -84.08,
    address: "SJO",
    city: "San Jose",
    state: "SJ",
    country: "CR",
    postalCode: "10101",
  },
  createdAt: "2026-04-15T00:00:00Z",
  updatedAt: "2026-04-15T00:00:00Z",
};

describe("gRPC mappers", () => {
  it("productToProto: status enum + attribute stringification + geo mapping", () => {
    const proto = productToProto(product);
    expect(proto.status).toBe(2); // ACTIVE
    expect(proto.attributes).toEqual({ ph: "6.2", organic: "true" });
    expect(proto.geo?.country).toBe("CR");
    expect(proto.geo?.postal_code).toBe("10101");
  });

  it("productToProto: missing geo yields undefined, unspecified status → 0", () => {
    const proto = productToProto({
      ...product,
      geo: undefined,
      status: "UNKNOWN" as ProductStatus,
    });
    expect(proto.geo).toBeUndefined();
    expect(proto.status).toBe(0);
  });

  it("protoProductStatusToDomain: maps ints back, returns undefined for 0/undefined", () => {
    expect(protoProductStatusToDomain(1)).toBe("DRAFT");
    expect(protoProductStatusToDomain(2)).toBe("ACTIVE");
    expect(protoProductStatusToDomain(3)).toBe("ARCHIVED");
    expect(protoProductStatusToDomain(0)).toBeUndefined();
    expect(protoProductStatusToDomain(undefined)).toBeUndefined();
    expect(protoProductStatusToDomain(999)).toBeUndefined();
  });

  it("protoFulfillmentTypesToDomain filters unknown enum ints", () => {
    expect(protoFulfillmentTypesToDomain([1, 3, 999])).toEqual(["PHYSICAL", "IN_PERSON"]);
    expect(protoFulfillmentTypesToDomain(undefined)).toEqual([]);
  });

  it("domainFulfillmentToProto covers each known type", () => {
    expect(domainFulfillmentToProto(FulfillmentType.PHYSICAL)).toBe(1);
    expect(domainFulfillmentToProto(FulfillmentType.DIGITAL)).toBe(2);
    expect(domainFulfillmentToProto(FulfillmentType.IN_PERSON)).toBe(3);
    expect(domainFulfillmentToProto(FulfillmentType.ONGOING)).toBe(4);
  });
});
