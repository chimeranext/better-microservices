// This is a generated file - do not edit.
//
// Generated from marketplace_core.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use productStatusDescriptor instead')
const ProductStatus$json = {
  '1': 'ProductStatus',
  '2': [
    {'1': 'PRODUCT_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'PRODUCT_STATUS_DRAFT', '2': 1},
    {'1': 'PRODUCT_STATUS_ACTIVE', '2': 2},
    {'1': 'PRODUCT_STATUS_ARCHIVED', '2': 3},
  ],
};

/// Descriptor for `ProductStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List productStatusDescriptor = $convert.base64Decode(
    'Cg1Qcm9kdWN0U3RhdHVzEh4KGlBST0RVQ1RfU1RBVFVTX1VOU1BFQ0lGSUVEEAASGAoUUFJPRF'
    'VDVF9TVEFUVVNfRFJBRlQQARIZChVQUk9EVUNUX1NUQVRVU19BQ1RJVkUQAhIbChdQUk9EVUNU'
    'X1NUQVRVU19BUkNISVZFRBAD');

@$core.Deprecated('Use inventoryPolicyDescriptor instead')
const InventoryPolicy$json = {
  '1': 'InventoryPolicy',
  '2': [
    {'1': 'INVENTORY_POLICY_UNSPECIFIED', '2': 0},
    {'1': 'INVENTORY_POLICY_TRACK', '2': 1},
    {'1': 'INVENTORY_POLICY_SINGLE', '2': 2},
    {'1': 'INVENTORY_POLICY_UNTRACK', '2': 3},
    {'1': 'INVENTORY_POLICY_CAPACITY', '2': 4},
  ],
};

/// Descriptor for `InventoryPolicy`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List inventoryPolicyDescriptor = $convert.base64Decode(
    'Cg9JbnZlbnRvcnlQb2xpY3kSIAocSU5WRU5UT1JZX1BPTElDWV9VTlNQRUNJRklFRBAAEhoKFk'
    'lOVkVOVE9SWV9QT0xJQ1lfVFJBQ0sQARIbChdJTlZFTlRPUllfUE9MSUNZX1NJTkdMRRACEhwK'
    'GElOVkVOVE9SWV9QT0xJQ1lfVU5UUkFDSxADEh0KGUlOVkVOVE9SWV9QT0xJQ1lfQ0FQQUNJVF'
    'kQBA==');

@$core.Deprecated('Use fulfillmentTypeDescriptor instead')
const FulfillmentType$json = {
  '1': 'FulfillmentType',
  '2': [
    {'1': 'FULFILLMENT_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'FULFILLMENT_TYPE_PHYSICAL', '2': 1},
    {'1': 'FULFILLMENT_TYPE_DIGITAL', '2': 2},
    {'1': 'FULFILLMENT_TYPE_IN_PERSON', '2': 3},
    {'1': 'FULFILLMENT_TYPE_ONGOING', '2': 4},
  ],
};

/// Descriptor for `FulfillmentType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List fulfillmentTypeDescriptor = $convert.base64Decode(
    'Cg9GdWxmaWxsbWVudFR5cGUSIAocRlVMRklMTE1FTlRfVFlQRV9VTlNQRUNJRklFRBAAEh0KGU'
    'ZVTEZJTExNRU5UX1RZUEVfUEhZU0lDQUwQARIcChhGVUxGSUxMTUVOVF9UWVBFX0RJR0lUQUwQ'
    'AhIeChpGVUxGSUxMTUVOVF9UWVBFX0lOX1BFUlNPThADEhwKGEZVTEZJTExNRU5UX1RZUEVfT0'
    '5HT0lORxAE');

@$core.Deprecated('Use collectionTypeDescriptor instead')
const CollectionType$json = {
  '1': 'CollectionType',
  '2': [
    {'1': 'COLLECTION_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'COLLECTION_TYPE_MANUAL', '2': 1},
    {'1': 'COLLECTION_TYPE_SMART', '2': 2},
  ],
};

/// Descriptor for `CollectionType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List collectionTypeDescriptor = $convert.base64Decode(
    'Cg5Db2xsZWN0aW9uVHlwZRIfChtDT0xMRUNUSU9OX1RZUEVfVU5TUEVDSUZJRUQQABIaChZDT0'
    'xMRUNUSU9OX1RZUEVfTUFOVUFMEAESGQoVQ09MTEVDVElPTl9UWVBFX1NNQVJUEAI=');

@$core.Deprecated('Use sortOrderDescriptor instead')
const SortOrder$json = {
  '1': 'SortOrder',
  '2': [
    {'1': 'SORT_ORDER_UNSPECIFIED', '2': 0},
    {'1': 'SORT_ORDER_MANUAL', '2': 1},
    {'1': 'SORT_ORDER_BEST_SELLING', '2': 2},
    {'1': 'SORT_ORDER_PRICE_ASC', '2': 3},
    {'1': 'SORT_ORDER_PRICE_DESC', '2': 4},
    {'1': 'SORT_ORDER_CREATED_DESC', '2': 5},
    {'1': 'SORT_ORDER_TITLE_ASC', '2': 6},
  ],
};

/// Descriptor for `SortOrder`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List sortOrderDescriptor = $convert.base64Decode(
    'CglTb3J0T3JkZXISGgoWU09SVF9PUkRFUl9VTlNQRUNJRklFRBAAEhUKEVNPUlRfT1JERVJfTU'
    'FOVUFMEAESGwoXU09SVF9PUkRFUl9CRVNUX1NFTExJTkcQAhIYChRTT1JUX09SREVSX1BSSUNF'
    'X0FTQxADEhkKFVNPUlRfT1JERVJfUFJJQ0VfREVTQxAEEhsKF1NPUlRfT1JERVJfQ1JFQVRFRF'
    '9ERVNDEAUSGAoUU09SVF9PUkRFUl9USVRMRV9BU0MQBg==');

@$core.Deprecated('Use verificationStatusDescriptor instead')
const VerificationStatus$json = {
  '1': 'VerificationStatus',
  '2': [
    {'1': 'VERIFICATION_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'VERIFICATION_STATUS_UNVERIFIED', '2': 1},
    {'1': 'VERIFICATION_STATUS_PENDING', '2': 2},
    {'1': 'VERIFICATION_STATUS_VERIFIED', '2': 3},
  ],
};

/// Descriptor for `VerificationStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List verificationStatusDescriptor = $convert.base64Decode(
    'ChJWZXJpZmljYXRpb25TdGF0dXMSIwofVkVSSUZJQ0FUSU9OX1NUQVRVU19VTlNQRUNJRklFRB'
    'AAEiIKHlZFUklGSUNBVElPTl9TVEFUVVNfVU5WRVJJRklFRBABEh8KG1ZFUklGSUNBVElPTl9T'
    'VEFUVVNfUEVORElORxACEiAKHFZFUklGSUNBVElPTl9TVEFUVVNfVkVSSUZJRUQQAw==');

@$core.Deprecated('Use mediaOwnerTypeDescriptor instead')
const MediaOwnerType$json = {
  '1': 'MediaOwnerType',
  '2': [
    {'1': 'MEDIA_OWNER_UNSPECIFIED', '2': 0},
    {'1': 'MEDIA_OWNER_PRODUCT', '2': 1},
    {'1': 'MEDIA_OWNER_VARIANT', '2': 2},
    {'1': 'MEDIA_OWNER_VENDOR', '2': 3},
    {'1': 'MEDIA_OWNER_STOREFRONT', '2': 4},
  ],
};

/// Descriptor for `MediaOwnerType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List mediaOwnerTypeDescriptor = $convert.base64Decode(
    'Cg5NZWRpYU93bmVyVHlwZRIbChdNRURJQV9PV05FUl9VTlNQRUNJRklFRBAAEhcKE01FRElBX0'
    '9XTkVSX1BST0RVQ1QQARIXChNNRURJQV9PV05FUl9WQVJJQU5UEAISFgoSTUVESUFfT1dORVJf'
    'VkVORE9SEAMSGgoWTUVESUFfT1dORVJfU1RPUkVGUk9OVBAE');

@$core.Deprecated('Use mediaTypeDescriptor instead')
const MediaType$json = {
  '1': 'MediaType',
  '2': [
    {'1': 'MEDIA_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'MEDIA_TYPE_IMAGE', '2': 1},
    {'1': 'MEDIA_TYPE_VIDEO', '2': 2},
    {'1': 'MEDIA_TYPE_DOCUMENT', '2': 3},
  ],
};

/// Descriptor for `MediaType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List mediaTypeDescriptor = $convert.base64Decode(
    'CglNZWRpYVR5cGUSGgoWTUVESUFfVFlQRV9VTlNQRUNJRklFRBAAEhQKEE1FRElBX1RZUEVfSU'
    '1BR0UQARIUChBNRURJQV9UWVBFX1ZJREVPEAISFwoTTUVESUFfVFlQRV9ET0NVTUVOVBAD');

@$core.Deprecated('Use availabilityTypeDescriptor instead')
const AvailabilityType$json = {
  '1': 'AvailabilityType',
  '2': [
    {'1': 'AVAILABILITY_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'AVAILABILITY_TYPE_ALWAYS', '2': 1},
    {'1': 'AVAILABILITY_TYPE_CALENDAR', '2': 2},
    {'1': 'AVAILABILITY_TYPE_DATE_RANGE', '2': 3},
    {'1': 'AVAILABILITY_TYPE_EXPIRABLE', '2': 4},
    {'1': 'AVAILABILITY_TYPE_SEASONAL', '2': 5},
  ],
};

/// Descriptor for `AvailabilityType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List availabilityTypeDescriptor = $convert.base64Decode(
    'ChBBdmFpbGFiaWxpdHlUeXBlEiEKHUFWQUlMQUJJTElUWV9UWVBFX1VOU1BFQ0lGSUVEEAASHA'
    'oYQVZBSUxBQklMSVRZX1RZUEVfQUxXQVlTEAESHgoaQVZBSUxBQklMSVRZX1RZUEVfQ0FMRU5E'
    'QVIQAhIgChxBVkFJTEFCSUxJVFlfVFlQRV9EQVRFX1JBTkdFEAMSHwobQVZBSUxBQklMSVRZX1'
    'RZUEVfRVhQSVJBQkxFEAQSHgoaQVZBSUxBQklMSVRZX1RZUEVfU0VBU09OQUwQBQ==');

@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor =
    $convert.base64Decode('CgVFbXB0eQ==');

@$core.Deprecated('Use productDescriptor instead')
const Product$json = {
  '1': 'Product',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'vendor_id', '3': 2, '4': 1, '5': 9, '10': 'vendorId'},
    {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'slug', '3': 5, '4': 1, '5': 9, '10': 'slug'},
    {
      '1': 'status',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.marketplace_core.ProductStatus',
      '10': 'status'
    },
    {'1': 'product_type', '3': 7, '4': 1, '5': 9, '10': 'productType'},
    {'1': 'tags', '3': 8, '4': 3, '5': 9, '10': 'tags'},
    {
      '1': 'media',
      '3': 9,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.MediaAsset',
      '10': 'media'
    },
    {
      '1': 'geo',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.GeoLocation',
      '10': 'geo'
    },
    {'1': 'schema_ref', '3': 11, '4': 1, '5': 9, '10': 'schemaRef'},
    {
      '1': 'attributes',
      '3': 12,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.Product.AttributesEntry',
      '10': 'attributes'
    },
    {
      '1': 'variants',
      '3': 13,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.Variant',
      '10': 'variants'
    },
    {'1': 'collection_ids', '3': 14, '4': 3, '5': 9, '10': 'collectionIds'},
    {
      '1': 'seo',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.SEO',
      '10': 'seo'
    },
    {'1': 'created_at', '3': 16, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 17, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
  '3': [Product_AttributesEntry$json],
};

@$core.Deprecated('Use productDescriptor instead')
const Product_AttributesEntry$json = {
  '1': 'AttributesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Product`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List productDescriptor = $convert.base64Decode(
    'CgdQcm9kdWN0Eg4KAmlkGAEgASgJUgJpZBIbCgl2ZW5kb3JfaWQYAiABKAlSCHZlbmRvcklkEh'
    'QKBXRpdGxlGAMgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgEIAEoCVILZGVzY3JpcHRpb24S'
    'EgoEc2x1ZxgFIAEoCVIEc2x1ZxI3CgZzdGF0dXMYBiABKA4yHy5tYXJrZXRwbGFjZV9jb3JlLl'
    'Byb2R1Y3RTdGF0dXNSBnN0YXR1cxIhCgxwcm9kdWN0X3R5cGUYByABKAlSC3Byb2R1Y3RUeXBl'
    'EhIKBHRhZ3MYCCADKAlSBHRhZ3MSMgoFbWVkaWEYCSADKAsyHC5tYXJrZXRwbGFjZV9jb3JlLk'
    '1lZGlhQXNzZXRSBW1lZGlhEi8KA2dlbxgKIAEoCzIdLm1hcmtldHBsYWNlX2NvcmUuR2VvTG9j'
    'YXRpb25SA2dlbxIdCgpzY2hlbWFfcmVmGAsgASgJUglzY2hlbWFSZWYSSQoKYXR0cmlidXRlcx'
    'gMIAMoCzIpLm1hcmtldHBsYWNlX2NvcmUuUHJvZHVjdC5BdHRyaWJ1dGVzRW50cnlSCmF0dHJp'
    'YnV0ZXMSNQoIdmFyaWFudHMYDSADKAsyGS5tYXJrZXRwbGFjZV9jb3JlLlZhcmlhbnRSCHZhcm'
    'lhbnRzEiUKDmNvbGxlY3Rpb25faWRzGA4gAygJUg1jb2xsZWN0aW9uSWRzEicKA3NlbxgPIAEo'
    'CzIVLm1hcmtldHBsYWNlX2NvcmUuU0VPUgNzZW8SHQoKY3JlYXRlZF9hdBgQIAEoCVIJY3JlYX'
    'RlZEF0Eh0KCnVwZGF0ZWRfYXQYESABKAlSCXVwZGF0ZWRBdBo9Cg9BdHRyaWJ1dGVzRW50cnkS'
    'EAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use variantDescriptor instead')
const Variant$json = {
  '1': 'Variant',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'product_id', '3': 2, '4': 1, '5': 9, '10': 'productId'},
    {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    {'1': 'sku', '3': 4, '4': 1, '5': 9, '10': 'sku'},
    {
      '1': 'price',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.Money',
      '10': 'price'
    },
    {
      '1': 'compare_at_price',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.Money',
      '10': 'compareAtPrice'
    },
    {
      '1': 'options',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.Option',
      '10': 'options'
    },
    {
      '1': 'inventory_policy',
      '3': 8,
      '4': 1,
      '5': 14,
      '6': '.marketplace_core.InventoryPolicy',
      '10': 'inventoryPolicy'
    },
    {
      '1': 'fulfillment_types',
      '3': 9,
      '4': 3,
      '5': 14,
      '6': '.marketplace_core.FulfillmentType',
      '10': 'fulfillmentTypes'
    },
    {
      '1': 'availability',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.AvailabilityRule',
      '10': 'availability'
    },
    {
      '1': 'inventory',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.InventoryInfo',
      '10': 'inventory'
    },
    {'1': 'available', '3': 12, '4': 1, '5': 8, '10': 'available'},
    {'1': 'position', '3': 13, '4': 1, '5': 5, '10': 'position'},
    {
      '1': 'metadata',
      '3': 14,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.Variant.MetadataEntry',
      '10': 'metadata'
    },
    {'1': 'created_at', '3': 15, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 16, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
  '3': [Variant_MetadataEntry$json],
};

@$core.Deprecated('Use variantDescriptor instead')
const Variant_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Variant`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List variantDescriptor = $convert.base64Decode(
    'CgdWYXJpYW50Eg4KAmlkGAEgASgJUgJpZBIdCgpwcm9kdWN0X2lkGAIgASgJUglwcm9kdWN0SW'
    'QSFAoFdGl0bGUYAyABKAlSBXRpdGxlEhAKA3NrdRgEIAEoCVIDc2t1Ei0KBXByaWNlGAUgASgL'
    'MhcubWFya2V0cGxhY2VfY29yZS5Nb25leVIFcHJpY2USQQoQY29tcGFyZV9hdF9wcmljZRgGIA'
    'EoCzIXLm1hcmtldHBsYWNlX2NvcmUuTW9uZXlSDmNvbXBhcmVBdFByaWNlEjIKB29wdGlvbnMY'
    'ByADKAsyGC5tYXJrZXRwbGFjZV9jb3JlLk9wdGlvblIHb3B0aW9ucxJMChBpbnZlbnRvcnlfcG'
    '9saWN5GAggASgOMiEubWFya2V0cGxhY2VfY29yZS5JbnZlbnRvcnlQb2xpY3lSD2ludmVudG9y'
    'eVBvbGljeRJOChFmdWxmaWxsbWVudF90eXBlcxgJIAMoDjIhLm1hcmtldHBsYWNlX2NvcmUuRn'
    'VsZmlsbG1lbnRUeXBlUhBmdWxmaWxsbWVudFR5cGVzEkYKDGF2YWlsYWJpbGl0eRgKIAEoCzIi'
    'Lm1hcmtldHBsYWNlX2NvcmUuQXZhaWxhYmlsaXR5UnVsZVIMYXZhaWxhYmlsaXR5Ej0KCWludm'
    'VudG9yeRgLIAEoCzIfLm1hcmtldHBsYWNlX2NvcmUuSW52ZW50b3J5SW5mb1IJaW52ZW50b3J5'
    'EhwKCWF2YWlsYWJsZRgMIAEoCFIJYXZhaWxhYmxlEhoKCHBvc2l0aW9uGA0gASgFUghwb3NpdG'
    'lvbhJDCghtZXRhZGF0YRgOIAMoCzInLm1hcmtldHBsYWNlX2NvcmUuVmFyaWFudC5NZXRhZGF0'
    'YUVudHJ5UghtZXRhZGF0YRIdCgpjcmVhdGVkX2F0GA8gASgJUgljcmVhdGVkQXQSHQoKdXBkYX'
    'RlZF9hdBgQIAEoCVIJdXBkYXRlZEF0GjsKDU1ldGFkYXRhRW50cnkSEAoDa2V5GAEgASgJUgNr'
    'ZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use collectionDescriptor instead')
const Collection$json = {
  '1': 'Collection',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'slug', '3': 3, '4': 1, '5': 9, '10': 'slug'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'type',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.marketplace_core.CollectionType',
      '10': 'type'
    },
    {
      '1': 'rules',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.CollectionRule',
      '10': 'rules'
    },
    {
      '1': 'sort_order',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.marketplace_core.SortOrder',
      '10': 'sortOrder'
    },
    {
      '1': 'image',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.MediaAsset',
      '10': 'image'
    },
    {
      '1': 'seo',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.SEO',
      '10': 'seo'
    },
    {'1': 'product_ids', '3': 10, '4': 3, '5': 9, '10': 'productIds'},
    {'1': 'created_at', '3': 11, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 12, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `Collection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List collectionDescriptor = $convert.base64Decode(
    'CgpDb2xsZWN0aW9uEg4KAmlkGAEgASgJUgJpZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSEgoEc2'
    'x1ZxgDIAEoCVIEc2x1ZxIgCgtkZXNjcmlwdGlvbhgEIAEoCVILZGVzY3JpcHRpb24SNAoEdHlw'
    'ZRgFIAEoDjIgLm1hcmtldHBsYWNlX2NvcmUuQ29sbGVjdGlvblR5cGVSBHR5cGUSNgoFcnVsZX'
    'MYBiADKAsyIC5tYXJrZXRwbGFjZV9jb3JlLkNvbGxlY3Rpb25SdWxlUgVydWxlcxI6Cgpzb3J0'
    'X29yZGVyGAcgASgOMhsubWFya2V0cGxhY2VfY29yZS5Tb3J0T3JkZXJSCXNvcnRPcmRlchIyCg'
    'VpbWFnZRgIIAEoCzIcLm1hcmtldHBsYWNlX2NvcmUuTWVkaWFBc3NldFIFaW1hZ2USJwoDc2Vv'
    'GAkgASgLMhUubWFya2V0cGxhY2VfY29yZS5TRU9SA3NlbxIfCgtwcm9kdWN0X2lkcxgKIAMoCV'
    'IKcHJvZHVjdElkcxIdCgpjcmVhdGVkX2F0GAsgASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9h'
    'dBgMIAEoCVIJdXBkYXRlZEF0');

@$core.Deprecated('Use collectionRuleDescriptor instead')
const CollectionRule$json = {
  '1': 'CollectionRule',
  '2': [
    {'1': 'field', '3': 1, '4': 1, '5': 9, '10': 'field'},
    {'1': 'operator', '3': 2, '4': 1, '5': 9, '10': 'operator'},
    {'1': 'value', '3': 3, '4': 1, '5': 9, '10': 'value'},
  ],
};

/// Descriptor for `CollectionRule`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List collectionRuleDescriptor = $convert.base64Decode(
    'Cg5Db2xsZWN0aW9uUnVsZRIUCgVmaWVsZBgBIAEoCVIFZmllbGQSGgoIb3BlcmF0b3IYAiABKA'
    'lSCG9wZXJhdG9yEhQKBXZhbHVlGAMgASgJUgV2YWx1ZQ==');

@$core.Deprecated('Use vendorDescriptor instead')
const Vendor$json = {
  '1': 'Vendor',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'slug', '3': 3, '4': 1, '5': 9, '10': 'slug'},
    {
      '1': 'verification',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.marketplace_core.VerificationStatus',
      '10': 'verification'
    },
    {'1': 'identity_doc', '3': 5, '4': 1, '5': 9, '10': 'identityDoc'},
    {
      '1': 'contact',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.Contact',
      '10': 'contact'
    },
    {
      '1': 'geo',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.GeoLocation',
      '10': 'geo'
    },
    {
      '1': 'metadata',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.Vendor.MetadataEntry',
      '10': 'metadata'
    },
    {'1': 'created_at', '3': 9, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 10, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
  '3': [Vendor_MetadataEntry$json],
};

@$core.Deprecated('Use vendorDescriptor instead')
const Vendor_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Vendor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List vendorDescriptor = $convert.base64Decode(
    'CgZWZW5kb3ISDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSEgoEc2x1ZxgDIA'
    'EoCVIEc2x1ZxJICgx2ZXJpZmljYXRpb24YBCABKA4yJC5tYXJrZXRwbGFjZV9jb3JlLlZlcmlm'
    'aWNhdGlvblN0YXR1c1IMdmVyaWZpY2F0aW9uEiEKDGlkZW50aXR5X2RvYxgFIAEoCVILaWRlbn'
    'RpdHlEb2MSMwoHY29udGFjdBgGIAEoCzIZLm1hcmtldHBsYWNlX2NvcmUuQ29udGFjdFIHY29u'
    'dGFjdBIvCgNnZW8YByABKAsyHS5tYXJrZXRwbGFjZV9jb3JlLkdlb0xvY2F0aW9uUgNnZW8SQg'
    'oIbWV0YWRhdGEYCCADKAsyJi5tYXJrZXRwbGFjZV9jb3JlLlZlbmRvci5NZXRhZGF0YUVudHJ5'
    'UghtZXRhZGF0YRIdCgpjcmVhdGVkX2F0GAkgASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdB'
    'gKIAEoCVIJdXBkYXRlZEF0GjsKDU1ldGFkYXRhRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoF'
    'dmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use vendorProfileDescriptor instead')
const VendorProfile$json = {
  '1': 'VendorProfile',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'slug', '3': 3, '4': 1, '5': 9, '10': 'slug'},
    {
      '1': 'verification',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.marketplace_core.VerificationStatus',
      '10': 'verification'
    },
    {
      '1': 'geo',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.GeoLocation',
      '10': 'geo'
    },
    {
      '1': 'reputation',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.ReputationScore',
      '10': 'reputation'
    },
    {'1': 'product_count', '3': 7, '4': 1, '5': 5, '10': 'productCount'},
    {'1': 'member_since', '3': 8, '4': 1, '5': 9, '10': 'memberSince'},
  ],
};

/// Descriptor for `VendorProfile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List vendorProfileDescriptor = $convert.base64Decode(
    'Cg1WZW5kb3JQcm9maWxlEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhIKBH'
    'NsdWcYAyABKAlSBHNsdWcSSAoMdmVyaWZpY2F0aW9uGAQgASgOMiQubWFya2V0cGxhY2VfY29y'
    'ZS5WZXJpZmljYXRpb25TdGF0dXNSDHZlcmlmaWNhdGlvbhIvCgNnZW8YBSABKAsyHS5tYXJrZX'
    'RwbGFjZV9jb3JlLkdlb0xvY2F0aW9uUgNnZW8SQQoKcmVwdXRhdGlvbhgGIAEoCzIhLm1hcmtl'
    'dHBsYWNlX2NvcmUuUmVwdXRhdGlvblNjb3JlUgpyZXB1dGF0aW9uEiMKDXByb2R1Y3RfY291bn'
    'QYByABKAVSDHByb2R1Y3RDb3VudBIhCgxtZW1iZXJfc2luY2UYCCABKAlSC21lbWJlclNpbmNl');

@$core.Deprecated('Use storefrontDescriptor instead')
const Storefront$json = {
  '1': 'Storefront',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'vendor_id', '3': 2, '4': 1, '5': 9, '10': 'vendorId'},
    {'1': 'slug', '3': 3, '4': 1, '5': 9, '10': 'slug'},
    {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'logo',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.MediaAsset',
      '10': 'logo'
    },
    {
      '1': 'banner',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.MediaAsset',
      '10': 'banner'
    },
    {
      '1': 'theme',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.Storefront.ThemeEntry',
      '10': 'theme'
    },
    {'1': 'is_public', '3': 9, '4': 1, '5': 8, '10': 'isPublic'},
    {'1': 'custom_domain', '3': 10, '4': 1, '5': 9, '10': 'customDomain'},
    {
      '1': 'seo',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.SEO',
      '10': 'seo'
    },
    {'1': 'created_at', '3': 12, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 13, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
  '3': [Storefront_ThemeEntry$json],
};

@$core.Deprecated('Use storefrontDescriptor instead')
const Storefront_ThemeEntry$json = {
  '1': 'ThemeEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Storefront`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storefrontDescriptor = $convert.base64Decode(
    'CgpTdG9yZWZyb250Eg4KAmlkGAEgASgJUgJpZBIbCgl2ZW5kb3JfaWQYAiABKAlSCHZlbmRvck'
    'lkEhIKBHNsdWcYAyABKAlSBHNsdWcSEgoEbmFtZRgEIAEoCVIEbmFtZRIgCgtkZXNjcmlwdGlv'
    'bhgFIAEoCVILZGVzY3JpcHRpb24SMAoEbG9nbxgGIAEoCzIcLm1hcmtldHBsYWNlX2NvcmUuTW'
    'VkaWFBc3NldFIEbG9nbxI0CgZiYW5uZXIYByABKAsyHC5tYXJrZXRwbGFjZV9jb3JlLk1lZGlh'
    'QXNzZXRSBmJhbm5lchI9CgV0aGVtZRgIIAMoCzInLm1hcmtldHBsYWNlX2NvcmUuU3RvcmVmcm'
    '9udC5UaGVtZUVudHJ5UgV0aGVtZRIbCglpc19wdWJsaWMYCSABKAhSCGlzUHVibGljEiMKDWN1'
    'c3RvbV9kb21haW4YCiABKAlSDGN1c3RvbURvbWFpbhInCgNzZW8YCyABKAsyFS5tYXJrZXRwbG'
    'FjZV9jb3JlLlNFT1IDc2VvEh0KCmNyZWF0ZWRfYXQYDCABKAlSCWNyZWF0ZWRBdBIdCgp1cGRh'
    'dGVkX2F0GA0gASgJUgl1cGRhdGVkQXQaOAoKVGhlbWVFbnRyeRIQCgNrZXkYASABKAlSA2tleR'
    'IUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use mediaAssetDescriptor instead')
const MediaAsset$json = {
  '1': 'MediaAsset',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'owner_type',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.marketplace_core.MediaOwnerType',
      '10': 'ownerType'
    },
    {'1': 'owner_id', '3': 3, '4': 1, '5': 9, '10': 'ownerId'},
    {
      '1': 'type',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.marketplace_core.MediaType',
      '10': 'type'
    },
    {'1': 'url', '3': 5, '4': 1, '5': 9, '10': 'url'},
    {'1': 'alt_text', '3': 6, '4': 1, '5': 9, '10': 'altText'},
    {'1': 'width', '3': 7, '4': 1, '5': 5, '10': 'width'},
    {'1': 'height', '3': 8, '4': 1, '5': 5, '10': 'height'},
    {'1': 'duration_seconds', '3': 9, '4': 1, '5': 5, '10': 'durationSeconds'},
    {'1': 'size_bytes', '3': 10, '4': 1, '5': 3, '10': 'sizeBytes'},
    {'1': 'mime_type', '3': 11, '4': 1, '5': 9, '10': 'mimeType'},
    {'1': 'created_at', '3': 12, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `MediaAsset`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaAssetDescriptor = $convert.base64Decode(
    'CgpNZWRpYUFzc2V0Eg4KAmlkGAEgASgJUgJpZBI/Cgpvd25lcl90eXBlGAIgASgOMiAubWFya2'
    'V0cGxhY2VfY29yZS5NZWRpYU93bmVyVHlwZVIJb3duZXJUeXBlEhkKCG93bmVyX2lkGAMgASgJ'
    'Ugdvd25lcklkEi8KBHR5cGUYBCABKA4yGy5tYXJrZXRwbGFjZV9jb3JlLk1lZGlhVHlwZVIEdH'
    'lwZRIQCgN1cmwYBSABKAlSA3VybBIZCghhbHRfdGV4dBgGIAEoCVIHYWx0VGV4dBIUCgV3aWR0'
    'aBgHIAEoBVIFd2lkdGgSFgoGaGVpZ2h0GAggASgFUgZoZWlnaHQSKQoQZHVyYXRpb25fc2Vjb2'
    '5kcxgJIAEoBVIPZHVyYXRpb25TZWNvbmRzEh0KCnNpemVfYnl0ZXMYCiABKANSCXNpemVCeXRl'
    'cxIbCgltaW1lX3R5cGUYCyABKAlSCG1pbWVUeXBlEh0KCmNyZWF0ZWRfYXQYDCABKAlSCWNyZW'
    'F0ZWRBdA==');

@$core.Deprecated('Use attributeSchemaDescriptor instead')
const AttributeSchema$json = {
  '1': 'AttributeSchema',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'domain', '3': 2, '4': 1, '5': 9, '10': 'domain'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'version', '3': 4, '4': 1, '5': 5, '10': 'version'},
    {'1': 'json_schema', '3': 5, '4': 1, '5': 9, '10': 'jsonSchema'},
    {'1': 'required_fields', '3': 6, '4': 3, '5': 9, '10': 'requiredFields'},
    {'1': 'ui_hints', '3': 7, '4': 1, '5': 9, '10': 'uiHints'},
    {
      '1': 'fulfillment_rules',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.FulfillmentRules',
      '10': 'fulfillmentRules'
    },
    {
      '1': 'inventory_rules',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.InventoryRules',
      '10': 'inventoryRules'
    },
    {
      '1': 'availability_rules',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.AvailabilityRules',
      '10': 'availabilityRules'
    },
    {'1': 'created_at', '3': 11, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 12, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `AttributeSchema`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List attributeSchemaDescriptor = $convert.base64Decode(
    'Cg9BdHRyaWJ1dGVTY2hlbWESDgoCaWQYASABKAlSAmlkEhYKBmRvbWFpbhgCIAEoCVIGZG9tYW'
    'luEhIKBG5hbWUYAyABKAlSBG5hbWUSGAoHdmVyc2lvbhgEIAEoBVIHdmVyc2lvbhIfCgtqc29u'
    'X3NjaGVtYRgFIAEoCVIKanNvblNjaGVtYRInCg9yZXF1aXJlZF9maWVsZHMYBiADKAlSDnJlcX'
    'VpcmVkRmllbGRzEhkKCHVpX2hpbnRzGAcgASgJUgd1aUhpbnRzEk8KEWZ1bGZpbGxtZW50X3J1'
    'bGVzGAggASgLMiIubWFya2V0cGxhY2VfY29yZS5GdWxmaWxsbWVudFJ1bGVzUhBmdWxmaWxsbW'
    'VudFJ1bGVzEkkKD2ludmVudG9yeV9ydWxlcxgJIAEoCzIgLm1hcmtldHBsYWNlX2NvcmUuSW52'
    'ZW50b3J5UnVsZXNSDmludmVudG9yeVJ1bGVzElIKEmF2YWlsYWJpbGl0eV9ydWxlcxgKIAEoCz'
    'IjLm1hcmtldHBsYWNlX2NvcmUuQXZhaWxhYmlsaXR5UnVsZXNSEWF2YWlsYWJpbGl0eVJ1bGVz'
    'Eh0KCmNyZWF0ZWRfYXQYCyABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GAwgASgJUgl1cG'
    'RhdGVkQXQ=');

@$core.Deprecated('Use fulfillmentRulesDescriptor instead')
const FulfillmentRules$json = {
  '1': 'FulfillmentRules',
  '2': [
    {
      '1': 'allowed',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.FulfillmentTypeSet',
      '10': 'allowed'
    },
    {
      '1': 'forbidden',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.FulfillmentTypeSet',
      '10': 'forbidden'
    },
    {
      '1': 'defaults',
      '3': 3,
      '4': 3,
      '5': 14,
      '6': '.marketplace_core.FulfillmentType',
      '10': 'defaults'
    },
  ],
};

/// Descriptor for `FulfillmentRules`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fulfillmentRulesDescriptor = $convert.base64Decode(
    'ChBGdWxmaWxsbWVudFJ1bGVzEj4KB2FsbG93ZWQYASADKAsyJC5tYXJrZXRwbGFjZV9jb3JlLk'
    'Z1bGZpbGxtZW50VHlwZVNldFIHYWxsb3dlZBJCCglmb3JiaWRkZW4YAiADKAsyJC5tYXJrZXRw'
    'bGFjZV9jb3JlLkZ1bGZpbGxtZW50VHlwZVNldFIJZm9yYmlkZGVuEj0KCGRlZmF1bHRzGAMgAy'
    'gOMiEubWFya2V0cGxhY2VfY29yZS5GdWxmaWxsbWVudFR5cGVSCGRlZmF1bHRz');

@$core.Deprecated('Use fulfillmentTypeSetDescriptor instead')
const FulfillmentTypeSet$json = {
  '1': 'FulfillmentTypeSet',
  '2': [
    {
      '1': 'types',
      '3': 1,
      '4': 3,
      '5': 14,
      '6': '.marketplace_core.FulfillmentType',
      '10': 'types'
    },
  ],
};

/// Descriptor for `FulfillmentTypeSet`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fulfillmentTypeSetDescriptor = $convert.base64Decode(
    'ChJGdWxmaWxsbWVudFR5cGVTZXQSNwoFdHlwZXMYASADKA4yIS5tYXJrZXRwbGFjZV9jb3JlLk'
    'Z1bGZpbGxtZW50VHlwZVIFdHlwZXM=');

@$core.Deprecated('Use inventoryRulesDescriptor instead')
const InventoryRules$json = {
  '1': 'InventoryRules',
  '2': [
    {
      '1': 'allowed_policies',
      '3': 1,
      '4': 3,
      '5': 14,
      '6': '.marketplace_core.InventoryPolicy',
      '10': 'allowedPolicies'
    },
    {
      '1': 'default_policy',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.marketplace_core.InventoryPolicy',
      '10': 'defaultPolicy'
    },
  ],
};

/// Descriptor for `InventoryRules`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inventoryRulesDescriptor = $convert.base64Decode(
    'Cg5JbnZlbnRvcnlSdWxlcxJMChBhbGxvd2VkX3BvbGljaWVzGAEgAygOMiEubWFya2V0cGxhY2'
    'VfY29yZS5JbnZlbnRvcnlQb2xpY3lSD2FsbG93ZWRQb2xpY2llcxJICg5kZWZhdWx0X3BvbGlj'
    'eRgCIAEoDjIhLm1hcmtldHBsYWNlX2NvcmUuSW52ZW50b3J5UG9saWN5Ug1kZWZhdWx0UG9saW'
    'N5');

@$core.Deprecated('Use availabilityRulesDescriptor instead')
const AvailabilityRules$json = {
  '1': 'AvailabilityRules',
  '2': [
    {
      '1': 'allowed_types',
      '3': 1,
      '4': 3,
      '5': 14,
      '6': '.marketplace_core.AvailabilityType',
      '10': 'allowedTypes'
    },
    {'1': 'required', '3': 2, '4': 1, '5': 8, '10': 'required'},
  ],
};

/// Descriptor for `AvailabilityRules`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List availabilityRulesDescriptor = $convert.base64Decode(
    'ChFBdmFpbGFiaWxpdHlSdWxlcxJHCg1hbGxvd2VkX3R5cGVzGAEgAygOMiIubWFya2V0cGxhY2'
    'VfY29yZS5BdmFpbGFiaWxpdHlUeXBlUgxhbGxvd2VkVHlwZXMSGgoIcmVxdWlyZWQYAiABKAhS'
    'CHJlcXVpcmVk');

@$core.Deprecated('Use moneyDescriptor instead')
const Money$json = {
  '1': 'Money',
  '2': [
    {'1': 'amount', '3': 1, '4': 1, '5': 9, '10': 'amount'},
    {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `Money`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moneyDescriptor = $convert.base64Decode(
    'CgVNb25leRIWCgZhbW91bnQYASABKAlSBmFtb3VudBIaCghjdXJyZW5jeRgCIAEoCVIIY3Vycm'
    'VuY3k=');

@$core.Deprecated('Use geoLocationDescriptor instead')
const GeoLocation$json = {
  '1': 'GeoLocation',
  '2': [
    {'1': 'lat', '3': 1, '4': 1, '5': 1, '10': 'lat'},
    {'1': 'lng', '3': 2, '4': 1, '5': 1, '10': 'lng'},
    {'1': 'address', '3': 3, '4': 1, '5': 9, '10': 'address'},
    {'1': 'city', '3': 4, '4': 1, '5': 9, '10': 'city'},
    {'1': 'state', '3': 5, '4': 1, '5': 9, '10': 'state'},
    {'1': 'country', '3': 6, '4': 1, '5': 9, '10': 'country'},
    {'1': 'postal_code', '3': 7, '4': 1, '5': 9, '10': 'postalCode'},
  ],
};

/// Descriptor for `GeoLocation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List geoLocationDescriptor = $convert.base64Decode(
    'CgtHZW9Mb2NhdGlvbhIQCgNsYXQYASABKAFSA2xhdBIQCgNsbmcYAiABKAFSA2xuZxIYCgdhZG'
    'RyZXNzGAMgASgJUgdhZGRyZXNzEhIKBGNpdHkYBCABKAlSBGNpdHkSFAoFc3RhdGUYBSABKAlS'
    'BXN0YXRlEhgKB2NvdW50cnkYBiABKAlSB2NvdW50cnkSHwoLcG9zdGFsX2NvZGUYByABKAlSCn'
    'Bvc3RhbENvZGU=');

@$core.Deprecated('Use sEODescriptor instead')
const SEO$json = {
  '1': 'SEO',
  '2': [
    {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {'1': 'og_image', '3': 3, '4': 1, '5': 9, '10': 'ogImage'},
    {'1': 'canonical_url', '3': 4, '4': 1, '5': 9, '10': 'canonicalUrl'},
  ],
};

/// Descriptor for `SEO`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sEODescriptor = $convert.base64Decode(
    'CgNTRU8SFAoFdGl0bGUYASABKAlSBXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAIgASgJUgtkZXNjcm'
    'lwdGlvbhIZCghvZ19pbWFnZRgDIAEoCVIHb2dJbWFnZRIjCg1jYW5vbmljYWxfdXJsGAQgASgJ'
    'UgxjYW5vbmljYWxVcmw=');

@$core.Deprecated('Use contactDescriptor instead')
const Contact$json = {
  '1': 'Contact',
  '2': [
    {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    {'1': 'whatsapp', '3': 3, '4': 1, '5': 9, '10': 'whatsapp'},
  ],
};

/// Descriptor for `Contact`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contactDescriptor = $convert.base64Decode(
    'CgdDb250YWN0EhQKBXBob25lGAEgASgJUgVwaG9uZRIUCgVlbWFpbBgCIAEoCVIFZW1haWwSGg'
    'oId2hhdHNhcHAYAyABKAlSCHdoYXRzYXBw');

@$core.Deprecated('Use optionDescriptor instead')
const Option$json = {
  '1': 'Option',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
};

/// Descriptor for `Option`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List optionDescriptor = $convert.base64Decode(
    'CgZPcHRpb24SEgoEbmFtZRgBIAEoCVIEbmFtZRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU=');

@$core.Deprecated('Use inventoryInfoDescriptor instead')
const InventoryInfo$json = {
  '1': 'InventoryInfo',
  '2': [
    {'1': 'quantity', '3': 1, '4': 1, '5': 5, '10': 'quantity'},
    {'1': 'reserved', '3': 2, '4': 1, '5': 5, '10': 'reserved'},
    {'1': 'available', '3': 3, '4': 1, '5': 5, '10': 'available'},
  ],
};

/// Descriptor for `InventoryInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inventoryInfoDescriptor = $convert.base64Decode(
    'Cg1JbnZlbnRvcnlJbmZvEhoKCHF1YW50aXR5GAEgASgFUghxdWFudGl0eRIaCghyZXNlcnZlZB'
    'gCIAEoBVIIcmVzZXJ2ZWQSHAoJYXZhaWxhYmxlGAMgASgFUglhdmFpbGFibGU=');

@$core.Deprecated('Use availabilityRuleDescriptor instead')
const AvailabilityRule$json = {
  '1': 'AvailabilityRule',
  '2': [
    {
      '1': 'type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.marketplace_core.AvailabilityType',
      '10': 'type'
    },
    {
      '1': 'schedule',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.TimeSlot',
      '10': 'schedule'
    },
    {'1': 'start_date', '3': 3, '4': 1, '5': 9, '10': 'startDate'},
    {'1': 'end_date', '3': 4, '4': 1, '5': 9, '10': 'endDate'},
    {'1': 'expiry_date', '3': 5, '4': 1, '5': 9, '10': 'expiryDate'},
    {'1': 'shelf_life_days', '3': 6, '4': 1, '5': 5, '10': 'shelfLifeDays'},
    {'1': 'best_before', '3': 7, '4': 1, '5': 9, '10': 'bestBefore'},
    {
      '1': 'seasons',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.Season',
      '10': 'seasons'
    },
    {'1': 'blackout_dates', '3': 9, '4': 3, '5': 9, '10': 'blackoutDates'},
    {'1': 'lead_time_hours', '3': 10, '4': 1, '5': 5, '10': 'leadTimeHours'},
  ],
};

/// Descriptor for `AvailabilityRule`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List availabilityRuleDescriptor = $convert.base64Decode(
    'ChBBdmFpbGFiaWxpdHlSdWxlEjYKBHR5cGUYASABKA4yIi5tYXJrZXRwbGFjZV9jb3JlLkF2YW'
    'lsYWJpbGl0eVR5cGVSBHR5cGUSNgoIc2NoZWR1bGUYAiADKAsyGi5tYXJrZXRwbGFjZV9jb3Jl'
    'LlRpbWVTbG90UghzY2hlZHVsZRIdCgpzdGFydF9kYXRlGAMgASgJUglzdGFydERhdGUSGQoIZW'
    '5kX2RhdGUYBCABKAlSB2VuZERhdGUSHwoLZXhwaXJ5X2RhdGUYBSABKAlSCmV4cGlyeURhdGUS'
    'JgoPc2hlbGZfbGlmZV9kYXlzGAYgASgFUg1zaGVsZkxpZmVEYXlzEh8KC2Jlc3RfYmVmb3JlGA'
    'cgASgJUgpiZXN0QmVmb3JlEjIKB3NlYXNvbnMYCCADKAsyGC5tYXJrZXRwbGFjZV9jb3JlLlNl'
    'YXNvblIHc2Vhc29ucxIlCg5ibGFja291dF9kYXRlcxgJIAMoCVINYmxhY2tvdXREYXRlcxImCg'
    '9sZWFkX3RpbWVfaG91cnMYCiABKAVSDWxlYWRUaW1lSG91cnM=');

@$core.Deprecated('Use timeSlotDescriptor instead')
const TimeSlot$json = {
  '1': 'TimeSlot',
  '2': [
    {'1': 'day_of_week', '3': 1, '4': 1, '5': 5, '10': 'dayOfWeek'},
    {'1': 'start_time', '3': 2, '4': 1, '5': 9, '10': 'startTime'},
    {'1': 'end_time', '3': 3, '4': 1, '5': 9, '10': 'endTime'},
    {'1': 'timezone', '3': 4, '4': 1, '5': 9, '10': 'timezone'},
  ],
};

/// Descriptor for `TimeSlot`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timeSlotDescriptor = $convert.base64Decode(
    'CghUaW1lU2xvdBIeCgtkYXlfb2Zfd2VlaxgBIAEoBVIJZGF5T2ZXZWVrEh0KCnN0YXJ0X3RpbW'
    'UYAiABKAlSCXN0YXJ0VGltZRIZCghlbmRfdGltZRgDIAEoCVIHZW5kVGltZRIaCgh0aW1lem9u'
    'ZRgEIAEoCVIIdGltZXpvbmU=');

@$core.Deprecated('Use seasonDescriptor instead')
const Season$json = {
  '1': 'Season',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'start_month', '3': 2, '4': 1, '5': 5, '10': 'startMonth'},
    {'1': 'end_month', '3': 3, '4': 1, '5': 5, '10': 'endMonth'},
  ],
};

/// Descriptor for `Season`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List seasonDescriptor = $convert.base64Decode(
    'CgZTZWFzb24SEgoEbmFtZRgBIAEoCVIEbmFtZRIfCgtzdGFydF9tb250aBgCIAEoBVIKc3Rhcn'
    'RNb250aBIbCgllbmRfbW9udGgYAyABKAVSCGVuZE1vbnRo');

@$core.Deprecated('Use traceEventDescriptor instead')
const TraceEvent$json = {
  '1': 'TraceEvent',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'product_id', '3': 2, '4': 1, '5': 9, '10': 'productId'},
    {'1': 'event_type', '3': 3, '4': 1, '5': 9, '10': 'eventType'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'from_party', '3': 5, '4': 1, '5': 9, '10': 'fromParty'},
    {'1': 'to_party', '3': 6, '4': 1, '5': 9, '10': 'toParty'},
    {
      '1': 'location',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.GeoLocation',
      '10': 'location'
    },
    {'1': 'timestamp', '3': 8, '4': 1, '5': 9, '10': 'timestamp'},
    {'1': 'record_hash', '3': 9, '4': 1, '5': 9, '10': 'recordHash'},
    {'1': 'previous_hash', '3': 10, '4': 1, '5': 9, '10': 'previousHash'},
    {'1': 'sequence_number', '3': 11, '4': 1, '5': 5, '10': 'sequenceNumber'},
    {
      '1': 'metadata',
      '3': 12,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.TraceEvent.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [TraceEvent_MetadataEntry$json],
};

@$core.Deprecated('Use traceEventDescriptor instead')
const TraceEvent_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `TraceEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List traceEventDescriptor = $convert.base64Decode(
    'CgpUcmFjZUV2ZW50Eg4KAmlkGAEgASgJUgJpZBIdCgpwcm9kdWN0X2lkGAIgASgJUglwcm9kdW'
    'N0SWQSHQoKZXZlbnRfdHlwZRgDIAEoCVIJZXZlbnRUeXBlEiAKC2Rlc2NyaXB0aW9uGAQgASgJ'
    'UgtkZXNjcmlwdGlvbhIdCgpmcm9tX3BhcnR5GAUgASgJUglmcm9tUGFydHkSGQoIdG9fcGFydH'
    'kYBiABKAlSB3RvUGFydHkSOQoIbG9jYXRpb24YByABKAsyHS5tYXJrZXRwbGFjZV9jb3JlLkdl'
    'b0xvY2F0aW9uUghsb2NhdGlvbhIcCgl0aW1lc3RhbXAYCCABKAlSCXRpbWVzdGFtcBIfCgtyZW'
    'NvcmRfaGFzaBgJIAEoCVIKcmVjb3JkSGFzaBIjCg1wcmV2aW91c19oYXNoGAogASgJUgxwcmV2'
    'aW91c0hhc2gSJwoPc2VxdWVuY2VfbnVtYmVyGAsgASgFUg5zZXF1ZW5jZU51bWJlchJGCghtZX'
    'RhZGF0YRgMIAMoCzIqLm1hcmtldHBsYWNlX2NvcmUuVHJhY2VFdmVudC5NZXRhZGF0YUVudHJ5'
    'UghtZXRhZGF0YRo7Cg1NZXRhZGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGA'
    'IgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use traceChainDescriptor instead')
const TraceChain$json = {
  '1': 'TraceChain',
  '2': [
    {'1': 'product_id', '3': 1, '4': 1, '5': 9, '10': 'productId'},
    {
      '1': 'events',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.TraceEvent',
      '10': 'events'
    },
    {
      '1': 'integrity_verified',
      '3': 3,
      '4': 1,
      '5': 8,
      '10': 'integrityVerified'
    },
  ],
};

/// Descriptor for `TraceChain`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List traceChainDescriptor = $convert.base64Decode(
    'CgpUcmFjZUNoYWluEh0KCnByb2R1Y3RfaWQYASABKAlSCXByb2R1Y3RJZBI0CgZldmVudHMYAi'
    'ADKAsyHC5tYXJrZXRwbGFjZV9jb3JlLlRyYWNlRXZlbnRSBmV2ZW50cxItChJpbnRlZ3JpdHlf'
    'dmVyaWZpZWQYAyABKAhSEWludGVncml0eVZlcmlmaWVk');

@$core.Deprecated('Use ratingDescriptor instead')
const Rating$json = {
  '1': 'Rating',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'from_id', '3': 2, '4': 1, '5': 9, '10': 'fromId'},
    {'1': 'to_id', '3': 3, '4': 1, '5': 9, '10': 'toId'},
    {'1': 'product_id', '3': 4, '4': 1, '5': 9, '10': 'productId'},
    {'1': 'transaction_id', '3': 5, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'score', '3': 6, '4': 1, '5': 5, '10': 'score'},
    {'1': 'comment', '3': 7, '4': 1, '5': 9, '10': 'comment'},
    {'1': 'created_at', '3': 8, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `Rating`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ratingDescriptor = $convert.base64Decode(
    'CgZSYXRpbmcSDgoCaWQYASABKAlSAmlkEhcKB2Zyb21faWQYAiABKAlSBmZyb21JZBITCgV0b1'
    '9pZBgDIAEoCVIEdG9JZBIdCgpwcm9kdWN0X2lkGAQgASgJUglwcm9kdWN0SWQSJQoOdHJhbnNh'
    'Y3Rpb25faWQYBSABKAlSDXRyYW5zYWN0aW9uSWQSFAoFc2NvcmUYBiABKAVSBXNjb3JlEhgKB2'
    'NvbW1lbnQYByABKAlSB2NvbW1lbnQSHQoKY3JlYXRlZF9hdBgIIAEoCVIJY3JlYXRlZEF0');

@$core.Deprecated('Use reputationScoreDescriptor instead')
const ReputationScore$json = {
  '1': 'ReputationScore',
  '2': [
    {'1': 'entity_id', '3': 1, '4': 1, '5': 9, '10': 'entityId'},
    {'1': 'average_score', '3': 2, '4': 1, '5': 1, '10': 'averageScore'},
    {'1': 'total_ratings', '3': 3, '4': 1, '5': 5, '10': 'totalRatings'},
    {
      '1': 'score_distribution',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.ReputationScore.ScoreDistributionEntry',
      '10': 'scoreDistribution'
    },
    {'1': 'last_updated', '3': 5, '4': 1, '5': 9, '10': 'lastUpdated'},
  ],
  '3': [ReputationScore_ScoreDistributionEntry$json],
};

@$core.Deprecated('Use reputationScoreDescriptor instead')
const ReputationScore_ScoreDistributionEntry$json = {
  '1': 'ScoreDistributionEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 5, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ReputationScore`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reputationScoreDescriptor = $convert.base64Decode(
    'Cg9SZXB1dGF0aW9uU2NvcmUSGwoJZW50aXR5X2lkGAEgASgJUghlbnRpdHlJZBIjCg1hdmVyYW'
    'dlX3Njb3JlGAIgASgBUgxhdmVyYWdlU2NvcmUSIwoNdG90YWxfcmF0aW5ncxgDIAEoBVIMdG90'
    'YWxSYXRpbmdzEmcKEnNjb3JlX2Rpc3RyaWJ1dGlvbhgEIAMoCzI4Lm1hcmtldHBsYWNlX2Nvcm'
    'UuUmVwdXRhdGlvblNjb3JlLlNjb3JlRGlzdHJpYnV0aW9uRW50cnlSEXNjb3JlRGlzdHJpYnV0'
    'aW9uEiEKDGxhc3RfdXBkYXRlZBgFIAEoCVILbGFzdFVwZGF0ZWQaRAoWU2NvcmVEaXN0cmlidX'
    'Rpb25FbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoBVIFdmFsdWU6AjgB');

@$core.Deprecated('Use reviewHistoryDescriptor instead')
const ReviewHistory$json = {
  '1': 'ReviewHistory',
  '2': [
    {'1': 'entity_id', '3': 1, '4': 1, '5': 9, '10': 'entityId'},
    {
      '1': 'ratings',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.Rating',
      '10': 'ratings'
    },
    {'1': 'total', '3': 3, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `ReviewHistory`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reviewHistoryDescriptor = $convert.base64Decode(
    'Cg1SZXZpZXdIaXN0b3J5EhsKCWVudGl0eV9pZBgBIAEoCVIIZW50aXR5SWQSMgoHcmF0aW5ncx'
    'gCIAMoCzIYLm1hcmtldHBsYWNlX2NvcmUuUmF0aW5nUgdyYXRpbmdzEhQKBXRvdGFsGAMgASgF'
    'UgV0b3RhbA==');

@$core.Deprecated('Use createProductRequestDescriptor instead')
const CreateProductRequest$json = {
  '1': 'CreateProductRequest',
  '2': [
    {'1': 'vendor_id', '3': 1, '4': 1, '5': 9, '10': 'vendorId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'product_type', '3': 4, '4': 1, '5': 9, '10': 'productType'},
    {'1': 'tags', '3': 5, '4': 3, '5': 9, '10': 'tags'},
    {'1': 'schema_ref', '3': 6, '4': 1, '5': 9, '10': 'schemaRef'},
    {
      '1': 'attributes',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.CreateProductRequest.AttributesEntry',
      '10': 'attributes'
    },
    {
      '1': 'geo',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.GeoLocation',
      '10': 'geo'
    },
    {
      '1': 'seo',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.SEO',
      '10': 'seo'
    },
  ],
  '3': [CreateProductRequest_AttributesEntry$json],
};

@$core.Deprecated('Use createProductRequestDescriptor instead')
const CreateProductRequest_AttributesEntry$json = {
  '1': 'AttributesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `CreateProductRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createProductRequestDescriptor = $convert.base64Decode(
    'ChRDcmVhdGVQcm9kdWN0UmVxdWVzdBIbCgl2ZW5kb3JfaWQYASABKAlSCHZlbmRvcklkEhQKBX'
    'RpdGxlGAIgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SIQoM'
    'cHJvZHVjdF90eXBlGAQgASgJUgtwcm9kdWN0VHlwZRISCgR0YWdzGAUgAygJUgR0YWdzEh0KCn'
    'NjaGVtYV9yZWYYBiABKAlSCXNjaGVtYVJlZhJWCgphdHRyaWJ1dGVzGAcgAygLMjYubWFya2V0'
    'cGxhY2VfY29yZS5DcmVhdGVQcm9kdWN0UmVxdWVzdC5BdHRyaWJ1dGVzRW50cnlSCmF0dHJpYn'
    'V0ZXMSLwoDZ2VvGAggASgLMh0ubWFya2V0cGxhY2VfY29yZS5HZW9Mb2NhdGlvblIDZ2VvEicK'
    'A3NlbxgJIAEoCzIVLm1hcmtldHBsYWNlX2NvcmUuU0VPUgNzZW8aPQoPQXR0cmlidXRlc0VudH'
    'J5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use updateProductRequestDescriptor instead')
const UpdateProductRequest$json = {
  '1': 'UpdateProductRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'tags', '3': 4, '4': 3, '5': 9, '10': 'tags'},
    {
      '1': 'attributes',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.UpdateProductRequest.AttributesEntry',
      '10': 'attributes'
    },
    {
      '1': 'geo',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.GeoLocation',
      '10': 'geo'
    },
    {
      '1': 'seo',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.SEO',
      '10': 'seo'
    },
    {
      '1': 'status',
      '3': 8,
      '4': 1,
      '5': 14,
      '6': '.marketplace_core.ProductStatus',
      '10': 'status'
    },
  ],
  '3': [UpdateProductRequest_AttributesEntry$json],
};

@$core.Deprecated('Use updateProductRequestDescriptor instead')
const UpdateProductRequest_AttributesEntry$json = {
  '1': 'AttributesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `UpdateProductRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateProductRequestDescriptor = $convert.base64Decode(
    'ChRVcGRhdGVQcm9kdWN0UmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSFAoFdGl0bGUYAiABKAlSBX'
    'RpdGxlEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhISCgR0YWdzGAQgAygJUgR0'
    'YWdzElYKCmF0dHJpYnV0ZXMYBSADKAsyNi5tYXJrZXRwbGFjZV9jb3JlLlVwZGF0ZVByb2R1Y3'
    'RSZXF1ZXN0LkF0dHJpYnV0ZXNFbnRyeVIKYXR0cmlidXRlcxIvCgNnZW8YBiABKAsyHS5tYXJr'
    'ZXRwbGFjZV9jb3JlLkdlb0xvY2F0aW9uUgNnZW8SJwoDc2VvGAcgASgLMhUubWFya2V0cGxhY2'
    'VfY29yZS5TRU9SA3NlbxI3CgZzdGF0dXMYCCABKA4yHy5tYXJrZXRwbGFjZV9jb3JlLlByb2R1'
    'Y3RTdGF0dXNSBnN0YXR1cxo9Cg9BdHRyaWJ1dGVzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFA'
    'oFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use archiveProductRequestDescriptor instead')
const ArchiveProductRequest$json = {
  '1': 'ArchiveProductRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `ArchiveProductRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List archiveProductRequestDescriptor = $convert
    .base64Decode('ChVBcmNoaXZlUHJvZHVjdFJlcXVlc3QSDgoCaWQYASABKAlSAmlk');

@$core.Deprecated('Use getProductRequestDescriptor instead')
const GetProductRequest$json = {
  '1': 'GetProductRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'slug', '3': 2, '4': 1, '5': 9, '10': 'slug'},
  ],
};

/// Descriptor for `GetProductRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getProductRequestDescriptor = $convert.base64Decode(
    'ChFHZXRQcm9kdWN0UmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSEgoEc2x1ZxgCIAEoCVIEc2x1Zw'
    '==');

@$core.Deprecated('Use listProductsRequestDescriptor instead')
const ListProductsRequest$json = {
  '1': 'ListProductsRequest',
  '2': [
    {'1': 'vendor_id', '3': 1, '4': 1, '5': 9, '10': 'vendorId'},
    {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.marketplace_core.ProductStatus',
      '10': 'status'
    },
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'cursor', '3': 4, '4': 1, '5': 9, '10': 'cursor'},
  ],
};

/// Descriptor for `ListProductsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listProductsRequestDescriptor = $convert.base64Decode(
    'ChNMaXN0UHJvZHVjdHNSZXF1ZXN0EhsKCXZlbmRvcl9pZBgBIAEoCVIIdmVuZG9ySWQSNwoGc3'
    'RhdHVzGAIgASgOMh8ubWFya2V0cGxhY2VfY29yZS5Qcm9kdWN0U3RhdHVzUgZzdGF0dXMSFAoF'
    'bGltaXQYAyABKAVSBWxpbWl0EhYKBmN1cnNvchgEIAEoCVIGY3Vyc29y');

@$core.Deprecated('Use productPageDescriptor instead')
const ProductPage$json = {
  '1': 'ProductPage',
  '2': [
    {
      '1': 'products',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.Product',
      '10': 'products'
    },
    {'1': 'next_cursor', '3': 2, '4': 1, '5': 9, '10': 'nextCursor'},
    {'1': 'total', '3': 3, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `ProductPage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List productPageDescriptor = $convert.base64Decode(
    'CgtQcm9kdWN0UGFnZRI1Cghwcm9kdWN0cxgBIAMoCzIZLm1hcmtldHBsYWNlX2NvcmUuUHJvZH'
    'VjdFIIcHJvZHVjdHMSHwoLbmV4dF9jdXJzb3IYAiABKAlSCm5leHRDdXJzb3ISFAoFdG90YWwY'
    'AyABKAVSBXRvdGFs');

@$core.Deprecated('Use createVariantRequestDescriptor instead')
const CreateVariantRequest$json = {
  '1': 'CreateVariantRequest',
  '2': [
    {'1': 'product_id', '3': 1, '4': 1, '5': 9, '10': 'productId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'sku', '3': 3, '4': 1, '5': 9, '10': 'sku'},
    {
      '1': 'price',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.Money',
      '10': 'price'
    },
    {
      '1': 'compare_at_price',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.Money',
      '10': 'compareAtPrice'
    },
    {
      '1': 'options',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.Option',
      '10': 'options'
    },
    {
      '1': 'inventory_policy',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.marketplace_core.InventoryPolicy',
      '10': 'inventoryPolicy'
    },
    {
      '1': 'fulfillment_types',
      '3': 8,
      '4': 3,
      '5': 14,
      '6': '.marketplace_core.FulfillmentType',
      '10': 'fulfillmentTypes'
    },
    {
      '1': 'availability',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.AvailabilityRule',
      '10': 'availability'
    },
    {'1': 'initial_quantity', '3': 10, '4': 1, '5': 5, '10': 'initialQuantity'},
  ],
};

/// Descriptor for `CreateVariantRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createVariantRequestDescriptor = $convert.base64Decode(
    'ChRDcmVhdGVWYXJpYW50UmVxdWVzdBIdCgpwcm9kdWN0X2lkGAEgASgJUglwcm9kdWN0SWQSFA'
    'oFdGl0bGUYAiABKAlSBXRpdGxlEhAKA3NrdRgDIAEoCVIDc2t1Ei0KBXByaWNlGAQgASgLMhcu'
    'bWFya2V0cGxhY2VfY29yZS5Nb25leVIFcHJpY2USQQoQY29tcGFyZV9hdF9wcmljZRgFIAEoCz'
    'IXLm1hcmtldHBsYWNlX2NvcmUuTW9uZXlSDmNvbXBhcmVBdFByaWNlEjIKB29wdGlvbnMYBiAD'
    'KAsyGC5tYXJrZXRwbGFjZV9jb3JlLk9wdGlvblIHb3B0aW9ucxJMChBpbnZlbnRvcnlfcG9saW'
    'N5GAcgASgOMiEubWFya2V0cGxhY2VfY29yZS5JbnZlbnRvcnlQb2xpY3lSD2ludmVudG9yeVBv'
    'bGljeRJOChFmdWxmaWxsbWVudF90eXBlcxgIIAMoDjIhLm1hcmtldHBsYWNlX2NvcmUuRnVsZm'
    'lsbG1lbnRUeXBlUhBmdWxmaWxsbWVudFR5cGVzEkYKDGF2YWlsYWJpbGl0eRgJIAEoCzIiLm1h'
    'cmtldHBsYWNlX2NvcmUuQXZhaWxhYmlsaXR5UnVsZVIMYXZhaWxhYmlsaXR5EikKEGluaXRpYW'
    'xfcXVhbnRpdHkYCiABKAVSD2luaXRpYWxRdWFudGl0eQ==');

@$core.Deprecated('Use updateVariantRequestDescriptor instead')
const UpdateVariantRequest$json = {
  '1': 'UpdateVariantRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {
      '1': 'price',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.Money',
      '10': 'price'
    },
    {
      '1': 'compare_at_price',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.Money',
      '10': 'compareAtPrice'
    },
    {
      '1': 'options',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.Option',
      '10': 'options'
    },
    {
      '1': 'fulfillment_types',
      '3': 6,
      '4': 3,
      '5': 14,
      '6': '.marketplace_core.FulfillmentType',
      '10': 'fulfillmentTypes'
    },
    {
      '1': 'availability',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.AvailabilityRule',
      '10': 'availability'
    },
  ],
};

/// Descriptor for `UpdateVariantRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateVariantRequestDescriptor = $convert.base64Decode(
    'ChRVcGRhdGVWYXJpYW50UmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSFAoFdGl0bGUYAiABKAlSBX'
    'RpdGxlEi0KBXByaWNlGAMgASgLMhcubWFya2V0cGxhY2VfY29yZS5Nb25leVIFcHJpY2USQQoQ'
    'Y29tcGFyZV9hdF9wcmljZRgEIAEoCzIXLm1hcmtldHBsYWNlX2NvcmUuTW9uZXlSDmNvbXBhcm'
    'VBdFByaWNlEjIKB29wdGlvbnMYBSADKAsyGC5tYXJrZXRwbGFjZV9jb3JlLk9wdGlvblIHb3B0'
    'aW9ucxJOChFmdWxmaWxsbWVudF90eXBlcxgGIAMoDjIhLm1hcmtldHBsYWNlX2NvcmUuRnVsZm'
    'lsbG1lbnRUeXBlUhBmdWxmaWxsbWVudFR5cGVzEkYKDGF2YWlsYWJpbGl0eRgHIAEoCzIiLm1h'
    'cmtldHBsYWNlX2NvcmUuQXZhaWxhYmlsaXR5UnVsZVIMYXZhaWxhYmlsaXR5');

@$core.Deprecated('Use deleteVariantRequestDescriptor instead')
const DeleteVariantRequest$json = {
  '1': 'DeleteVariantRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteVariantRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteVariantRequestDescriptor = $convert
    .base64Decode('ChREZWxldGVWYXJpYW50UmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');

@$core.Deprecated('Use bulkCreateVariantsRequestDescriptor instead')
const BulkCreateVariantsRequest$json = {
  '1': 'BulkCreateVariantsRequest',
  '2': [
    {'1': 'product_id', '3': 1, '4': 1, '5': 9, '10': 'productId'},
    {
      '1': 'variants',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.CreateVariantRequest',
      '10': 'variants'
    },
  ],
};

/// Descriptor for `BulkCreateVariantsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bulkCreateVariantsRequestDescriptor = $convert.base64Decode(
    'ChlCdWxrQ3JlYXRlVmFyaWFudHNSZXF1ZXN0Eh0KCnByb2R1Y3RfaWQYASABKAlSCXByb2R1Y3'
    'RJZBJCCgh2YXJpYW50cxgCIAMoCzImLm1hcmtldHBsYWNlX2NvcmUuQ3JlYXRlVmFyaWFudFJl'
    'cXVlc3RSCHZhcmlhbnRz');

@$core.Deprecated('Use bulkVariantsResponseDescriptor instead')
const BulkVariantsResponse$json = {
  '1': 'BulkVariantsResponse',
  '2': [
    {
      '1': 'variants',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.Variant',
      '10': 'variants'
    },
    {
      '1': 'errors',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.UserError',
      '10': 'errors'
    },
  ],
};

/// Descriptor for `BulkVariantsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bulkVariantsResponseDescriptor = $convert.base64Decode(
    'ChRCdWxrVmFyaWFudHNSZXNwb25zZRI1Cgh2YXJpYW50cxgBIAMoCzIZLm1hcmtldHBsYWNlX2'
    'NvcmUuVmFyaWFudFIIdmFyaWFudHMSMwoGZXJyb3JzGAIgAygLMhsubWFya2V0cGxhY2VfY29y'
    'ZS5Vc2VyRXJyb3JSBmVycm9ycw==');

@$core.Deprecated('Use createCollectionRequestDescriptor instead')
const CreateCollectionRequest$json = {
  '1': 'CreateCollectionRequest',
  '2': [
    {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'type',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.marketplace_core.CollectionType',
      '10': 'type'
    },
    {
      '1': 'rules',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.CollectionRule',
      '10': 'rules'
    },
    {
      '1': 'sort_order',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.marketplace_core.SortOrder',
      '10': 'sortOrder'
    },
    {
      '1': 'seo',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.SEO',
      '10': 'seo'
    },
  ],
};

/// Descriptor for `CreateCollectionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createCollectionRequestDescriptor = $convert.base64Decode(
    'ChdDcmVhdGVDb2xsZWN0aW9uUmVxdWVzdBIUCgV0aXRsZRgBIAEoCVIFdGl0bGUSIAoLZGVzY3'
    'JpcHRpb24YAiABKAlSC2Rlc2NyaXB0aW9uEjQKBHR5cGUYAyABKA4yIC5tYXJrZXRwbGFjZV9j'
    'b3JlLkNvbGxlY3Rpb25UeXBlUgR0eXBlEjYKBXJ1bGVzGAQgAygLMiAubWFya2V0cGxhY2VfY2'
    '9yZS5Db2xsZWN0aW9uUnVsZVIFcnVsZXMSOgoKc29ydF9vcmRlchgFIAEoDjIbLm1hcmtldHBs'
    'YWNlX2NvcmUuU29ydE9yZGVyUglzb3J0T3JkZXISJwoDc2VvGAYgASgLMhUubWFya2V0cGxhY2'
    'VfY29yZS5TRU9SA3Nlbw==');

@$core.Deprecated('Use updateCollectionRequestDescriptor instead')
const UpdateCollectionRequest$json = {
  '1': 'UpdateCollectionRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'sort_order',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.marketplace_core.SortOrder',
      '10': 'sortOrder'
    },
    {
      '1': 'seo',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.SEO',
      '10': 'seo'
    },
  ],
};

/// Descriptor for `UpdateCollectionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCollectionRequestDescriptor = $convert.base64Decode(
    'ChdVcGRhdGVDb2xsZWN0aW9uUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSFAoFdGl0bGUYAiABKA'
    'lSBXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhI6Cgpzb3J0X29yZGVy'
    'GAQgASgOMhsubWFya2V0cGxhY2VfY29yZS5Tb3J0T3JkZXJSCXNvcnRPcmRlchInCgNzZW8YBS'
    'ABKAsyFS5tYXJrZXRwbGFjZV9jb3JlLlNFT1IDc2Vv');

@$core.Deprecated('Use deleteCollectionRequestDescriptor instead')
const DeleteCollectionRequest$json = {
  '1': 'DeleteCollectionRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteCollectionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteCollectionRequestDescriptor = $convert
    .base64Decode('ChdEZWxldGVDb2xsZWN0aW9uUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');

@$core.Deprecated('Use collectionProductsRequestDescriptor instead')
const CollectionProductsRequest$json = {
  '1': 'CollectionProductsRequest',
  '2': [
    {'1': 'collection_id', '3': 1, '4': 1, '5': 9, '10': 'collectionId'},
    {'1': 'product_ids', '3': 2, '4': 3, '5': 9, '10': 'productIds'},
  ],
};

/// Descriptor for `CollectionProductsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List collectionProductsRequestDescriptor =
    $convert.base64Decode(
        'ChlDb2xsZWN0aW9uUHJvZHVjdHNSZXF1ZXN0EiMKDWNvbGxlY3Rpb25faWQYASABKAlSDGNvbG'
        'xlY3Rpb25JZBIfCgtwcm9kdWN0X2lkcxgCIAMoCVIKcHJvZHVjdElkcw==');

@$core.Deprecated('Use getCollectionRequestDescriptor instead')
const GetCollectionRequest$json = {
  '1': 'GetCollectionRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'slug', '3': 2, '4': 1, '5': 9, '10': 'slug'},
  ],
};

/// Descriptor for `GetCollectionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCollectionRequestDescriptor = $convert.base64Decode(
    'ChRHZXRDb2xsZWN0aW9uUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSEgoEc2x1ZxgCIAEoCVIEc2'
    'x1Zw==');

@$core.Deprecated('Use collectionPageDescriptor instead')
const CollectionPage$json = {
  '1': 'CollectionPage',
  '2': [
    {
      '1': 'collections',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.Collection',
      '10': 'collections'
    },
    {'1': 'next_cursor', '3': 2, '4': 1, '5': 9, '10': 'nextCursor'},
    {'1': 'total', '3': 3, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `CollectionPage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List collectionPageDescriptor = $convert.base64Decode(
    'Cg5Db2xsZWN0aW9uUGFnZRI+Cgtjb2xsZWN0aW9ucxgBIAMoCzIcLm1hcmtldHBsYWNlX2Nvcm'
    'UuQ29sbGVjdGlvblILY29sbGVjdGlvbnMSHwoLbmV4dF9jdXJzb3IYAiABKAlSCm5leHRDdXJz'
    'b3ISFAoFdG90YWwYAyABKAVSBXRvdGFs');

@$core.Deprecated('Use listCollectionsRequestDescriptor instead')
const ListCollectionsRequest$json = {
  '1': 'ListCollectionsRequest',
  '2': [
    {'1': 'vendor_id', '3': 1, '4': 1, '5': 9, '10': 'vendorId'},
    {
      '1': 'type',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.marketplace_core.CollectionType',
      '10': 'type'
    },
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'cursor', '3': 4, '4': 1, '5': 9, '10': 'cursor'},
  ],
};

/// Descriptor for `ListCollectionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listCollectionsRequestDescriptor = $convert.base64Decode(
    'ChZMaXN0Q29sbGVjdGlvbnNSZXF1ZXN0EhsKCXZlbmRvcl9pZBgBIAEoCVIIdmVuZG9ySWQSNA'
    'oEdHlwZRgCIAEoDjIgLm1hcmtldHBsYWNlX2NvcmUuQ29sbGVjdGlvblR5cGVSBHR5cGUSFAoF'
    'bGltaXQYAyABKAVSBWxpbWl0EhYKBmN1cnNvchgEIAEoCVIGY3Vyc29y');

@$core.Deprecated('Use registerVendorRequestDescriptor instead')
const RegisterVendorRequest$json = {
  '1': 'RegisterVendorRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'contact',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.Contact',
      '10': 'contact'
    },
    {
      '1': 'geo',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.GeoLocation',
      '10': 'geo'
    },
    {
      '1': 'metadata',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.RegisterVendorRequest.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [RegisterVendorRequest_MetadataEntry$json],
};

@$core.Deprecated('Use registerVendorRequestDescriptor instead')
const RegisterVendorRequest_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `RegisterVendorRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerVendorRequestDescriptor = $convert.base64Decode(
    'ChVSZWdpc3RlclZlbmRvclJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZRIzCgdjb250YWN0GA'
    'IgASgLMhkubWFya2V0cGxhY2VfY29yZS5Db250YWN0Ugdjb250YWN0Ei8KA2dlbxgDIAEoCzId'
    'Lm1hcmtldHBsYWNlX2NvcmUuR2VvTG9jYXRpb25SA2dlbxJRCghtZXRhZGF0YRgEIAMoCzI1Lm'
    '1hcmtldHBsYWNlX2NvcmUuUmVnaXN0ZXJWZW5kb3JSZXF1ZXN0Lk1ldGFkYXRhRW50cnlSCG1l'
    'dGFkYXRhGjsKDU1ldGFkYXRhRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKA'
    'lSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use updateVendorRequestDescriptor instead')
const UpdateVendorRequest$json = {
  '1': 'UpdateVendorRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'contact',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.Contact',
      '10': 'contact'
    },
    {
      '1': 'geo',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.GeoLocation',
      '10': 'geo'
    },
  ],
};

/// Descriptor for `UpdateVendorRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateVendorRequestDescriptor = $convert.base64Decode(
    'ChNVcGRhdGVWZW5kb3JSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW'
    '1lEjMKB2NvbnRhY3QYAyABKAsyGS5tYXJrZXRwbGFjZV9jb3JlLkNvbnRhY3RSB2NvbnRhY3QS'
    'LwoDZ2VvGAQgASgLMh0ubWFya2V0cGxhY2VfY29yZS5HZW9Mb2NhdGlvblIDZ2Vv');

@$core.Deprecated('Use verifyVendorRequestDescriptor instead')
const VerifyVendorRequest$json = {
  '1': 'VerifyVendorRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'identity_doc', '3': 2, '4': 1, '5': 9, '10': 'identityDoc'},
    {
      '1': 'verification_method',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'verificationMethod'
    },
  ],
};

/// Descriptor for `VerifyVendorRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyVendorRequestDescriptor = $convert.base64Decode(
    'ChNWZXJpZnlWZW5kb3JSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBIhCgxpZGVudGl0eV9kb2MYAi'
    'ABKAlSC2lkZW50aXR5RG9jEi8KE3ZlcmlmaWNhdGlvbl9tZXRob2QYAyABKAlSEnZlcmlmaWNh'
    'dGlvbk1ldGhvZA==');

@$core.Deprecated('Use getVendorProfileRequestDescriptor instead')
const GetVendorProfileRequest$json = {
  '1': 'GetVendorProfileRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'slug', '3': 2, '4': 1, '5': 9, '10': 'slug'},
  ],
};

/// Descriptor for `GetVendorProfileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVendorProfileRequestDescriptor =
    $convert.base64Decode(
        'ChdHZXRWZW5kb3JQcm9maWxlUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSEgoEc2x1ZxgCIAEoCV'
        'IEc2x1Zw==');

@$core.Deprecated('Use createStorefrontRequestDescriptor instead')
const CreateStorefrontRequest$json = {
  '1': 'CreateStorefrontRequest',
  '2': [
    {'1': 'vendor_id', '3': 1, '4': 1, '5': 9, '10': 'vendorId'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'seo',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.SEO',
      '10': 'seo'
    },
  ],
};

/// Descriptor for `CreateStorefrontRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createStorefrontRequestDescriptor = $convert.base64Decode(
    'ChdDcmVhdGVTdG9yZWZyb250UmVxdWVzdBIbCgl2ZW5kb3JfaWQYASABKAlSCHZlbmRvcklkEh'
    'IKBG5hbWUYAiABKAlSBG5hbWUSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uEicK'
    'A3NlbxgEIAEoCzIVLm1hcmtldHBsYWNlX2NvcmUuU0VPUgNzZW8=');

@$core.Deprecated('Use updateStorefrontRequestDescriptor instead')
const UpdateStorefrontRequest$json = {
  '1': 'UpdateStorefrontRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'theme',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.UpdateStorefrontRequest.ThemeEntry',
      '10': 'theme'
    },
    {'1': 'is_public', '3': 5, '4': 1, '5': 8, '10': 'isPublic'},
    {'1': 'custom_domain', '3': 6, '4': 1, '5': 9, '10': 'customDomain'},
    {
      '1': 'seo',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.SEO',
      '10': 'seo'
    },
  ],
  '3': [UpdateStorefrontRequest_ThemeEntry$json],
};

@$core.Deprecated('Use updateStorefrontRequestDescriptor instead')
const UpdateStorefrontRequest_ThemeEntry$json = {
  '1': 'ThemeEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `UpdateStorefrontRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateStorefrontRequestDescriptor = $convert.base64Decode(
    'ChdVcGRhdGVTdG9yZWZyb250UmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCV'
    'IEbmFtZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SSgoFdGhlbWUYBCADKAsy'
    'NC5tYXJrZXRwbGFjZV9jb3JlLlVwZGF0ZVN0b3JlZnJvbnRSZXF1ZXN0LlRoZW1lRW50cnlSBX'
    'RoZW1lEhsKCWlzX3B1YmxpYxgFIAEoCFIIaXNQdWJsaWMSIwoNY3VzdG9tX2RvbWFpbhgGIAEo'
    'CVIMY3VzdG9tRG9tYWluEicKA3NlbxgHIAEoCzIVLm1hcmtldHBsYWNlX2NvcmUuU0VPUgNzZW'
    '8aOAoKVGhlbWVFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6'
    'AjgB');

@$core.Deprecated('Use getStorefrontRequestDescriptor instead')
const GetStorefrontRequest$json = {
  '1': 'GetStorefrontRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'slug', '3': 2, '4': 1, '5': 9, '10': 'slug'},
  ],
};

/// Descriptor for `GetStorefrontRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStorefrontRequestDescriptor = $convert.base64Decode(
    'ChRHZXRTdG9yZWZyb250UmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSEgoEc2x1ZxgCIAEoCVIEc2'
    'x1Zw==');

@$core.Deprecated('Use uploadMediaRequestDescriptor instead')
const UploadMediaRequest$json = {
  '1': 'UploadMediaRequest',
  '2': [
    {
      '1': 'owner_type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.marketplace_core.MediaOwnerType',
      '10': 'ownerType'
    },
    {'1': 'owner_id', '3': 2, '4': 1, '5': 9, '10': 'ownerId'},
    {
      '1': 'type',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.marketplace_core.MediaType',
      '10': 'type'
    },
    {'1': 'filename', '3': 4, '4': 1, '5': 9, '10': 'filename'},
    {'1': 'alt_text', '3': 5, '4': 1, '5': 9, '10': 'altText'},
    {'1': 'chunk', '3': 6, '4': 1, '5': 12, '10': 'chunk'},
  ],
};

/// Descriptor for `UploadMediaRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadMediaRequestDescriptor = $convert.base64Decode(
    'ChJVcGxvYWRNZWRpYVJlcXVlc3QSPwoKb3duZXJfdHlwZRgBIAEoDjIgLm1hcmtldHBsYWNlX2'
    'NvcmUuTWVkaWFPd25lclR5cGVSCW93bmVyVHlwZRIZCghvd25lcl9pZBgCIAEoCVIHb3duZXJJ'
    'ZBIvCgR0eXBlGAMgASgOMhsubWFya2V0cGxhY2VfY29yZS5NZWRpYVR5cGVSBHR5cGUSGgoIZm'
    'lsZW5hbWUYBCABKAlSCGZpbGVuYW1lEhkKCGFsdF90ZXh0GAUgASgJUgdhbHRUZXh0EhQKBWNo'
    'dW5rGAYgASgMUgVjaHVuaw==');

@$core.Deprecated('Use deleteMediaRequestDescriptor instead')
const DeleteMediaRequest$json = {
  '1': 'DeleteMediaRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteMediaRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteMediaRequestDescriptor =
    $convert.base64Decode('ChJEZWxldGVNZWRpYVJlcXVlc3QSDgoCaWQYASABKAlSAmlk');

@$core.Deprecated('Use browseRequestDescriptor instead')
const BrowseRequest$json = {
  '1': 'BrowseRequest',
  '2': [
    {'1': 'collection_id', '3': 1, '4': 1, '5': 9, '10': 'collectionId'},
    {'1': 'vendor_id', '3': 2, '4': 1, '5': 9, '10': 'vendorId'},
    {
      '1': 'fulfillment_types',
      '3': 3,
      '4': 3,
      '5': 14,
      '6': '.marketplace_core.FulfillmentType',
      '10': 'fulfillmentTypes'
    },
    {
      '1': 'price_min',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.Money',
      '10': 'priceMin'
    },
    {
      '1': 'price_max',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.Money',
      '10': 'priceMax'
    },
    {
      '1': 'near',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.GeoLocation',
      '10': 'near'
    },
    {'1': 'radius_km', '3': 7, '4': 1, '5': 1, '10': 'radiusKm'},
    {'1': 'tags', '3': 8, '4': 3, '5': 9, '10': 'tags'},
    {
      '1': 'sort',
      '3': 9,
      '4': 1,
      '5': 14,
      '6': '.marketplace_core.SortOrder',
      '10': 'sort'
    },
    {'1': 'limit', '3': 10, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'cursor', '3': 11, '4': 1, '5': 9, '10': 'cursor'},
  ],
};

/// Descriptor for `BrowseRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List browseRequestDescriptor = $convert.base64Decode(
    'Cg1Ccm93c2VSZXF1ZXN0EiMKDWNvbGxlY3Rpb25faWQYASABKAlSDGNvbGxlY3Rpb25JZBIbCg'
    'l2ZW5kb3JfaWQYAiABKAlSCHZlbmRvcklkEk4KEWZ1bGZpbGxtZW50X3R5cGVzGAMgAygOMiEu'
    'bWFya2V0cGxhY2VfY29yZS5GdWxmaWxsbWVudFR5cGVSEGZ1bGZpbGxtZW50VHlwZXMSNAoJcH'
    'JpY2VfbWluGAQgASgLMhcubWFya2V0cGxhY2VfY29yZS5Nb25leVIIcHJpY2VNaW4SNAoJcHJp'
    'Y2VfbWF4GAUgASgLMhcubWFya2V0cGxhY2VfY29yZS5Nb25leVIIcHJpY2VNYXgSMQoEbmVhch'
    'gGIAEoCzIdLm1hcmtldHBsYWNlX2NvcmUuR2VvTG9jYXRpb25SBG5lYXISGwoJcmFkaXVzX2tt'
    'GAcgASgBUghyYWRpdXNLbRISCgR0YWdzGAggAygJUgR0YWdzEi8KBHNvcnQYCSABKA4yGy5tYX'
    'JrZXRwbGFjZV9jb3JlLlNvcnRPcmRlclIEc29ydBIUCgVsaW1pdBgKIAEoBVIFbGltaXQSFgoG'
    'Y3Vyc29yGAsgASgJUgZjdXJzb3I=');

@$core.Deprecated('Use searchRequestDescriptor instead')
const SearchRequest$json = {
  '1': 'SearchRequest',
  '2': [
    {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    {'1': 'collection_id', '3': 2, '4': 1, '5': 9, '10': 'collectionId'},
    {
      '1': 'fulfillment_types',
      '3': 3,
      '4': 3,
      '5': 14,
      '6': '.marketplace_core.FulfillmentType',
      '10': 'fulfillmentTypes'
    },
    {
      '1': 'price_min',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.Money',
      '10': 'priceMin'
    },
    {
      '1': 'price_max',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.Money',
      '10': 'priceMax'
    },
    {
      '1': 'near',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.GeoLocation',
      '10': 'near'
    },
    {'1': 'radius_km', '3': 7, '4': 1, '5': 1, '10': 'radiusKm'},
    {'1': 'tags', '3': 8, '4': 3, '5': 9, '10': 'tags'},
    {
      '1': 'attribute_filters',
      '3': 9,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.SearchRequest.AttributeFiltersEntry',
      '10': 'attributeFilters'
    },
    {
      '1': 'sort',
      '3': 10,
      '4': 1,
      '5': 14,
      '6': '.marketplace_core.SortOrder',
      '10': 'sort'
    },
    {'1': 'limit', '3': 11, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'cursor', '3': 12, '4': 1, '5': 9, '10': 'cursor'},
  ],
  '3': [SearchRequest_AttributeFiltersEntry$json],
};

@$core.Deprecated('Use searchRequestDescriptor instead')
const SearchRequest_AttributeFiltersEntry$json = {
  '1': 'AttributeFiltersEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `SearchRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchRequestDescriptor = $convert.base64Decode(
    'Cg1TZWFyY2hSZXF1ZXN0EhQKBXF1ZXJ5GAEgASgJUgVxdWVyeRIjCg1jb2xsZWN0aW9uX2lkGA'
    'IgASgJUgxjb2xsZWN0aW9uSWQSTgoRZnVsZmlsbG1lbnRfdHlwZXMYAyADKA4yIS5tYXJrZXRw'
    'bGFjZV9jb3JlLkZ1bGZpbGxtZW50VHlwZVIQZnVsZmlsbG1lbnRUeXBlcxI0CglwcmljZV9taW'
    '4YBCABKAsyFy5tYXJrZXRwbGFjZV9jb3JlLk1vbmV5UghwcmljZU1pbhI0CglwcmljZV9tYXgY'
    'BSABKAsyFy5tYXJrZXRwbGFjZV9jb3JlLk1vbmV5UghwcmljZU1heBIxCgRuZWFyGAYgASgLMh'
    '0ubWFya2V0cGxhY2VfY29yZS5HZW9Mb2NhdGlvblIEbmVhchIbCglyYWRpdXNfa20YByABKAFS'
    'CHJhZGl1c0ttEhIKBHRhZ3MYCCADKAlSBHRhZ3MSYgoRYXR0cmlidXRlX2ZpbHRlcnMYCSADKA'
    'syNS5tYXJrZXRwbGFjZV9jb3JlLlNlYXJjaFJlcXVlc3QuQXR0cmlidXRlRmlsdGVyc0VudHJ5'
    'UhBhdHRyaWJ1dGVGaWx0ZXJzEi8KBHNvcnQYCiABKA4yGy5tYXJrZXRwbGFjZV9jb3JlLlNvcn'
    'RPcmRlclIEc29ydBIUCgVsaW1pdBgLIAEoBVIFbGltaXQSFgoGY3Vyc29yGAwgASgJUgZjdXJz'
    'b3IaQwoVQXR0cmlidXRlRmlsdGVyc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGA'
    'IgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use registerSchemaRequestDescriptor instead')
const RegisterSchemaRequest$json = {
  '1': 'RegisterSchemaRequest',
  '2': [
    {'1': 'domain', '3': 1, '4': 1, '5': 9, '10': 'domain'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'json_schema', '3': 3, '4': 1, '5': 9, '10': 'jsonSchema'},
    {'1': 'required_fields', '3': 4, '4': 3, '5': 9, '10': 'requiredFields'},
    {'1': 'ui_hints', '3': 5, '4': 1, '5': 9, '10': 'uiHints'},
    {
      '1': 'fulfillment_rules',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.FulfillmentRules',
      '10': 'fulfillmentRules'
    },
    {
      '1': 'inventory_rules',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.InventoryRules',
      '10': 'inventoryRules'
    },
    {
      '1': 'availability_rules',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.AvailabilityRules',
      '10': 'availabilityRules'
    },
  ],
};

/// Descriptor for `RegisterSchemaRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerSchemaRequestDescriptor = $convert.base64Decode(
    'ChVSZWdpc3RlclNjaGVtYVJlcXVlc3QSFgoGZG9tYWluGAEgASgJUgZkb21haW4SEgoEbmFtZR'
    'gCIAEoCVIEbmFtZRIfCgtqc29uX3NjaGVtYRgDIAEoCVIKanNvblNjaGVtYRInCg9yZXF1aXJl'
    'ZF9maWVsZHMYBCADKAlSDnJlcXVpcmVkRmllbGRzEhkKCHVpX2hpbnRzGAUgASgJUgd1aUhpbn'
    'RzEk8KEWZ1bGZpbGxtZW50X3J1bGVzGAYgASgLMiIubWFya2V0cGxhY2VfY29yZS5GdWxmaWxs'
    'bWVudFJ1bGVzUhBmdWxmaWxsbWVudFJ1bGVzEkkKD2ludmVudG9yeV9ydWxlcxgHIAEoCzIgLm'
    '1hcmtldHBsYWNlX2NvcmUuSW52ZW50b3J5UnVsZXNSDmludmVudG9yeVJ1bGVzElIKEmF2YWls'
    'YWJpbGl0eV9ydWxlcxgIIAEoCzIjLm1hcmtldHBsYWNlX2NvcmUuQXZhaWxhYmlsaXR5UnVsZX'
    'NSEWF2YWlsYWJpbGl0eVJ1bGVz');

@$core.Deprecated('Use getSchemaRequestDescriptor instead')
const GetSchemaRequest$json = {
  '1': 'GetSchemaRequest',
  '2': [
    {'1': 'schema_ref', '3': 1, '4': 1, '5': 9, '10': 'schemaRef'},
  ],
};

/// Descriptor for `GetSchemaRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSchemaRequestDescriptor = $convert.base64Decode(
    'ChBHZXRTY2hlbWFSZXF1ZXN0Eh0KCnNjaGVtYV9yZWYYASABKAlSCXNjaGVtYVJlZg==');

@$core.Deprecated('Use listSchemasRequestDescriptor instead')
const ListSchemasRequest$json = {
  '1': 'ListSchemasRequest',
  '2': [
    {'1': 'domain', '3': 1, '4': 1, '5': 9, '10': 'domain'},
  ],
};

/// Descriptor for `ListSchemasRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listSchemasRequestDescriptor =
    $convert.base64Decode(
        'ChJMaXN0U2NoZW1hc1JlcXVlc3QSFgoGZG9tYWluGAEgASgJUgZkb21haW4=');

@$core.Deprecated('Use schemaListDescriptor instead')
const SchemaList$json = {
  '1': 'SchemaList',
  '2': [
    {
      '1': 'schemas',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.AttributeSchema',
      '10': 'schemas'
    },
  ],
};

/// Descriptor for `SchemaList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List schemaListDescriptor = $convert.base64Decode(
    'CgpTY2hlbWFMaXN0EjsKB3NjaGVtYXMYASADKAsyIS5tYXJrZXRwbGFjZV9jb3JlLkF0dHJpYn'
    'V0ZVNjaGVtYVIHc2NoZW1hcw==');

@$core.Deprecated('Use validateAttributesRequestDescriptor instead')
const ValidateAttributesRequest$json = {
  '1': 'ValidateAttributesRequest',
  '2': [
    {'1': 'schema_ref', '3': 1, '4': 1, '5': 9, '10': 'schemaRef'},
    {
      '1': 'attributes',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.ValidateAttributesRequest.AttributesEntry',
      '10': 'attributes'
    },
    {
      '1': 'fulfillment_types',
      '3': 3,
      '4': 3,
      '5': 14,
      '6': '.marketplace_core.FulfillmentType',
      '10': 'fulfillmentTypes'
    },
    {
      '1': 'inventory_policy',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.marketplace_core.InventoryPolicy',
      '10': 'inventoryPolicy'
    },
  ],
  '3': [ValidateAttributesRequest_AttributesEntry$json],
};

@$core.Deprecated('Use validateAttributesRequestDescriptor instead')
const ValidateAttributesRequest_AttributesEntry$json = {
  '1': 'AttributesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ValidateAttributesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateAttributesRequestDescriptor = $convert.base64Decode(
    'ChlWYWxpZGF0ZUF0dHJpYnV0ZXNSZXF1ZXN0Eh0KCnNjaGVtYV9yZWYYASABKAlSCXNjaGVtYV'
    'JlZhJbCgphdHRyaWJ1dGVzGAIgAygLMjsubWFya2V0cGxhY2VfY29yZS5WYWxpZGF0ZUF0dHJp'
    'YnV0ZXNSZXF1ZXN0LkF0dHJpYnV0ZXNFbnRyeVIKYXR0cmlidXRlcxJOChFmdWxmaWxsbWVudF'
    '90eXBlcxgDIAMoDjIhLm1hcmtldHBsYWNlX2NvcmUuRnVsZmlsbG1lbnRUeXBlUhBmdWxmaWxs'
    'bWVudFR5cGVzEkwKEGludmVudG9yeV9wb2xpY3kYBCABKA4yIS5tYXJrZXRwbGFjZV9jb3JlLk'
    'ludmVudG9yeVBvbGljeVIPaW52ZW50b3J5UG9saWN5Gj0KD0F0dHJpYnV0ZXNFbnRyeRIQCgNr'
    'ZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use validationResultDescriptor instead')
const ValidationResult$json = {
  '1': 'ValidationResult',
  '2': [
    {'1': 'valid', '3': 1, '4': 1, '5': 8, '10': 'valid'},
    {
      '1': 'errors',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.UserError',
      '10': 'errors'
    },
  ],
};

/// Descriptor for `ValidationResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validationResultDescriptor = $convert.base64Decode(
    'ChBWYWxpZGF0aW9uUmVzdWx0EhQKBXZhbGlkGAEgASgIUgV2YWxpZBIzCgZlcnJvcnMYAiADKA'
    'syGy5tYXJrZXRwbGFjZV9jb3JlLlVzZXJFcnJvclIGZXJyb3Jz');

@$core.Deprecated('Use confirmTransactionRequestDescriptor instead')
const ConfirmTransactionRequest$json = {
  '1': 'ConfirmTransactionRequest',
  '2': [
    {'1': 'product_id', '3': 1, '4': 1, '5': 9, '10': 'productId'},
    {'1': 'variant_id', '3': 2, '4': 1, '5': 9, '10': 'variantId'},
    {'1': 'buyer_id', '3': 3, '4': 1, '5': 9, '10': 'buyerId'},
    {'1': 'quantity', '3': 4, '4': 1, '5': 5, '10': 'quantity'},
    {
      '1': 'metadata',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.ConfirmTransactionRequest.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [ConfirmTransactionRequest_MetadataEntry$json],
};

@$core.Deprecated('Use confirmTransactionRequestDescriptor instead')
const ConfirmTransactionRequest_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ConfirmTransactionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List confirmTransactionRequestDescriptor = $convert.base64Decode(
    'ChlDb25maXJtVHJhbnNhY3Rpb25SZXF1ZXN0Eh0KCnByb2R1Y3RfaWQYASABKAlSCXByb2R1Y3'
    'RJZBIdCgp2YXJpYW50X2lkGAIgASgJUgl2YXJpYW50SWQSGQoIYnV5ZXJfaWQYAyABKAlSB2J1'
    'eWVySWQSGgoIcXVhbnRpdHkYBCABKAVSCHF1YW50aXR5ElUKCG1ldGFkYXRhGAUgAygLMjkubW'
    'Fya2V0cGxhY2VfY29yZS5Db25maXJtVHJhbnNhY3Rpb25SZXF1ZXN0Lk1ldGFkYXRhRW50cnlS'
    'CG1ldGFkYXRhGjsKDU1ldGFkYXRhRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAi'
    'ABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use cancelTransactionRequestDescriptor instead')
const CancelTransactionRequest$json = {
  '1': 'CancelTransactionRequest',
  '2': [
    {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `CancelTransactionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelTransactionRequestDescriptor =
    $convert.base64Decode(
        'ChhDYW5jZWxUcmFuc2FjdGlvblJlcXVlc3QSJQoOdHJhbnNhY3Rpb25faWQYASABKAlSDXRyYW'
        '5zYWN0aW9uSWQSFgoGcmVhc29uGAIgASgJUgZyZWFzb24=');

@$core.Deprecated('Use getTransactionStatusRequestDescriptor instead')
const GetTransactionStatusRequest$json = {
  '1': 'GetTransactionStatusRequest',
  '2': [
    {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `GetTransactionStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionStatusRequestDescriptor =
    $convert.base64Decode(
        'ChtHZXRUcmFuc2FjdGlvblN0YXR1c1JlcXVlc3QSJQoOdHJhbnNhY3Rpb25faWQYASABKAlSDX'
        'RyYW5zYWN0aW9uSWQ=');

@$core.Deprecated('Use transactionResultDescriptor instead')
const TransactionResult$json = {
  '1': 'TransactionResult',
  '2': [
    {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    {
      '1': 'errors',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.UserError',
      '10': 'errors'
    },
  ],
};

/// Descriptor for `TransactionResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionResultDescriptor = $convert.base64Decode(
    'ChFUcmFuc2FjdGlvblJlc3VsdBIlCg50cmFuc2FjdGlvbl9pZBgBIAEoCVINdHJhbnNhY3Rpb2'
    '5JZBIYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNzEhYKBnN0YXR1cxgDIAEoCVIGc3RhdHVzEjMK'
    'BmVycm9ycxgEIAMoCzIbLm1hcmtldHBsYWNlX2NvcmUuVXNlckVycm9yUgZlcnJvcnM=');

@$core.Deprecated('Use transactionStatusDescriptor instead')
const TransactionStatus$json = {
  '1': 'TransactionStatus',
  '2': [
    {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'product_id', '3': 3, '4': 1, '5': 9, '10': 'productId'},
    {'1': 'variant_id', '3': 4, '4': 1, '5': 9, '10': 'variantId'},
    {'1': 'buyer_id', '3': 5, '4': 1, '5': 9, '10': 'buyerId'},
    {'1': 'created_at', '3': 6, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 7, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `TransactionStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionStatusDescriptor = $convert.base64Decode(
    'ChFUcmFuc2FjdGlvblN0YXR1cxIlCg50cmFuc2FjdGlvbl9pZBgBIAEoCVINdHJhbnNhY3Rpb2'
    '5JZBIWCgZzdGF0dXMYAiABKAlSBnN0YXR1cxIdCgpwcm9kdWN0X2lkGAMgASgJUglwcm9kdWN0'
    'SWQSHQoKdmFyaWFudF9pZBgEIAEoCVIJdmFyaWFudElkEhkKCGJ1eWVyX2lkGAUgASgJUgdidX'
    'llcklkEh0KCmNyZWF0ZWRfYXQYBiABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GAcgASgJ'
    'Ugl1cGRhdGVkQXQ=');

@$core.Deprecated('Use inventoryRequestDescriptor instead')
const InventoryRequest$json = {
  '1': 'InventoryRequest',
  '2': [
    {'1': 'variant_id', '3': 1, '4': 1, '5': 9, '10': 'variantId'},
    {'1': 'quantity', '3': 2, '4': 1, '5': 5, '10': 'quantity'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `InventoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inventoryRequestDescriptor = $convert.base64Decode(
    'ChBJbnZlbnRvcnlSZXF1ZXN0Eh0KCnZhcmlhbnRfaWQYASABKAlSCXZhcmlhbnRJZBIaCghxdW'
    'FudGl0eRgCIAEoBVIIcXVhbnRpdHkSFgoGcmVhc29uGAMgASgJUgZyZWFzb24=');

@$core.Deprecated('Use adjustInventoryRequestDescriptor instead')
const AdjustInventoryRequest$json = {
  '1': 'AdjustInventoryRequest',
  '2': [
    {'1': 'variant_id', '3': 1, '4': 1, '5': 9, '10': 'variantId'},
    {'1': 'delta', '3': 2, '4': 1, '5': 5, '10': 'delta'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `AdjustInventoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adjustInventoryRequestDescriptor =
    $convert.base64Decode(
        'ChZBZGp1c3RJbnZlbnRvcnlSZXF1ZXN0Eh0KCnZhcmlhbnRfaWQYASABKAlSCXZhcmlhbnRJZB'
        'IUCgVkZWx0YRgCIAEoBVIFZGVsdGESFgoGcmVhc29uGAMgASgJUgZyZWFzb24=');

@$core.Deprecated('Use inventoryResultDescriptor instead')
const InventoryResult$json = {
  '1': 'InventoryResult',
  '2': [
    {'1': 'variant_id', '3': 1, '4': 1, '5': 9, '10': 'variantId'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {
      '1': 'inventory',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.InventoryInfo',
      '10': 'inventory'
    },
    {
      '1': 'errors',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.UserError',
      '10': 'errors'
    },
  ],
};

/// Descriptor for `InventoryResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inventoryResultDescriptor = $convert.base64Decode(
    'Cg9JbnZlbnRvcnlSZXN1bHQSHQoKdmFyaWFudF9pZBgBIAEoCVIJdmFyaWFudElkEhgKB3N1Y2'
    'Nlc3MYAiABKAhSB3N1Y2Nlc3MSPQoJaW52ZW50b3J5GAMgASgLMh8ubWFya2V0cGxhY2VfY29y'
    'ZS5JbnZlbnRvcnlJbmZvUglpbnZlbnRvcnkSMwoGZXJyb3JzGAQgAygLMhsubWFya2V0cGxhY2'
    'VfY29yZS5Vc2VyRXJyb3JSBmVycm9ycw==');

@$core.Deprecated('Use getAvailabilityRequestDescriptor instead')
const GetAvailabilityRequest$json = {
  '1': 'GetAvailabilityRequest',
  '2': [
    {'1': 'variant_id', '3': 1, '4': 1, '5': 9, '10': 'variantId'},
    {'1': 'date', '3': 2, '4': 1, '5': 9, '10': 'date'},
  ],
};

/// Descriptor for `GetAvailabilityRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAvailabilityRequestDescriptor =
    $convert.base64Decode(
        'ChZHZXRBdmFpbGFiaWxpdHlSZXF1ZXN0Eh0KCnZhcmlhbnRfaWQYASABKAlSCXZhcmlhbnRJZB'
        'ISCgRkYXRlGAIgASgJUgRkYXRl');

@$core.Deprecated('Use availabilityInfoDescriptor instead')
const AvailabilityInfo$json = {
  '1': 'AvailabilityInfo',
  '2': [
    {'1': 'variant_id', '3': 1, '4': 1, '5': 9, '10': 'variantId'},
    {'1': 'available', '3': 2, '4': 1, '5': 8, '10': 'available'},
    {
      '1': 'rule',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.AvailabilityRule',
      '10': 'rule'
    },
    {
      '1': 'inventory',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.InventoryInfo',
      '10': 'inventory'
    },
    {
      '1': 'open_slots',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.TimeSlot',
      '10': 'openSlots'
    },
  ],
};

/// Descriptor for `AvailabilityInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List availabilityInfoDescriptor = $convert.base64Decode(
    'ChBBdmFpbGFiaWxpdHlJbmZvEh0KCnZhcmlhbnRfaWQYASABKAlSCXZhcmlhbnRJZBIcCglhdm'
    'FpbGFibGUYAiABKAhSCWF2YWlsYWJsZRI2CgRydWxlGAMgASgLMiIubWFya2V0cGxhY2VfY29y'
    'ZS5BdmFpbGFiaWxpdHlSdWxlUgRydWxlEj0KCWludmVudG9yeRgEIAEoCzIfLm1hcmtldHBsYW'
    'NlX2NvcmUuSW52ZW50b3J5SW5mb1IJaW52ZW50b3J5EjkKCm9wZW5fc2xvdHMYBSADKAsyGi5t'
    'YXJrZXRwbGFjZV9jb3JlLlRpbWVTbG90UglvcGVuU2xvdHM=');

@$core.Deprecated('Use recordOriginRequestDescriptor instead')
const RecordOriginRequest$json = {
  '1': 'RecordOriginRequest',
  '2': [
    {'1': 'product_id', '3': 1, '4': 1, '5': 9, '10': 'productId'},
    {'1': 'origin_party', '3': 2, '4': 1, '5': 9, '10': 'originParty'},
    {
      '1': 'origin_location',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.GeoLocation',
      '10': 'originLocation'
    },
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'metadata',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.RecordOriginRequest.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [RecordOriginRequest_MetadataEntry$json],
};

@$core.Deprecated('Use recordOriginRequestDescriptor instead')
const RecordOriginRequest_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `RecordOriginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recordOriginRequestDescriptor = $convert.base64Decode(
    'ChNSZWNvcmRPcmlnaW5SZXF1ZXN0Eh0KCnByb2R1Y3RfaWQYASABKAlSCXByb2R1Y3RJZBIhCg'
    'xvcmlnaW5fcGFydHkYAiABKAlSC29yaWdpblBhcnR5EkYKD29yaWdpbl9sb2NhdGlvbhgDIAEo'
    'CzIdLm1hcmtldHBsYWNlX2NvcmUuR2VvTG9jYXRpb25SDm9yaWdpbkxvY2F0aW9uEiAKC2Rlc2'
    'NyaXB0aW9uGAQgASgJUgtkZXNjcmlwdGlvbhJPCghtZXRhZGF0YRgFIAMoCzIzLm1hcmtldHBs'
    'YWNlX2NvcmUuUmVjb3JkT3JpZ2luUmVxdWVzdC5NZXRhZGF0YUVudHJ5UghtZXRhZGF0YRo7Cg'
    '1NZXRhZGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToC'
    'OAE=');

@$core.Deprecated('Use recordTransferRequestDescriptor instead')
const RecordTransferRequest$json = {
  '1': 'RecordTransferRequest',
  '2': [
    {'1': 'product_id', '3': 1, '4': 1, '5': 9, '10': 'productId'},
    {'1': 'from_party', '3': 2, '4': 1, '5': 9, '10': 'fromParty'},
    {'1': 'to_party', '3': 3, '4': 1, '5': 9, '10': 'toParty'},
    {
      '1': 'location',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.marketplace_core.GeoLocation',
      '10': 'location'
    },
    {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'metadata',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.RecordTransferRequest.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [RecordTransferRequest_MetadataEntry$json],
};

@$core.Deprecated('Use recordTransferRequestDescriptor instead')
const RecordTransferRequest_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `RecordTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recordTransferRequestDescriptor = $convert.base64Decode(
    'ChVSZWNvcmRUcmFuc2ZlclJlcXVlc3QSHQoKcHJvZHVjdF9pZBgBIAEoCVIJcHJvZHVjdElkEh'
    '0KCmZyb21fcGFydHkYAiABKAlSCWZyb21QYXJ0eRIZCgh0b19wYXJ0eRgDIAEoCVIHdG9QYXJ0'
    'eRI5Cghsb2NhdGlvbhgEIAEoCzIdLm1hcmtldHBsYWNlX2NvcmUuR2VvTG9jYXRpb25SCGxvY2'
    'F0aW9uEiAKC2Rlc2NyaXB0aW9uGAUgASgJUgtkZXNjcmlwdGlvbhJRCghtZXRhZGF0YRgGIAMo'
    'CzI1Lm1hcmtldHBsYWNlX2NvcmUuUmVjb3JkVHJhbnNmZXJSZXF1ZXN0Lk1ldGFkYXRhRW50cn'
    'lSCG1ldGFkYXRhGjsKDU1ldGFkYXRhRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUY'
    'AiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use recordTransformationRequestDescriptor instead')
const RecordTransformationRequest$json = {
  '1': 'RecordTransformationRequest',
  '2': [
    {'1': 'product_id', '3': 1, '4': 1, '5': 9, '10': 'productId'},
    {'1': 'input_product_ids', '3': 2, '4': 3, '5': 9, '10': 'inputProductIds'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'metadata',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.marketplace_core.RecordTransformationRequest.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [RecordTransformationRequest_MetadataEntry$json],
};

@$core.Deprecated('Use recordTransformationRequestDescriptor instead')
const RecordTransformationRequest_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `RecordTransformationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recordTransformationRequestDescriptor = $convert.base64Decode(
    'ChtSZWNvcmRUcmFuc2Zvcm1hdGlvblJlcXVlc3QSHQoKcHJvZHVjdF9pZBgBIAEoCVIJcHJvZH'
    'VjdElkEioKEWlucHV0X3Byb2R1Y3RfaWRzGAIgAygJUg9pbnB1dFByb2R1Y3RJZHMSIAoLZGVz'
    'Y3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uElcKCG1ldGFkYXRhGAQgAygLMjsubWFya2V0cG'
    'xhY2VfY29yZS5SZWNvcmRUcmFuc2Zvcm1hdGlvblJlcXVlc3QuTWV0YWRhdGFFbnRyeVIIbWV0'
    'YWRhdGEaOwoNTWV0YWRhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCV'
    'IFdmFsdWU6AjgB');

@$core.Deprecated('Use getChainRequestDescriptor instead')
const GetChainRequest$json = {
  '1': 'GetChainRequest',
  '2': [
    {'1': 'product_id', '3': 1, '4': 1, '5': 9, '10': 'productId'},
  ],
};

/// Descriptor for `GetChainRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getChainRequestDescriptor = $convert.base64Decode(
    'Cg9HZXRDaGFpblJlcXVlc3QSHQoKcHJvZHVjdF9pZBgBIAEoCVIJcHJvZHVjdElk');

@$core.Deprecated('Use verifyChainRequestDescriptor instead')
const VerifyChainRequest$json = {
  '1': 'VerifyChainRequest',
  '2': [
    {'1': 'product_id', '3': 1, '4': 1, '5': 9, '10': 'productId'},
  ],
};

/// Descriptor for `VerifyChainRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyChainRequestDescriptor =
    $convert.base64Decode(
        'ChJWZXJpZnlDaGFpblJlcXVlc3QSHQoKcHJvZHVjdF9pZBgBIAEoCVIJcHJvZHVjdElk');

@$core.Deprecated('Use verifyChainResultDescriptor instead')
const VerifyChainResult$json = {
  '1': 'VerifyChainResult',
  '2': [
    {'1': 'product_id', '3': 1, '4': 1, '5': 9, '10': 'productId'},
    {'1': 'verified', '3': 2, '4': 1, '5': 8, '10': 'verified'},
    {'1': 'event_count', '3': 3, '4': 1, '5': 5, '10': 'eventCount'},
    {'1': 'first_event', '3': 4, '4': 1, '5': 9, '10': 'firstEvent'},
    {'1': 'last_event', '3': 5, '4': 1, '5': 9, '10': 'lastEvent'},
  ],
};

/// Descriptor for `VerifyChainResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyChainResultDescriptor = $convert.base64Decode(
    'ChFWZXJpZnlDaGFpblJlc3VsdBIdCgpwcm9kdWN0X2lkGAEgASgJUglwcm9kdWN0SWQSGgoIdm'
    'VyaWZpZWQYAiABKAhSCHZlcmlmaWVkEh8KC2V2ZW50X2NvdW50GAMgASgFUgpldmVudENvdW50'
    'Eh8KC2ZpcnN0X2V2ZW50GAQgASgJUgpmaXJzdEV2ZW50Eh0KCmxhc3RfZXZlbnQYBSABKAlSCW'
    'xhc3RFdmVudA==');

@$core.Deprecated('Use submitRatingRequestDescriptor instead')
const SubmitRatingRequest$json = {
  '1': 'SubmitRatingRequest',
  '2': [
    {'1': 'from_id', '3': 1, '4': 1, '5': 9, '10': 'fromId'},
    {'1': 'to_id', '3': 2, '4': 1, '5': 9, '10': 'toId'},
    {'1': 'product_id', '3': 3, '4': 1, '5': 9, '10': 'productId'},
    {'1': 'transaction_id', '3': 4, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'score', '3': 5, '4': 1, '5': 5, '10': 'score'},
    {'1': 'comment', '3': 6, '4': 1, '5': 9, '10': 'comment'},
  ],
};

/// Descriptor for `SubmitRatingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List submitRatingRequestDescriptor = $convert.base64Decode(
    'ChNTdWJtaXRSYXRpbmdSZXF1ZXN0EhcKB2Zyb21faWQYASABKAlSBmZyb21JZBITCgV0b19pZB'
    'gCIAEoCVIEdG9JZBIdCgpwcm9kdWN0X2lkGAMgASgJUglwcm9kdWN0SWQSJQoOdHJhbnNhY3Rp'
    'b25faWQYBCABKAlSDXRyYW5zYWN0aW9uSWQSFAoFc2NvcmUYBSABKAVSBXNjb3JlEhgKB2NvbW'
    '1lbnQYBiABKAlSB2NvbW1lbnQ=');

@$core.Deprecated('Use getReputationRequestDescriptor instead')
const GetReputationRequest$json = {
  '1': 'GetReputationRequest',
  '2': [
    {'1': 'entity_id', '3': 1, '4': 1, '5': 9, '10': 'entityId'},
  ],
};

/// Descriptor for `GetReputationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getReputationRequestDescriptor =
    $convert.base64Decode(
        'ChRHZXRSZXB1dGF0aW9uUmVxdWVzdBIbCgllbnRpdHlfaWQYASABKAlSCGVudGl0eUlk');

@$core.Deprecated('Use getReviewHistoryRequestDescriptor instead')
const GetReviewHistoryRequest$json = {
  '1': 'GetReviewHistoryRequest',
  '2': [
    {'1': 'entity_id', '3': 1, '4': 1, '5': 9, '10': 'entityId'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'cursor', '3': 3, '4': 1, '5': 9, '10': 'cursor'},
  ],
};

/// Descriptor for `GetReviewHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getReviewHistoryRequestDescriptor =
    $convert.base64Decode(
        'ChdHZXRSZXZpZXdIaXN0b3J5UmVxdWVzdBIbCgllbnRpdHlfaWQYASABKAlSCGVudGl0eUlkEh'
        'QKBWxpbWl0GAIgASgFUgVsaW1pdBIWCgZjdXJzb3IYAyABKAlSBmN1cnNvcg==');

@$core.Deprecated('Use userErrorDescriptor instead')
const UserError$json = {
  '1': 'UserError',
  '2': [
    {'1': 'field', '3': 1, '4': 3, '5': 9, '10': 'field'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UserError`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userErrorDescriptor = $convert.base64Decode(
    'CglVc2VyRXJyb3ISFAoFZmllbGQYASADKAlSBWZpZWxkEhgKB21lc3NhZ2UYAiABKAlSB21lc3'
    'NhZ2U=');

@$core.Deprecated('Use healthStatusDescriptor instead')
const HealthStatus$json = {
  '1': 'HealthStatus',
  '2': [
    {'1': 'healthy', '3': 1, '4': 1, '5': 8, '10': 'healthy'},
    {'1': 'version', '3': 2, '4': 1, '5': 9, '10': 'version'},
    {'1': 'active_vendors', '3': 3, '4': 1, '5': 5, '10': 'activeVendors'},
    {'1': 'active_products', '3': 4, '4': 1, '5': 5, '10': 'activeProducts'},
  ],
};

/// Descriptor for `HealthStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List healthStatusDescriptor = $convert.base64Decode(
    'CgxIZWFsdGhTdGF0dXMSGAoHaGVhbHRoeRgBIAEoCFIHaGVhbHRoeRIYCgd2ZXJzaW9uGAIgAS'
    'gJUgd2ZXJzaW9uEiUKDmFjdGl2ZV92ZW5kb3JzGAMgASgFUg1hY3RpdmVWZW5kb3JzEicKD2Fj'
    'dGl2ZV9wcm9kdWN0cxgEIAEoBVIOYWN0aXZlUHJvZHVjdHM=');
