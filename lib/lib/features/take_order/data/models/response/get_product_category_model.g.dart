// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_product_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProductCategoryModel _$GetProductCategoryModelFromJson(
  Map<String, dynamic> json,
) => GetProductCategoryModel(
  productCategories:
      (json['product_categories'] as List<dynamic>?)
          ?.map((e) => ProductCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
  productSubCategories: json['product_sub_categories'] as List<dynamic>?,
  message: json['message'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$GetProductCategoryModelToJson(
  GetProductCategoryModel instance,
) => <String, dynamic>{
  'product_categories': instance.productCategories,
  'product_sub_categories': instance.productSubCategories,
  'message': instance.message,
  'status': instance.status,
};

ProductCategory _$ProductCategoryFromJson(Map<String, dynamic> json) =>
    ProductCategory(
      productCategoryId: json['product_category_id'] as String?,
      categoryName: json['category_name'] as String?,
      products:
          (json['products'] as List<dynamic>?)
              ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList(),
      subcategory: json['subcategory'] as List<dynamic>?,
    );

Map<String, dynamic> _$ProductCategoryToJson(ProductCategory instance) =>
    <String, dynamic>{
      'product_category_id': instance.productCategoryId,
      'category_name': instance.categoryName,
      'products': instance.products,
      'subcategory': instance.subcategory,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  productId: json['product_id'] as String?,
  productVariantId: json['product_variant_id'] as String?,
  productCategoryId: json['product_category_id'] as String?,
  productSubCategoryId: json['product_sub_category_id'] as String?,
  productName: json['product_name'] as String?,
  productVariantName: json['product_variant_name'] as String?,
  hsnCode: json['hsn_code'] as String?,
  variantPhoto: json['variant_photo'] as String?,
  variantPackingType: json['variant_packing_type'] as String?,
  variantBulkType: json['variant_bulk_type'] as String?,
  variantBulkTypeView: json['variant_bulk_type_view'] as String?,
  sku: json['sku'] as String?,
  variantPerBoxPiece: json['variant_per_box_piece'] as String?,
  basePrice: json['base_price'] as String?,
  retailerSellingPrice: json['retailer_selling_price'] as String?,
  maximumRetailPrice: json['maximum_retail_price'] as String?,
  mrp: json['mrp'] as String?,
  menufacturingCost: json['menufacturing_cost'] as String?,
  unitMeasurementId: json['unit_measurement_id'] as String?,
  unitMeasurementName: json['unit_measurement_name'] as String?,
  variantDescription: json['variant_description'] as String?,
  weightInKg: json['weight_in_kg'] as String?,
  totalOffer: json['total_offer'] as String?,
  gstPercentage: json['gst_percentage'] as String?,
  cgst: json['cgst'] as String?,
  sgst: json['sgst'] as String?,
  igst: json['igst'] as String?,
  isOfferAvailable: json['is_offer_available'] as bool?,
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'product_id': instance.productId,
  'product_variant_id': instance.productVariantId,
  'product_category_id': instance.productCategoryId,
  'product_sub_category_id': instance.productSubCategoryId,
  'product_name': instance.productName,
  'product_variant_name': instance.productVariantName,
  'hsn_code': instance.hsnCode,
  'variant_photo': instance.variantPhoto,
  'variant_packing_type': instance.variantPackingType,
  'variant_bulk_type': instance.variantBulkType,
  'variant_bulk_type_view': instance.variantBulkTypeView,
  'sku': instance.sku,
  'variant_per_box_piece': instance.variantPerBoxPiece,
  'base_price': instance.basePrice,
  'retailer_selling_price': instance.retailerSellingPrice,
  'maximum_retail_price': instance.maximumRetailPrice,
  'mrp': instance.mrp,
  'menufacturing_cost': instance.menufacturingCost,
  'unit_measurement_id': instance.unitMeasurementId,
  'unit_measurement_name': instance.unitMeasurementName,
  'variant_description': instance.variantDescription,
  'weight_in_kg': instance.weightInKg,
  'total_offer': instance.totalOffer,
  'gst_percentage': instance.gstPercentage,
  'cgst': instance.cgst,
  'sgst': instance.sgst,
  'igst': instance.igst,
  'is_offer_available': instance.isOfferAvailable,
};
