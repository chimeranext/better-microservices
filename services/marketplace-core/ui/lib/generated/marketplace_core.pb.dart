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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'marketplace_core.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'marketplace_core.pbenum.dart';

class Empty extends $pb.GeneratedMessage {
  factory Empty() => create();

  Empty._();

  factory Empty.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Empty.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Empty',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Empty clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Empty copyWith(void Function(Empty) updates) =>
      super.copyWith((message) => updates(message as Empty)) as Empty;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Empty create() => Empty._();
  @$core.override
  Empty createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Empty getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Empty>(create);
  static Empty? _defaultInstance;
}

class Product extends $pb.GeneratedMessage {
  factory Product({
    $core.String? id,
    $core.String? vendorId,
    $core.String? title,
    $core.String? description,
    $core.String? slug,
    ProductStatus? status,
    $core.String? productType,
    $core.Iterable<$core.String>? tags,
    $core.Iterable<MediaAsset>? media,
    GeoLocation? geo,
    $core.String? schemaRef,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? attributes,
    $core.Iterable<Variant>? variants,
    $core.Iterable<$core.String>? collectionIds,
    SEO? seo,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (vendorId != null) result.vendorId = vendorId;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (slug != null) result.slug = slug;
    if (status != null) result.status = status;
    if (productType != null) result.productType = productType;
    if (tags != null) result.tags.addAll(tags);
    if (media != null) result.media.addAll(media);
    if (geo != null) result.geo = geo;
    if (schemaRef != null) result.schemaRef = schemaRef;
    if (attributes != null) result.attributes.addEntries(attributes);
    if (variants != null) result.variants.addAll(variants);
    if (collectionIds != null) result.collectionIds.addAll(collectionIds);
    if (seo != null) result.seo = seo;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  Product._();

  factory Product.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Product.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Product',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'vendorId')
    ..aOS(3, _omitFieldNames ? '' : 'title')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aOS(5, _omitFieldNames ? '' : 'slug')
    ..aE<ProductStatus>(6, _omitFieldNames ? '' : 'status',
        enumValues: ProductStatus.values)
    ..aOS(7, _omitFieldNames ? '' : 'productType')
    ..pPS(8, _omitFieldNames ? '' : 'tags')
    ..pPM<MediaAsset>(9, _omitFieldNames ? '' : 'media',
        subBuilder: MediaAsset.create)
    ..aOM<GeoLocation>(10, _omitFieldNames ? '' : 'geo',
        subBuilder: GeoLocation.create)
    ..aOS(11, _omitFieldNames ? '' : 'schemaRef')
    ..m<$core.String, $core.String>(12, _omitFieldNames ? '' : 'attributes',
        entryClassName: 'Product.AttributesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('marketplace_core'))
    ..pPM<Variant>(13, _omitFieldNames ? '' : 'variants',
        subBuilder: Variant.create)
    ..pPS(14, _omitFieldNames ? '' : 'collectionIds')
    ..aOM<SEO>(15, _omitFieldNames ? '' : 'seo', subBuilder: SEO.create)
    ..aOS(16, _omitFieldNames ? '' : 'createdAt')
    ..aOS(17, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Product clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Product copyWith(void Function(Product) updates) =>
      super.copyWith((message) => updates(message as Product)) as Product;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Product create() => Product._();
  @$core.override
  Product createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Product getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Product>(create);
  static Product? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get vendorId => $_getSZ(1);
  @$pb.TagNumber(2)
  set vendorId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVendorId() => $_has(1);
  @$pb.TagNumber(2)
  void clearVendorId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get slug => $_getSZ(4);
  @$pb.TagNumber(5)
  set slug($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSlug() => $_has(4);
  @$pb.TagNumber(5)
  void clearSlug() => $_clearField(5);

  @$pb.TagNumber(6)
  ProductStatus get status => $_getN(5);
  @$pb.TagNumber(6)
  set status(ProductStatus value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get productType => $_getSZ(6);
  @$pb.TagNumber(7)
  set productType($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasProductType() => $_has(6);
  @$pb.TagNumber(7)
  void clearProductType() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<$core.String> get tags => $_getList(7);

  @$pb.TagNumber(9)
  $pb.PbList<MediaAsset> get media => $_getList(8);

  @$pb.TagNumber(10)
  GeoLocation get geo => $_getN(9);
  @$pb.TagNumber(10)
  set geo(GeoLocation value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasGeo() => $_has(9);
  @$pb.TagNumber(10)
  void clearGeo() => $_clearField(10);
  @$pb.TagNumber(10)
  GeoLocation ensureGeo() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.String get schemaRef => $_getSZ(10);
  @$pb.TagNumber(11)
  set schemaRef($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasSchemaRef() => $_has(10);
  @$pb.TagNumber(11)
  void clearSchemaRef() => $_clearField(11);

  @$pb.TagNumber(12)
  $pb.PbMap<$core.String, $core.String> get attributes => $_getMap(11);

  @$pb.TagNumber(13)
  $pb.PbList<Variant> get variants => $_getList(12);

  @$pb.TagNumber(14)
  $pb.PbList<$core.String> get collectionIds => $_getList(13);

  @$pb.TagNumber(15)
  SEO get seo => $_getN(14);
  @$pb.TagNumber(15)
  set seo(SEO value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasSeo() => $_has(14);
  @$pb.TagNumber(15)
  void clearSeo() => $_clearField(15);
  @$pb.TagNumber(15)
  SEO ensureSeo() => $_ensure(14);

  @$pb.TagNumber(16)
  $core.String get createdAt => $_getSZ(15);
  @$pb.TagNumber(16)
  set createdAt($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasCreatedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearCreatedAt() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get updatedAt => $_getSZ(16);
  @$pb.TagNumber(17)
  set updatedAt($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasUpdatedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearUpdatedAt() => $_clearField(17);
}

class Variant extends $pb.GeneratedMessage {
  factory Variant({
    $core.String? id,
    $core.String? productId,
    $core.String? title,
    $core.String? sku,
    Money? price,
    Money? compareAtPrice,
    $core.Iterable<Option>? options,
    InventoryPolicy? inventoryPolicy,
    $core.Iterable<FulfillmentType>? fulfillmentTypes,
    AvailabilityRule? availability,
    InventoryInfo? inventory,
    $core.bool? available,
    $core.int? position,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (productId != null) result.productId = productId;
    if (title != null) result.title = title;
    if (sku != null) result.sku = sku;
    if (price != null) result.price = price;
    if (compareAtPrice != null) result.compareAtPrice = compareAtPrice;
    if (options != null) result.options.addAll(options);
    if (inventoryPolicy != null) result.inventoryPolicy = inventoryPolicy;
    if (fulfillmentTypes != null)
      result.fulfillmentTypes.addAll(fulfillmentTypes);
    if (availability != null) result.availability = availability;
    if (inventory != null) result.inventory = inventory;
    if (available != null) result.available = available;
    if (position != null) result.position = position;
    if (metadata != null) result.metadata.addEntries(metadata);
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  Variant._();

  factory Variant.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Variant.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Variant',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'productId')
    ..aOS(3, _omitFieldNames ? '' : 'title')
    ..aOS(4, _omitFieldNames ? '' : 'sku')
    ..aOM<Money>(5, _omitFieldNames ? '' : 'price', subBuilder: Money.create)
    ..aOM<Money>(6, _omitFieldNames ? '' : 'compareAtPrice',
        subBuilder: Money.create)
    ..pPM<Option>(7, _omitFieldNames ? '' : 'options',
        subBuilder: Option.create)
    ..aE<InventoryPolicy>(8, _omitFieldNames ? '' : 'inventoryPolicy',
        enumValues: InventoryPolicy.values)
    ..pc<FulfillmentType>(
        9, _omitFieldNames ? '' : 'fulfillmentTypes', $pb.PbFieldType.KE,
        valueOf: FulfillmentType.valueOf,
        enumValues: FulfillmentType.values,
        defaultEnumValue: FulfillmentType.FULFILLMENT_TYPE_UNSPECIFIED)
    ..aOM<AvailabilityRule>(10, _omitFieldNames ? '' : 'availability',
        subBuilder: AvailabilityRule.create)
    ..aOM<InventoryInfo>(11, _omitFieldNames ? '' : 'inventory',
        subBuilder: InventoryInfo.create)
    ..aOB(12, _omitFieldNames ? '' : 'available')
    ..aI(13, _omitFieldNames ? '' : 'position')
    ..m<$core.String, $core.String>(14, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'Variant.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('marketplace_core'))
    ..aOS(15, _omitFieldNames ? '' : 'createdAt')
    ..aOS(16, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Variant clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Variant copyWith(void Function(Variant) updates) =>
      super.copyWith((message) => updates(message as Variant)) as Variant;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Variant create() => Variant._();
  @$core.override
  Variant createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Variant getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Variant>(create);
  static Variant? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get productId => $_getSZ(1);
  @$pb.TagNumber(2)
  set productId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProductId() => $_has(1);
  @$pb.TagNumber(2)
  void clearProductId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get sku => $_getSZ(3);
  @$pb.TagNumber(4)
  set sku($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSku() => $_has(3);
  @$pb.TagNumber(4)
  void clearSku() => $_clearField(4);

  @$pb.TagNumber(5)
  Money get price => $_getN(4);
  @$pb.TagNumber(5)
  set price(Money value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasPrice() => $_has(4);
  @$pb.TagNumber(5)
  void clearPrice() => $_clearField(5);
  @$pb.TagNumber(5)
  Money ensurePrice() => $_ensure(4);

  @$pb.TagNumber(6)
  Money get compareAtPrice => $_getN(5);
  @$pb.TagNumber(6)
  set compareAtPrice(Money value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasCompareAtPrice() => $_has(5);
  @$pb.TagNumber(6)
  void clearCompareAtPrice() => $_clearField(6);
  @$pb.TagNumber(6)
  Money ensureCompareAtPrice() => $_ensure(5);

  @$pb.TagNumber(7)
  $pb.PbList<Option> get options => $_getList(6);

  @$pb.TagNumber(8)
  InventoryPolicy get inventoryPolicy => $_getN(7);
  @$pb.TagNumber(8)
  set inventoryPolicy(InventoryPolicy value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasInventoryPolicy() => $_has(7);
  @$pb.TagNumber(8)
  void clearInventoryPolicy() => $_clearField(8);

  @$pb.TagNumber(9)
  $pb.PbList<FulfillmentType> get fulfillmentTypes => $_getList(8);

  @$pb.TagNumber(10)
  AvailabilityRule get availability => $_getN(9);
  @$pb.TagNumber(10)
  set availability(AvailabilityRule value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasAvailability() => $_has(9);
  @$pb.TagNumber(10)
  void clearAvailability() => $_clearField(10);
  @$pb.TagNumber(10)
  AvailabilityRule ensureAvailability() => $_ensure(9);

  @$pb.TagNumber(11)
  InventoryInfo get inventory => $_getN(10);
  @$pb.TagNumber(11)
  set inventory(InventoryInfo value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasInventory() => $_has(10);
  @$pb.TagNumber(11)
  void clearInventory() => $_clearField(11);
  @$pb.TagNumber(11)
  InventoryInfo ensureInventory() => $_ensure(10);

  @$pb.TagNumber(12)
  $core.bool get available => $_getBF(11);
  @$pb.TagNumber(12)
  set available($core.bool value) => $_setBool(11, value);
  @$pb.TagNumber(12)
  $core.bool hasAvailable() => $_has(11);
  @$pb.TagNumber(12)
  void clearAvailable() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get position => $_getIZ(12);
  @$pb.TagNumber(13)
  set position($core.int value) => $_setSignedInt32(12, value);
  @$pb.TagNumber(13)
  $core.bool hasPosition() => $_has(12);
  @$pb.TagNumber(13)
  void clearPosition() => $_clearField(13);

  @$pb.TagNumber(14)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(13);

  @$pb.TagNumber(15)
  $core.String get createdAt => $_getSZ(14);
  @$pb.TagNumber(15)
  set createdAt($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasCreatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearCreatedAt() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get updatedAt => $_getSZ(15);
  @$pb.TagNumber(16)
  set updatedAt($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasUpdatedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearUpdatedAt() => $_clearField(16);
}

class Collection extends $pb.GeneratedMessage {
  factory Collection({
    $core.String? id,
    $core.String? title,
    $core.String? slug,
    $core.String? description,
    CollectionType? type,
    $core.Iterable<CollectionRule>? rules,
    SortOrder? sortOrder,
    MediaAsset? image,
    SEO? seo,
    $core.Iterable<$core.String>? productIds,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    if (slug != null) result.slug = slug;
    if (description != null) result.description = description;
    if (type != null) result.type = type;
    if (rules != null) result.rules.addAll(rules);
    if (sortOrder != null) result.sortOrder = sortOrder;
    if (image != null) result.image = image;
    if (seo != null) result.seo = seo;
    if (productIds != null) result.productIds.addAll(productIds);
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  Collection._();

  factory Collection.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Collection.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Collection',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'slug')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aE<CollectionType>(5, _omitFieldNames ? '' : 'type',
        enumValues: CollectionType.values)
    ..pPM<CollectionRule>(6, _omitFieldNames ? '' : 'rules',
        subBuilder: CollectionRule.create)
    ..aE<SortOrder>(7, _omitFieldNames ? '' : 'sortOrder',
        enumValues: SortOrder.values)
    ..aOM<MediaAsset>(8, _omitFieldNames ? '' : 'image',
        subBuilder: MediaAsset.create)
    ..aOM<SEO>(9, _omitFieldNames ? '' : 'seo', subBuilder: SEO.create)
    ..pPS(10, _omitFieldNames ? '' : 'productIds')
    ..aOS(11, _omitFieldNames ? '' : 'createdAt')
    ..aOS(12, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Collection clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Collection copyWith(void Function(Collection) updates) =>
      super.copyWith((message) => updates(message as Collection)) as Collection;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Collection create() => Collection._();
  @$core.override
  Collection createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Collection getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Collection>(create);
  static Collection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get slug => $_getSZ(2);
  @$pb.TagNumber(3)
  set slug($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSlug() => $_has(2);
  @$pb.TagNumber(3)
  void clearSlug() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  CollectionType get type => $_getN(4);
  @$pb.TagNumber(5)
  set type(CollectionType value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasType() => $_has(4);
  @$pb.TagNumber(5)
  void clearType() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<CollectionRule> get rules => $_getList(5);

  @$pb.TagNumber(7)
  SortOrder get sortOrder => $_getN(6);
  @$pb.TagNumber(7)
  set sortOrder(SortOrder value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasSortOrder() => $_has(6);
  @$pb.TagNumber(7)
  void clearSortOrder() => $_clearField(7);

  @$pb.TagNumber(8)
  MediaAsset get image => $_getN(7);
  @$pb.TagNumber(8)
  set image(MediaAsset value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasImage() => $_has(7);
  @$pb.TagNumber(8)
  void clearImage() => $_clearField(8);
  @$pb.TagNumber(8)
  MediaAsset ensureImage() => $_ensure(7);

  @$pb.TagNumber(9)
  SEO get seo => $_getN(8);
  @$pb.TagNumber(9)
  set seo(SEO value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasSeo() => $_has(8);
  @$pb.TagNumber(9)
  void clearSeo() => $_clearField(9);
  @$pb.TagNumber(9)
  SEO ensureSeo() => $_ensure(8);

  @$pb.TagNumber(10)
  $pb.PbList<$core.String> get productIds => $_getList(9);

  @$pb.TagNumber(11)
  $core.String get createdAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set createdAt($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get updatedAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set updatedAt($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasUpdatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearUpdatedAt() => $_clearField(12);
}

class CollectionRule extends $pb.GeneratedMessage {
  factory CollectionRule({
    $core.String? field_1,
    $core.String? operator,
    $core.String? value,
  }) {
    final result = create();
    if (field_1 != null) result.field_1 = field_1;
    if (operator != null) result.operator = operator;
    if (value != null) result.value = value;
    return result;
  }

  CollectionRule._();

  factory CollectionRule.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CollectionRule.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CollectionRule',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'field')
    ..aOS(2, _omitFieldNames ? '' : 'operator')
    ..aOS(3, _omitFieldNames ? '' : 'value')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CollectionRule clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CollectionRule copyWith(void Function(CollectionRule) updates) =>
      super.copyWith((message) => updates(message as CollectionRule))
          as CollectionRule;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CollectionRule create() => CollectionRule._();
  @$core.override
  CollectionRule createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CollectionRule getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CollectionRule>(create);
  static CollectionRule? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get field_1 => $_getSZ(0);
  @$pb.TagNumber(1)
  set field_1($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasField_1() => $_has(0);
  @$pb.TagNumber(1)
  void clearField_1() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get operator => $_getSZ(1);
  @$pb.TagNumber(2)
  set operator($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOperator() => $_has(1);
  @$pb.TagNumber(2)
  void clearOperator() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get value => $_getSZ(2);
  @$pb.TagNumber(3)
  set value($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearValue() => $_clearField(3);
}

class Vendor extends $pb.GeneratedMessage {
  factory Vendor({
    $core.String? id,
    $core.String? name,
    $core.String? slug,
    VerificationStatus? verification,
    $core.String? identityDoc,
    Contact? contact,
    GeoLocation? geo,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (slug != null) result.slug = slug;
    if (verification != null) result.verification = verification;
    if (identityDoc != null) result.identityDoc = identityDoc;
    if (contact != null) result.contact = contact;
    if (geo != null) result.geo = geo;
    if (metadata != null) result.metadata.addEntries(metadata);
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  Vendor._();

  factory Vendor.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Vendor.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Vendor',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'slug')
    ..aE<VerificationStatus>(4, _omitFieldNames ? '' : 'verification',
        enumValues: VerificationStatus.values)
    ..aOS(5, _omitFieldNames ? '' : 'identityDoc')
    ..aOM<Contact>(6, _omitFieldNames ? '' : 'contact',
        subBuilder: Contact.create)
    ..aOM<GeoLocation>(7, _omitFieldNames ? '' : 'geo',
        subBuilder: GeoLocation.create)
    ..m<$core.String, $core.String>(8, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'Vendor.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('marketplace_core'))
    ..aOS(9, _omitFieldNames ? '' : 'createdAt')
    ..aOS(10, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Vendor clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Vendor copyWith(void Function(Vendor) updates) =>
      super.copyWith((message) => updates(message as Vendor)) as Vendor;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Vendor create() => Vendor._();
  @$core.override
  Vendor createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Vendor getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Vendor>(create);
  static Vendor? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get slug => $_getSZ(2);
  @$pb.TagNumber(3)
  set slug($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSlug() => $_has(2);
  @$pb.TagNumber(3)
  void clearSlug() => $_clearField(3);

  @$pb.TagNumber(4)
  VerificationStatus get verification => $_getN(3);
  @$pb.TagNumber(4)
  set verification(VerificationStatus value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasVerification() => $_has(3);
  @$pb.TagNumber(4)
  void clearVerification() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get identityDoc => $_getSZ(4);
  @$pb.TagNumber(5)
  set identityDoc($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIdentityDoc() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdentityDoc() => $_clearField(5);

  @$pb.TagNumber(6)
  Contact get contact => $_getN(5);
  @$pb.TagNumber(6)
  set contact(Contact value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasContact() => $_has(5);
  @$pb.TagNumber(6)
  void clearContact() => $_clearField(6);
  @$pb.TagNumber(6)
  Contact ensureContact() => $_ensure(5);

  @$pb.TagNumber(7)
  GeoLocation get geo => $_getN(6);
  @$pb.TagNumber(7)
  set geo(GeoLocation value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasGeo() => $_has(6);
  @$pb.TagNumber(7)
  void clearGeo() => $_clearField(7);
  @$pb.TagNumber(7)
  GeoLocation ensureGeo() => $_ensure(6);

  @$pb.TagNumber(8)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(7);

  @$pb.TagNumber(9)
  $core.String get createdAt => $_getSZ(8);
  @$pb.TagNumber(9)
  set createdAt($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get updatedAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set updatedAt($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasUpdatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearUpdatedAt() => $_clearField(10);
}

class VendorProfile extends $pb.GeneratedMessage {
  factory VendorProfile({
    $core.String? id,
    $core.String? name,
    $core.String? slug,
    VerificationStatus? verification,
    GeoLocation? geo,
    ReputationScore? reputation,
    $core.int? productCount,
    $core.String? memberSince,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (slug != null) result.slug = slug;
    if (verification != null) result.verification = verification;
    if (geo != null) result.geo = geo;
    if (reputation != null) result.reputation = reputation;
    if (productCount != null) result.productCount = productCount;
    if (memberSince != null) result.memberSince = memberSince;
    return result;
  }

  VendorProfile._();

  factory VendorProfile.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VendorProfile.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VendorProfile',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'slug')
    ..aE<VerificationStatus>(4, _omitFieldNames ? '' : 'verification',
        enumValues: VerificationStatus.values)
    ..aOM<GeoLocation>(5, _omitFieldNames ? '' : 'geo',
        subBuilder: GeoLocation.create)
    ..aOM<ReputationScore>(6, _omitFieldNames ? '' : 'reputation',
        subBuilder: ReputationScore.create)
    ..aI(7, _omitFieldNames ? '' : 'productCount')
    ..aOS(8, _omitFieldNames ? '' : 'memberSince')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VendorProfile clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VendorProfile copyWith(void Function(VendorProfile) updates) =>
      super.copyWith((message) => updates(message as VendorProfile))
          as VendorProfile;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VendorProfile create() => VendorProfile._();
  @$core.override
  VendorProfile createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VendorProfile getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VendorProfile>(create);
  static VendorProfile? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get slug => $_getSZ(2);
  @$pb.TagNumber(3)
  set slug($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSlug() => $_has(2);
  @$pb.TagNumber(3)
  void clearSlug() => $_clearField(3);

  @$pb.TagNumber(4)
  VerificationStatus get verification => $_getN(3);
  @$pb.TagNumber(4)
  set verification(VerificationStatus value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasVerification() => $_has(3);
  @$pb.TagNumber(4)
  void clearVerification() => $_clearField(4);

  @$pb.TagNumber(5)
  GeoLocation get geo => $_getN(4);
  @$pb.TagNumber(5)
  set geo(GeoLocation value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasGeo() => $_has(4);
  @$pb.TagNumber(5)
  void clearGeo() => $_clearField(5);
  @$pb.TagNumber(5)
  GeoLocation ensureGeo() => $_ensure(4);

  @$pb.TagNumber(6)
  ReputationScore get reputation => $_getN(5);
  @$pb.TagNumber(6)
  set reputation(ReputationScore value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasReputation() => $_has(5);
  @$pb.TagNumber(6)
  void clearReputation() => $_clearField(6);
  @$pb.TagNumber(6)
  ReputationScore ensureReputation() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.int get productCount => $_getIZ(6);
  @$pb.TagNumber(7)
  set productCount($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasProductCount() => $_has(6);
  @$pb.TagNumber(7)
  void clearProductCount() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get memberSince => $_getSZ(7);
  @$pb.TagNumber(8)
  set memberSince($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasMemberSince() => $_has(7);
  @$pb.TagNumber(8)
  void clearMemberSince() => $_clearField(8);
}

class Storefront extends $pb.GeneratedMessage {
  factory Storefront({
    $core.String? id,
    $core.String? vendorId,
    $core.String? slug,
    $core.String? name,
    $core.String? description,
    MediaAsset? logo,
    MediaAsset? banner,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? theme,
    $core.bool? isPublic,
    $core.String? customDomain,
    SEO? seo,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (vendorId != null) result.vendorId = vendorId;
    if (slug != null) result.slug = slug;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (logo != null) result.logo = logo;
    if (banner != null) result.banner = banner;
    if (theme != null) result.theme.addEntries(theme);
    if (isPublic != null) result.isPublic = isPublic;
    if (customDomain != null) result.customDomain = customDomain;
    if (seo != null) result.seo = seo;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  Storefront._();

  factory Storefront.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Storefront.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Storefront',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'vendorId')
    ..aOS(3, _omitFieldNames ? '' : 'slug')
    ..aOS(4, _omitFieldNames ? '' : 'name')
    ..aOS(5, _omitFieldNames ? '' : 'description')
    ..aOM<MediaAsset>(6, _omitFieldNames ? '' : 'logo',
        subBuilder: MediaAsset.create)
    ..aOM<MediaAsset>(7, _omitFieldNames ? '' : 'banner',
        subBuilder: MediaAsset.create)
    ..m<$core.String, $core.String>(8, _omitFieldNames ? '' : 'theme',
        entryClassName: 'Storefront.ThemeEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('marketplace_core'))
    ..aOB(9, _omitFieldNames ? '' : 'isPublic')
    ..aOS(10, _omitFieldNames ? '' : 'customDomain')
    ..aOM<SEO>(11, _omitFieldNames ? '' : 'seo', subBuilder: SEO.create)
    ..aOS(12, _omitFieldNames ? '' : 'createdAt')
    ..aOS(13, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Storefront clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Storefront copyWith(void Function(Storefront) updates) =>
      super.copyWith((message) => updates(message as Storefront)) as Storefront;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Storefront create() => Storefront._();
  @$core.override
  Storefront createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Storefront getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Storefront>(create);
  static Storefront? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get vendorId => $_getSZ(1);
  @$pb.TagNumber(2)
  set vendorId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVendorId() => $_has(1);
  @$pb.TagNumber(2)
  void clearVendorId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get slug => $_getSZ(2);
  @$pb.TagNumber(3)
  set slug($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSlug() => $_has(2);
  @$pb.TagNumber(3)
  void clearSlug() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get name => $_getSZ(3);
  @$pb.TagNumber(4)
  set name($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasName() => $_has(3);
  @$pb.TagNumber(4)
  void clearName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => $_clearField(5);

  @$pb.TagNumber(6)
  MediaAsset get logo => $_getN(5);
  @$pb.TagNumber(6)
  set logo(MediaAsset value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasLogo() => $_has(5);
  @$pb.TagNumber(6)
  void clearLogo() => $_clearField(6);
  @$pb.TagNumber(6)
  MediaAsset ensureLogo() => $_ensure(5);

  @$pb.TagNumber(7)
  MediaAsset get banner => $_getN(6);
  @$pb.TagNumber(7)
  set banner(MediaAsset value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasBanner() => $_has(6);
  @$pb.TagNumber(7)
  void clearBanner() => $_clearField(7);
  @$pb.TagNumber(7)
  MediaAsset ensureBanner() => $_ensure(6);

  @$pb.TagNumber(8)
  $pb.PbMap<$core.String, $core.String> get theme => $_getMap(7);

  @$pb.TagNumber(9)
  $core.bool get isPublic => $_getBF(8);
  @$pb.TagNumber(9)
  set isPublic($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasIsPublic() => $_has(8);
  @$pb.TagNumber(9)
  void clearIsPublic() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get customDomain => $_getSZ(9);
  @$pb.TagNumber(10)
  set customDomain($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCustomDomain() => $_has(9);
  @$pb.TagNumber(10)
  void clearCustomDomain() => $_clearField(10);

  @$pb.TagNumber(11)
  SEO get seo => $_getN(10);
  @$pb.TagNumber(11)
  set seo(SEO value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasSeo() => $_has(10);
  @$pb.TagNumber(11)
  void clearSeo() => $_clearField(11);
  @$pb.TagNumber(11)
  SEO ensureSeo() => $_ensure(10);

  @$pb.TagNumber(12)
  $core.String get createdAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set createdAt($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get updatedAt => $_getSZ(12);
  @$pb.TagNumber(13)
  set updatedAt($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasUpdatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearUpdatedAt() => $_clearField(13);
}

class MediaAsset extends $pb.GeneratedMessage {
  factory MediaAsset({
    $core.String? id,
    MediaOwnerType? ownerType,
    $core.String? ownerId,
    MediaType? type,
    $core.String? url,
    $core.String? altText,
    $core.int? width,
    $core.int? height,
    $core.int? durationSeconds,
    $fixnum.Int64? sizeBytes,
    $core.String? mimeType,
    $core.String? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (ownerType != null) result.ownerType = ownerType;
    if (ownerId != null) result.ownerId = ownerId;
    if (type != null) result.type = type;
    if (url != null) result.url = url;
    if (altText != null) result.altText = altText;
    if (width != null) result.width = width;
    if (height != null) result.height = height;
    if (durationSeconds != null) result.durationSeconds = durationSeconds;
    if (sizeBytes != null) result.sizeBytes = sizeBytes;
    if (mimeType != null) result.mimeType = mimeType;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  MediaAsset._();

  factory MediaAsset.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MediaAsset.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MediaAsset',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aE<MediaOwnerType>(2, _omitFieldNames ? '' : 'ownerType',
        enumValues: MediaOwnerType.values)
    ..aOS(3, _omitFieldNames ? '' : 'ownerId')
    ..aE<MediaType>(4, _omitFieldNames ? '' : 'type',
        enumValues: MediaType.values)
    ..aOS(5, _omitFieldNames ? '' : 'url')
    ..aOS(6, _omitFieldNames ? '' : 'altText')
    ..aI(7, _omitFieldNames ? '' : 'width')
    ..aI(8, _omitFieldNames ? '' : 'height')
    ..aI(9, _omitFieldNames ? '' : 'durationSeconds')
    ..aInt64(10, _omitFieldNames ? '' : 'sizeBytes')
    ..aOS(11, _omitFieldNames ? '' : 'mimeType')
    ..aOS(12, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaAsset clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaAsset copyWith(void Function(MediaAsset) updates) =>
      super.copyWith((message) => updates(message as MediaAsset)) as MediaAsset;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MediaAsset create() => MediaAsset._();
  @$core.override
  MediaAsset createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MediaAsset getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MediaAsset>(create);
  static MediaAsset? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  MediaOwnerType get ownerType => $_getN(1);
  @$pb.TagNumber(2)
  set ownerType(MediaOwnerType value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasOwnerType() => $_has(1);
  @$pb.TagNumber(2)
  void clearOwnerType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get ownerId => $_getSZ(2);
  @$pb.TagNumber(3)
  set ownerId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOwnerId() => $_has(2);
  @$pb.TagNumber(3)
  void clearOwnerId() => $_clearField(3);

  @$pb.TagNumber(4)
  MediaType get type => $_getN(3);
  @$pb.TagNumber(4)
  set type(MediaType value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasType() => $_has(3);
  @$pb.TagNumber(4)
  void clearType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get url => $_getSZ(4);
  @$pb.TagNumber(5)
  set url($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearUrl() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get altText => $_getSZ(5);
  @$pb.TagNumber(6)
  set altText($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAltText() => $_has(5);
  @$pb.TagNumber(6)
  void clearAltText() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get width => $_getIZ(6);
  @$pb.TagNumber(7)
  set width($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasWidth() => $_has(6);
  @$pb.TagNumber(7)
  void clearWidth() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get height => $_getIZ(7);
  @$pb.TagNumber(8)
  set height($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasHeight() => $_has(7);
  @$pb.TagNumber(8)
  void clearHeight() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get durationSeconds => $_getIZ(8);
  @$pb.TagNumber(9)
  set durationSeconds($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDurationSeconds() => $_has(8);
  @$pb.TagNumber(9)
  void clearDurationSeconds() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get sizeBytes => $_getI64(9);
  @$pb.TagNumber(10)
  set sizeBytes($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasSizeBytes() => $_has(9);
  @$pb.TagNumber(10)
  void clearSizeBytes() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get mimeType => $_getSZ(10);
  @$pb.TagNumber(11)
  set mimeType($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasMimeType() => $_has(10);
  @$pb.TagNumber(11)
  void clearMimeType() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get createdAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set createdAt($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => $_clearField(12);
}

class AttributeSchema extends $pb.GeneratedMessage {
  factory AttributeSchema({
    $core.String? id,
    $core.String? domain,
    $core.String? name,
    $core.int? version,
    $core.String? jsonSchema,
    $core.Iterable<$core.String>? requiredFields,
    $core.String? uiHints,
    FulfillmentRules? fulfillmentRules,
    InventoryRules? inventoryRules,
    AvailabilityRules? availabilityRules,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (domain != null) result.domain = domain;
    if (name != null) result.name = name;
    if (version != null) result.version = version;
    if (jsonSchema != null) result.jsonSchema = jsonSchema;
    if (requiredFields != null) result.requiredFields.addAll(requiredFields);
    if (uiHints != null) result.uiHints = uiHints;
    if (fulfillmentRules != null) result.fulfillmentRules = fulfillmentRules;
    if (inventoryRules != null) result.inventoryRules = inventoryRules;
    if (availabilityRules != null) result.availabilityRules = availabilityRules;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  AttributeSchema._();

  factory AttributeSchema.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AttributeSchema.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AttributeSchema',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'domain')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aI(4, _omitFieldNames ? '' : 'version')
    ..aOS(5, _omitFieldNames ? '' : 'jsonSchema')
    ..pPS(6, _omitFieldNames ? '' : 'requiredFields')
    ..aOS(7, _omitFieldNames ? '' : 'uiHints')
    ..aOM<FulfillmentRules>(8, _omitFieldNames ? '' : 'fulfillmentRules',
        subBuilder: FulfillmentRules.create)
    ..aOM<InventoryRules>(9, _omitFieldNames ? '' : 'inventoryRules',
        subBuilder: InventoryRules.create)
    ..aOM<AvailabilityRules>(10, _omitFieldNames ? '' : 'availabilityRules',
        subBuilder: AvailabilityRules.create)
    ..aOS(11, _omitFieldNames ? '' : 'createdAt')
    ..aOS(12, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AttributeSchema clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AttributeSchema copyWith(void Function(AttributeSchema) updates) =>
      super.copyWith((message) => updates(message as AttributeSchema))
          as AttributeSchema;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AttributeSchema create() => AttributeSchema._();
  @$core.override
  AttributeSchema createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AttributeSchema getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AttributeSchema>(create);
  static AttributeSchema? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get domain => $_getSZ(1);
  @$pb.TagNumber(2)
  set domain($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDomain() => $_has(1);
  @$pb.TagNumber(2)
  void clearDomain() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get version => $_getIZ(3);
  @$pb.TagNumber(4)
  set version($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasVersion() => $_has(3);
  @$pb.TagNumber(4)
  void clearVersion() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get jsonSchema => $_getSZ(4);
  @$pb.TagNumber(5)
  set jsonSchema($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasJsonSchema() => $_has(4);
  @$pb.TagNumber(5)
  void clearJsonSchema() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get requiredFields => $_getList(5);

  @$pb.TagNumber(7)
  $core.String get uiHints => $_getSZ(6);
  @$pb.TagNumber(7)
  set uiHints($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasUiHints() => $_has(6);
  @$pb.TagNumber(7)
  void clearUiHints() => $_clearField(7);

  @$pb.TagNumber(8)
  FulfillmentRules get fulfillmentRules => $_getN(7);
  @$pb.TagNumber(8)
  set fulfillmentRules(FulfillmentRules value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasFulfillmentRules() => $_has(7);
  @$pb.TagNumber(8)
  void clearFulfillmentRules() => $_clearField(8);
  @$pb.TagNumber(8)
  FulfillmentRules ensureFulfillmentRules() => $_ensure(7);

  @$pb.TagNumber(9)
  InventoryRules get inventoryRules => $_getN(8);
  @$pb.TagNumber(9)
  set inventoryRules(InventoryRules value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasInventoryRules() => $_has(8);
  @$pb.TagNumber(9)
  void clearInventoryRules() => $_clearField(9);
  @$pb.TagNumber(9)
  InventoryRules ensureInventoryRules() => $_ensure(8);

  @$pb.TagNumber(10)
  AvailabilityRules get availabilityRules => $_getN(9);
  @$pb.TagNumber(10)
  set availabilityRules(AvailabilityRules value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasAvailabilityRules() => $_has(9);
  @$pb.TagNumber(10)
  void clearAvailabilityRules() => $_clearField(10);
  @$pb.TagNumber(10)
  AvailabilityRules ensureAvailabilityRules() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.String get createdAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set createdAt($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get updatedAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set updatedAt($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasUpdatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearUpdatedAt() => $_clearField(12);
}

class FulfillmentRules extends $pb.GeneratedMessage {
  factory FulfillmentRules({
    $core.Iterable<FulfillmentTypeSet>? allowed,
    $core.Iterable<FulfillmentTypeSet>? forbidden,
    $core.Iterable<FulfillmentType>? defaults,
  }) {
    final result = create();
    if (allowed != null) result.allowed.addAll(allowed);
    if (forbidden != null) result.forbidden.addAll(forbidden);
    if (defaults != null) result.defaults.addAll(defaults);
    return result;
  }

  FulfillmentRules._();

  factory FulfillmentRules.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FulfillmentRules.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FulfillmentRules',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..pPM<FulfillmentTypeSet>(1, _omitFieldNames ? '' : 'allowed',
        subBuilder: FulfillmentTypeSet.create)
    ..pPM<FulfillmentTypeSet>(2, _omitFieldNames ? '' : 'forbidden',
        subBuilder: FulfillmentTypeSet.create)
    ..pc<FulfillmentType>(
        3, _omitFieldNames ? '' : 'defaults', $pb.PbFieldType.KE,
        valueOf: FulfillmentType.valueOf,
        enumValues: FulfillmentType.values,
        defaultEnumValue: FulfillmentType.FULFILLMENT_TYPE_UNSPECIFIED)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FulfillmentRules clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FulfillmentRules copyWith(void Function(FulfillmentRules) updates) =>
      super.copyWith((message) => updates(message as FulfillmentRules))
          as FulfillmentRules;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FulfillmentRules create() => FulfillmentRules._();
  @$core.override
  FulfillmentRules createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FulfillmentRules getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FulfillmentRules>(create);
  static FulfillmentRules? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<FulfillmentTypeSet> get allowed => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<FulfillmentTypeSet> get forbidden => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<FulfillmentType> get defaults => $_getList(2);
}

class FulfillmentTypeSet extends $pb.GeneratedMessage {
  factory FulfillmentTypeSet({
    $core.Iterable<FulfillmentType>? types,
  }) {
    final result = create();
    if (types != null) result.types.addAll(types);
    return result;
  }

  FulfillmentTypeSet._();

  factory FulfillmentTypeSet.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FulfillmentTypeSet.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FulfillmentTypeSet',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..pc<FulfillmentType>(1, _omitFieldNames ? '' : 'types', $pb.PbFieldType.KE,
        valueOf: FulfillmentType.valueOf,
        enumValues: FulfillmentType.values,
        defaultEnumValue: FulfillmentType.FULFILLMENT_TYPE_UNSPECIFIED)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FulfillmentTypeSet clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FulfillmentTypeSet copyWith(void Function(FulfillmentTypeSet) updates) =>
      super.copyWith((message) => updates(message as FulfillmentTypeSet))
          as FulfillmentTypeSet;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FulfillmentTypeSet create() => FulfillmentTypeSet._();
  @$core.override
  FulfillmentTypeSet createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FulfillmentTypeSet getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FulfillmentTypeSet>(create);
  static FulfillmentTypeSet? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<FulfillmentType> get types => $_getList(0);
}

class InventoryRules extends $pb.GeneratedMessage {
  factory InventoryRules({
    $core.Iterable<InventoryPolicy>? allowedPolicies,
    InventoryPolicy? defaultPolicy,
  }) {
    final result = create();
    if (allowedPolicies != null) result.allowedPolicies.addAll(allowedPolicies);
    if (defaultPolicy != null) result.defaultPolicy = defaultPolicy;
    return result;
  }

  InventoryRules._();

  factory InventoryRules.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InventoryRules.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InventoryRules',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..pc<InventoryPolicy>(
        1, _omitFieldNames ? '' : 'allowedPolicies', $pb.PbFieldType.KE,
        valueOf: InventoryPolicy.valueOf,
        enumValues: InventoryPolicy.values,
        defaultEnumValue: InventoryPolicy.INVENTORY_POLICY_UNSPECIFIED)
    ..aE<InventoryPolicy>(2, _omitFieldNames ? '' : 'defaultPolicy',
        enumValues: InventoryPolicy.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InventoryRules clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InventoryRules copyWith(void Function(InventoryRules) updates) =>
      super.copyWith((message) => updates(message as InventoryRules))
          as InventoryRules;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InventoryRules create() => InventoryRules._();
  @$core.override
  InventoryRules createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InventoryRules getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InventoryRules>(create);
  static InventoryRules? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InventoryPolicy> get allowedPolicies => $_getList(0);

  @$pb.TagNumber(2)
  InventoryPolicy get defaultPolicy => $_getN(1);
  @$pb.TagNumber(2)
  set defaultPolicy(InventoryPolicy value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasDefaultPolicy() => $_has(1);
  @$pb.TagNumber(2)
  void clearDefaultPolicy() => $_clearField(2);
}

class AvailabilityRules extends $pb.GeneratedMessage {
  factory AvailabilityRules({
    $core.Iterable<AvailabilityType>? allowedTypes,
    $core.bool? required,
  }) {
    final result = create();
    if (allowedTypes != null) result.allowedTypes.addAll(allowedTypes);
    if (required != null) result.required = required;
    return result;
  }

  AvailabilityRules._();

  factory AvailabilityRules.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AvailabilityRules.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AvailabilityRules',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..pc<AvailabilityType>(
        1, _omitFieldNames ? '' : 'allowedTypes', $pb.PbFieldType.KE,
        valueOf: AvailabilityType.valueOf,
        enumValues: AvailabilityType.values,
        defaultEnumValue: AvailabilityType.AVAILABILITY_TYPE_UNSPECIFIED)
    ..aOB(2, _omitFieldNames ? '' : 'required')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AvailabilityRules clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AvailabilityRules copyWith(void Function(AvailabilityRules) updates) =>
      super.copyWith((message) => updates(message as AvailabilityRules))
          as AvailabilityRules;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AvailabilityRules create() => AvailabilityRules._();
  @$core.override
  AvailabilityRules createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AvailabilityRules getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AvailabilityRules>(create);
  static AvailabilityRules? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AvailabilityType> get allowedTypes => $_getList(0);

  @$pb.TagNumber(2)
  $core.bool get required => $_getBF(1);
  @$pb.TagNumber(2)
  set required($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRequired() => $_has(1);
  @$pb.TagNumber(2)
  void clearRequired() => $_clearField(2);
}

class Money extends $pb.GeneratedMessage {
  factory Money({
    $core.String? amount,
    $core.String? currency,
  }) {
    final result = create();
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    return result;
  }

  Money._();

  factory Money.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Money.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Money',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'amount')
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Money clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Money copyWith(void Function(Money) updates) =>
      super.copyWith((message) => updates(message as Money)) as Money;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Money create() => Money._();
  @$core.override
  Money createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Money getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Money>(create);
  static Money? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get amount => $_getSZ(0);
  @$pb.TagNumber(1)
  set amount($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmount() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => $_clearField(2);
}

class GeoLocation extends $pb.GeneratedMessage {
  factory GeoLocation({
    $core.double? lat,
    $core.double? lng,
    $core.String? address,
    $core.String? city,
    $core.String? state,
    $core.String? country,
    $core.String? postalCode,
  }) {
    final result = create();
    if (lat != null) result.lat = lat;
    if (lng != null) result.lng = lng;
    if (address != null) result.address = address;
    if (city != null) result.city = city;
    if (state != null) result.state = state;
    if (country != null) result.country = country;
    if (postalCode != null) result.postalCode = postalCode;
    return result;
  }

  GeoLocation._();

  factory GeoLocation.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GeoLocation.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GeoLocation',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aD(1, _omitFieldNames ? '' : 'lat')
    ..aD(2, _omitFieldNames ? '' : 'lng')
    ..aOS(3, _omitFieldNames ? '' : 'address')
    ..aOS(4, _omitFieldNames ? '' : 'city')
    ..aOS(5, _omitFieldNames ? '' : 'state')
    ..aOS(6, _omitFieldNames ? '' : 'country')
    ..aOS(7, _omitFieldNames ? '' : 'postalCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GeoLocation clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GeoLocation copyWith(void Function(GeoLocation) updates) =>
      super.copyWith((message) => updates(message as GeoLocation))
          as GeoLocation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GeoLocation create() => GeoLocation._();
  @$core.override
  GeoLocation createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GeoLocation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GeoLocation>(create);
  static GeoLocation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get lat => $_getN(0);
  @$pb.TagNumber(1)
  set lat($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLat() => $_has(0);
  @$pb.TagNumber(1)
  void clearLat() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get lng => $_getN(1);
  @$pb.TagNumber(2)
  set lng($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLng() => $_has(1);
  @$pb.TagNumber(2)
  void clearLng() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get address => $_getSZ(2);
  @$pb.TagNumber(3)
  set address($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAddress() => $_has(2);
  @$pb.TagNumber(3)
  void clearAddress() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get city => $_getSZ(3);
  @$pb.TagNumber(4)
  set city($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCity() => $_has(3);
  @$pb.TagNumber(4)
  void clearCity() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get state => $_getSZ(4);
  @$pb.TagNumber(5)
  set state($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasState() => $_has(4);
  @$pb.TagNumber(5)
  void clearState() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get country => $_getSZ(5);
  @$pb.TagNumber(6)
  set country($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCountry() => $_has(5);
  @$pb.TagNumber(6)
  void clearCountry() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get postalCode => $_getSZ(6);
  @$pb.TagNumber(7)
  set postalCode($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPostalCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearPostalCode() => $_clearField(7);
}

class SEO extends $pb.GeneratedMessage {
  factory SEO({
    $core.String? title,
    $core.String? description,
    $core.String? ogImage,
    $core.String? canonicalUrl,
  }) {
    final result = create();
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (ogImage != null) result.ogImage = ogImage;
    if (canonicalUrl != null) result.canonicalUrl = canonicalUrl;
    return result;
  }

  SEO._();

  factory SEO.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SEO.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SEO',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'title')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..aOS(3, _omitFieldNames ? '' : 'ogImage')
    ..aOS(4, _omitFieldNames ? '' : 'canonicalUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SEO clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SEO copyWith(void Function(SEO) updates) =>
      super.copyWith((message) => updates(message as SEO)) as SEO;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SEO create() => SEO._();
  @$core.override
  SEO createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SEO getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SEO>(create);
  static SEO? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get ogImage => $_getSZ(2);
  @$pb.TagNumber(3)
  set ogImage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOgImage() => $_has(2);
  @$pb.TagNumber(3)
  void clearOgImage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get canonicalUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set canonicalUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCanonicalUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearCanonicalUrl() => $_clearField(4);
}

class Contact extends $pb.GeneratedMessage {
  factory Contact({
    $core.String? phone,
    $core.String? email,
    $core.String? whatsapp,
  }) {
    final result = create();
    if (phone != null) result.phone = phone;
    if (email != null) result.email = email;
    if (whatsapp != null) result.whatsapp = whatsapp;
    return result;
  }

  Contact._();

  factory Contact.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Contact.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Contact',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'phone')
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..aOS(3, _omitFieldNames ? '' : 'whatsapp')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Contact clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Contact copyWith(void Function(Contact) updates) =>
      super.copyWith((message) => updates(message as Contact)) as Contact;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Contact create() => Contact._();
  @$core.override
  Contact createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Contact getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Contact>(create);
  static Contact? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phone => $_getSZ(0);
  @$pb.TagNumber(1)
  set phone($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPhone() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhone() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get whatsapp => $_getSZ(2);
  @$pb.TagNumber(3)
  set whatsapp($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasWhatsapp() => $_has(2);
  @$pb.TagNumber(3)
  void clearWhatsapp() => $_clearField(3);
}

class Option extends $pb.GeneratedMessage {
  factory Option({
    $core.String? name,
    $core.String? value,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (value != null) result.value = value;
    return result;
  }

  Option._();

  factory Option.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Option.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Option',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'value')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Option clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Option copyWith(void Function(Option) updates) =>
      super.copyWith((message) => updates(message as Option)) as Option;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Option create() => Option._();
  @$core.override
  Option createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Option getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Option>(create);
  static Option? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get value => $_getSZ(1);
  @$pb.TagNumber(2)
  set value($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => $_clearField(2);
}

class InventoryInfo extends $pb.GeneratedMessage {
  factory InventoryInfo({
    $core.int? quantity,
    $core.int? reserved,
    $core.int? available,
  }) {
    final result = create();
    if (quantity != null) result.quantity = quantity;
    if (reserved != null) result.reserved = reserved;
    if (available != null) result.available = available;
    return result;
  }

  InventoryInfo._();

  factory InventoryInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InventoryInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InventoryInfo',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'quantity')
    ..aI(2, _omitFieldNames ? '' : 'reserved')
    ..aI(3, _omitFieldNames ? '' : 'available')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InventoryInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InventoryInfo copyWith(void Function(InventoryInfo) updates) =>
      super.copyWith((message) => updates(message as InventoryInfo))
          as InventoryInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InventoryInfo create() => InventoryInfo._();
  @$core.override
  InventoryInfo createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InventoryInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InventoryInfo>(create);
  static InventoryInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get quantity => $_getIZ(0);
  @$pb.TagNumber(1)
  set quantity($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuantity() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuantity() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get reserved => $_getIZ(1);
  @$pb.TagNumber(2)
  set reserved($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReserved() => $_has(1);
  @$pb.TagNumber(2)
  void clearReserved() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get available => $_getIZ(2);
  @$pb.TagNumber(3)
  set available($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAvailable() => $_has(2);
  @$pb.TagNumber(3)
  void clearAvailable() => $_clearField(3);
}

class AvailabilityRule extends $pb.GeneratedMessage {
  factory AvailabilityRule({
    AvailabilityType? type,
    $core.Iterable<TimeSlot>? schedule,
    $core.String? startDate,
    $core.String? endDate,
    $core.String? expiryDate,
    $core.int? shelfLifeDays,
    $core.String? bestBefore,
    $core.Iterable<Season>? seasons,
    $core.Iterable<$core.String>? blackoutDates,
    $core.int? leadTimeHours,
  }) {
    final result = create();
    if (type != null) result.type = type;
    if (schedule != null) result.schedule.addAll(schedule);
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (expiryDate != null) result.expiryDate = expiryDate;
    if (shelfLifeDays != null) result.shelfLifeDays = shelfLifeDays;
    if (bestBefore != null) result.bestBefore = bestBefore;
    if (seasons != null) result.seasons.addAll(seasons);
    if (blackoutDates != null) result.blackoutDates.addAll(blackoutDates);
    if (leadTimeHours != null) result.leadTimeHours = leadTimeHours;
    return result;
  }

  AvailabilityRule._();

  factory AvailabilityRule.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AvailabilityRule.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AvailabilityRule',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aE<AvailabilityType>(1, _omitFieldNames ? '' : 'type',
        enumValues: AvailabilityType.values)
    ..pPM<TimeSlot>(2, _omitFieldNames ? '' : 'schedule',
        subBuilder: TimeSlot.create)
    ..aOS(3, _omitFieldNames ? '' : 'startDate')
    ..aOS(4, _omitFieldNames ? '' : 'endDate')
    ..aOS(5, _omitFieldNames ? '' : 'expiryDate')
    ..aI(6, _omitFieldNames ? '' : 'shelfLifeDays')
    ..aOS(7, _omitFieldNames ? '' : 'bestBefore')
    ..pPM<Season>(8, _omitFieldNames ? '' : 'seasons',
        subBuilder: Season.create)
    ..pPS(9, _omitFieldNames ? '' : 'blackoutDates')
    ..aI(10, _omitFieldNames ? '' : 'leadTimeHours')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AvailabilityRule clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AvailabilityRule copyWith(void Function(AvailabilityRule) updates) =>
      super.copyWith((message) => updates(message as AvailabilityRule))
          as AvailabilityRule;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AvailabilityRule create() => AvailabilityRule._();
  @$core.override
  AvailabilityRule createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AvailabilityRule getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AvailabilityRule>(create);
  static AvailabilityRule? _defaultInstance;

  @$pb.TagNumber(1)
  AvailabilityType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(AvailabilityType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<TimeSlot> get schedule => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get startDate => $_getSZ(2);
  @$pb.TagNumber(3)
  set startDate($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStartDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearStartDate() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get endDate => $_getSZ(3);
  @$pb.TagNumber(4)
  set endDate($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEndDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearEndDate() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get expiryDate => $_getSZ(4);
  @$pb.TagNumber(5)
  set expiryDate($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasExpiryDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearExpiryDate() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get shelfLifeDays => $_getIZ(5);
  @$pb.TagNumber(6)
  set shelfLifeDays($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasShelfLifeDays() => $_has(5);
  @$pb.TagNumber(6)
  void clearShelfLifeDays() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get bestBefore => $_getSZ(6);
  @$pb.TagNumber(7)
  set bestBefore($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBestBefore() => $_has(6);
  @$pb.TagNumber(7)
  void clearBestBefore() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<Season> get seasons => $_getList(7);

  @$pb.TagNumber(9)
  $pb.PbList<$core.String> get blackoutDates => $_getList(8);

  @$pb.TagNumber(10)
  $core.int get leadTimeHours => $_getIZ(9);
  @$pb.TagNumber(10)
  set leadTimeHours($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasLeadTimeHours() => $_has(9);
  @$pb.TagNumber(10)
  void clearLeadTimeHours() => $_clearField(10);
}

class TimeSlot extends $pb.GeneratedMessage {
  factory TimeSlot({
    $core.int? dayOfWeek,
    $core.String? startTime,
    $core.String? endTime,
    $core.String? timezone,
  }) {
    final result = create();
    if (dayOfWeek != null) result.dayOfWeek = dayOfWeek;
    if (startTime != null) result.startTime = startTime;
    if (endTime != null) result.endTime = endTime;
    if (timezone != null) result.timezone = timezone;
    return result;
  }

  TimeSlot._();

  factory TimeSlot.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TimeSlot.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TimeSlot',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'dayOfWeek')
    ..aOS(2, _omitFieldNames ? '' : 'startTime')
    ..aOS(3, _omitFieldNames ? '' : 'endTime')
    ..aOS(4, _omitFieldNames ? '' : 'timezone')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TimeSlot clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TimeSlot copyWith(void Function(TimeSlot) updates) =>
      super.copyWith((message) => updates(message as TimeSlot)) as TimeSlot;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TimeSlot create() => TimeSlot._();
  @$core.override
  TimeSlot createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TimeSlot getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TimeSlot>(create);
  static TimeSlot? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get dayOfWeek => $_getIZ(0);
  @$pb.TagNumber(1)
  set dayOfWeek($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDayOfWeek() => $_has(0);
  @$pb.TagNumber(1)
  void clearDayOfWeek() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get startTime => $_getSZ(1);
  @$pb.TagNumber(2)
  set startTime($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStartTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartTime() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get endTime => $_getSZ(2);
  @$pb.TagNumber(3)
  set endTime($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEndTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearEndTime() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get timezone => $_getSZ(3);
  @$pb.TagNumber(4)
  set timezone($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTimezone() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimezone() => $_clearField(4);
}

class Season extends $pb.GeneratedMessage {
  factory Season({
    $core.String? name,
    $core.int? startMonth,
    $core.int? endMonth,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (startMonth != null) result.startMonth = startMonth;
    if (endMonth != null) result.endMonth = endMonth;
    return result;
  }

  Season._();

  factory Season.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Season.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Season',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aI(2, _omitFieldNames ? '' : 'startMonth')
    ..aI(3, _omitFieldNames ? '' : 'endMonth')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Season clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Season copyWith(void Function(Season) updates) =>
      super.copyWith((message) => updates(message as Season)) as Season;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Season create() => Season._();
  @$core.override
  Season createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Season getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Season>(create);
  static Season? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get startMonth => $_getIZ(1);
  @$pb.TagNumber(2)
  set startMonth($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStartMonth() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartMonth() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get endMonth => $_getIZ(2);
  @$pb.TagNumber(3)
  set endMonth($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEndMonth() => $_has(2);
  @$pb.TagNumber(3)
  void clearEndMonth() => $_clearField(3);
}

class TraceEvent extends $pb.GeneratedMessage {
  factory TraceEvent({
    $core.String? id,
    $core.String? productId,
    $core.String? eventType,
    $core.String? description,
    $core.String? fromParty,
    $core.String? toParty,
    GeoLocation? location,
    $core.String? timestamp,
    $core.String? recordHash,
    $core.String? previousHash,
    $core.int? sequenceNumber,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (productId != null) result.productId = productId;
    if (eventType != null) result.eventType = eventType;
    if (description != null) result.description = description;
    if (fromParty != null) result.fromParty = fromParty;
    if (toParty != null) result.toParty = toParty;
    if (location != null) result.location = location;
    if (timestamp != null) result.timestamp = timestamp;
    if (recordHash != null) result.recordHash = recordHash;
    if (previousHash != null) result.previousHash = previousHash;
    if (sequenceNumber != null) result.sequenceNumber = sequenceNumber;
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  TraceEvent._();

  factory TraceEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TraceEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TraceEvent',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'productId')
    ..aOS(3, _omitFieldNames ? '' : 'eventType')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aOS(5, _omitFieldNames ? '' : 'fromParty')
    ..aOS(6, _omitFieldNames ? '' : 'toParty')
    ..aOM<GeoLocation>(7, _omitFieldNames ? '' : 'location',
        subBuilder: GeoLocation.create)
    ..aOS(8, _omitFieldNames ? '' : 'timestamp')
    ..aOS(9, _omitFieldNames ? '' : 'recordHash')
    ..aOS(10, _omitFieldNames ? '' : 'previousHash')
    ..aI(11, _omitFieldNames ? '' : 'sequenceNumber')
    ..m<$core.String, $core.String>(12, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'TraceEvent.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('marketplace_core'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TraceEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TraceEvent copyWith(void Function(TraceEvent) updates) =>
      super.copyWith((message) => updates(message as TraceEvent)) as TraceEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TraceEvent create() => TraceEvent._();
  @$core.override
  TraceEvent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TraceEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TraceEvent>(create);
  static TraceEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get productId => $_getSZ(1);
  @$pb.TagNumber(2)
  set productId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProductId() => $_has(1);
  @$pb.TagNumber(2)
  void clearProductId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get eventType => $_getSZ(2);
  @$pb.TagNumber(3)
  set eventType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEventType() => $_has(2);
  @$pb.TagNumber(3)
  void clearEventType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get fromParty => $_getSZ(4);
  @$pb.TagNumber(5)
  set fromParty($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFromParty() => $_has(4);
  @$pb.TagNumber(5)
  void clearFromParty() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get toParty => $_getSZ(5);
  @$pb.TagNumber(6)
  set toParty($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasToParty() => $_has(5);
  @$pb.TagNumber(6)
  void clearToParty() => $_clearField(6);

  @$pb.TagNumber(7)
  GeoLocation get location => $_getN(6);
  @$pb.TagNumber(7)
  set location(GeoLocation value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasLocation() => $_has(6);
  @$pb.TagNumber(7)
  void clearLocation() => $_clearField(7);
  @$pb.TagNumber(7)
  GeoLocation ensureLocation() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.String get timestamp => $_getSZ(7);
  @$pb.TagNumber(8)
  set timestamp($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTimestamp() => $_has(7);
  @$pb.TagNumber(8)
  void clearTimestamp() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get recordHash => $_getSZ(8);
  @$pb.TagNumber(9)
  set recordHash($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasRecordHash() => $_has(8);
  @$pb.TagNumber(9)
  void clearRecordHash() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get previousHash => $_getSZ(9);
  @$pb.TagNumber(10)
  set previousHash($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasPreviousHash() => $_has(9);
  @$pb.TagNumber(10)
  void clearPreviousHash() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get sequenceNumber => $_getIZ(10);
  @$pb.TagNumber(11)
  set sequenceNumber($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasSequenceNumber() => $_has(10);
  @$pb.TagNumber(11)
  void clearSequenceNumber() => $_clearField(11);

  @$pb.TagNumber(12)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(11);
}

class TraceChain extends $pb.GeneratedMessage {
  factory TraceChain({
    $core.String? productId,
    $core.Iterable<TraceEvent>? events,
    $core.bool? integrityVerified,
  }) {
    final result = create();
    if (productId != null) result.productId = productId;
    if (events != null) result.events.addAll(events);
    if (integrityVerified != null) result.integrityVerified = integrityVerified;
    return result;
  }

  TraceChain._();

  factory TraceChain.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TraceChain.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TraceChain',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'productId')
    ..pPM<TraceEvent>(2, _omitFieldNames ? '' : 'events',
        subBuilder: TraceEvent.create)
    ..aOB(3, _omitFieldNames ? '' : 'integrityVerified')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TraceChain clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TraceChain copyWith(void Function(TraceChain) updates) =>
      super.copyWith((message) => updates(message as TraceChain)) as TraceChain;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TraceChain create() => TraceChain._();
  @$core.override
  TraceChain createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TraceChain getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TraceChain>(create);
  static TraceChain? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get productId => $_getSZ(0);
  @$pb.TagNumber(1)
  set productId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProductId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProductId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<TraceEvent> get events => $_getList(1);

  @$pb.TagNumber(3)
  $core.bool get integrityVerified => $_getBF(2);
  @$pb.TagNumber(3)
  set integrityVerified($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIntegrityVerified() => $_has(2);
  @$pb.TagNumber(3)
  void clearIntegrityVerified() => $_clearField(3);
}

class Rating extends $pb.GeneratedMessage {
  factory Rating({
    $core.String? id,
    $core.String? fromId,
    $core.String? toId,
    $core.String? productId,
    $core.String? transactionId,
    $core.int? score,
    $core.String? comment,
    $core.String? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (fromId != null) result.fromId = fromId;
    if (toId != null) result.toId = toId;
    if (productId != null) result.productId = productId;
    if (transactionId != null) result.transactionId = transactionId;
    if (score != null) result.score = score;
    if (comment != null) result.comment = comment;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  Rating._();

  factory Rating.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Rating.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Rating',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'fromId')
    ..aOS(3, _omitFieldNames ? '' : 'toId')
    ..aOS(4, _omitFieldNames ? '' : 'productId')
    ..aOS(5, _omitFieldNames ? '' : 'transactionId')
    ..aI(6, _omitFieldNames ? '' : 'score')
    ..aOS(7, _omitFieldNames ? '' : 'comment')
    ..aOS(8, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Rating clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Rating copyWith(void Function(Rating) updates) =>
      super.copyWith((message) => updates(message as Rating)) as Rating;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Rating create() => Rating._();
  @$core.override
  Rating createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Rating getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Rating>(create);
  static Rating? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get fromId => $_getSZ(1);
  @$pb.TagNumber(2)
  set fromId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFromId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFromId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get toId => $_getSZ(2);
  @$pb.TagNumber(3)
  set toId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasToId() => $_has(2);
  @$pb.TagNumber(3)
  void clearToId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get productId => $_getSZ(3);
  @$pb.TagNumber(4)
  set productId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasProductId() => $_has(3);
  @$pb.TagNumber(4)
  void clearProductId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get transactionId => $_getSZ(4);
  @$pb.TagNumber(5)
  set transactionId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTransactionId() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransactionId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get score => $_getIZ(5);
  @$pb.TagNumber(6)
  set score($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasScore() => $_has(5);
  @$pb.TagNumber(6)
  void clearScore() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get comment => $_getSZ(6);
  @$pb.TagNumber(7)
  set comment($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasComment() => $_has(6);
  @$pb.TagNumber(7)
  void clearComment() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get createdAt => $_getSZ(7);
  @$pb.TagNumber(8)
  set createdAt($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => $_clearField(8);
}

class ReputationScore extends $pb.GeneratedMessage {
  factory ReputationScore({
    $core.String? entityId,
    $core.double? averageScore,
    $core.int? totalRatings,
    $core.Iterable<$core.MapEntry<$core.String, $core.int>>? scoreDistribution,
    $core.String? lastUpdated,
  }) {
    final result = create();
    if (entityId != null) result.entityId = entityId;
    if (averageScore != null) result.averageScore = averageScore;
    if (totalRatings != null) result.totalRatings = totalRatings;
    if (scoreDistribution != null)
      result.scoreDistribution.addEntries(scoreDistribution);
    if (lastUpdated != null) result.lastUpdated = lastUpdated;
    return result;
  }

  ReputationScore._();

  factory ReputationScore.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReputationScore.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReputationScore',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'entityId')
    ..aD(2, _omitFieldNames ? '' : 'averageScore')
    ..aI(3, _omitFieldNames ? '' : 'totalRatings')
    ..m<$core.String, $core.int>(4, _omitFieldNames ? '' : 'scoreDistribution',
        entryClassName: 'ReputationScore.ScoreDistributionEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.O3,
        packageName: const $pb.PackageName('marketplace_core'))
    ..aOS(5, _omitFieldNames ? '' : 'lastUpdated')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReputationScore clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReputationScore copyWith(void Function(ReputationScore) updates) =>
      super.copyWith((message) => updates(message as ReputationScore))
          as ReputationScore;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReputationScore create() => ReputationScore._();
  @$core.override
  ReputationScore createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ReputationScore getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReputationScore>(create);
  static ReputationScore? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get entityId => $_getSZ(0);
  @$pb.TagNumber(1)
  set entityId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEntityId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEntityId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get averageScore => $_getN(1);
  @$pb.TagNumber(2)
  set averageScore($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAverageScore() => $_has(1);
  @$pb.TagNumber(2)
  void clearAverageScore() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalRatings => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalRatings($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalRatings() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalRatings() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbMap<$core.String, $core.int> get scoreDistribution => $_getMap(3);

  @$pb.TagNumber(5)
  $core.String get lastUpdated => $_getSZ(4);
  @$pb.TagNumber(5)
  set lastUpdated($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasLastUpdated() => $_has(4);
  @$pb.TagNumber(5)
  void clearLastUpdated() => $_clearField(5);
}

class ReviewHistory extends $pb.GeneratedMessage {
  factory ReviewHistory({
    $core.String? entityId,
    $core.Iterable<Rating>? ratings,
    $core.int? total,
  }) {
    final result = create();
    if (entityId != null) result.entityId = entityId;
    if (ratings != null) result.ratings.addAll(ratings);
    if (total != null) result.total = total;
    return result;
  }

  ReviewHistory._();

  factory ReviewHistory.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReviewHistory.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReviewHistory',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'entityId')
    ..pPM<Rating>(2, _omitFieldNames ? '' : 'ratings',
        subBuilder: Rating.create)
    ..aI(3, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReviewHistory clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReviewHistory copyWith(void Function(ReviewHistory) updates) =>
      super.copyWith((message) => updates(message as ReviewHistory))
          as ReviewHistory;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReviewHistory create() => ReviewHistory._();
  @$core.override
  ReviewHistory createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ReviewHistory getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReviewHistory>(create);
  static ReviewHistory? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get entityId => $_getSZ(0);
  @$pb.TagNumber(1)
  set entityId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEntityId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEntityId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<Rating> get ratings => $_getList(1);

  @$pb.TagNumber(3)
  $core.int get total => $_getIZ(2);
  @$pb.TagNumber(3)
  set total($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotal() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotal() => $_clearField(3);
}

class CreateProductRequest extends $pb.GeneratedMessage {
  factory CreateProductRequest({
    $core.String? vendorId,
    $core.String? title,
    $core.String? description,
    $core.String? productType,
    $core.Iterable<$core.String>? tags,
    $core.String? schemaRef,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? attributes,
    GeoLocation? geo,
    SEO? seo,
  }) {
    final result = create();
    if (vendorId != null) result.vendorId = vendorId;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (productType != null) result.productType = productType;
    if (tags != null) result.tags.addAll(tags);
    if (schemaRef != null) result.schemaRef = schemaRef;
    if (attributes != null) result.attributes.addEntries(attributes);
    if (geo != null) result.geo = geo;
    if (seo != null) result.seo = seo;
    return result;
  }

  CreateProductRequest._();

  factory CreateProductRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateProductRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateProductRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'vendorId')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'productType')
    ..pPS(5, _omitFieldNames ? '' : 'tags')
    ..aOS(6, _omitFieldNames ? '' : 'schemaRef')
    ..m<$core.String, $core.String>(7, _omitFieldNames ? '' : 'attributes',
        entryClassName: 'CreateProductRequest.AttributesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('marketplace_core'))
    ..aOM<GeoLocation>(8, _omitFieldNames ? '' : 'geo',
        subBuilder: GeoLocation.create)
    ..aOM<SEO>(9, _omitFieldNames ? '' : 'seo', subBuilder: SEO.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateProductRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateProductRequest copyWith(void Function(CreateProductRequest) updates) =>
      super.copyWith((message) => updates(message as CreateProductRequest))
          as CreateProductRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateProductRequest create() => CreateProductRequest._();
  @$core.override
  CreateProductRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateProductRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateProductRequest>(create);
  static CreateProductRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get vendorId => $_getSZ(0);
  @$pb.TagNumber(1)
  set vendorId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVendorId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVendorId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get productType => $_getSZ(3);
  @$pb.TagNumber(4)
  set productType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasProductType() => $_has(3);
  @$pb.TagNumber(4)
  void clearProductType() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get tags => $_getList(4);

  @$pb.TagNumber(6)
  $core.String get schemaRef => $_getSZ(5);
  @$pb.TagNumber(6)
  set schemaRef($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSchemaRef() => $_has(5);
  @$pb.TagNumber(6)
  void clearSchemaRef() => $_clearField(6);

  @$pb.TagNumber(7)
  $pb.PbMap<$core.String, $core.String> get attributes => $_getMap(6);

  @$pb.TagNumber(8)
  GeoLocation get geo => $_getN(7);
  @$pb.TagNumber(8)
  set geo(GeoLocation value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasGeo() => $_has(7);
  @$pb.TagNumber(8)
  void clearGeo() => $_clearField(8);
  @$pb.TagNumber(8)
  GeoLocation ensureGeo() => $_ensure(7);

  @$pb.TagNumber(9)
  SEO get seo => $_getN(8);
  @$pb.TagNumber(9)
  set seo(SEO value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasSeo() => $_has(8);
  @$pb.TagNumber(9)
  void clearSeo() => $_clearField(9);
  @$pb.TagNumber(9)
  SEO ensureSeo() => $_ensure(8);
}

class UpdateProductRequest extends $pb.GeneratedMessage {
  factory UpdateProductRequest({
    $core.String? id,
    $core.String? title,
    $core.String? description,
    $core.Iterable<$core.String>? tags,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? attributes,
    GeoLocation? geo,
    SEO? seo,
    ProductStatus? status,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (tags != null) result.tags.addAll(tags);
    if (attributes != null) result.attributes.addEntries(attributes);
    if (geo != null) result.geo = geo;
    if (seo != null) result.seo = seo;
    if (status != null) result.status = status;
    return result;
  }

  UpdateProductRequest._();

  factory UpdateProductRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateProductRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateProductRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..pPS(4, _omitFieldNames ? '' : 'tags')
    ..m<$core.String, $core.String>(5, _omitFieldNames ? '' : 'attributes',
        entryClassName: 'UpdateProductRequest.AttributesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('marketplace_core'))
    ..aOM<GeoLocation>(6, _omitFieldNames ? '' : 'geo',
        subBuilder: GeoLocation.create)
    ..aOM<SEO>(7, _omitFieldNames ? '' : 'seo', subBuilder: SEO.create)
    ..aE<ProductStatus>(8, _omitFieldNames ? '' : 'status',
        enumValues: ProductStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateProductRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateProductRequest copyWith(void Function(UpdateProductRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateProductRequest))
          as UpdateProductRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateProductRequest create() => UpdateProductRequest._();
  @$core.override
  UpdateProductRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateProductRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateProductRequest>(create);
  static UpdateProductRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get tags => $_getList(3);

  @$pb.TagNumber(5)
  $pb.PbMap<$core.String, $core.String> get attributes => $_getMap(4);

  @$pb.TagNumber(6)
  GeoLocation get geo => $_getN(5);
  @$pb.TagNumber(6)
  set geo(GeoLocation value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasGeo() => $_has(5);
  @$pb.TagNumber(6)
  void clearGeo() => $_clearField(6);
  @$pb.TagNumber(6)
  GeoLocation ensureGeo() => $_ensure(5);

  @$pb.TagNumber(7)
  SEO get seo => $_getN(6);
  @$pb.TagNumber(7)
  set seo(SEO value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasSeo() => $_has(6);
  @$pb.TagNumber(7)
  void clearSeo() => $_clearField(7);
  @$pb.TagNumber(7)
  SEO ensureSeo() => $_ensure(6);

  @$pb.TagNumber(8)
  ProductStatus get status => $_getN(7);
  @$pb.TagNumber(8)
  set status(ProductStatus value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => $_clearField(8);
}

class ArchiveProductRequest extends $pb.GeneratedMessage {
  factory ArchiveProductRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  ArchiveProductRequest._();

  factory ArchiveProductRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ArchiveProductRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ArchiveProductRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ArchiveProductRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ArchiveProductRequest copyWith(
          void Function(ArchiveProductRequest) updates) =>
      super.copyWith((message) => updates(message as ArchiveProductRequest))
          as ArchiveProductRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ArchiveProductRequest create() => ArchiveProductRequest._();
  @$core.override
  ArchiveProductRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ArchiveProductRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ArchiveProductRequest>(create);
  static ArchiveProductRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class GetProductRequest extends $pb.GeneratedMessage {
  factory GetProductRequest({
    $core.String? id,
    $core.String? slug,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (slug != null) result.slug = slug;
    return result;
  }

  GetProductRequest._();

  factory GetProductRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetProductRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetProductRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'slug')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetProductRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetProductRequest copyWith(void Function(GetProductRequest) updates) =>
      super.copyWith((message) => updates(message as GetProductRequest))
          as GetProductRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetProductRequest create() => GetProductRequest._();
  @$core.override
  GetProductRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetProductRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetProductRequest>(create);
  static GetProductRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get slug => $_getSZ(1);
  @$pb.TagNumber(2)
  set slug($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSlug() => $_has(1);
  @$pb.TagNumber(2)
  void clearSlug() => $_clearField(2);
}

class ListProductsRequest extends $pb.GeneratedMessage {
  factory ListProductsRequest({
    $core.String? vendorId,
    ProductStatus? status,
    $core.int? limit,
    $core.String? cursor,
  }) {
    final result = create();
    if (vendorId != null) result.vendorId = vendorId;
    if (status != null) result.status = status;
    if (limit != null) result.limit = limit;
    if (cursor != null) result.cursor = cursor;
    return result;
  }

  ListProductsRequest._();

  factory ListProductsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListProductsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListProductsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'vendorId')
    ..aE<ProductStatus>(2, _omitFieldNames ? '' : 'status',
        enumValues: ProductStatus.values)
    ..aI(3, _omitFieldNames ? '' : 'limit')
    ..aOS(4, _omitFieldNames ? '' : 'cursor')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListProductsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListProductsRequest copyWith(void Function(ListProductsRequest) updates) =>
      super.copyWith((message) => updates(message as ListProductsRequest))
          as ListProductsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListProductsRequest create() => ListProductsRequest._();
  @$core.override
  ListProductsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListProductsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListProductsRequest>(create);
  static ListProductsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get vendorId => $_getSZ(0);
  @$pb.TagNumber(1)
  set vendorId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVendorId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVendorId() => $_clearField(1);

  @$pb.TagNumber(2)
  ProductStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(ProductStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get cursor => $_getSZ(3);
  @$pb.TagNumber(4)
  set cursor($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCursor() => $_has(3);
  @$pb.TagNumber(4)
  void clearCursor() => $_clearField(4);
}

class ProductPage extends $pb.GeneratedMessage {
  factory ProductPage({
    $core.Iterable<Product>? products,
    $core.String? nextCursor,
    $core.int? total,
  }) {
    final result = create();
    if (products != null) result.products.addAll(products);
    if (nextCursor != null) result.nextCursor = nextCursor;
    if (total != null) result.total = total;
    return result;
  }

  ProductPage._();

  factory ProductPage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProductPage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProductPage',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..pPM<Product>(1, _omitFieldNames ? '' : 'products',
        subBuilder: Product.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextCursor')
    ..aI(3, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProductPage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProductPage copyWith(void Function(ProductPage) updates) =>
      super.copyWith((message) => updates(message as ProductPage))
          as ProductPage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProductPage create() => ProductPage._();
  @$core.override
  ProductPage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ProductPage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProductPage>(create);
  static ProductPage? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Product> get products => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextCursor => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextCursor($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextCursor() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextCursor() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get total => $_getIZ(2);
  @$pb.TagNumber(3)
  set total($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotal() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotal() => $_clearField(3);
}

class CreateVariantRequest extends $pb.GeneratedMessage {
  factory CreateVariantRequest({
    $core.String? productId,
    $core.String? title,
    $core.String? sku,
    Money? price,
    Money? compareAtPrice,
    $core.Iterable<Option>? options,
    InventoryPolicy? inventoryPolicy,
    $core.Iterable<FulfillmentType>? fulfillmentTypes,
    AvailabilityRule? availability,
    $core.int? initialQuantity,
  }) {
    final result = create();
    if (productId != null) result.productId = productId;
    if (title != null) result.title = title;
    if (sku != null) result.sku = sku;
    if (price != null) result.price = price;
    if (compareAtPrice != null) result.compareAtPrice = compareAtPrice;
    if (options != null) result.options.addAll(options);
    if (inventoryPolicy != null) result.inventoryPolicy = inventoryPolicy;
    if (fulfillmentTypes != null)
      result.fulfillmentTypes.addAll(fulfillmentTypes);
    if (availability != null) result.availability = availability;
    if (initialQuantity != null) result.initialQuantity = initialQuantity;
    return result;
  }

  CreateVariantRequest._();

  factory CreateVariantRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateVariantRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateVariantRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'productId')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'sku')
    ..aOM<Money>(4, _omitFieldNames ? '' : 'price', subBuilder: Money.create)
    ..aOM<Money>(5, _omitFieldNames ? '' : 'compareAtPrice',
        subBuilder: Money.create)
    ..pPM<Option>(6, _omitFieldNames ? '' : 'options',
        subBuilder: Option.create)
    ..aE<InventoryPolicy>(7, _omitFieldNames ? '' : 'inventoryPolicy',
        enumValues: InventoryPolicy.values)
    ..pc<FulfillmentType>(
        8, _omitFieldNames ? '' : 'fulfillmentTypes', $pb.PbFieldType.KE,
        valueOf: FulfillmentType.valueOf,
        enumValues: FulfillmentType.values,
        defaultEnumValue: FulfillmentType.FULFILLMENT_TYPE_UNSPECIFIED)
    ..aOM<AvailabilityRule>(9, _omitFieldNames ? '' : 'availability',
        subBuilder: AvailabilityRule.create)
    ..aI(10, _omitFieldNames ? '' : 'initialQuantity')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateVariantRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateVariantRequest copyWith(void Function(CreateVariantRequest) updates) =>
      super.copyWith((message) => updates(message as CreateVariantRequest))
          as CreateVariantRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateVariantRequest create() => CreateVariantRequest._();
  @$core.override
  CreateVariantRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateVariantRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateVariantRequest>(create);
  static CreateVariantRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get productId => $_getSZ(0);
  @$pb.TagNumber(1)
  set productId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProductId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProductId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get sku => $_getSZ(2);
  @$pb.TagNumber(3)
  set sku($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSku() => $_has(2);
  @$pb.TagNumber(3)
  void clearSku() => $_clearField(3);

  @$pb.TagNumber(4)
  Money get price => $_getN(3);
  @$pb.TagNumber(4)
  set price(Money value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPrice() => $_has(3);
  @$pb.TagNumber(4)
  void clearPrice() => $_clearField(4);
  @$pb.TagNumber(4)
  Money ensurePrice() => $_ensure(3);

  @$pb.TagNumber(5)
  Money get compareAtPrice => $_getN(4);
  @$pb.TagNumber(5)
  set compareAtPrice(Money value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasCompareAtPrice() => $_has(4);
  @$pb.TagNumber(5)
  void clearCompareAtPrice() => $_clearField(5);
  @$pb.TagNumber(5)
  Money ensureCompareAtPrice() => $_ensure(4);

  @$pb.TagNumber(6)
  $pb.PbList<Option> get options => $_getList(5);

  @$pb.TagNumber(7)
  InventoryPolicy get inventoryPolicy => $_getN(6);
  @$pb.TagNumber(7)
  set inventoryPolicy(InventoryPolicy value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasInventoryPolicy() => $_has(6);
  @$pb.TagNumber(7)
  void clearInventoryPolicy() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<FulfillmentType> get fulfillmentTypes => $_getList(7);

  @$pb.TagNumber(9)
  AvailabilityRule get availability => $_getN(8);
  @$pb.TagNumber(9)
  set availability(AvailabilityRule value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasAvailability() => $_has(8);
  @$pb.TagNumber(9)
  void clearAvailability() => $_clearField(9);
  @$pb.TagNumber(9)
  AvailabilityRule ensureAvailability() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.int get initialQuantity => $_getIZ(9);
  @$pb.TagNumber(10)
  set initialQuantity($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasInitialQuantity() => $_has(9);
  @$pb.TagNumber(10)
  void clearInitialQuantity() => $_clearField(10);
}

class UpdateVariantRequest extends $pb.GeneratedMessage {
  factory UpdateVariantRequest({
    $core.String? id,
    $core.String? title,
    Money? price,
    Money? compareAtPrice,
    $core.Iterable<Option>? options,
    $core.Iterable<FulfillmentType>? fulfillmentTypes,
    AvailabilityRule? availability,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    if (price != null) result.price = price;
    if (compareAtPrice != null) result.compareAtPrice = compareAtPrice;
    if (options != null) result.options.addAll(options);
    if (fulfillmentTypes != null)
      result.fulfillmentTypes.addAll(fulfillmentTypes);
    if (availability != null) result.availability = availability;
    return result;
  }

  UpdateVariantRequest._();

  factory UpdateVariantRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateVariantRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateVariantRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOM<Money>(3, _omitFieldNames ? '' : 'price', subBuilder: Money.create)
    ..aOM<Money>(4, _omitFieldNames ? '' : 'compareAtPrice',
        subBuilder: Money.create)
    ..pPM<Option>(5, _omitFieldNames ? '' : 'options',
        subBuilder: Option.create)
    ..pc<FulfillmentType>(
        6, _omitFieldNames ? '' : 'fulfillmentTypes', $pb.PbFieldType.KE,
        valueOf: FulfillmentType.valueOf,
        enumValues: FulfillmentType.values,
        defaultEnumValue: FulfillmentType.FULFILLMENT_TYPE_UNSPECIFIED)
    ..aOM<AvailabilityRule>(7, _omitFieldNames ? '' : 'availability',
        subBuilder: AvailabilityRule.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateVariantRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateVariantRequest copyWith(void Function(UpdateVariantRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateVariantRequest))
          as UpdateVariantRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateVariantRequest create() => UpdateVariantRequest._();
  @$core.override
  UpdateVariantRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateVariantRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateVariantRequest>(create);
  static UpdateVariantRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  Money get price => $_getN(2);
  @$pb.TagNumber(3)
  set price(Money value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPrice() => $_has(2);
  @$pb.TagNumber(3)
  void clearPrice() => $_clearField(3);
  @$pb.TagNumber(3)
  Money ensurePrice() => $_ensure(2);

  @$pb.TagNumber(4)
  Money get compareAtPrice => $_getN(3);
  @$pb.TagNumber(4)
  set compareAtPrice(Money value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCompareAtPrice() => $_has(3);
  @$pb.TagNumber(4)
  void clearCompareAtPrice() => $_clearField(4);
  @$pb.TagNumber(4)
  Money ensureCompareAtPrice() => $_ensure(3);

  @$pb.TagNumber(5)
  $pb.PbList<Option> get options => $_getList(4);

  @$pb.TagNumber(6)
  $pb.PbList<FulfillmentType> get fulfillmentTypes => $_getList(5);

  @$pb.TagNumber(7)
  AvailabilityRule get availability => $_getN(6);
  @$pb.TagNumber(7)
  set availability(AvailabilityRule value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasAvailability() => $_has(6);
  @$pb.TagNumber(7)
  void clearAvailability() => $_clearField(7);
  @$pb.TagNumber(7)
  AvailabilityRule ensureAvailability() => $_ensure(6);
}

class DeleteVariantRequest extends $pb.GeneratedMessage {
  factory DeleteVariantRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  DeleteVariantRequest._();

  factory DeleteVariantRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteVariantRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteVariantRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteVariantRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteVariantRequest copyWith(void Function(DeleteVariantRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteVariantRequest))
          as DeleteVariantRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteVariantRequest create() => DeleteVariantRequest._();
  @$core.override
  DeleteVariantRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeleteVariantRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteVariantRequest>(create);
  static DeleteVariantRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class BulkCreateVariantsRequest extends $pb.GeneratedMessage {
  factory BulkCreateVariantsRequest({
    $core.String? productId,
    $core.Iterable<CreateVariantRequest>? variants,
  }) {
    final result = create();
    if (productId != null) result.productId = productId;
    if (variants != null) result.variants.addAll(variants);
    return result;
  }

  BulkCreateVariantsRequest._();

  factory BulkCreateVariantsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BulkCreateVariantsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BulkCreateVariantsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'productId')
    ..pPM<CreateVariantRequest>(2, _omitFieldNames ? '' : 'variants',
        subBuilder: CreateVariantRequest.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BulkCreateVariantsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BulkCreateVariantsRequest copyWith(
          void Function(BulkCreateVariantsRequest) updates) =>
      super.copyWith((message) => updates(message as BulkCreateVariantsRequest))
          as BulkCreateVariantsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BulkCreateVariantsRequest create() => BulkCreateVariantsRequest._();
  @$core.override
  BulkCreateVariantsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BulkCreateVariantsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BulkCreateVariantsRequest>(create);
  static BulkCreateVariantsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get productId => $_getSZ(0);
  @$pb.TagNumber(1)
  set productId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProductId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProductId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<CreateVariantRequest> get variants => $_getList(1);
}

class BulkVariantsResponse extends $pb.GeneratedMessage {
  factory BulkVariantsResponse({
    $core.Iterable<Variant>? variants,
    $core.Iterable<UserError>? errors,
  }) {
    final result = create();
    if (variants != null) result.variants.addAll(variants);
    if (errors != null) result.errors.addAll(errors);
    return result;
  }

  BulkVariantsResponse._();

  factory BulkVariantsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BulkVariantsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BulkVariantsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..pPM<Variant>(1, _omitFieldNames ? '' : 'variants',
        subBuilder: Variant.create)
    ..pPM<UserError>(2, _omitFieldNames ? '' : 'errors',
        subBuilder: UserError.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BulkVariantsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BulkVariantsResponse copyWith(void Function(BulkVariantsResponse) updates) =>
      super.copyWith((message) => updates(message as BulkVariantsResponse))
          as BulkVariantsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BulkVariantsResponse create() => BulkVariantsResponse._();
  @$core.override
  BulkVariantsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BulkVariantsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BulkVariantsResponse>(create);
  static BulkVariantsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Variant> get variants => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<UserError> get errors => $_getList(1);
}

class CreateCollectionRequest extends $pb.GeneratedMessage {
  factory CreateCollectionRequest({
    $core.String? title,
    $core.String? description,
    CollectionType? type,
    $core.Iterable<CollectionRule>? rules,
    SortOrder? sortOrder,
    SEO? seo,
  }) {
    final result = create();
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (type != null) result.type = type;
    if (rules != null) result.rules.addAll(rules);
    if (sortOrder != null) result.sortOrder = sortOrder;
    if (seo != null) result.seo = seo;
    return result;
  }

  CreateCollectionRequest._();

  factory CreateCollectionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateCollectionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateCollectionRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'title')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..aE<CollectionType>(3, _omitFieldNames ? '' : 'type',
        enumValues: CollectionType.values)
    ..pPM<CollectionRule>(4, _omitFieldNames ? '' : 'rules',
        subBuilder: CollectionRule.create)
    ..aE<SortOrder>(5, _omitFieldNames ? '' : 'sortOrder',
        enumValues: SortOrder.values)
    ..aOM<SEO>(6, _omitFieldNames ? '' : 'seo', subBuilder: SEO.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateCollectionRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateCollectionRequest copyWith(
          void Function(CreateCollectionRequest) updates) =>
      super.copyWith((message) => updates(message as CreateCollectionRequest))
          as CreateCollectionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateCollectionRequest create() => CreateCollectionRequest._();
  @$core.override
  CreateCollectionRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateCollectionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateCollectionRequest>(create);
  static CreateCollectionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);

  @$pb.TagNumber(3)
  CollectionType get type => $_getN(2);
  @$pb.TagNumber(3)
  set type(CollectionType value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<CollectionRule> get rules => $_getList(3);

  @$pb.TagNumber(5)
  SortOrder get sortOrder => $_getN(4);
  @$pb.TagNumber(5)
  set sortOrder(SortOrder value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasSortOrder() => $_has(4);
  @$pb.TagNumber(5)
  void clearSortOrder() => $_clearField(5);

  @$pb.TagNumber(6)
  SEO get seo => $_getN(5);
  @$pb.TagNumber(6)
  set seo(SEO value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasSeo() => $_has(5);
  @$pb.TagNumber(6)
  void clearSeo() => $_clearField(6);
  @$pb.TagNumber(6)
  SEO ensureSeo() => $_ensure(5);
}

class UpdateCollectionRequest extends $pb.GeneratedMessage {
  factory UpdateCollectionRequest({
    $core.String? id,
    $core.String? title,
    $core.String? description,
    SortOrder? sortOrder,
    SEO? seo,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (sortOrder != null) result.sortOrder = sortOrder;
    if (seo != null) result.seo = seo;
    return result;
  }

  UpdateCollectionRequest._();

  factory UpdateCollectionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateCollectionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateCollectionRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aE<SortOrder>(4, _omitFieldNames ? '' : 'sortOrder',
        enumValues: SortOrder.values)
    ..aOM<SEO>(5, _omitFieldNames ? '' : 'seo', subBuilder: SEO.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCollectionRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCollectionRequest copyWith(
          void Function(UpdateCollectionRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateCollectionRequest))
          as UpdateCollectionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateCollectionRequest create() => UpdateCollectionRequest._();
  @$core.override
  UpdateCollectionRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateCollectionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateCollectionRequest>(create);
  static UpdateCollectionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  SortOrder get sortOrder => $_getN(3);
  @$pb.TagNumber(4)
  set sortOrder(SortOrder value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasSortOrder() => $_has(3);
  @$pb.TagNumber(4)
  void clearSortOrder() => $_clearField(4);

  @$pb.TagNumber(5)
  SEO get seo => $_getN(4);
  @$pb.TagNumber(5)
  set seo(SEO value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasSeo() => $_has(4);
  @$pb.TagNumber(5)
  void clearSeo() => $_clearField(5);
  @$pb.TagNumber(5)
  SEO ensureSeo() => $_ensure(4);
}

class DeleteCollectionRequest extends $pb.GeneratedMessage {
  factory DeleteCollectionRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  DeleteCollectionRequest._();

  factory DeleteCollectionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteCollectionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteCollectionRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteCollectionRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteCollectionRequest copyWith(
          void Function(DeleteCollectionRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteCollectionRequest))
          as DeleteCollectionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteCollectionRequest create() => DeleteCollectionRequest._();
  @$core.override
  DeleteCollectionRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeleteCollectionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteCollectionRequest>(create);
  static DeleteCollectionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class CollectionProductsRequest extends $pb.GeneratedMessage {
  factory CollectionProductsRequest({
    $core.String? collectionId,
    $core.Iterable<$core.String>? productIds,
  }) {
    final result = create();
    if (collectionId != null) result.collectionId = collectionId;
    if (productIds != null) result.productIds.addAll(productIds);
    return result;
  }

  CollectionProductsRequest._();

  factory CollectionProductsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CollectionProductsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CollectionProductsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'collectionId')
    ..pPS(2, _omitFieldNames ? '' : 'productIds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CollectionProductsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CollectionProductsRequest copyWith(
          void Function(CollectionProductsRequest) updates) =>
      super.copyWith((message) => updates(message as CollectionProductsRequest))
          as CollectionProductsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CollectionProductsRequest create() => CollectionProductsRequest._();
  @$core.override
  CollectionProductsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CollectionProductsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CollectionProductsRequest>(create);
  static CollectionProductsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get collectionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set collectionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCollectionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCollectionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get productIds => $_getList(1);
}

class GetCollectionRequest extends $pb.GeneratedMessage {
  factory GetCollectionRequest({
    $core.String? id,
    $core.String? slug,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (slug != null) result.slug = slug;
    return result;
  }

  GetCollectionRequest._();

  factory GetCollectionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCollectionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCollectionRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'slug')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCollectionRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCollectionRequest copyWith(void Function(GetCollectionRequest) updates) =>
      super.copyWith((message) => updates(message as GetCollectionRequest))
          as GetCollectionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCollectionRequest create() => GetCollectionRequest._();
  @$core.override
  GetCollectionRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetCollectionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCollectionRequest>(create);
  static GetCollectionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get slug => $_getSZ(1);
  @$pb.TagNumber(2)
  set slug($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSlug() => $_has(1);
  @$pb.TagNumber(2)
  void clearSlug() => $_clearField(2);
}

class CollectionPage extends $pb.GeneratedMessage {
  factory CollectionPage({
    $core.Iterable<Collection>? collections,
    $core.String? nextCursor,
    $core.int? total,
  }) {
    final result = create();
    if (collections != null) result.collections.addAll(collections);
    if (nextCursor != null) result.nextCursor = nextCursor;
    if (total != null) result.total = total;
    return result;
  }

  CollectionPage._();

  factory CollectionPage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CollectionPage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CollectionPage',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..pPM<Collection>(1, _omitFieldNames ? '' : 'collections',
        subBuilder: Collection.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextCursor')
    ..aI(3, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CollectionPage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CollectionPage copyWith(void Function(CollectionPage) updates) =>
      super.copyWith((message) => updates(message as CollectionPage))
          as CollectionPage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CollectionPage create() => CollectionPage._();
  @$core.override
  CollectionPage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CollectionPage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CollectionPage>(create);
  static CollectionPage? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Collection> get collections => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextCursor => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextCursor($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextCursor() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextCursor() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get total => $_getIZ(2);
  @$pb.TagNumber(3)
  set total($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotal() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotal() => $_clearField(3);
}

class ListCollectionsRequest extends $pb.GeneratedMessage {
  factory ListCollectionsRequest({
    $core.String? vendorId,
    CollectionType? type,
    $core.int? limit,
    $core.String? cursor,
  }) {
    final result = create();
    if (vendorId != null) result.vendorId = vendorId;
    if (type != null) result.type = type;
    if (limit != null) result.limit = limit;
    if (cursor != null) result.cursor = cursor;
    return result;
  }

  ListCollectionsRequest._();

  factory ListCollectionsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListCollectionsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListCollectionsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'vendorId')
    ..aE<CollectionType>(2, _omitFieldNames ? '' : 'type',
        enumValues: CollectionType.values)
    ..aI(3, _omitFieldNames ? '' : 'limit')
    ..aOS(4, _omitFieldNames ? '' : 'cursor')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCollectionsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCollectionsRequest copyWith(
          void Function(ListCollectionsRequest) updates) =>
      super.copyWith((message) => updates(message as ListCollectionsRequest))
          as ListCollectionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListCollectionsRequest create() => ListCollectionsRequest._();
  @$core.override
  ListCollectionsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListCollectionsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListCollectionsRequest>(create);
  static ListCollectionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get vendorId => $_getSZ(0);
  @$pb.TagNumber(1)
  set vendorId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVendorId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVendorId() => $_clearField(1);

  @$pb.TagNumber(2)
  CollectionType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(CollectionType value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get cursor => $_getSZ(3);
  @$pb.TagNumber(4)
  set cursor($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCursor() => $_has(3);
  @$pb.TagNumber(4)
  void clearCursor() => $_clearField(4);
}

class RegisterVendorRequest extends $pb.GeneratedMessage {
  factory RegisterVendorRequest({
    $core.String? name,
    Contact? contact,
    GeoLocation? geo,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (contact != null) result.contact = contact;
    if (geo != null) result.geo = geo;
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  RegisterVendorRequest._();

  factory RegisterVendorRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RegisterVendorRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RegisterVendorRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOM<Contact>(2, _omitFieldNames ? '' : 'contact',
        subBuilder: Contact.create)
    ..aOM<GeoLocation>(3, _omitFieldNames ? '' : 'geo',
        subBuilder: GeoLocation.create)
    ..m<$core.String, $core.String>(4, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'RegisterVendorRequest.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('marketplace_core'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterVendorRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterVendorRequest copyWith(
          void Function(RegisterVendorRequest) updates) =>
      super.copyWith((message) => updates(message as RegisterVendorRequest))
          as RegisterVendorRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RegisterVendorRequest create() => RegisterVendorRequest._();
  @$core.override
  RegisterVendorRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RegisterVendorRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RegisterVendorRequest>(create);
  static RegisterVendorRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  Contact get contact => $_getN(1);
  @$pb.TagNumber(2)
  set contact(Contact value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasContact() => $_has(1);
  @$pb.TagNumber(2)
  void clearContact() => $_clearField(2);
  @$pb.TagNumber(2)
  Contact ensureContact() => $_ensure(1);

  @$pb.TagNumber(3)
  GeoLocation get geo => $_getN(2);
  @$pb.TagNumber(3)
  set geo(GeoLocation value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasGeo() => $_has(2);
  @$pb.TagNumber(3)
  void clearGeo() => $_clearField(3);
  @$pb.TagNumber(3)
  GeoLocation ensureGeo() => $_ensure(2);

  @$pb.TagNumber(4)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(3);
}

class UpdateVendorRequest extends $pb.GeneratedMessage {
  factory UpdateVendorRequest({
    $core.String? id,
    $core.String? name,
    Contact? contact,
    GeoLocation? geo,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (contact != null) result.contact = contact;
    if (geo != null) result.geo = geo;
    return result;
  }

  UpdateVendorRequest._();

  factory UpdateVendorRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateVendorRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateVendorRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<Contact>(3, _omitFieldNames ? '' : 'contact',
        subBuilder: Contact.create)
    ..aOM<GeoLocation>(4, _omitFieldNames ? '' : 'geo',
        subBuilder: GeoLocation.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateVendorRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateVendorRequest copyWith(void Function(UpdateVendorRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateVendorRequest))
          as UpdateVendorRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateVendorRequest create() => UpdateVendorRequest._();
  @$core.override
  UpdateVendorRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateVendorRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateVendorRequest>(create);
  static UpdateVendorRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  Contact get contact => $_getN(2);
  @$pb.TagNumber(3)
  set contact(Contact value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasContact() => $_has(2);
  @$pb.TagNumber(3)
  void clearContact() => $_clearField(3);
  @$pb.TagNumber(3)
  Contact ensureContact() => $_ensure(2);

  @$pb.TagNumber(4)
  GeoLocation get geo => $_getN(3);
  @$pb.TagNumber(4)
  set geo(GeoLocation value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasGeo() => $_has(3);
  @$pb.TagNumber(4)
  void clearGeo() => $_clearField(4);
  @$pb.TagNumber(4)
  GeoLocation ensureGeo() => $_ensure(3);
}

class VerifyVendorRequest extends $pb.GeneratedMessage {
  factory VerifyVendorRequest({
    $core.String? id,
    $core.String? identityDoc,
    $core.String? verificationMethod,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (identityDoc != null) result.identityDoc = identityDoc;
    if (verificationMethod != null)
      result.verificationMethod = verificationMethod;
    return result;
  }

  VerifyVendorRequest._();

  factory VerifyVendorRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyVendorRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyVendorRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'identityDoc')
    ..aOS(3, _omitFieldNames ? '' : 'verificationMethod')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyVendorRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyVendorRequest copyWith(void Function(VerifyVendorRequest) updates) =>
      super.copyWith((message) => updates(message as VerifyVendorRequest))
          as VerifyVendorRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyVendorRequest create() => VerifyVendorRequest._();
  @$core.override
  VerifyVendorRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VerifyVendorRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyVendorRequest>(create);
  static VerifyVendorRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get identityDoc => $_getSZ(1);
  @$pb.TagNumber(2)
  set identityDoc($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIdentityDoc() => $_has(1);
  @$pb.TagNumber(2)
  void clearIdentityDoc() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get verificationMethod => $_getSZ(2);
  @$pb.TagNumber(3)
  set verificationMethod($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVerificationMethod() => $_has(2);
  @$pb.TagNumber(3)
  void clearVerificationMethod() => $_clearField(3);
}

class GetVendorProfileRequest extends $pb.GeneratedMessage {
  factory GetVendorProfileRequest({
    $core.String? id,
    $core.String? slug,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (slug != null) result.slug = slug;
    return result;
  }

  GetVendorProfileRequest._();

  factory GetVendorProfileRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetVendorProfileRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetVendorProfileRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'slug')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVendorProfileRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVendorProfileRequest copyWith(
          void Function(GetVendorProfileRequest) updates) =>
      super.copyWith((message) => updates(message as GetVendorProfileRequest))
          as GetVendorProfileRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVendorProfileRequest create() => GetVendorProfileRequest._();
  @$core.override
  GetVendorProfileRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetVendorProfileRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetVendorProfileRequest>(create);
  static GetVendorProfileRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get slug => $_getSZ(1);
  @$pb.TagNumber(2)
  set slug($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSlug() => $_has(1);
  @$pb.TagNumber(2)
  void clearSlug() => $_clearField(2);
}

class CreateStorefrontRequest extends $pb.GeneratedMessage {
  factory CreateStorefrontRequest({
    $core.String? vendorId,
    $core.String? name,
    $core.String? description,
    SEO? seo,
  }) {
    final result = create();
    if (vendorId != null) result.vendorId = vendorId;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (seo != null) result.seo = seo;
    return result;
  }

  CreateStorefrontRequest._();

  factory CreateStorefrontRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateStorefrontRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateStorefrontRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'vendorId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOM<SEO>(4, _omitFieldNames ? '' : 'seo', subBuilder: SEO.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateStorefrontRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateStorefrontRequest copyWith(
          void Function(CreateStorefrontRequest) updates) =>
      super.copyWith((message) => updates(message as CreateStorefrontRequest))
          as CreateStorefrontRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateStorefrontRequest create() => CreateStorefrontRequest._();
  @$core.override
  CreateStorefrontRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateStorefrontRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateStorefrontRequest>(create);
  static CreateStorefrontRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get vendorId => $_getSZ(0);
  @$pb.TagNumber(1)
  set vendorId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVendorId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVendorId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  SEO get seo => $_getN(3);
  @$pb.TagNumber(4)
  set seo(SEO value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasSeo() => $_has(3);
  @$pb.TagNumber(4)
  void clearSeo() => $_clearField(4);
  @$pb.TagNumber(4)
  SEO ensureSeo() => $_ensure(3);
}

class UpdateStorefrontRequest extends $pb.GeneratedMessage {
  factory UpdateStorefrontRequest({
    $core.String? id,
    $core.String? name,
    $core.String? description,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? theme,
    $core.bool? isPublic,
    $core.String? customDomain,
    SEO? seo,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (theme != null) result.theme.addEntries(theme);
    if (isPublic != null) result.isPublic = isPublic;
    if (customDomain != null) result.customDomain = customDomain;
    if (seo != null) result.seo = seo;
    return result;
  }

  UpdateStorefrontRequest._();

  factory UpdateStorefrontRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateStorefrontRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateStorefrontRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..m<$core.String, $core.String>(4, _omitFieldNames ? '' : 'theme',
        entryClassName: 'UpdateStorefrontRequest.ThemeEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('marketplace_core'))
    ..aOB(5, _omitFieldNames ? '' : 'isPublic')
    ..aOS(6, _omitFieldNames ? '' : 'customDomain')
    ..aOM<SEO>(7, _omitFieldNames ? '' : 'seo', subBuilder: SEO.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateStorefrontRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateStorefrontRequest copyWith(
          void Function(UpdateStorefrontRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateStorefrontRequest))
          as UpdateStorefrontRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateStorefrontRequest create() => UpdateStorefrontRequest._();
  @$core.override
  UpdateStorefrontRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateStorefrontRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateStorefrontRequest>(create);
  static UpdateStorefrontRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbMap<$core.String, $core.String> get theme => $_getMap(3);

  @$pb.TagNumber(5)
  $core.bool get isPublic => $_getBF(4);
  @$pb.TagNumber(5)
  set isPublic($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsPublic() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsPublic() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get customDomain => $_getSZ(5);
  @$pb.TagNumber(6)
  set customDomain($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCustomDomain() => $_has(5);
  @$pb.TagNumber(6)
  void clearCustomDomain() => $_clearField(6);

  @$pb.TagNumber(7)
  SEO get seo => $_getN(6);
  @$pb.TagNumber(7)
  set seo(SEO value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasSeo() => $_has(6);
  @$pb.TagNumber(7)
  void clearSeo() => $_clearField(7);
  @$pb.TagNumber(7)
  SEO ensureSeo() => $_ensure(6);
}

class GetStorefrontRequest extends $pb.GeneratedMessage {
  factory GetStorefrontRequest({
    $core.String? id,
    $core.String? slug,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (slug != null) result.slug = slug;
    return result;
  }

  GetStorefrontRequest._();

  factory GetStorefrontRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetStorefrontRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetStorefrontRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'slug')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStorefrontRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStorefrontRequest copyWith(void Function(GetStorefrontRequest) updates) =>
      super.copyWith((message) => updates(message as GetStorefrontRequest))
          as GetStorefrontRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStorefrontRequest create() => GetStorefrontRequest._();
  @$core.override
  GetStorefrontRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetStorefrontRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetStorefrontRequest>(create);
  static GetStorefrontRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get slug => $_getSZ(1);
  @$pb.TagNumber(2)
  set slug($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSlug() => $_has(1);
  @$pb.TagNumber(2)
  void clearSlug() => $_clearField(2);
}

class UploadMediaRequest extends $pb.GeneratedMessage {
  factory UploadMediaRequest({
    MediaOwnerType? ownerType,
    $core.String? ownerId,
    MediaType? type,
    $core.String? filename,
    $core.String? altText,
    $core.List<$core.int>? chunk,
  }) {
    final result = create();
    if (ownerType != null) result.ownerType = ownerType;
    if (ownerId != null) result.ownerId = ownerId;
    if (type != null) result.type = type;
    if (filename != null) result.filename = filename;
    if (altText != null) result.altText = altText;
    if (chunk != null) result.chunk = chunk;
    return result;
  }

  UploadMediaRequest._();

  factory UploadMediaRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadMediaRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadMediaRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aE<MediaOwnerType>(1, _omitFieldNames ? '' : 'ownerType',
        enumValues: MediaOwnerType.values)
    ..aOS(2, _omitFieldNames ? '' : 'ownerId')
    ..aE<MediaType>(3, _omitFieldNames ? '' : 'type',
        enumValues: MediaType.values)
    ..aOS(4, _omitFieldNames ? '' : 'filename')
    ..aOS(5, _omitFieldNames ? '' : 'altText')
    ..a<$core.List<$core.int>>(
        6, _omitFieldNames ? '' : 'chunk', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadMediaRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadMediaRequest copyWith(void Function(UploadMediaRequest) updates) =>
      super.copyWith((message) => updates(message as UploadMediaRequest))
          as UploadMediaRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadMediaRequest create() => UploadMediaRequest._();
  @$core.override
  UploadMediaRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UploadMediaRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadMediaRequest>(create);
  static UploadMediaRequest? _defaultInstance;

  @$pb.TagNumber(1)
  MediaOwnerType get ownerType => $_getN(0);
  @$pb.TagNumber(1)
  set ownerType(MediaOwnerType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasOwnerType() => $_has(0);
  @$pb.TagNumber(1)
  void clearOwnerType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get ownerId => $_getSZ(1);
  @$pb.TagNumber(2)
  set ownerId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOwnerId() => $_has(1);
  @$pb.TagNumber(2)
  void clearOwnerId() => $_clearField(2);

  @$pb.TagNumber(3)
  MediaType get type => $_getN(2);
  @$pb.TagNumber(3)
  set type(MediaType value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get filename => $_getSZ(3);
  @$pb.TagNumber(4)
  set filename($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFilename() => $_has(3);
  @$pb.TagNumber(4)
  void clearFilename() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get altText => $_getSZ(4);
  @$pb.TagNumber(5)
  set altText($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAltText() => $_has(4);
  @$pb.TagNumber(5)
  void clearAltText() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.int> get chunk => $_getN(5);
  @$pb.TagNumber(6)
  set chunk($core.List<$core.int> value) => $_setBytes(5, value);
  @$pb.TagNumber(6)
  $core.bool hasChunk() => $_has(5);
  @$pb.TagNumber(6)
  void clearChunk() => $_clearField(6);
}

class DeleteMediaRequest extends $pb.GeneratedMessage {
  factory DeleteMediaRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  DeleteMediaRequest._();

  factory DeleteMediaRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteMediaRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteMediaRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteMediaRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteMediaRequest copyWith(void Function(DeleteMediaRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteMediaRequest))
          as DeleteMediaRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteMediaRequest create() => DeleteMediaRequest._();
  @$core.override
  DeleteMediaRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeleteMediaRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteMediaRequest>(create);
  static DeleteMediaRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class BrowseRequest extends $pb.GeneratedMessage {
  factory BrowseRequest({
    $core.String? collectionId,
    $core.String? vendorId,
    $core.Iterable<FulfillmentType>? fulfillmentTypes,
    Money? priceMin,
    Money? priceMax,
    GeoLocation? near,
    $core.double? radiusKm,
    $core.Iterable<$core.String>? tags,
    SortOrder? sort,
    $core.int? limit,
    $core.String? cursor,
  }) {
    final result = create();
    if (collectionId != null) result.collectionId = collectionId;
    if (vendorId != null) result.vendorId = vendorId;
    if (fulfillmentTypes != null)
      result.fulfillmentTypes.addAll(fulfillmentTypes);
    if (priceMin != null) result.priceMin = priceMin;
    if (priceMax != null) result.priceMax = priceMax;
    if (near != null) result.near = near;
    if (radiusKm != null) result.radiusKm = radiusKm;
    if (tags != null) result.tags.addAll(tags);
    if (sort != null) result.sort = sort;
    if (limit != null) result.limit = limit;
    if (cursor != null) result.cursor = cursor;
    return result;
  }

  BrowseRequest._();

  factory BrowseRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BrowseRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BrowseRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'collectionId')
    ..aOS(2, _omitFieldNames ? '' : 'vendorId')
    ..pc<FulfillmentType>(
        3, _omitFieldNames ? '' : 'fulfillmentTypes', $pb.PbFieldType.KE,
        valueOf: FulfillmentType.valueOf,
        enumValues: FulfillmentType.values,
        defaultEnumValue: FulfillmentType.FULFILLMENT_TYPE_UNSPECIFIED)
    ..aOM<Money>(4, _omitFieldNames ? '' : 'priceMin', subBuilder: Money.create)
    ..aOM<Money>(5, _omitFieldNames ? '' : 'priceMax', subBuilder: Money.create)
    ..aOM<GeoLocation>(6, _omitFieldNames ? '' : 'near',
        subBuilder: GeoLocation.create)
    ..aD(7, _omitFieldNames ? '' : 'radiusKm')
    ..pPS(8, _omitFieldNames ? '' : 'tags')
    ..aE<SortOrder>(9, _omitFieldNames ? '' : 'sort',
        enumValues: SortOrder.values)
    ..aI(10, _omitFieldNames ? '' : 'limit')
    ..aOS(11, _omitFieldNames ? '' : 'cursor')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BrowseRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BrowseRequest copyWith(void Function(BrowseRequest) updates) =>
      super.copyWith((message) => updates(message as BrowseRequest))
          as BrowseRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BrowseRequest create() => BrowseRequest._();
  @$core.override
  BrowseRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BrowseRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BrowseRequest>(create);
  static BrowseRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get collectionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set collectionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCollectionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCollectionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get vendorId => $_getSZ(1);
  @$pb.TagNumber(2)
  set vendorId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVendorId() => $_has(1);
  @$pb.TagNumber(2)
  void clearVendorId() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<FulfillmentType> get fulfillmentTypes => $_getList(2);

  @$pb.TagNumber(4)
  Money get priceMin => $_getN(3);
  @$pb.TagNumber(4)
  set priceMin(Money value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPriceMin() => $_has(3);
  @$pb.TagNumber(4)
  void clearPriceMin() => $_clearField(4);
  @$pb.TagNumber(4)
  Money ensurePriceMin() => $_ensure(3);

  @$pb.TagNumber(5)
  Money get priceMax => $_getN(4);
  @$pb.TagNumber(5)
  set priceMax(Money value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasPriceMax() => $_has(4);
  @$pb.TagNumber(5)
  void clearPriceMax() => $_clearField(5);
  @$pb.TagNumber(5)
  Money ensurePriceMax() => $_ensure(4);

  @$pb.TagNumber(6)
  GeoLocation get near => $_getN(5);
  @$pb.TagNumber(6)
  set near(GeoLocation value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasNear() => $_has(5);
  @$pb.TagNumber(6)
  void clearNear() => $_clearField(6);
  @$pb.TagNumber(6)
  GeoLocation ensureNear() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.double get radiusKm => $_getN(6);
  @$pb.TagNumber(7)
  set radiusKm($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRadiusKm() => $_has(6);
  @$pb.TagNumber(7)
  void clearRadiusKm() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<$core.String> get tags => $_getList(7);

  @$pb.TagNumber(9)
  SortOrder get sort => $_getN(8);
  @$pb.TagNumber(9)
  set sort(SortOrder value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasSort() => $_has(8);
  @$pb.TagNumber(9)
  void clearSort() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get limit => $_getIZ(9);
  @$pb.TagNumber(10)
  set limit($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasLimit() => $_has(9);
  @$pb.TagNumber(10)
  void clearLimit() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get cursor => $_getSZ(10);
  @$pb.TagNumber(11)
  set cursor($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCursor() => $_has(10);
  @$pb.TagNumber(11)
  void clearCursor() => $_clearField(11);
}

class SearchRequest extends $pb.GeneratedMessage {
  factory SearchRequest({
    $core.String? query,
    $core.String? collectionId,
    $core.Iterable<FulfillmentType>? fulfillmentTypes,
    Money? priceMin,
    Money? priceMax,
    GeoLocation? near,
    $core.double? radiusKm,
    $core.Iterable<$core.String>? tags,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>?
        attributeFilters,
    SortOrder? sort,
    $core.int? limit,
    $core.String? cursor,
  }) {
    final result = create();
    if (query != null) result.query = query;
    if (collectionId != null) result.collectionId = collectionId;
    if (fulfillmentTypes != null)
      result.fulfillmentTypes.addAll(fulfillmentTypes);
    if (priceMin != null) result.priceMin = priceMin;
    if (priceMax != null) result.priceMax = priceMax;
    if (near != null) result.near = near;
    if (radiusKm != null) result.radiusKm = radiusKm;
    if (tags != null) result.tags.addAll(tags);
    if (attributeFilters != null)
      result.attributeFilters.addEntries(attributeFilters);
    if (sort != null) result.sort = sort;
    if (limit != null) result.limit = limit;
    if (cursor != null) result.cursor = cursor;
    return result;
  }

  SearchRequest._();

  factory SearchRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..aOS(2, _omitFieldNames ? '' : 'collectionId')
    ..pc<FulfillmentType>(
        3, _omitFieldNames ? '' : 'fulfillmentTypes', $pb.PbFieldType.KE,
        valueOf: FulfillmentType.valueOf,
        enumValues: FulfillmentType.values,
        defaultEnumValue: FulfillmentType.FULFILLMENT_TYPE_UNSPECIFIED)
    ..aOM<Money>(4, _omitFieldNames ? '' : 'priceMin', subBuilder: Money.create)
    ..aOM<Money>(5, _omitFieldNames ? '' : 'priceMax', subBuilder: Money.create)
    ..aOM<GeoLocation>(6, _omitFieldNames ? '' : 'near',
        subBuilder: GeoLocation.create)
    ..aD(7, _omitFieldNames ? '' : 'radiusKm')
    ..pPS(8, _omitFieldNames ? '' : 'tags')
    ..m<$core.String, $core.String>(
        9, _omitFieldNames ? '' : 'attributeFilters',
        entryClassName: 'SearchRequest.AttributeFiltersEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('marketplace_core'))
    ..aE<SortOrder>(10, _omitFieldNames ? '' : 'sort',
        enumValues: SortOrder.values)
    ..aI(11, _omitFieldNames ? '' : 'limit')
    ..aOS(12, _omitFieldNames ? '' : 'cursor')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchRequest copyWith(void Function(SearchRequest) updates) =>
      super.copyWith((message) => updates(message as SearchRequest))
          as SearchRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchRequest create() => SearchRequest._();
  @$core.override
  SearchRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SearchRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchRequest>(create);
  static SearchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get collectionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set collectionId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCollectionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCollectionId() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<FulfillmentType> get fulfillmentTypes => $_getList(2);

  @$pb.TagNumber(4)
  Money get priceMin => $_getN(3);
  @$pb.TagNumber(4)
  set priceMin(Money value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPriceMin() => $_has(3);
  @$pb.TagNumber(4)
  void clearPriceMin() => $_clearField(4);
  @$pb.TagNumber(4)
  Money ensurePriceMin() => $_ensure(3);

  @$pb.TagNumber(5)
  Money get priceMax => $_getN(4);
  @$pb.TagNumber(5)
  set priceMax(Money value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasPriceMax() => $_has(4);
  @$pb.TagNumber(5)
  void clearPriceMax() => $_clearField(5);
  @$pb.TagNumber(5)
  Money ensurePriceMax() => $_ensure(4);

  @$pb.TagNumber(6)
  GeoLocation get near => $_getN(5);
  @$pb.TagNumber(6)
  set near(GeoLocation value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasNear() => $_has(5);
  @$pb.TagNumber(6)
  void clearNear() => $_clearField(6);
  @$pb.TagNumber(6)
  GeoLocation ensureNear() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.double get radiusKm => $_getN(6);
  @$pb.TagNumber(7)
  set radiusKm($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRadiusKm() => $_has(6);
  @$pb.TagNumber(7)
  void clearRadiusKm() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<$core.String> get tags => $_getList(7);

  @$pb.TagNumber(9)
  $pb.PbMap<$core.String, $core.String> get attributeFilters => $_getMap(8);

  @$pb.TagNumber(10)
  SortOrder get sort => $_getN(9);
  @$pb.TagNumber(10)
  set sort(SortOrder value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasSort() => $_has(9);
  @$pb.TagNumber(10)
  void clearSort() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get limit => $_getIZ(10);
  @$pb.TagNumber(11)
  set limit($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasLimit() => $_has(10);
  @$pb.TagNumber(11)
  void clearLimit() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get cursor => $_getSZ(11);
  @$pb.TagNumber(12)
  set cursor($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCursor() => $_has(11);
  @$pb.TagNumber(12)
  void clearCursor() => $_clearField(12);
}

class RegisterSchemaRequest extends $pb.GeneratedMessage {
  factory RegisterSchemaRequest({
    $core.String? domain,
    $core.String? name,
    $core.String? jsonSchema,
    $core.Iterable<$core.String>? requiredFields,
    $core.String? uiHints,
    FulfillmentRules? fulfillmentRules,
    InventoryRules? inventoryRules,
    AvailabilityRules? availabilityRules,
  }) {
    final result = create();
    if (domain != null) result.domain = domain;
    if (name != null) result.name = name;
    if (jsonSchema != null) result.jsonSchema = jsonSchema;
    if (requiredFields != null) result.requiredFields.addAll(requiredFields);
    if (uiHints != null) result.uiHints = uiHints;
    if (fulfillmentRules != null) result.fulfillmentRules = fulfillmentRules;
    if (inventoryRules != null) result.inventoryRules = inventoryRules;
    if (availabilityRules != null) result.availabilityRules = availabilityRules;
    return result;
  }

  RegisterSchemaRequest._();

  factory RegisterSchemaRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RegisterSchemaRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RegisterSchemaRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'domain')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'jsonSchema')
    ..pPS(4, _omitFieldNames ? '' : 'requiredFields')
    ..aOS(5, _omitFieldNames ? '' : 'uiHints')
    ..aOM<FulfillmentRules>(6, _omitFieldNames ? '' : 'fulfillmentRules',
        subBuilder: FulfillmentRules.create)
    ..aOM<InventoryRules>(7, _omitFieldNames ? '' : 'inventoryRules',
        subBuilder: InventoryRules.create)
    ..aOM<AvailabilityRules>(8, _omitFieldNames ? '' : 'availabilityRules',
        subBuilder: AvailabilityRules.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterSchemaRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterSchemaRequest copyWith(
          void Function(RegisterSchemaRequest) updates) =>
      super.copyWith((message) => updates(message as RegisterSchemaRequest))
          as RegisterSchemaRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RegisterSchemaRequest create() => RegisterSchemaRequest._();
  @$core.override
  RegisterSchemaRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RegisterSchemaRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RegisterSchemaRequest>(create);
  static RegisterSchemaRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get domain => $_getSZ(0);
  @$pb.TagNumber(1)
  set domain($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDomain() => $_has(0);
  @$pb.TagNumber(1)
  void clearDomain() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get jsonSchema => $_getSZ(2);
  @$pb.TagNumber(3)
  set jsonSchema($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasJsonSchema() => $_has(2);
  @$pb.TagNumber(3)
  void clearJsonSchema() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get requiredFields => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get uiHints => $_getSZ(4);
  @$pb.TagNumber(5)
  set uiHints($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUiHints() => $_has(4);
  @$pb.TagNumber(5)
  void clearUiHints() => $_clearField(5);

  @$pb.TagNumber(6)
  FulfillmentRules get fulfillmentRules => $_getN(5);
  @$pb.TagNumber(6)
  set fulfillmentRules(FulfillmentRules value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasFulfillmentRules() => $_has(5);
  @$pb.TagNumber(6)
  void clearFulfillmentRules() => $_clearField(6);
  @$pb.TagNumber(6)
  FulfillmentRules ensureFulfillmentRules() => $_ensure(5);

  @$pb.TagNumber(7)
  InventoryRules get inventoryRules => $_getN(6);
  @$pb.TagNumber(7)
  set inventoryRules(InventoryRules value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasInventoryRules() => $_has(6);
  @$pb.TagNumber(7)
  void clearInventoryRules() => $_clearField(7);
  @$pb.TagNumber(7)
  InventoryRules ensureInventoryRules() => $_ensure(6);

  @$pb.TagNumber(8)
  AvailabilityRules get availabilityRules => $_getN(7);
  @$pb.TagNumber(8)
  set availabilityRules(AvailabilityRules value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasAvailabilityRules() => $_has(7);
  @$pb.TagNumber(8)
  void clearAvailabilityRules() => $_clearField(8);
  @$pb.TagNumber(8)
  AvailabilityRules ensureAvailabilityRules() => $_ensure(7);
}

class GetSchemaRequest extends $pb.GeneratedMessage {
  factory GetSchemaRequest({
    $core.String? schemaRef,
  }) {
    final result = create();
    if (schemaRef != null) result.schemaRef = schemaRef;
    return result;
  }

  GetSchemaRequest._();

  factory GetSchemaRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSchemaRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSchemaRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'schemaRef')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSchemaRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSchemaRequest copyWith(void Function(GetSchemaRequest) updates) =>
      super.copyWith((message) => updates(message as GetSchemaRequest))
          as GetSchemaRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSchemaRequest create() => GetSchemaRequest._();
  @$core.override
  GetSchemaRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetSchemaRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSchemaRequest>(create);
  static GetSchemaRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get schemaRef => $_getSZ(0);
  @$pb.TagNumber(1)
  set schemaRef($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSchemaRef() => $_has(0);
  @$pb.TagNumber(1)
  void clearSchemaRef() => $_clearField(1);
}

class ListSchemasRequest extends $pb.GeneratedMessage {
  factory ListSchemasRequest({
    $core.String? domain,
  }) {
    final result = create();
    if (domain != null) result.domain = domain;
    return result;
  }

  ListSchemasRequest._();

  factory ListSchemasRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListSchemasRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListSchemasRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'domain')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSchemasRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSchemasRequest copyWith(void Function(ListSchemasRequest) updates) =>
      super.copyWith((message) => updates(message as ListSchemasRequest))
          as ListSchemasRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListSchemasRequest create() => ListSchemasRequest._();
  @$core.override
  ListSchemasRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListSchemasRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListSchemasRequest>(create);
  static ListSchemasRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get domain => $_getSZ(0);
  @$pb.TagNumber(1)
  set domain($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDomain() => $_has(0);
  @$pb.TagNumber(1)
  void clearDomain() => $_clearField(1);
}

class SchemaList extends $pb.GeneratedMessage {
  factory SchemaList({
    $core.Iterable<AttributeSchema>? schemas,
  }) {
    final result = create();
    if (schemas != null) result.schemas.addAll(schemas);
    return result;
  }

  SchemaList._();

  factory SchemaList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SchemaList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SchemaList',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..pPM<AttributeSchema>(1, _omitFieldNames ? '' : 'schemas',
        subBuilder: AttributeSchema.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SchemaList clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SchemaList copyWith(void Function(SchemaList) updates) =>
      super.copyWith((message) => updates(message as SchemaList)) as SchemaList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SchemaList create() => SchemaList._();
  @$core.override
  SchemaList createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SchemaList getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SchemaList>(create);
  static SchemaList? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AttributeSchema> get schemas => $_getList(0);
}

class ValidateAttributesRequest extends $pb.GeneratedMessage {
  factory ValidateAttributesRequest({
    $core.String? schemaRef,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? attributes,
    $core.Iterable<FulfillmentType>? fulfillmentTypes,
    InventoryPolicy? inventoryPolicy,
  }) {
    final result = create();
    if (schemaRef != null) result.schemaRef = schemaRef;
    if (attributes != null) result.attributes.addEntries(attributes);
    if (fulfillmentTypes != null)
      result.fulfillmentTypes.addAll(fulfillmentTypes);
    if (inventoryPolicy != null) result.inventoryPolicy = inventoryPolicy;
    return result;
  }

  ValidateAttributesRequest._();

  factory ValidateAttributesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ValidateAttributesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ValidateAttributesRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'schemaRef')
    ..m<$core.String, $core.String>(2, _omitFieldNames ? '' : 'attributes',
        entryClassName: 'ValidateAttributesRequest.AttributesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('marketplace_core'))
    ..pc<FulfillmentType>(
        3, _omitFieldNames ? '' : 'fulfillmentTypes', $pb.PbFieldType.KE,
        valueOf: FulfillmentType.valueOf,
        enumValues: FulfillmentType.values,
        defaultEnumValue: FulfillmentType.FULFILLMENT_TYPE_UNSPECIFIED)
    ..aE<InventoryPolicy>(4, _omitFieldNames ? '' : 'inventoryPolicy',
        enumValues: InventoryPolicy.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidateAttributesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidateAttributesRequest copyWith(
          void Function(ValidateAttributesRequest) updates) =>
      super.copyWith((message) => updates(message as ValidateAttributesRequest))
          as ValidateAttributesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidateAttributesRequest create() => ValidateAttributesRequest._();
  @$core.override
  ValidateAttributesRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ValidateAttributesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ValidateAttributesRequest>(create);
  static ValidateAttributesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get schemaRef => $_getSZ(0);
  @$pb.TagNumber(1)
  set schemaRef($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSchemaRef() => $_has(0);
  @$pb.TagNumber(1)
  void clearSchemaRef() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbMap<$core.String, $core.String> get attributes => $_getMap(1);

  @$pb.TagNumber(3)
  $pb.PbList<FulfillmentType> get fulfillmentTypes => $_getList(2);

  @$pb.TagNumber(4)
  InventoryPolicy get inventoryPolicy => $_getN(3);
  @$pb.TagNumber(4)
  set inventoryPolicy(InventoryPolicy value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasInventoryPolicy() => $_has(3);
  @$pb.TagNumber(4)
  void clearInventoryPolicy() => $_clearField(4);
}

class ValidationResult extends $pb.GeneratedMessage {
  factory ValidationResult({
    $core.bool? valid,
    $core.Iterable<UserError>? errors,
  }) {
    final result = create();
    if (valid != null) result.valid = valid;
    if (errors != null) result.errors.addAll(errors);
    return result;
  }

  ValidationResult._();

  factory ValidationResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ValidationResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ValidationResult',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'valid')
    ..pPM<UserError>(2, _omitFieldNames ? '' : 'errors',
        subBuilder: UserError.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidationResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidationResult copyWith(void Function(ValidationResult) updates) =>
      super.copyWith((message) => updates(message as ValidationResult))
          as ValidationResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidationResult create() => ValidationResult._();
  @$core.override
  ValidationResult createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ValidationResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ValidationResult>(create);
  static ValidationResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get valid => $_getBF(0);
  @$pb.TagNumber(1)
  set valid($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasValid() => $_has(0);
  @$pb.TagNumber(1)
  void clearValid() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<UserError> get errors => $_getList(1);
}

class ConfirmTransactionRequest extends $pb.GeneratedMessage {
  factory ConfirmTransactionRequest({
    $core.String? productId,
    $core.String? variantId,
    $core.String? buyerId,
    $core.int? quantity,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (productId != null) result.productId = productId;
    if (variantId != null) result.variantId = variantId;
    if (buyerId != null) result.buyerId = buyerId;
    if (quantity != null) result.quantity = quantity;
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  ConfirmTransactionRequest._();

  factory ConfirmTransactionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ConfirmTransactionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConfirmTransactionRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'productId')
    ..aOS(2, _omitFieldNames ? '' : 'variantId')
    ..aOS(3, _omitFieldNames ? '' : 'buyerId')
    ..aI(4, _omitFieldNames ? '' : 'quantity')
    ..m<$core.String, $core.String>(5, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'ConfirmTransactionRequest.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('marketplace_core'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConfirmTransactionRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConfirmTransactionRequest copyWith(
          void Function(ConfirmTransactionRequest) updates) =>
      super.copyWith((message) => updates(message as ConfirmTransactionRequest))
          as ConfirmTransactionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConfirmTransactionRequest create() => ConfirmTransactionRequest._();
  @$core.override
  ConfirmTransactionRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ConfirmTransactionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConfirmTransactionRequest>(create);
  static ConfirmTransactionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get productId => $_getSZ(0);
  @$pb.TagNumber(1)
  set productId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProductId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProductId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get variantId => $_getSZ(1);
  @$pb.TagNumber(2)
  set variantId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVariantId() => $_has(1);
  @$pb.TagNumber(2)
  void clearVariantId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get buyerId => $_getSZ(2);
  @$pb.TagNumber(3)
  set buyerId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBuyerId() => $_has(2);
  @$pb.TagNumber(3)
  void clearBuyerId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get quantity => $_getIZ(3);
  @$pb.TagNumber(4)
  set quantity($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasQuantity() => $_has(3);
  @$pb.TagNumber(4)
  void clearQuantity() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(4);
}

class CancelTransactionRequest extends $pb.GeneratedMessage {
  factory CancelTransactionRequest({
    $core.String? transactionId,
    $core.String? reason,
  }) {
    final result = create();
    if (transactionId != null) result.transactionId = transactionId;
    if (reason != null) result.reason = reason;
    return result;
  }

  CancelTransactionRequest._();

  factory CancelTransactionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelTransactionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelTransactionRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionId')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelTransactionRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelTransactionRequest copyWith(
          void Function(CancelTransactionRequest) updates) =>
      super.copyWith((message) => updates(message as CancelTransactionRequest))
          as CancelTransactionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelTransactionRequest create() => CancelTransactionRequest._();
  @$core.override
  CancelTransactionRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CancelTransactionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelTransactionRequest>(create);
  static CancelTransactionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);
}

class GetTransactionStatusRequest extends $pb.GeneratedMessage {
  factory GetTransactionStatusRequest({
    $core.String? transactionId,
  }) {
    final result = create();
    if (transactionId != null) result.transactionId = transactionId;
    return result;
  }

  GetTransactionStatusRequest._();

  factory GetTransactionStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTransactionStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTransactionStatusRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransactionStatusRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransactionStatusRequest copyWith(
          void Function(GetTransactionStatusRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetTransactionStatusRequest))
          as GetTransactionStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransactionStatusRequest create() =>
      GetTransactionStatusRequest._();
  @$core.override
  GetTransactionStatusRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetTransactionStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTransactionStatusRequest>(create);
  static GetTransactionStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => $_clearField(1);
}

class TransactionResult extends $pb.GeneratedMessage {
  factory TransactionResult({
    $core.String? transactionId,
    $core.bool? success,
    $core.String? status,
    $core.Iterable<UserError>? errors,
  }) {
    final result = create();
    if (transactionId != null) result.transactionId = transactionId;
    if (success != null) result.success = success;
    if (status != null) result.status = status;
    if (errors != null) result.errors.addAll(errors);
    return result;
  }

  TransactionResult._();

  factory TransactionResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TransactionResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TransactionResult',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionId')
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..pPM<UserError>(4, _omitFieldNames ? '' : 'errors',
        subBuilder: UserError.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransactionResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransactionResult copyWith(void Function(TransactionResult) updates) =>
      super.copyWith((message) => updates(message as TransactionResult))
          as TransactionResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransactionResult create() => TransactionResult._();
  @$core.override
  TransactionResult createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TransactionResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TransactionResult>(create);
  static TransactionResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<UserError> get errors => $_getList(3);
}

class TransactionStatus extends $pb.GeneratedMessage {
  factory TransactionStatus({
    $core.String? transactionId,
    $core.String? status,
    $core.String? productId,
    $core.String? variantId,
    $core.String? buyerId,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (transactionId != null) result.transactionId = transactionId;
    if (status != null) result.status = status;
    if (productId != null) result.productId = productId;
    if (variantId != null) result.variantId = variantId;
    if (buyerId != null) result.buyerId = buyerId;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  TransactionStatus._();

  factory TransactionStatus.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TransactionStatus.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TransactionStatus',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionId')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..aOS(3, _omitFieldNames ? '' : 'productId')
    ..aOS(4, _omitFieldNames ? '' : 'variantId')
    ..aOS(5, _omitFieldNames ? '' : 'buyerId')
    ..aOS(6, _omitFieldNames ? '' : 'createdAt')
    ..aOS(7, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransactionStatus clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransactionStatus copyWith(void Function(TransactionStatus) updates) =>
      super.copyWith((message) => updates(message as TransactionStatus))
          as TransactionStatus;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransactionStatus create() => TransactionStatus._();
  @$core.override
  TransactionStatus createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TransactionStatus getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TransactionStatus>(create);
  static TransactionStatus? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get productId => $_getSZ(2);
  @$pb.TagNumber(3)
  set productId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasProductId() => $_has(2);
  @$pb.TagNumber(3)
  void clearProductId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get variantId => $_getSZ(3);
  @$pb.TagNumber(4)
  set variantId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasVariantId() => $_has(3);
  @$pb.TagNumber(4)
  void clearVariantId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get buyerId => $_getSZ(4);
  @$pb.TagNumber(5)
  set buyerId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBuyerId() => $_has(4);
  @$pb.TagNumber(5)
  void clearBuyerId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get createdAt => $_getSZ(5);
  @$pb.TagNumber(6)
  set createdAt($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCreatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreatedAt() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get updatedAt => $_getSZ(6);
  @$pb.TagNumber(7)
  set updatedAt($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasUpdatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearUpdatedAt() => $_clearField(7);
}

class InventoryRequest extends $pb.GeneratedMessage {
  factory InventoryRequest({
    $core.String? variantId,
    $core.int? quantity,
    $core.String? reason,
  }) {
    final result = create();
    if (variantId != null) result.variantId = variantId;
    if (quantity != null) result.quantity = quantity;
    if (reason != null) result.reason = reason;
    return result;
  }

  InventoryRequest._();

  factory InventoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InventoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InventoryRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'variantId')
    ..aI(2, _omitFieldNames ? '' : 'quantity')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InventoryRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InventoryRequest copyWith(void Function(InventoryRequest) updates) =>
      super.copyWith((message) => updates(message as InventoryRequest))
          as InventoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InventoryRequest create() => InventoryRequest._();
  @$core.override
  InventoryRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InventoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InventoryRequest>(create);
  static InventoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get variantId => $_getSZ(0);
  @$pb.TagNumber(1)
  set variantId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVariantId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVariantId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get quantity => $_getIZ(1);
  @$pb.TagNumber(2)
  set quantity($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasQuantity() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuantity() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => $_clearField(3);
}

class AdjustInventoryRequest extends $pb.GeneratedMessage {
  factory AdjustInventoryRequest({
    $core.String? variantId,
    $core.int? delta,
    $core.String? reason,
  }) {
    final result = create();
    if (variantId != null) result.variantId = variantId;
    if (delta != null) result.delta = delta;
    if (reason != null) result.reason = reason;
    return result;
  }

  AdjustInventoryRequest._();

  factory AdjustInventoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdjustInventoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdjustInventoryRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'variantId')
    ..aI(2, _omitFieldNames ? '' : 'delta')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdjustInventoryRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdjustInventoryRequest copyWith(
          void Function(AdjustInventoryRequest) updates) =>
      super.copyWith((message) => updates(message as AdjustInventoryRequest))
          as AdjustInventoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdjustInventoryRequest create() => AdjustInventoryRequest._();
  @$core.override
  AdjustInventoryRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AdjustInventoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdjustInventoryRequest>(create);
  static AdjustInventoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get variantId => $_getSZ(0);
  @$pb.TagNumber(1)
  set variantId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVariantId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVariantId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get delta => $_getIZ(1);
  @$pb.TagNumber(2)
  set delta($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDelta() => $_has(1);
  @$pb.TagNumber(2)
  void clearDelta() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => $_clearField(3);
}

class InventoryResult extends $pb.GeneratedMessage {
  factory InventoryResult({
    $core.String? variantId,
    $core.bool? success,
    InventoryInfo? inventory,
    $core.Iterable<UserError>? errors,
  }) {
    final result = create();
    if (variantId != null) result.variantId = variantId;
    if (success != null) result.success = success;
    if (inventory != null) result.inventory = inventory;
    if (errors != null) result.errors.addAll(errors);
    return result;
  }

  InventoryResult._();

  factory InventoryResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InventoryResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InventoryResult',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'variantId')
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOM<InventoryInfo>(3, _omitFieldNames ? '' : 'inventory',
        subBuilder: InventoryInfo.create)
    ..pPM<UserError>(4, _omitFieldNames ? '' : 'errors',
        subBuilder: UserError.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InventoryResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InventoryResult copyWith(void Function(InventoryResult) updates) =>
      super.copyWith((message) => updates(message as InventoryResult))
          as InventoryResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InventoryResult create() => InventoryResult._();
  @$core.override
  InventoryResult createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InventoryResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InventoryResult>(create);
  static InventoryResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get variantId => $_getSZ(0);
  @$pb.TagNumber(1)
  set variantId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVariantId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVariantId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  InventoryInfo get inventory => $_getN(2);
  @$pb.TagNumber(3)
  set inventory(InventoryInfo value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasInventory() => $_has(2);
  @$pb.TagNumber(3)
  void clearInventory() => $_clearField(3);
  @$pb.TagNumber(3)
  InventoryInfo ensureInventory() => $_ensure(2);

  @$pb.TagNumber(4)
  $pb.PbList<UserError> get errors => $_getList(3);
}

class GetAvailabilityRequest extends $pb.GeneratedMessage {
  factory GetAvailabilityRequest({
    $core.String? variantId,
    $core.String? date,
  }) {
    final result = create();
    if (variantId != null) result.variantId = variantId;
    if (date != null) result.date = date;
    return result;
  }

  GetAvailabilityRequest._();

  factory GetAvailabilityRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAvailabilityRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAvailabilityRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'variantId')
    ..aOS(2, _omitFieldNames ? '' : 'date')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAvailabilityRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAvailabilityRequest copyWith(
          void Function(GetAvailabilityRequest) updates) =>
      super.copyWith((message) => updates(message as GetAvailabilityRequest))
          as GetAvailabilityRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAvailabilityRequest create() => GetAvailabilityRequest._();
  @$core.override
  GetAvailabilityRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetAvailabilityRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAvailabilityRequest>(create);
  static GetAvailabilityRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get variantId => $_getSZ(0);
  @$pb.TagNumber(1)
  set variantId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVariantId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVariantId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get date => $_getSZ(1);
  @$pb.TagNumber(2)
  set date($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearDate() => $_clearField(2);
}

class AvailabilityInfo extends $pb.GeneratedMessage {
  factory AvailabilityInfo({
    $core.String? variantId,
    $core.bool? available,
    AvailabilityRule? rule,
    InventoryInfo? inventory,
    $core.Iterable<TimeSlot>? openSlots,
  }) {
    final result = create();
    if (variantId != null) result.variantId = variantId;
    if (available != null) result.available = available;
    if (rule != null) result.rule = rule;
    if (inventory != null) result.inventory = inventory;
    if (openSlots != null) result.openSlots.addAll(openSlots);
    return result;
  }

  AvailabilityInfo._();

  factory AvailabilityInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AvailabilityInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AvailabilityInfo',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'variantId')
    ..aOB(2, _omitFieldNames ? '' : 'available')
    ..aOM<AvailabilityRule>(3, _omitFieldNames ? '' : 'rule',
        subBuilder: AvailabilityRule.create)
    ..aOM<InventoryInfo>(4, _omitFieldNames ? '' : 'inventory',
        subBuilder: InventoryInfo.create)
    ..pPM<TimeSlot>(5, _omitFieldNames ? '' : 'openSlots',
        subBuilder: TimeSlot.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AvailabilityInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AvailabilityInfo copyWith(void Function(AvailabilityInfo) updates) =>
      super.copyWith((message) => updates(message as AvailabilityInfo))
          as AvailabilityInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AvailabilityInfo create() => AvailabilityInfo._();
  @$core.override
  AvailabilityInfo createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AvailabilityInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AvailabilityInfo>(create);
  static AvailabilityInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get variantId => $_getSZ(0);
  @$pb.TagNumber(1)
  set variantId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVariantId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVariantId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get available => $_getBF(1);
  @$pb.TagNumber(2)
  set available($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAvailable() => $_has(1);
  @$pb.TagNumber(2)
  void clearAvailable() => $_clearField(2);

  @$pb.TagNumber(3)
  AvailabilityRule get rule => $_getN(2);
  @$pb.TagNumber(3)
  set rule(AvailabilityRule value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasRule() => $_has(2);
  @$pb.TagNumber(3)
  void clearRule() => $_clearField(3);
  @$pb.TagNumber(3)
  AvailabilityRule ensureRule() => $_ensure(2);

  @$pb.TagNumber(4)
  InventoryInfo get inventory => $_getN(3);
  @$pb.TagNumber(4)
  set inventory(InventoryInfo value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasInventory() => $_has(3);
  @$pb.TagNumber(4)
  void clearInventory() => $_clearField(4);
  @$pb.TagNumber(4)
  InventoryInfo ensureInventory() => $_ensure(3);

  @$pb.TagNumber(5)
  $pb.PbList<TimeSlot> get openSlots => $_getList(4);
}

class RecordOriginRequest extends $pb.GeneratedMessage {
  factory RecordOriginRequest({
    $core.String? productId,
    $core.String? originParty,
    GeoLocation? originLocation,
    $core.String? description,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (productId != null) result.productId = productId;
    if (originParty != null) result.originParty = originParty;
    if (originLocation != null) result.originLocation = originLocation;
    if (description != null) result.description = description;
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  RecordOriginRequest._();

  factory RecordOriginRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RecordOriginRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecordOriginRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'productId')
    ..aOS(2, _omitFieldNames ? '' : 'originParty')
    ..aOM<GeoLocation>(3, _omitFieldNames ? '' : 'originLocation',
        subBuilder: GeoLocation.create)
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..m<$core.String, $core.String>(5, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'RecordOriginRequest.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('marketplace_core'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecordOriginRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecordOriginRequest copyWith(void Function(RecordOriginRequest) updates) =>
      super.copyWith((message) => updates(message as RecordOriginRequest))
          as RecordOriginRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecordOriginRequest create() => RecordOriginRequest._();
  @$core.override
  RecordOriginRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RecordOriginRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RecordOriginRequest>(create);
  static RecordOriginRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get productId => $_getSZ(0);
  @$pb.TagNumber(1)
  set productId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProductId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProductId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get originParty => $_getSZ(1);
  @$pb.TagNumber(2)
  set originParty($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOriginParty() => $_has(1);
  @$pb.TagNumber(2)
  void clearOriginParty() => $_clearField(2);

  @$pb.TagNumber(3)
  GeoLocation get originLocation => $_getN(2);
  @$pb.TagNumber(3)
  set originLocation(GeoLocation value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasOriginLocation() => $_has(2);
  @$pb.TagNumber(3)
  void clearOriginLocation() => $_clearField(3);
  @$pb.TagNumber(3)
  GeoLocation ensureOriginLocation() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(4);
}

class RecordTransferRequest extends $pb.GeneratedMessage {
  factory RecordTransferRequest({
    $core.String? productId,
    $core.String? fromParty,
    $core.String? toParty,
    GeoLocation? location,
    $core.String? description,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (productId != null) result.productId = productId;
    if (fromParty != null) result.fromParty = fromParty;
    if (toParty != null) result.toParty = toParty;
    if (location != null) result.location = location;
    if (description != null) result.description = description;
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  RecordTransferRequest._();

  factory RecordTransferRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RecordTransferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecordTransferRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'productId')
    ..aOS(2, _omitFieldNames ? '' : 'fromParty')
    ..aOS(3, _omitFieldNames ? '' : 'toParty')
    ..aOM<GeoLocation>(4, _omitFieldNames ? '' : 'location',
        subBuilder: GeoLocation.create)
    ..aOS(5, _omitFieldNames ? '' : 'description')
    ..m<$core.String, $core.String>(6, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'RecordTransferRequest.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('marketplace_core'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecordTransferRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecordTransferRequest copyWith(
          void Function(RecordTransferRequest) updates) =>
      super.copyWith((message) => updates(message as RecordTransferRequest))
          as RecordTransferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecordTransferRequest create() => RecordTransferRequest._();
  @$core.override
  RecordTransferRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RecordTransferRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RecordTransferRequest>(create);
  static RecordTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get productId => $_getSZ(0);
  @$pb.TagNumber(1)
  set productId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProductId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProductId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get fromParty => $_getSZ(1);
  @$pb.TagNumber(2)
  set fromParty($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFromParty() => $_has(1);
  @$pb.TagNumber(2)
  void clearFromParty() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get toParty => $_getSZ(2);
  @$pb.TagNumber(3)
  set toParty($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasToParty() => $_has(2);
  @$pb.TagNumber(3)
  void clearToParty() => $_clearField(3);

  @$pb.TagNumber(4)
  GeoLocation get location => $_getN(3);
  @$pb.TagNumber(4)
  set location(GeoLocation value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasLocation() => $_has(3);
  @$pb.TagNumber(4)
  void clearLocation() => $_clearField(4);
  @$pb.TagNumber(4)
  GeoLocation ensureLocation() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(5);
}

class RecordTransformationRequest extends $pb.GeneratedMessage {
  factory RecordTransformationRequest({
    $core.String? productId,
    $core.Iterable<$core.String>? inputProductIds,
    $core.String? description,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (productId != null) result.productId = productId;
    if (inputProductIds != null) result.inputProductIds.addAll(inputProductIds);
    if (description != null) result.description = description;
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  RecordTransformationRequest._();

  factory RecordTransformationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RecordTransformationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecordTransformationRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'productId')
    ..pPS(2, _omitFieldNames ? '' : 'inputProductIds')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..m<$core.String, $core.String>(4, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'RecordTransformationRequest.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('marketplace_core'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecordTransformationRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecordTransformationRequest copyWith(
          void Function(RecordTransformationRequest) updates) =>
      super.copyWith(
              (message) => updates(message as RecordTransformationRequest))
          as RecordTransformationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecordTransformationRequest create() =>
      RecordTransformationRequest._();
  @$core.override
  RecordTransformationRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RecordTransformationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RecordTransformationRequest>(create);
  static RecordTransformationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get productId => $_getSZ(0);
  @$pb.TagNumber(1)
  set productId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProductId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProductId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get inputProductIds => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(3);
}

class GetChainRequest extends $pb.GeneratedMessage {
  factory GetChainRequest({
    $core.String? productId,
  }) {
    final result = create();
    if (productId != null) result.productId = productId;
    return result;
  }

  GetChainRequest._();

  factory GetChainRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetChainRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetChainRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'productId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetChainRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetChainRequest copyWith(void Function(GetChainRequest) updates) =>
      super.copyWith((message) => updates(message as GetChainRequest))
          as GetChainRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetChainRequest create() => GetChainRequest._();
  @$core.override
  GetChainRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetChainRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetChainRequest>(create);
  static GetChainRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get productId => $_getSZ(0);
  @$pb.TagNumber(1)
  set productId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProductId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProductId() => $_clearField(1);
}

class VerifyChainRequest extends $pb.GeneratedMessage {
  factory VerifyChainRequest({
    $core.String? productId,
  }) {
    final result = create();
    if (productId != null) result.productId = productId;
    return result;
  }

  VerifyChainRequest._();

  factory VerifyChainRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyChainRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyChainRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'productId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyChainRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyChainRequest copyWith(void Function(VerifyChainRequest) updates) =>
      super.copyWith((message) => updates(message as VerifyChainRequest))
          as VerifyChainRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyChainRequest create() => VerifyChainRequest._();
  @$core.override
  VerifyChainRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VerifyChainRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyChainRequest>(create);
  static VerifyChainRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get productId => $_getSZ(0);
  @$pb.TagNumber(1)
  set productId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProductId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProductId() => $_clearField(1);
}

class VerifyChainResult extends $pb.GeneratedMessage {
  factory VerifyChainResult({
    $core.String? productId,
    $core.bool? verified,
    $core.int? eventCount,
    $core.String? firstEvent,
    $core.String? lastEvent,
  }) {
    final result = create();
    if (productId != null) result.productId = productId;
    if (verified != null) result.verified = verified;
    if (eventCount != null) result.eventCount = eventCount;
    if (firstEvent != null) result.firstEvent = firstEvent;
    if (lastEvent != null) result.lastEvent = lastEvent;
    return result;
  }

  VerifyChainResult._();

  factory VerifyChainResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyChainResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyChainResult',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'productId')
    ..aOB(2, _omitFieldNames ? '' : 'verified')
    ..aI(3, _omitFieldNames ? '' : 'eventCount')
    ..aOS(4, _omitFieldNames ? '' : 'firstEvent')
    ..aOS(5, _omitFieldNames ? '' : 'lastEvent')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyChainResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyChainResult copyWith(void Function(VerifyChainResult) updates) =>
      super.copyWith((message) => updates(message as VerifyChainResult))
          as VerifyChainResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyChainResult create() => VerifyChainResult._();
  @$core.override
  VerifyChainResult createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VerifyChainResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyChainResult>(create);
  static VerifyChainResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get productId => $_getSZ(0);
  @$pb.TagNumber(1)
  set productId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProductId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProductId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get verified => $_getBF(1);
  @$pb.TagNumber(2)
  set verified($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVerified() => $_has(1);
  @$pb.TagNumber(2)
  void clearVerified() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get eventCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set eventCount($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEventCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearEventCount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get firstEvent => $_getSZ(3);
  @$pb.TagNumber(4)
  set firstEvent($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFirstEvent() => $_has(3);
  @$pb.TagNumber(4)
  void clearFirstEvent() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get lastEvent => $_getSZ(4);
  @$pb.TagNumber(5)
  set lastEvent($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasLastEvent() => $_has(4);
  @$pb.TagNumber(5)
  void clearLastEvent() => $_clearField(5);
}

class SubmitRatingRequest extends $pb.GeneratedMessage {
  factory SubmitRatingRequest({
    $core.String? fromId,
    $core.String? toId,
    $core.String? productId,
    $core.String? transactionId,
    $core.int? score,
    $core.String? comment,
  }) {
    final result = create();
    if (fromId != null) result.fromId = fromId;
    if (toId != null) result.toId = toId;
    if (productId != null) result.productId = productId;
    if (transactionId != null) result.transactionId = transactionId;
    if (score != null) result.score = score;
    if (comment != null) result.comment = comment;
    return result;
  }

  SubmitRatingRequest._();

  factory SubmitRatingRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubmitRatingRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubmitRatingRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromId')
    ..aOS(2, _omitFieldNames ? '' : 'toId')
    ..aOS(3, _omitFieldNames ? '' : 'productId')
    ..aOS(4, _omitFieldNames ? '' : 'transactionId')
    ..aI(5, _omitFieldNames ? '' : 'score')
    ..aOS(6, _omitFieldNames ? '' : 'comment')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitRatingRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitRatingRequest copyWith(void Function(SubmitRatingRequest) updates) =>
      super.copyWith((message) => updates(message as SubmitRatingRequest))
          as SubmitRatingRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubmitRatingRequest create() => SubmitRatingRequest._();
  @$core.override
  SubmitRatingRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SubmitRatingRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubmitRatingRequest>(create);
  static SubmitRatingRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFromId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get toId => $_getSZ(1);
  @$pb.TagNumber(2)
  set toId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasToId() => $_has(1);
  @$pb.TagNumber(2)
  void clearToId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get productId => $_getSZ(2);
  @$pb.TagNumber(3)
  set productId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasProductId() => $_has(2);
  @$pb.TagNumber(3)
  void clearProductId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get transactionId => $_getSZ(3);
  @$pb.TagNumber(4)
  set transactionId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTransactionId() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransactionId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get score => $_getIZ(4);
  @$pb.TagNumber(5)
  set score($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasScore() => $_has(4);
  @$pb.TagNumber(5)
  void clearScore() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get comment => $_getSZ(5);
  @$pb.TagNumber(6)
  set comment($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasComment() => $_has(5);
  @$pb.TagNumber(6)
  void clearComment() => $_clearField(6);
}

class GetReputationRequest extends $pb.GeneratedMessage {
  factory GetReputationRequest({
    $core.String? entityId,
  }) {
    final result = create();
    if (entityId != null) result.entityId = entityId;
    return result;
  }

  GetReputationRequest._();

  factory GetReputationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetReputationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetReputationRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'entityId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetReputationRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetReputationRequest copyWith(void Function(GetReputationRequest) updates) =>
      super.copyWith((message) => updates(message as GetReputationRequest))
          as GetReputationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetReputationRequest create() => GetReputationRequest._();
  @$core.override
  GetReputationRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetReputationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetReputationRequest>(create);
  static GetReputationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get entityId => $_getSZ(0);
  @$pb.TagNumber(1)
  set entityId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEntityId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEntityId() => $_clearField(1);
}

class GetReviewHistoryRequest extends $pb.GeneratedMessage {
  factory GetReviewHistoryRequest({
    $core.String? entityId,
    $core.int? limit,
    $core.String? cursor,
  }) {
    final result = create();
    if (entityId != null) result.entityId = entityId;
    if (limit != null) result.limit = limit;
    if (cursor != null) result.cursor = cursor;
    return result;
  }

  GetReviewHistoryRequest._();

  factory GetReviewHistoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetReviewHistoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetReviewHistoryRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'entityId')
    ..aI(2, _omitFieldNames ? '' : 'limit')
    ..aOS(3, _omitFieldNames ? '' : 'cursor')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetReviewHistoryRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetReviewHistoryRequest copyWith(
          void Function(GetReviewHistoryRequest) updates) =>
      super.copyWith((message) => updates(message as GetReviewHistoryRequest))
          as GetReviewHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetReviewHistoryRequest create() => GetReviewHistoryRequest._();
  @$core.override
  GetReviewHistoryRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetReviewHistoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetReviewHistoryRequest>(create);
  static GetReviewHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get entityId => $_getSZ(0);
  @$pb.TagNumber(1)
  set entityId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEntityId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEntityId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get cursor => $_getSZ(2);
  @$pb.TagNumber(3)
  set cursor($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCursor() => $_has(2);
  @$pb.TagNumber(3)
  void clearCursor() => $_clearField(3);
}

class UserError extends $pb.GeneratedMessage {
  factory UserError({
    $core.Iterable<$core.String>? field,
    $core.String? message,
  }) {
    final result = create();
    if (field != null) result.field.addAll(field);
    if (message != null) result.message = message;
    return result;
  }

  UserError._();

  factory UserError.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserError.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserError',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'field')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserError clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserError copyWith(void Function(UserError) updates) =>
      super.copyWith((message) => updates(message as UserError)) as UserError;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserError create() => UserError._();
  @$core.override
  UserError createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserError getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserError>(create);
  static UserError? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get field => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class HealthStatus extends $pb.GeneratedMessage {
  factory HealthStatus({
    $core.bool? healthy,
    $core.String? version,
    $core.int? activeVendors,
    $core.int? activeProducts,
  }) {
    final result = create();
    if (healthy != null) result.healthy = healthy;
    if (version != null) result.version = version;
    if (activeVendors != null) result.activeVendors = activeVendors;
    if (activeProducts != null) result.activeProducts = activeProducts;
    return result;
  }

  HealthStatus._();

  factory HealthStatus.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HealthStatus.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HealthStatus',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'marketplace_core'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'healthy')
    ..aOS(2, _omitFieldNames ? '' : 'version')
    ..aI(3, _omitFieldNames ? '' : 'activeVendors')
    ..aI(4, _omitFieldNames ? '' : 'activeProducts')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HealthStatus clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HealthStatus copyWith(void Function(HealthStatus) updates) =>
      super.copyWith((message) => updates(message as HealthStatus))
          as HealthStatus;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HealthStatus create() => HealthStatus._();
  @$core.override
  HealthStatus createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HealthStatus getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HealthStatus>(create);
  static HealthStatus? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get healthy => $_getBF(0);
  @$pb.TagNumber(1)
  set healthy($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasHealthy() => $_has(0);
  @$pb.TagNumber(1)
  void clearHealthy() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get version => $_getSZ(1);
  @$pb.TagNumber(2)
  set version($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get activeVendors => $_getIZ(2);
  @$pb.TagNumber(3)
  set activeVendors($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasActiveVendors() => $_has(2);
  @$pb.TagNumber(3)
  void clearActiveVendors() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get activeProducts => $_getIZ(3);
  @$pb.TagNumber(4)
  set activeProducts($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasActiveProducts() => $_has(3);
  @$pb.TagNumber(4)
  void clearActiveProducts() => $_clearField(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
