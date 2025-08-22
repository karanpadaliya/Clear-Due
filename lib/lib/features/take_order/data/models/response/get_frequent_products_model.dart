// To parse this JSON data, do
//
//     final getFrequentProductsModel = getFrequentProductsModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:myco_flutter/features/take_order/domain/entities/get_frequent_prodcts_entity.dart';

part 'get_frequent_products_model.g.dart';

GetFrequentProductsModel getFrequentProductsModelFromJson(String str) =>
    GetFrequentProductsModel.fromJson(json.decode(str));

String getFrequentProductsModelToJson(GetFrequentProductsModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class GetFrequentProductsModel {
  @JsonKey(name: 'products')
  List<Product>? products;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'status')
  String? status;

  GetFrequentProductsModel({this.products, this.message, this.status});

  factory GetFrequentProductsModel.fromJson(Map<String, dynamic> json) =>
      _$GetFrequentProductsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetFrequentProductsModelToJson(this);

  GetFrequentProductsEntity toEntity() => GetFrequentProductsEntity(
    products: products?.map((e) => e.toEntity()).toList() ?? [],
    message: message ?? '',
    status: status ?? '',
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
  @JsonKey(name: 'product_name')
  String? productName;
  @JsonKey(name: 'product_variant_name')
  String? productVariantName;
  @JsonKey(name: 'hsn_code')
  String? hsnCode;
  @JsonKey(name: 'frequent_count')
  String? frequentCount;
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
  @JsonKey(name: 'retailer_selling_price')
  String? retailerSellingPrice;
  @JsonKey(name: 'maximum_retail_price')
  String? maximumRetailPrice;
  @JsonKey(name: 'base_price')
  String? basePrice;
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
    this.productName,
    this.productVariantName,
    this.hsnCode,
    this.frequentCount,
    this.variantPhoto,
    this.variantPackingType,
    this.variantBulkType,
    this.variantBulkTypeView,
    this.sku,
    this.variantPerBoxPiece,
    this.retailerSellingPrice,
    this.maximumRetailPrice,
    this.basePrice,
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
    productName: productName ?? '',
    productVariantName: productVariantName ?? '',
    hsnCode: hsnCode ?? '',
    frequentCount: frequentCount ?? '',
    variantPhoto: variantPhoto ?? '',
    variantPackingType: variantPackingType ?? '',
    variantBulkType: variantBulkType ?? '',
    variantBulkTypeView: variantBulkTypeView ?? '',
    sku: sku ?? '',
    variantPerBoxPiece: variantPerBoxPiece ?? '',
    retailerSellingPrice: retailerSellingPrice ?? '',
    maximumRetailPrice: maximumRetailPrice ?? '',
    basePrice: basePrice ?? '',
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
