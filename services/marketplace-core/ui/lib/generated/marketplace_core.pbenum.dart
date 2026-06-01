// This is a generated file - do not edit.
//
// Generated from marketplace_core.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ProductStatus extends $pb.ProtobufEnum {
  static const ProductStatus PRODUCT_STATUS_UNSPECIFIED =
      ProductStatus._(0, _omitEnumNames ? '' : 'PRODUCT_STATUS_UNSPECIFIED');
  static const ProductStatus PRODUCT_STATUS_DRAFT =
      ProductStatus._(1, _omitEnumNames ? '' : 'PRODUCT_STATUS_DRAFT');
  static const ProductStatus PRODUCT_STATUS_ACTIVE =
      ProductStatus._(2, _omitEnumNames ? '' : 'PRODUCT_STATUS_ACTIVE');
  static const ProductStatus PRODUCT_STATUS_ARCHIVED =
      ProductStatus._(3, _omitEnumNames ? '' : 'PRODUCT_STATUS_ARCHIVED');

  static const $core.List<ProductStatus> values = <ProductStatus>[
    PRODUCT_STATUS_UNSPECIFIED,
    PRODUCT_STATUS_DRAFT,
    PRODUCT_STATUS_ACTIVE,
    PRODUCT_STATUS_ARCHIVED,
  ];

  static final $core.List<ProductStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static ProductStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ProductStatus._(super.value, super.name);
}

class InventoryPolicy extends $pb.ProtobufEnum {
  static const InventoryPolicy INVENTORY_POLICY_UNSPECIFIED = InventoryPolicy._(
      0, _omitEnumNames ? '' : 'INVENTORY_POLICY_UNSPECIFIED');
  static const InventoryPolicy INVENTORY_POLICY_TRACK =
      InventoryPolicy._(1, _omitEnumNames ? '' : 'INVENTORY_POLICY_TRACK');
  static const InventoryPolicy INVENTORY_POLICY_SINGLE =
      InventoryPolicy._(2, _omitEnumNames ? '' : 'INVENTORY_POLICY_SINGLE');
  static const InventoryPolicy INVENTORY_POLICY_UNTRACK =
      InventoryPolicy._(3, _omitEnumNames ? '' : 'INVENTORY_POLICY_UNTRACK');
  static const InventoryPolicy INVENTORY_POLICY_CAPACITY =
      InventoryPolicy._(4, _omitEnumNames ? '' : 'INVENTORY_POLICY_CAPACITY');

  static const $core.List<InventoryPolicy> values = <InventoryPolicy>[
    INVENTORY_POLICY_UNSPECIFIED,
    INVENTORY_POLICY_TRACK,
    INVENTORY_POLICY_SINGLE,
    INVENTORY_POLICY_UNTRACK,
    INVENTORY_POLICY_CAPACITY,
  ];

  static final $core.List<InventoryPolicy?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static InventoryPolicy? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const InventoryPolicy._(super.value, super.name);
}

class FulfillmentType extends $pb.ProtobufEnum {
  static const FulfillmentType FULFILLMENT_TYPE_UNSPECIFIED = FulfillmentType._(
      0, _omitEnumNames ? '' : 'FULFILLMENT_TYPE_UNSPECIFIED');
  static const FulfillmentType FULFILLMENT_TYPE_PHYSICAL =
      FulfillmentType._(1, _omitEnumNames ? '' : 'FULFILLMENT_TYPE_PHYSICAL');
  static const FulfillmentType FULFILLMENT_TYPE_DIGITAL =
      FulfillmentType._(2, _omitEnumNames ? '' : 'FULFILLMENT_TYPE_DIGITAL');
  static const FulfillmentType FULFILLMENT_TYPE_IN_PERSON =
      FulfillmentType._(3, _omitEnumNames ? '' : 'FULFILLMENT_TYPE_IN_PERSON');
  static const FulfillmentType FULFILLMENT_TYPE_ONGOING =
      FulfillmentType._(4, _omitEnumNames ? '' : 'FULFILLMENT_TYPE_ONGOING');

  static const $core.List<FulfillmentType> values = <FulfillmentType>[
    FULFILLMENT_TYPE_UNSPECIFIED,
    FULFILLMENT_TYPE_PHYSICAL,
    FULFILLMENT_TYPE_DIGITAL,
    FULFILLMENT_TYPE_IN_PERSON,
    FULFILLMENT_TYPE_ONGOING,
  ];

  static final $core.List<FulfillmentType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static FulfillmentType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const FulfillmentType._(super.value, super.name);
}

class CollectionType extends $pb.ProtobufEnum {
  static const CollectionType COLLECTION_TYPE_UNSPECIFIED =
      CollectionType._(0, _omitEnumNames ? '' : 'COLLECTION_TYPE_UNSPECIFIED');
  static const CollectionType COLLECTION_TYPE_MANUAL =
      CollectionType._(1, _omitEnumNames ? '' : 'COLLECTION_TYPE_MANUAL');
  static const CollectionType COLLECTION_TYPE_SMART =
      CollectionType._(2, _omitEnumNames ? '' : 'COLLECTION_TYPE_SMART');

  static const $core.List<CollectionType> values = <CollectionType>[
    COLLECTION_TYPE_UNSPECIFIED,
    COLLECTION_TYPE_MANUAL,
    COLLECTION_TYPE_SMART,
  ];

  static final $core.List<CollectionType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static CollectionType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const CollectionType._(super.value, super.name);
}

class SortOrder extends $pb.ProtobufEnum {
  static const SortOrder SORT_ORDER_UNSPECIFIED =
      SortOrder._(0, _omitEnumNames ? '' : 'SORT_ORDER_UNSPECIFIED');
  static const SortOrder SORT_ORDER_MANUAL =
      SortOrder._(1, _omitEnumNames ? '' : 'SORT_ORDER_MANUAL');
  static const SortOrder SORT_ORDER_BEST_SELLING =
      SortOrder._(2, _omitEnumNames ? '' : 'SORT_ORDER_BEST_SELLING');
  static const SortOrder SORT_ORDER_PRICE_ASC =
      SortOrder._(3, _omitEnumNames ? '' : 'SORT_ORDER_PRICE_ASC');
  static const SortOrder SORT_ORDER_PRICE_DESC =
      SortOrder._(4, _omitEnumNames ? '' : 'SORT_ORDER_PRICE_DESC');
  static const SortOrder SORT_ORDER_CREATED_DESC =
      SortOrder._(5, _omitEnumNames ? '' : 'SORT_ORDER_CREATED_DESC');
  static const SortOrder SORT_ORDER_TITLE_ASC =
      SortOrder._(6, _omitEnumNames ? '' : 'SORT_ORDER_TITLE_ASC');

  static const $core.List<SortOrder> values = <SortOrder>[
    SORT_ORDER_UNSPECIFIED,
    SORT_ORDER_MANUAL,
    SORT_ORDER_BEST_SELLING,
    SORT_ORDER_PRICE_ASC,
    SORT_ORDER_PRICE_DESC,
    SORT_ORDER_CREATED_DESC,
    SORT_ORDER_TITLE_ASC,
  ];

  static final $core.List<SortOrder?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 6);
  static SortOrder? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SortOrder._(super.value, super.name);
}

class VerificationStatus extends $pb.ProtobufEnum {
  static const VerificationStatus VERIFICATION_STATUS_UNSPECIFIED =
      VerificationStatus._(
          0, _omitEnumNames ? '' : 'VERIFICATION_STATUS_UNSPECIFIED');
  static const VerificationStatus VERIFICATION_STATUS_UNVERIFIED =
      VerificationStatus._(
          1, _omitEnumNames ? '' : 'VERIFICATION_STATUS_UNVERIFIED');
  static const VerificationStatus VERIFICATION_STATUS_PENDING =
      VerificationStatus._(
          2, _omitEnumNames ? '' : 'VERIFICATION_STATUS_PENDING');
  static const VerificationStatus VERIFICATION_STATUS_VERIFIED =
      VerificationStatus._(
          3, _omitEnumNames ? '' : 'VERIFICATION_STATUS_VERIFIED');

  static const $core.List<VerificationStatus> values = <VerificationStatus>[
    VERIFICATION_STATUS_UNSPECIFIED,
    VERIFICATION_STATUS_UNVERIFIED,
    VERIFICATION_STATUS_PENDING,
    VERIFICATION_STATUS_VERIFIED,
  ];

  static final $core.List<VerificationStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static VerificationStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const VerificationStatus._(super.value, super.name);
}

class MediaOwnerType extends $pb.ProtobufEnum {
  static const MediaOwnerType MEDIA_OWNER_UNSPECIFIED =
      MediaOwnerType._(0, _omitEnumNames ? '' : 'MEDIA_OWNER_UNSPECIFIED');
  static const MediaOwnerType MEDIA_OWNER_PRODUCT =
      MediaOwnerType._(1, _omitEnumNames ? '' : 'MEDIA_OWNER_PRODUCT');
  static const MediaOwnerType MEDIA_OWNER_VARIANT =
      MediaOwnerType._(2, _omitEnumNames ? '' : 'MEDIA_OWNER_VARIANT');
  static const MediaOwnerType MEDIA_OWNER_VENDOR =
      MediaOwnerType._(3, _omitEnumNames ? '' : 'MEDIA_OWNER_VENDOR');
  static const MediaOwnerType MEDIA_OWNER_STOREFRONT =
      MediaOwnerType._(4, _omitEnumNames ? '' : 'MEDIA_OWNER_STOREFRONT');

  static const $core.List<MediaOwnerType> values = <MediaOwnerType>[
    MEDIA_OWNER_UNSPECIFIED,
    MEDIA_OWNER_PRODUCT,
    MEDIA_OWNER_VARIANT,
    MEDIA_OWNER_VENDOR,
    MEDIA_OWNER_STOREFRONT,
  ];

  static final $core.List<MediaOwnerType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static MediaOwnerType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MediaOwnerType._(super.value, super.name);
}

class MediaType extends $pb.ProtobufEnum {
  static const MediaType MEDIA_TYPE_UNSPECIFIED =
      MediaType._(0, _omitEnumNames ? '' : 'MEDIA_TYPE_UNSPECIFIED');
  static const MediaType MEDIA_TYPE_IMAGE =
      MediaType._(1, _omitEnumNames ? '' : 'MEDIA_TYPE_IMAGE');
  static const MediaType MEDIA_TYPE_VIDEO =
      MediaType._(2, _omitEnumNames ? '' : 'MEDIA_TYPE_VIDEO');
  static const MediaType MEDIA_TYPE_DOCUMENT =
      MediaType._(3, _omitEnumNames ? '' : 'MEDIA_TYPE_DOCUMENT');

  static const $core.List<MediaType> values = <MediaType>[
    MEDIA_TYPE_UNSPECIFIED,
    MEDIA_TYPE_IMAGE,
    MEDIA_TYPE_VIDEO,
    MEDIA_TYPE_DOCUMENT,
  ];

  static final $core.List<MediaType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static MediaType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MediaType._(super.value, super.name);
}

class AvailabilityType extends $pb.ProtobufEnum {
  static const AvailabilityType AVAILABILITY_TYPE_UNSPECIFIED =
      AvailabilityType._(
          0, _omitEnumNames ? '' : 'AVAILABILITY_TYPE_UNSPECIFIED');
  static const AvailabilityType AVAILABILITY_TYPE_ALWAYS =
      AvailabilityType._(1, _omitEnumNames ? '' : 'AVAILABILITY_TYPE_ALWAYS');
  static const AvailabilityType AVAILABILITY_TYPE_CALENDAR =
      AvailabilityType._(2, _omitEnumNames ? '' : 'AVAILABILITY_TYPE_CALENDAR');
  static const AvailabilityType AVAILABILITY_TYPE_DATE_RANGE =
      AvailabilityType._(
          3, _omitEnumNames ? '' : 'AVAILABILITY_TYPE_DATE_RANGE');
  static const AvailabilityType AVAILABILITY_TYPE_EXPIRABLE =
      AvailabilityType._(
          4, _omitEnumNames ? '' : 'AVAILABILITY_TYPE_EXPIRABLE');
  static const AvailabilityType AVAILABILITY_TYPE_SEASONAL =
      AvailabilityType._(5, _omitEnumNames ? '' : 'AVAILABILITY_TYPE_SEASONAL');

  static const $core.List<AvailabilityType> values = <AvailabilityType>[
    AVAILABILITY_TYPE_UNSPECIFIED,
    AVAILABILITY_TYPE_ALWAYS,
    AVAILABILITY_TYPE_CALENDAR,
    AVAILABILITY_TYPE_DATE_RANGE,
    AVAILABILITY_TYPE_EXPIRABLE,
    AVAILABILITY_TYPE_SEASONAL,
  ];

  static final $core.List<AvailabilityType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static AvailabilityType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const AvailabilityType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
