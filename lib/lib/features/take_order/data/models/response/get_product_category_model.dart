// To parse this JSON data, do
//
//     final getProductCategoryModel = getProductCategoryModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:myco_flutter/features/take_order/domain/entities/get_product_category_entity.dart';

part 'get_product_category_model.g.dart';

GetProductCategoryModel getProductCategoryModelFromJson(String str) =>
    GetProductCategoryModel.fromJson(json.decode(str));

String getProductCategoryModelToJson(GetProductCategoryModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class GetProductCategoryModel {
  @JsonKey(name: 'product_categories')
  List<ProductCategory>? productCategories;
  @JsonKey(name: 'product_sub_categories')
  List<dynamic>? productSubCategories;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'status')
  String? status;

  GetProductCategoryModel({
    this.productCategories,
    this.productSubCategories,
    this.message,
    this.status,
  });

  factory GetProductCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$GetProductCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetProductCategoryModelToJson(this);

  GetProductCategoryEntity toEntity() => GetProductCategoryEntity(
    productCategories:
        productCategories?.map((e) => e.toEntity()).toList() ?? [],
    productSubCategories: productSubCategories ?? [],
    message: message ?? '',
    status: status ?? '',
  );
}

@JsonSerializable()
class ProductCategory {
  @JsonKey(name: 'product_category_id')
  String? productCategoryId;
  @JsonKey(name: 'category_name')
  String? categoryName;
  @JsonKey(name: 'products')
  List<Product>? products;
  @JsonKey(name: 'subcategory')
  List<dynamic>? subcategory;

  ProductCategory({
    this.productCategoryId,
    this.categoryName,
    this.products,
    this.subcategory,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryToJson(this);

  ProductCategoryEntity toEntity() => ProductCategoryEntity(
    productCategoryId: productCategoryId ?? '',
    categoryName: categoryName ?? '',
    products: products?.map((e) => e.toEntity()).toList() ?? [],
    subcategory: subcategory ?? [],
  );
}

@JsonSerializable()
class Product {
  @JsonKey(name: 'product_id')
  String? productId;
  @JsonKey(name: 'product_variant_id')
  String? productVariantId;
  @JsonKey(name: 'product_category_id')
  String? productCategoryId;
  @JsonKey(name: 'product_sub_category_id')
  String? productSubCategoryId;
  @JsonKey(name: 'product_name')
  String? productName;
  @JsonKey(name: 'product_variant_name')
  String? productVariantName;
  @JsonKey(name: 'hsn_code')
  String? hsnCode;
  @JsonKey(name: 'variant_photo')
  String? variantPhoto;
  @JsonKey(name: 'variant_packing_type')
  String? variantPackingType;
  @JsonKey(name: 'variant_bulk_type')
  String? variantBulkType;
  @JsonKey(name: 'variant_bulk_type_view')
  String? variantBulkTypeView;
  @JsonKey(name: 'sku')
  String? sku;
  @JsonKey(name: 'variant_per_box_piece')
  String? variantPerBoxPiece;
  @JsonKey(name: 'base_price')
  String? basePrice;
  @JsonKey(name: 'retailer_selling_price')
  String? retailerSellingPrice;
  @JsonKey(name: 'maximum_retail_price')
  String? maximumRetailPrice;
  @JsonKey(name: 'mrp')
  String? mrp;
  @JsonKey(name: 'menufacturing_cost')
  String? menufacturingCost;
  @JsonKey(name: 'unit_measurement_id')
  String? unitMeasurementId;
  @JsonKey(name: 'unit_measurement_name')
  String? unitMeasurementName;
  @JsonKey(name: 'variant_description')
  String? variantDescription;
  @JsonKey(name: 'weight_in_kg')
  String? weightInKg;
  @JsonKey(name: 'total_offer')
  String? totalOffer;
  @JsonKey(name: 'gst_percentage')
  String? gstPercentage;
  @JsonKey(name: 'cgst')
  String? cgst;
  @JsonKey(name: 'sgst')
  String? sgst;
  @JsonKey(name: 'igst')
  String? igst;
  @JsonKey(name: 'is_offer_available')
  bool? isOfferAvailable;

  Product({
    this.productId,
    this.productVariantId,
    this.productCategoryId,
    this.productSubCategoryId,
    this.productName,
    this.productVariantName,
    this.hsnCode,
    this.variantPhoto,
    this.variantPackingType,
    this.variantBulkType,
    this.variantBulkTypeView,
    this.sku,
    this.variantPerBoxPiece,
    this.basePrice,
    this.retailerSellingPrice,
    this.maximumRetailPrice,
    this.mrp,
    this.menufacturingCost,
    this.unitMeasurementId,
    this.unitMeasurementName,
    this.variantDescription,
    this.weightInKg,
    this.totalOffer,
    this.gstPercentage,
    this.cgst,
    this.sgst,
    this.igst,
    this.isOfferAvailable,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  ProductEntity toEntity() => ProductEntity(
    productId: productId ?? '',
    productVariantId: productVariantId ?? '',
    productCategoryId: productCategoryId ?? '',
    productSubCategoryId: productSubCategoryId ?? '',
    productName: productName ?? '',
    productVariantName: productVariantName ?? '',
    hsnCode: hsnCode ?? '',
    variantPhoto: variantPhoto ?? '',
    variantPackingType: variantPackingType ?? '',
    variantBulkType: variantBulkType ?? '',
    variantBulkTypeView: variantBulkTypeView ?? '',
    sku: sku ?? '',
    variantPerBoxPiece: variantPerBoxPiece ?? '',
    basePrice: basePrice ?? '',
    retailerSellingPrice: retailerSellingPrice ?? '',
    maximumRetailPrice: maximumRetailPrice ?? '',
    mrp: mrp ?? '',
    menufacturingCost: menufacturingCost ?? '',
    unitMeasurementId: unitMeasurementId ?? '',
    unitMeasurementName: unitMeasurementName ?? '',
    variantDescription: variantDescription ?? '',
    weightInKg: weightInKg ?? '',
    totalOffer: totalOffer ?? '',
    gstPercentage: gstPercentage ?? '',
    cgst: cgst ?? '',
    sgst: sgst ?? '',
    igst: igst ?? '',
    isOfferAvailable: isOfferAvailable ?? false,
  );
}
