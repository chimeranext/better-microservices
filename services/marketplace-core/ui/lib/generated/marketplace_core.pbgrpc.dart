// This is a generated file - do not edit.
//
// Generated from marketplace_core.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'marketplace_core.pb.dart' as $0;

export 'marketplace_core.pb.dart';

@$pb.GrpcServiceName('marketplace_core.MarketplaceAdmin')
class MarketplaceAdminClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  MarketplaceAdminClient(super.channel, {super.options, super.interceptors});

  /// Products
  $grpc.ResponseFuture<$0.Product> createProduct(
    $0.CreateProductRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createProduct, request, options: options);
  }

  $grpc.ResponseFuture<$0.Product> updateProduct(
    $0.UpdateProductRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateProduct, request, options: options);
  }

  $grpc.ResponseFuture<$0.Product> archiveProduct(
    $0.ArchiveProductRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$archiveProduct, request, options: options);
  }

  $grpc.ResponseFuture<$0.Product> getProduct(
    $0.GetProductRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getProduct, request, options: options);
  }

  $grpc.ResponseFuture<$0.ProductPage> listProducts(
    $0.ListProductsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listProducts, request, options: options);
  }

  /// Variants
  $grpc.ResponseFuture<$0.Variant> createVariant(
    $0.CreateVariantRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createVariant, request, options: options);
  }

  $grpc.ResponseFuture<$0.Variant> updateVariant(
    $0.UpdateVariantRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateVariant, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> deleteVariant(
    $0.DeleteVariantRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deleteVariant, request, options: options);
  }

  $grpc.ResponseFuture<$0.BulkVariantsResponse> bulkCreateVariants(
    $0.BulkCreateVariantsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$bulkCreateVariants, request, options: options);
  }

  /// Collections
  $grpc.ResponseFuture<$0.Collection> createCollection(
    $0.CreateCollectionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createCollection, request, options: options);
  }

  $grpc.ResponseFuture<$0.Collection> updateCollection(
    $0.UpdateCollectionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateCollection, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> deleteCollection(
    $0.DeleteCollectionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deleteCollection, request, options: options);
  }

  $grpc.ResponseFuture<$0.Collection> addProductsToCollection(
    $0.CollectionProductsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$addProductsToCollection, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.Collection> removeProductsFromCollection(
    $0.CollectionProductsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$removeProductsFromCollection, request,
        options: options);
  }

  /// Vendors
  $grpc.ResponseFuture<$0.Vendor> registerVendor(
    $0.RegisterVendorRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$registerVendor, request, options: options);
  }

  $grpc.ResponseFuture<$0.Vendor> updateVendor(
    $0.UpdateVendorRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateVendor, request, options: options);
  }

  $grpc.ResponseFuture<$0.Vendor> verifyVendor(
    $0.VerifyVendorRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$verifyVendor, request, options: options);
  }

  /// Storefronts
  $grpc.ResponseFuture<$0.Storefront> createStorefront(
    $0.CreateStorefrontRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createStorefront, request, options: options);
  }

  $grpc.ResponseFuture<$0.Storefront> updateStorefront(
    $0.UpdateStorefrontRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateStorefront, request, options: options);
  }

  /// Media
  $grpc.ResponseFuture<$0.MediaAsset> uploadMedia(
    $async.Stream<$0.UploadMediaRequest> request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(_$uploadMedia, request, options: options)
        .single;
  }

  $grpc.ResponseFuture<$0.Empty> deleteMedia(
    $0.DeleteMediaRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deleteMedia, request, options: options);
  }

  /// Schema Registry
  $grpc.ResponseFuture<$0.AttributeSchema> registerSchema(
    $0.RegisterSchemaRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$registerSchema, request, options: options);
  }

  $grpc.ResponseFuture<$0.AttributeSchema> getSchema(
    $0.GetSchemaRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getSchema, request, options: options);
  }

  $grpc.ResponseFuture<$0.SchemaList> listSchemas(
    $0.ListSchemasRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listSchemas, request, options: options);
  }

  $grpc.ResponseFuture<$0.ValidationResult> validateAttributes(
    $0.ValidateAttributesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$validateAttributes, request, options: options);
  }

  /// Health
  $grpc.ResponseFuture<$0.HealthStatus> healthCheck(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$healthCheck, request, options: options);
  }

  // method descriptors

  static final _$createProduct =
      $grpc.ClientMethod<$0.CreateProductRequest, $0.Product>(
          '/marketplace_core.MarketplaceAdmin/CreateProduct',
          ($0.CreateProductRequest value) => value.writeToBuffer(),
          $0.Product.fromBuffer);
  static final _$updateProduct =
      $grpc.ClientMethod<$0.UpdateProductRequest, $0.Product>(
          '/marketplace_core.MarketplaceAdmin/UpdateProduct',
          ($0.UpdateProductRequest value) => value.writeToBuffer(),
          $0.Product.fromBuffer);
  static final _$archiveProduct =
      $grpc.ClientMethod<$0.ArchiveProductRequest, $0.Product>(
          '/marketplace_core.MarketplaceAdmin/ArchiveProduct',
          ($0.ArchiveProductRequest value) => value.writeToBuffer(),
          $0.Product.fromBuffer);
  static final _$getProduct =
      $grpc.ClientMethod<$0.GetProductRequest, $0.Product>(
          '/marketplace_core.MarketplaceAdmin/GetProduct',
          ($0.GetProductRequest value) => value.writeToBuffer(),
          $0.Product.fromBuffer);
  static final _$listProducts =
      $grpc.ClientMethod<$0.ListProductsRequest, $0.ProductPage>(
          '/marketplace_core.MarketplaceAdmin/ListProducts',
          ($0.ListProductsRequest value) => value.writeToBuffer(),
          $0.ProductPage.fromBuffer);
  static final _$createVariant =
      $grpc.ClientMethod<$0.CreateVariantRequest, $0.Variant>(
          '/marketplace_core.MarketplaceAdmin/CreateVariant',
          ($0.CreateVariantRequest value) => value.writeToBuffer(),
          $0.Variant.fromBuffer);
  static final _$updateVariant =
      $grpc.ClientMethod<$0.UpdateVariantRequest, $0.Variant>(
          '/marketplace_core.MarketplaceAdmin/UpdateVariant',
          ($0.UpdateVariantRequest value) => value.writeToBuffer(),
          $0.Variant.fromBuffer);
  static final _$deleteVariant =
      $grpc.ClientMethod<$0.DeleteVariantRequest, $0.Empty>(
          '/marketplace_core.MarketplaceAdmin/DeleteVariant',
          ($0.DeleteVariantRequest value) => value.writeToBuffer(),
          $0.Empty.fromBuffer);
  static final _$bulkCreateVariants =
      $grpc.ClientMethod<$0.BulkCreateVariantsRequest, $0.BulkVariantsResponse>(
          '/marketplace_core.MarketplaceAdmin/BulkCreateVariants',
          ($0.BulkCreateVariantsRequest value) => value.writeToBuffer(),
          $0.BulkVariantsResponse.fromBuffer);
  static final _$createCollection =
      $grpc.ClientMethod<$0.CreateCollectionRequest, $0.Collection>(
          '/marketplace_core.MarketplaceAdmin/CreateCollection',
          ($0.CreateCollectionRequest value) => value.writeToBuffer(),
          $0.Collection.fromBuffer);
  static final _$updateCollection =
      $grpc.ClientMethod<$0.UpdateCollectionRequest, $0.Collection>(
          '/marketplace_core.MarketplaceAdmin/UpdateCollection',
          ($0.UpdateCollectionRequest value) => value.writeToBuffer(),
          $0.Collection.fromBuffer);
  static final _$deleteCollection =
      $grpc.ClientMethod<$0.DeleteCollectionRequest, $0.Empty>(
          '/marketplace_core.MarketplaceAdmin/DeleteCollection',
          ($0.DeleteCollectionRequest value) => value.writeToBuffer(),
          $0.Empty.fromBuffer);
  static final _$addProductsToCollection =
      $grpc.ClientMethod<$0.CollectionProductsRequest, $0.Collection>(
          '/marketplace_core.MarketplaceAdmin/AddProductsToCollection',
          ($0.CollectionProductsRequest value) => value.writeToBuffer(),
          $0.Collection.fromBuffer);
  static final _$removeProductsFromCollection =
      $grpc.ClientMethod<$0.CollectionProductsRequest, $0.Collection>(
          '/marketplace_core.MarketplaceAdmin/RemoveProductsFromCollection',
          ($0.CollectionProductsRequest value) => value.writeToBuffer(),
          $0.Collection.fromBuffer);
  static final _$registerVendor =
      $grpc.ClientMethod<$0.RegisterVendorRequest, $0.Vendor>(
          '/marketplace_core.MarketplaceAdmin/RegisterVendor',
          ($0.RegisterVendorRequest value) => value.writeToBuffer(),
          $0.Vendor.fromBuffer);
  static final _$updateVendor =
      $grpc.ClientMethod<$0.UpdateVendorRequest, $0.Vendor>(
          '/marketplace_core.MarketplaceAdmin/UpdateVendor',
          ($0.UpdateVendorRequest value) => value.writeToBuffer(),
          $0.Vendor.fromBuffer);
  static final _$verifyVendor =
      $grpc.ClientMethod<$0.VerifyVendorRequest, $0.Vendor>(
          '/marketplace_core.MarketplaceAdmin/VerifyVendor',
          ($0.VerifyVendorRequest value) => value.writeToBuffer(),
          $0.Vendor.fromBuffer);
  static final _$createStorefront =
      $grpc.ClientMethod<$0.CreateStorefrontRequest, $0.Storefront>(
          '/marketplace_core.MarketplaceAdmin/CreateStorefront',
          ($0.CreateStorefrontRequest value) => value.writeToBuffer(),
          $0.Storefront.fromBuffer);
  static final _$updateStorefront =
      $grpc.ClientMethod<$0.UpdateStorefrontRequest, $0.Storefront>(
          '/marketplace_core.MarketplaceAdmin/UpdateStorefront',
          ($0.UpdateStorefrontRequest value) => value.writeToBuffer(),
          $0.Storefront.fromBuffer);
  static final _$uploadMedia =
      $grpc.ClientMethod<$0.UploadMediaRequest, $0.MediaAsset>(
          '/marketplace_core.MarketplaceAdmin/UploadMedia',
          ($0.UploadMediaRequest value) => value.writeToBuffer(),
          $0.MediaAsset.fromBuffer);
  static final _$deleteMedia =
      $grpc.ClientMethod<$0.DeleteMediaRequest, $0.Empty>(
          '/marketplace_core.MarketplaceAdmin/DeleteMedia',
          ($0.DeleteMediaRequest value) => value.writeToBuffer(),
          $0.Empty.fromBuffer);
  static final _$registerSchema =
      $grpc.ClientMethod<$0.RegisterSchemaRequest, $0.AttributeSchema>(
          '/marketplace_core.MarketplaceAdmin/RegisterSchema',
          ($0.RegisterSchemaRequest value) => value.writeToBuffer(),
          $0.AttributeSchema.fromBuffer);
  static final _$getSchema =
      $grpc.ClientMethod<$0.GetSchemaRequest, $0.AttributeSchema>(
          '/marketplace_core.MarketplaceAdmin/GetSchema',
          ($0.GetSchemaRequest value) => value.writeToBuffer(),
          $0.AttributeSchema.fromBuffer);
  static final _$listSchemas =
      $grpc.ClientMethod<$0.ListSchemasRequest, $0.SchemaList>(
          '/marketplace_core.MarketplaceAdmin/ListSchemas',
          ($0.ListSchemasRequest value) => value.writeToBuffer(),
          $0.SchemaList.fromBuffer);
  static final _$validateAttributes =
      $grpc.ClientMethod<$0.ValidateAttributesRequest, $0.ValidationResult>(
          '/marketplace_core.MarketplaceAdmin/ValidateAttributes',
          ($0.ValidateAttributesRequest value) => value.writeToBuffer(),
          $0.ValidationResult.fromBuffer);
  static final _$healthCheck = $grpc.ClientMethod<$0.Empty, $0.HealthStatus>(
      '/marketplace_core.MarketplaceAdmin/HealthCheck',
      ($0.Empty value) => value.writeToBuffer(),
      $0.HealthStatus.fromBuffer);
}

@$pb.GrpcServiceName('marketplace_core.MarketplaceAdmin')
abstract class MarketplaceAdminServiceBase extends $grpc.Service {
  $core.String get $name => 'marketplace_core.MarketplaceAdmin';

  MarketplaceAdminServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateProductRequest, $0.Product>(
        'CreateProduct',
        createProduct_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateProductRequest.fromBuffer(value),
        ($0.Product value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateProductRequest, $0.Product>(
        'UpdateProduct',
        updateProduct_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateProductRequest.fromBuffer(value),
        ($0.Product value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ArchiveProductRequest, $0.Product>(
        'ArchiveProduct',
        archiveProduct_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ArchiveProductRequest.fromBuffer(value),
        ($0.Product value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetProductRequest, $0.Product>(
        'GetProduct',
        getProduct_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetProductRequest.fromBuffer(value),
        ($0.Product value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListProductsRequest, $0.ProductPage>(
        'ListProducts',
        listProducts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListProductsRequest.fromBuffer(value),
        ($0.ProductPage value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateVariantRequest, $0.Variant>(
        'CreateVariant',
        createVariant_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateVariantRequest.fromBuffer(value),
        ($0.Variant value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateVariantRequest, $0.Variant>(
        'UpdateVariant',
        updateVariant_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateVariantRequest.fromBuffer(value),
        ($0.Variant value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteVariantRequest, $0.Empty>(
        'DeleteVariant',
        deleteVariant_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteVariantRequest.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BulkCreateVariantsRequest,
            $0.BulkVariantsResponse>(
        'BulkCreateVariants',
        bulkCreateVariants_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.BulkCreateVariantsRequest.fromBuffer(value),
        ($0.BulkVariantsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateCollectionRequest, $0.Collection>(
        'CreateCollection',
        createCollection_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateCollectionRequest.fromBuffer(value),
        ($0.Collection value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateCollectionRequest, $0.Collection>(
        'UpdateCollection',
        updateCollection_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateCollectionRequest.fromBuffer(value),
        ($0.Collection value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteCollectionRequest, $0.Empty>(
        'DeleteCollection',
        deleteCollection_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteCollectionRequest.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CollectionProductsRequest, $0.Collection>(
        'AddProductsToCollection',
        addProductsToCollection_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CollectionProductsRequest.fromBuffer(value),
        ($0.Collection value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CollectionProductsRequest, $0.Collection>(
        'RemoveProductsFromCollection',
        removeProductsFromCollection_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CollectionProductsRequest.fromBuffer(value),
        ($0.Collection value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RegisterVendorRequest, $0.Vendor>(
        'RegisterVendor',
        registerVendor_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RegisterVendorRequest.fromBuffer(value),
        ($0.Vendor value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateVendorRequest, $0.Vendor>(
        'UpdateVendor',
        updateVendor_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateVendorRequest.fromBuffer(value),
        ($0.Vendor value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyVendorRequest, $0.Vendor>(
        'VerifyVendor',
        verifyVendor_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.VerifyVendorRequest.fromBuffer(value),
        ($0.Vendor value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateStorefrontRequest, $0.Storefront>(
        'CreateStorefront',
        createStorefront_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateStorefrontRequest.fromBuffer(value),
        ($0.Storefront value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateStorefrontRequest, $0.Storefront>(
        'UpdateStorefront',
        updateStorefront_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateStorefrontRequest.fromBuffer(value),
        ($0.Storefront value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UploadMediaRequest, $0.MediaAsset>(
        'UploadMedia',
        uploadMedia,
        true,
        false,
        ($core.List<$core.int> value) =>
            $0.UploadMediaRequest.fromBuffer(value),
        ($0.MediaAsset value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteMediaRequest, $0.Empty>(
        'DeleteMedia',
        deleteMedia_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteMediaRequest.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.RegisterSchemaRequest, $0.AttributeSchema>(
            'RegisterSchema',
            registerSchema_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.RegisterSchemaRequest.fromBuffer(value),
            ($0.AttributeSchema value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSchemaRequest, $0.AttributeSchema>(
        'GetSchema',
        getSchema_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetSchemaRequest.fromBuffer(value),
        ($0.AttributeSchema value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListSchemasRequest, $0.SchemaList>(
        'ListSchemas',
        listSchemas_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListSchemasRequest.fromBuffer(value),
        ($0.SchemaList value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ValidateAttributesRequest, $0.ValidationResult>(
            'ValidateAttributes',
            validateAttributes_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ValidateAttributesRequest.fromBuffer(value),
            ($0.ValidationResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.HealthStatus>(
        'HealthCheck',
        healthCheck_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.HealthStatus value) => value.writeToBuffer()));
  }

  $async.Future<$0.Product> createProduct_Pre($grpc.ServiceCall $call,
      $async.Future<$0.CreateProductRequest> $request) async {
    return createProduct($call, await $request);
  }

  $async.Future<$0.Product> createProduct(
      $grpc.ServiceCall call, $0.CreateProductRequest request);

  $async.Future<$0.Product> updateProduct_Pre($grpc.ServiceCall $call,
      $async.Future<$0.UpdateProductRequest> $request) async {
    return updateProduct($call, await $request);
  }

  $async.Future<$0.Product> updateProduct(
      $grpc.ServiceCall call, $0.UpdateProductRequest request);

  $async.Future<$0.Product> archiveProduct_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ArchiveProductRequest> $request) async {
    return archiveProduct($call, await $request);
  }

  $async.Future<$0.Product> archiveProduct(
      $grpc.ServiceCall call, $0.ArchiveProductRequest request);

  $async.Future<$0.Product> getProduct_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetProductRequest> $request) async {
    return getProduct($call, await $request);
  }

  $async.Future<$0.Product> getProduct(
      $grpc.ServiceCall call, $0.GetProductRequest request);

  $async.Future<$0.ProductPage> listProducts_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ListProductsRequest> $request) async {
    return listProducts($call, await $request);
  }

  $async.Future<$0.ProductPage> listProducts(
      $grpc.ServiceCall call, $0.ListProductsRequest request);

  $async.Future<$0.Variant> createVariant_Pre($grpc.ServiceCall $call,
      $async.Future<$0.CreateVariantRequest> $request) async {
    return createVariant($call, await $request);
  }

  $async.Future<$0.Variant> createVariant(
      $grpc.ServiceCall call, $0.CreateVariantRequest request);

  $async.Future<$0.Variant> updateVariant_Pre($grpc.ServiceCall $call,
      $async.Future<$0.UpdateVariantRequest> $request) async {
    return updateVariant($call, await $request);
  }

  $async.Future<$0.Variant> updateVariant(
      $grpc.ServiceCall call, $0.UpdateVariantRequest request);

  $async.Future<$0.Empty> deleteVariant_Pre($grpc.ServiceCall $call,
      $async.Future<$0.DeleteVariantRequest> $request) async {
    return deleteVariant($call, await $request);
  }

  $async.Future<$0.Empty> deleteVariant(
      $grpc.ServiceCall call, $0.DeleteVariantRequest request);

  $async.Future<$0.BulkVariantsResponse> bulkCreateVariants_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.BulkCreateVariantsRequest> $request) async {
    return bulkCreateVariants($call, await $request);
  }

  $async.Future<$0.BulkVariantsResponse> bulkCreateVariants(
      $grpc.ServiceCall call, $0.BulkCreateVariantsRequest request);

  $async.Future<$0.Collection> createCollection_Pre($grpc.ServiceCall $call,
      $async.Future<$0.CreateCollectionRequest> $request) async {
    return createCollection($call, await $request);
  }

  $async.Future<$0.Collection> createCollection(
      $grpc.ServiceCall call, $0.CreateCollectionRequest request);

  $async.Future<$0.Collection> updateCollection_Pre($grpc.ServiceCall $call,
      $async.Future<$0.UpdateCollectionRequest> $request) async {
    return updateCollection($call, await $request);
  }

  $async.Future<$0.Collection> updateCollection(
      $grpc.ServiceCall call, $0.UpdateCollectionRequest request);

  $async.Future<$0.Empty> deleteCollection_Pre($grpc.ServiceCall $call,
      $async.Future<$0.DeleteCollectionRequest> $request) async {
    return deleteCollection($call, await $request);
  }

  $async.Future<$0.Empty> deleteCollection(
      $grpc.ServiceCall call, $0.DeleteCollectionRequest request);

  $async.Future<$0.Collection> addProductsToCollection_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CollectionProductsRequest> $request) async {
    return addProductsToCollection($call, await $request);
  }

  $async.Future<$0.Collection> addProductsToCollection(
      $grpc.ServiceCall call, $0.CollectionProductsRequest request);

  $async.Future<$0.Collection> removeProductsFromCollection_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CollectionProductsRequest> $request) async {
    return removeProductsFromCollection($call, await $request);
  }

  $async.Future<$0.Collection> removeProductsFromCollection(
      $grpc.ServiceCall call, $0.CollectionProductsRequest request);

  $async.Future<$0.Vendor> registerVendor_Pre($grpc.ServiceCall $call,
      $async.Future<$0.RegisterVendorRequest> $request) async {
    return registerVendor($call, await $request);
  }

  $async.Future<$0.Vendor> registerVendor(
      $grpc.ServiceCall call, $0.RegisterVendorRequest request);

  $async.Future<$0.Vendor> updateVendor_Pre($grpc.ServiceCall $call,
      $async.Future<$0.UpdateVendorRequest> $request) async {
    return updateVendor($call, await $request);
  }

  $async.Future<$0.Vendor> updateVendor(
      $grpc.ServiceCall call, $0.UpdateVendorRequest request);

  $async.Future<$0.Vendor> verifyVendor_Pre($grpc.ServiceCall $call,
      $async.Future<$0.VerifyVendorRequest> $request) async {
    return verifyVendor($call, await $request);
  }

  $async.Future<$0.Vendor> verifyVendor(
      $grpc.ServiceCall call, $0.VerifyVendorRequest request);

  $async.Future<$0.Storefront> createStorefront_Pre($grpc.ServiceCall $call,
      $async.Future<$0.CreateStorefrontRequest> $request) async {
    return createStorefront($call, await $request);
  }

  $async.Future<$0.Storefront> createStorefront(
      $grpc.ServiceCall call, $0.CreateStorefrontRequest request);

  $async.Future<$0.Storefront> updateStorefront_Pre($grpc.ServiceCall $call,
      $async.Future<$0.UpdateStorefrontRequest> $request) async {
    return updateStorefront($call, await $request);
  }

  $async.Future<$0.Storefront> updateStorefront(
      $grpc.ServiceCall call, $0.UpdateStorefrontRequest request);

  $async.Future<$0.MediaAsset> uploadMedia(
      $grpc.ServiceCall call, $async.Stream<$0.UploadMediaRequest> request);

  $async.Future<$0.Empty> deleteMedia_Pre($grpc.ServiceCall $call,
      $async.Future<$0.DeleteMediaRequest> $request) async {
    return deleteMedia($call, await $request);
  }

  $async.Future<$0.Empty> deleteMedia(
      $grpc.ServiceCall call, $0.DeleteMediaRequest request);

  $async.Future<$0.AttributeSchema> registerSchema_Pre($grpc.ServiceCall $call,
      $async.Future<$0.RegisterSchemaRequest> $request) async {
    return registerSchema($call, await $request);
  }

  $async.Future<$0.AttributeSchema> registerSchema(
      $grpc.ServiceCall call, $0.RegisterSchemaRequest request);

  $async.Future<$0.AttributeSchema> getSchema_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetSchemaRequest> $request) async {
    return getSchema($call, await $request);
  }

  $async.Future<$0.AttributeSchema> getSchema(
      $grpc.ServiceCall call, $0.GetSchemaRequest request);

  $async.Future<$0.SchemaList> listSchemas_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ListSchemasRequest> $request) async {
    return listSchemas($call, await $request);
  }

  $async.Future<$0.SchemaList> listSchemas(
      $grpc.ServiceCall call, $0.ListSchemasRequest request);

  $async.Future<$0.ValidationResult> validateAttributes_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ValidateAttributesRequest> $request) async {
    return validateAttributes($call, await $request);
  }

  $async.Future<$0.ValidationResult> validateAttributes(
      $grpc.ServiceCall call, $0.ValidateAttributesRequest request);

  $async.Future<$0.HealthStatus> healthCheck_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return healthCheck($call, await $request);
  }

  $async.Future<$0.HealthStatus> healthCheck(
      $grpc.ServiceCall call, $0.Empty request);
}

@$pb.GrpcServiceName('marketplace_core.MarketplaceStorefront')
class MarketplaceStorefrontClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  MarketplaceStorefrontClient(super.channel,
      {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.ProductPage> browseProducts(
    $0.BrowseRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$browseProducts, request, options: options);
  }

  $grpc.ResponseFuture<$0.Product> getProductDetail(
    $0.GetProductRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getProductDetail, request, options: options);
  }

  $grpc.ResponseFuture<$0.ProductPage> searchProducts(
    $0.SearchRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$searchProducts, request, options: options);
  }

  $grpc.ResponseFuture<$0.CollectionPage> listCollections(
    $0.ListCollectionsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listCollections, request, options: options);
  }

  $grpc.ResponseFuture<$0.Collection> getCollection(
    $0.GetCollectionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getCollection, request, options: options);
  }

  $grpc.ResponseFuture<$0.Storefront> getStorefront(
    $0.GetStorefrontRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getStorefront, request, options: options);
  }

  $grpc.ResponseFuture<$0.VendorProfile> getVendorProfile(
    $0.GetVendorProfileRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getVendorProfile, request, options: options);
  }

  // method descriptors

  static final _$browseProducts =
      $grpc.ClientMethod<$0.BrowseRequest, $0.ProductPage>(
          '/marketplace_core.MarketplaceStorefront/BrowseProducts',
          ($0.BrowseRequest value) => value.writeToBuffer(),
          $0.ProductPage.fromBuffer);
  static final _$getProductDetail =
      $grpc.ClientMethod<$0.GetProductRequest, $0.Product>(
          '/marketplace_core.MarketplaceStorefront/GetProductDetail',
          ($0.GetProductRequest value) => value.writeToBuffer(),
          $0.Product.fromBuffer);
  static final _$searchProducts =
      $grpc.ClientMethod<$0.SearchRequest, $0.ProductPage>(
          '/marketplace_core.MarketplaceStorefront/SearchProducts',
          ($0.SearchRequest value) => value.writeToBuffer(),
          $0.ProductPage.fromBuffer);
  static final _$listCollections =
      $grpc.ClientMethod<$0.ListCollectionsRequest, $0.CollectionPage>(
          '/marketplace_core.MarketplaceStorefront/ListCollections',
          ($0.ListCollectionsRequest value) => value.writeToBuffer(),
          $0.CollectionPage.fromBuffer);
  static final _$getCollection =
      $grpc.ClientMethod<$0.GetCollectionRequest, $0.Collection>(
          '/marketplace_core.MarketplaceStorefront/GetCollection',
          ($0.GetCollectionRequest value) => value.writeToBuffer(),
          $0.Collection.fromBuffer);
  static final _$getStorefront =
      $grpc.ClientMethod<$0.GetStorefrontRequest, $0.Storefront>(
          '/marketplace_core.MarketplaceStorefront/GetStorefront',
          ($0.GetStorefrontRequest value) => value.writeToBuffer(),
          $0.Storefront.fromBuffer);
  static final _$getVendorProfile =
      $grpc.ClientMethod<$0.GetVendorProfileRequest, $0.VendorProfile>(
          '/marketplace_core.MarketplaceStorefront/GetVendorProfile',
          ($0.GetVendorProfileRequest value) => value.writeToBuffer(),
          $0.VendorProfile.fromBuffer);
}

@$pb.GrpcServiceName('marketplace_core.MarketplaceStorefront')
abstract class MarketplaceStorefrontServiceBase extends $grpc.Service {
  $core.String get $name => 'marketplace_core.MarketplaceStorefront';

  MarketplaceStorefrontServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.BrowseRequest, $0.ProductPage>(
        'BrowseProducts',
        browseProducts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BrowseRequest.fromBuffer(value),
        ($0.ProductPage value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetProductRequest, $0.Product>(
        'GetProductDetail',
        getProductDetail_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetProductRequest.fromBuffer(value),
        ($0.Product value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SearchRequest, $0.ProductPage>(
        'SearchProducts',
        searchProducts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SearchRequest.fromBuffer(value),
        ($0.ProductPage value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ListCollectionsRequest, $0.CollectionPage>(
            'ListCollections',
            listCollections_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ListCollectionsRequest.fromBuffer(value),
            ($0.CollectionPage value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCollectionRequest, $0.Collection>(
        'GetCollection',
        getCollection_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetCollectionRequest.fromBuffer(value),
        ($0.Collection value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetStorefrontRequest, $0.Storefront>(
        'GetStorefront',
        getStorefront_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetStorefrontRequest.fromBuffer(value),
        ($0.Storefront value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetVendorProfileRequest, $0.VendorProfile>(
            'GetVendorProfile',
            getVendorProfile_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetVendorProfileRequest.fromBuffer(value),
            ($0.VendorProfile value) => value.writeToBuffer()));
  }

  $async.Future<$0.ProductPage> browseProducts_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.BrowseRequest> $request) async {
    return browseProducts($call, await $request);
  }

  $async.Future<$0.ProductPage> browseProducts(
      $grpc.ServiceCall call, $0.BrowseRequest request);

  $async.Future<$0.Product> getProductDetail_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetProductRequest> $request) async {
    return getProductDetail($call, await $request);
  }

  $async.Future<$0.Product> getProductDetail(
      $grpc.ServiceCall call, $0.GetProductRequest request);

  $async.Future<$0.ProductPage> searchProducts_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.SearchRequest> $request) async {
    return searchProducts($call, await $request);
  }

  $async.Future<$0.ProductPage> searchProducts(
      $grpc.ServiceCall call, $0.SearchRequest request);

  $async.Future<$0.CollectionPage> listCollections_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ListCollectionsRequest> $request) async {
    return listCollections($call, await $request);
  }

  $async.Future<$0.CollectionPage> listCollections(
      $grpc.ServiceCall call, $0.ListCollectionsRequest request);

  $async.Future<$0.Collection> getCollection_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetCollectionRequest> $request) async {
    return getCollection($call, await $request);
  }

  $async.Future<$0.Collection> getCollection(
      $grpc.ServiceCall call, $0.GetCollectionRequest request);

  $async.Future<$0.Storefront> getStorefront_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetStorefrontRequest> $request) async {
    return getStorefront($call, await $request);
  }

  $async.Future<$0.Storefront> getStorefront(
      $grpc.ServiceCall call, $0.GetStorefrontRequest request);

  $async.Future<$0.VendorProfile> getVendorProfile_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetVendorProfileRequest> $request) async {
    return getVendorProfile($call, await $request);
  }

  $async.Future<$0.VendorProfile> getVendorProfile(
      $grpc.ServiceCall call, $0.GetVendorProfileRequest request);
}

@$pb.GrpcServiceName('marketplace_core.MarketplaceTransaction')
class MarketplaceTransactionClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  MarketplaceTransactionClient(super.channel,
      {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.TransactionResult> confirmTransaction(
    $0.ConfirmTransactionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$confirmTransaction, request, options: options);
  }

  $grpc.ResponseFuture<$0.TransactionResult> cancelTransaction(
    $0.CancelTransactionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$cancelTransaction, request, options: options);
  }

  $grpc.ResponseFuture<$0.TransactionStatus> getTransactionStatus(
    $0.GetTransactionStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getTransactionStatus, request, options: options);
  }

  // method descriptors

  static final _$confirmTransaction =
      $grpc.ClientMethod<$0.ConfirmTransactionRequest, $0.TransactionResult>(
          '/marketplace_core.MarketplaceTransaction/ConfirmTransaction',
          ($0.ConfirmTransactionRequest value) => value.writeToBuffer(),
          $0.TransactionResult.fromBuffer);
  static final _$cancelTransaction =
      $grpc.ClientMethod<$0.CancelTransactionRequest, $0.TransactionResult>(
          '/marketplace_core.MarketplaceTransaction/CancelTransaction',
          ($0.CancelTransactionRequest value) => value.writeToBuffer(),
          $0.TransactionResult.fromBuffer);
  static final _$getTransactionStatus =
      $grpc.ClientMethod<$0.GetTransactionStatusRequest, $0.TransactionStatus>(
          '/marketplace_core.MarketplaceTransaction/GetTransactionStatus',
          ($0.GetTransactionStatusRequest value) => value.writeToBuffer(),
          $0.TransactionStatus.fromBuffer);
}

@$pb.GrpcServiceName('marketplace_core.MarketplaceTransaction')
abstract class MarketplaceTransactionServiceBase extends $grpc.Service {
  $core.String get $name => 'marketplace_core.MarketplaceTransaction';

  MarketplaceTransactionServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.ConfirmTransactionRequest, $0.TransactionResult>(
            'ConfirmTransaction',
            confirmTransaction_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ConfirmTransactionRequest.fromBuffer(value),
            ($0.TransactionResult value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.CancelTransactionRequest, $0.TransactionResult>(
            'CancelTransaction',
            cancelTransaction_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.CancelTransactionRequest.fromBuffer(value),
            ($0.TransactionResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTransactionStatusRequest,
            $0.TransactionStatus>(
        'GetTransactionStatus',
        getTransactionStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetTransactionStatusRequest.fromBuffer(value),
        ($0.TransactionStatus value) => value.writeToBuffer()));
  }

  $async.Future<$0.TransactionResult> confirmTransaction_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ConfirmTransactionRequest> $request) async {
    return confirmTransaction($call, await $request);
  }

  $async.Future<$0.TransactionResult> confirmTransaction(
      $grpc.ServiceCall call, $0.ConfirmTransactionRequest request);

  $async.Future<$0.TransactionResult> cancelTransaction_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CancelTransactionRequest> $request) async {
    return cancelTransaction($call, await $request);
  }

  $async.Future<$0.TransactionResult> cancelTransaction(
      $grpc.ServiceCall call, $0.CancelTransactionRequest request);

  $async.Future<$0.TransactionStatus> getTransactionStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetTransactionStatusRequest> $request) async {
    return getTransactionStatus($call, await $request);
  }

  $async.Future<$0.TransactionStatus> getTransactionStatus(
      $grpc.ServiceCall call, $0.GetTransactionStatusRequest request);
}

@$pb.GrpcServiceName('marketplace_core.MarketplaceInventory')
class MarketplaceInventoryClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  MarketplaceInventoryClient(super.channel,
      {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.InventoryResult> reserveInventory(
    $0.InventoryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$reserveInventory, request, options: options);
  }

  $grpc.ResponseFuture<$0.InventoryResult> releaseInventory(
    $0.InventoryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$releaseInventory, request, options: options);
  }

  $grpc.ResponseFuture<$0.InventoryResult> adjustInventory(
    $0.AdjustInventoryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adjustInventory, request, options: options);
  }

  $grpc.ResponseFuture<$0.AvailabilityInfo> getAvailability(
    $0.GetAvailabilityRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAvailability, request, options: options);
  }

  // method descriptors

  static final _$reserveInventory =
      $grpc.ClientMethod<$0.InventoryRequest, $0.InventoryResult>(
          '/marketplace_core.MarketplaceInventory/ReserveInventory',
          ($0.InventoryRequest value) => value.writeToBuffer(),
          $0.InventoryResult.fromBuffer);
  static final _$releaseInventory =
      $grpc.ClientMethod<$0.InventoryRequest, $0.InventoryResult>(
          '/marketplace_core.MarketplaceInventory/ReleaseInventory',
          ($0.InventoryRequest value) => value.writeToBuffer(),
          $0.InventoryResult.fromBuffer);
  static final _$adjustInventory =
      $grpc.ClientMethod<$0.AdjustInventoryRequest, $0.InventoryResult>(
          '/marketplace_core.MarketplaceInventory/AdjustInventory',
          ($0.AdjustInventoryRequest value) => value.writeToBuffer(),
          $0.InventoryResult.fromBuffer);
  static final _$getAvailability =
      $grpc.ClientMethod<$0.GetAvailabilityRequest, $0.AvailabilityInfo>(
          '/marketplace_core.MarketplaceInventory/GetAvailability',
          ($0.GetAvailabilityRequest value) => value.writeToBuffer(),
          $0.AvailabilityInfo.fromBuffer);
}

@$pb.GrpcServiceName('marketplace_core.MarketplaceInventory')
abstract class MarketplaceInventoryServiceBase extends $grpc.Service {
  $core.String get $name => 'marketplace_core.MarketplaceInventory';

  MarketplaceInventoryServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.InventoryRequest, $0.InventoryResult>(
        'ReserveInventory',
        reserveInventory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.InventoryRequest.fromBuffer(value),
        ($0.InventoryResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.InventoryRequest, $0.InventoryResult>(
        'ReleaseInventory',
        releaseInventory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.InventoryRequest.fromBuffer(value),
        ($0.InventoryResult value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.AdjustInventoryRequest, $0.InventoryResult>(
            'AdjustInventory',
            adjustInventory_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.AdjustInventoryRequest.fromBuffer(value),
            ($0.InventoryResult value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetAvailabilityRequest, $0.AvailabilityInfo>(
            'GetAvailability',
            getAvailability_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetAvailabilityRequest.fromBuffer(value),
            ($0.AvailabilityInfo value) => value.writeToBuffer()));
  }

  $async.Future<$0.InventoryResult> reserveInventory_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.InventoryRequest> $request) async {
    return reserveInventory($call, await $request);
  }

  $async.Future<$0.InventoryResult> reserveInventory(
      $grpc.ServiceCall call, $0.InventoryRequest request);

  $async.Future<$0.InventoryResult> releaseInventory_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.InventoryRequest> $request) async {
    return releaseInventory($call, await $request);
  }

  $async.Future<$0.InventoryResult> releaseInventory(
      $grpc.ServiceCall call, $0.InventoryRequest request);

  $async.Future<$0.InventoryResult> adjustInventory_Pre($grpc.ServiceCall $call,
      $async.Future<$0.AdjustInventoryRequest> $request) async {
    return adjustInventory($call, await $request);
  }

  $async.Future<$0.InventoryResult> adjustInventory(
      $grpc.ServiceCall call, $0.AdjustInventoryRequest request);

  $async.Future<$0.AvailabilityInfo> getAvailability_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAvailabilityRequest> $request) async {
    return getAvailability($call, await $request);
  }

  $async.Future<$0.AvailabilityInfo> getAvailability(
      $grpc.ServiceCall call, $0.GetAvailabilityRequest request);
}

@$pb.GrpcServiceName('marketplace_core.MarketplaceTraceability')
class MarketplaceTraceabilityClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  MarketplaceTraceabilityClient(super.channel,
      {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.TraceEvent> recordOrigin(
    $0.RecordOriginRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$recordOrigin, request, options: options);
  }

  $grpc.ResponseFuture<$0.TraceEvent> recordTransfer(
    $0.RecordTransferRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$recordTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$0.TraceEvent> recordTransformation(
    $0.RecordTransformationRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$recordTransformation, request, options: options);
  }

  $grpc.ResponseFuture<$0.TraceChain> getChain(
    $0.GetChainRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getChain, request, options: options);
  }

  $grpc.ResponseFuture<$0.VerifyChainResult> verifyChain(
    $0.VerifyChainRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$verifyChain, request, options: options);
  }

  // method descriptors

  static final _$recordOrigin =
      $grpc.ClientMethod<$0.RecordOriginRequest, $0.TraceEvent>(
          '/marketplace_core.MarketplaceTraceability/RecordOrigin',
          ($0.RecordOriginRequest value) => value.writeToBuffer(),
          $0.TraceEvent.fromBuffer);
  static final _$recordTransfer =
      $grpc.ClientMethod<$0.RecordTransferRequest, $0.TraceEvent>(
          '/marketplace_core.MarketplaceTraceability/RecordTransfer',
          ($0.RecordTransferRequest value) => value.writeToBuffer(),
          $0.TraceEvent.fromBuffer);
  static final _$recordTransformation =
      $grpc.ClientMethod<$0.RecordTransformationRequest, $0.TraceEvent>(
          '/marketplace_core.MarketplaceTraceability/RecordTransformation',
          ($0.RecordTransformationRequest value) => value.writeToBuffer(),
          $0.TraceEvent.fromBuffer);
  static final _$getChain =
      $grpc.ClientMethod<$0.GetChainRequest, $0.TraceChain>(
          '/marketplace_core.MarketplaceTraceability/GetChain',
          ($0.GetChainRequest value) => value.writeToBuffer(),
          $0.TraceChain.fromBuffer);
  static final _$verifyChain =
      $grpc.ClientMethod<$0.VerifyChainRequest, $0.VerifyChainResult>(
          '/marketplace_core.MarketplaceTraceability/VerifyChain',
          ($0.VerifyChainRequest value) => value.writeToBuffer(),
          $0.VerifyChainResult.fromBuffer);
}

@$pb.GrpcServiceName('marketplace_core.MarketplaceTraceability')
abstract class MarketplaceTraceabilityServiceBase extends $grpc.Service {
  $core.String get $name => 'marketplace_core.MarketplaceTraceability';

  MarketplaceTraceabilityServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.RecordOriginRequest, $0.TraceEvent>(
        'RecordOrigin',
        recordOrigin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RecordOriginRequest.fromBuffer(value),
        ($0.TraceEvent value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RecordTransferRequest, $0.TraceEvent>(
        'RecordTransfer',
        recordTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RecordTransferRequest.fromBuffer(value),
        ($0.TraceEvent value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.RecordTransformationRequest, $0.TraceEvent>(
            'RecordTransformation',
            recordTransformation_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.RecordTransformationRequest.fromBuffer(value),
            ($0.TraceEvent value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetChainRequest, $0.TraceChain>(
        'GetChain',
        getChain_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetChainRequest.fromBuffer(value),
        ($0.TraceChain value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyChainRequest, $0.VerifyChainResult>(
        'VerifyChain',
        verifyChain_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.VerifyChainRequest.fromBuffer(value),
        ($0.VerifyChainResult value) => value.writeToBuffer()));
  }

  $async.Future<$0.TraceEvent> recordOrigin_Pre($grpc.ServiceCall $call,
      $async.Future<$0.RecordOriginRequest> $request) async {
    return recordOrigin($call, await $request);
  }

  $async.Future<$0.TraceEvent> recordOrigin(
      $grpc.ServiceCall call, $0.RecordOriginRequest request);

  $async.Future<$0.TraceEvent> recordTransfer_Pre($grpc.ServiceCall $call,
      $async.Future<$0.RecordTransferRequest> $request) async {
    return recordTransfer($call, await $request);
  }

  $async.Future<$0.TraceEvent> recordTransfer(
      $grpc.ServiceCall call, $0.RecordTransferRequest request);

  $async.Future<$0.TraceEvent> recordTransformation_Pre($grpc.ServiceCall $call,
      $async.Future<$0.RecordTransformationRequest> $request) async {
    return recordTransformation($call, await $request);
  }

  $async.Future<$0.TraceEvent> recordTransformation(
      $grpc.ServiceCall call, $0.RecordTransformationRequest request);

  $async.Future<$0.TraceChain> getChain_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetChainRequest> $request) async {
    return getChain($call, await $request);
  }

  $async.Future<$0.TraceChain> getChain(
      $grpc.ServiceCall call, $0.GetChainRequest request);

  $async.Future<$0.VerifyChainResult> verifyChain_Pre($grpc.ServiceCall $call,
      $async.Future<$0.VerifyChainRequest> $request) async {
    return verifyChain($call, await $request);
  }

  $async.Future<$0.VerifyChainResult> verifyChain(
      $grpc.ServiceCall call, $0.VerifyChainRequest request);
}

@$pb.GrpcServiceName('marketplace_core.MarketplaceReputation')
class MarketplaceReputationClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  MarketplaceReputationClient(super.channel,
      {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.Rating> submitRating(
    $0.SubmitRatingRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$submitRating, request, options: options);
  }

  $grpc.ResponseFuture<$0.ReputationScore> getReputation(
    $0.GetReputationRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getReputation, request, options: options);
  }

  $grpc.ResponseFuture<$0.ReviewHistory> getReviewHistory(
    $0.GetReviewHistoryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getReviewHistory, request, options: options);
  }

  // method descriptors

  static final _$submitRating =
      $grpc.ClientMethod<$0.SubmitRatingRequest, $0.Rating>(
          '/marketplace_core.MarketplaceReputation/SubmitRating',
          ($0.SubmitRatingRequest value) => value.writeToBuffer(),
          $0.Rating.fromBuffer);
  static final _$getReputation =
      $grpc.ClientMethod<$0.GetReputationRequest, $0.ReputationScore>(
          '/marketplace_core.MarketplaceReputation/GetReputation',
          ($0.GetReputationRequest value) => value.writeToBuffer(),
          $0.ReputationScore.fromBuffer);
  static final _$getReviewHistory =
      $grpc.ClientMethod<$0.GetReviewHistoryRequest, $0.ReviewHistory>(
          '/marketplace_core.MarketplaceReputation/GetReviewHistory',
          ($0.GetReviewHistoryRequest value) => value.writeToBuffer(),
          $0.ReviewHistory.fromBuffer);
}

@$pb.GrpcServiceName('marketplace_core.MarketplaceReputation')
abstract class MarketplaceReputationServiceBase extends $grpc.Service {
  $core.String get $name => 'marketplace_core.MarketplaceReputation';

  MarketplaceReputationServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SubmitRatingRequest, $0.Rating>(
        'SubmitRating',
        submitRating_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SubmitRatingRequest.fromBuffer(value),
        ($0.Rating value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetReputationRequest, $0.ReputationScore>(
        'GetReputation',
        getReputation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetReputationRequest.fromBuffer(value),
        ($0.ReputationScore value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetReviewHistoryRequest, $0.ReviewHistory>(
            'GetReviewHistory',
            getReviewHistory_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetReviewHistoryRequest.fromBuffer(value),
            ($0.ReviewHistory value) => value.writeToBuffer()));
  }

  $async.Future<$0.Rating> submitRating_Pre($grpc.ServiceCall $call,
      $async.Future<$0.SubmitRatingRequest> $request) async {
    return submitRating($call, await $request);
  }

  $async.Future<$0.Rating> submitRating(
      $grpc.ServiceCall call, $0.SubmitRatingRequest request);

  $async.Future<$0.ReputationScore> getReputation_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetReputationRequest> $request) async {
    return getReputation($call, await $request);
  }

  $async.Future<$0.ReputationScore> getReputation(
      $grpc.ServiceCall call, $0.GetReputationRequest request);

  $async.Future<$0.ReviewHistory> getReviewHistory_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetReviewHistoryRequest> $request) async {
    return getReviewHistory($call, await $request);
  }

  $async.Future<$0.ReviewHistory> getReviewHistory(
      $grpc.ServiceCall call, $0.GetReviewHistoryRequest request);
}
