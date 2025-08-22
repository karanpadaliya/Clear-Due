class GetProductCategoryEntity {
  final List<ProductCategoryEntity>? productCategories;
  final List<dynamic>? productSubCategories;
  final String? message;
  final String? status;

  GetProductCategoryEntity({
    this.productCategories,
    this.productSubCategories,
    this.message,
    this.status,
  });
}

class ProductCategoryEntity {
  final String productCategoryId;
  final String categoryName;
  final List<ProductEntity> products;
  final List<dynamic> subcategory;

  ProductCategoryEntity({
    required this.productCategoryId,
    required this.categoryName,
    required this.products,
    required this.subcategory,
  });
}

class ProductEntity {
  final String? productId;
  final String? productVariantId;
  final String? productCategoryId;
  final String? productSubCategoryId;
  final String? productName;
  final String? productVariantName;
  final String? hsnCode;
  final String? variantPhoto;
  final String? variantPackingType;
  final String? variantBulkType;
  final String? variantBulkTypeView;
  final String? sku;
  final String? variantPerBoxPiece;
  final String? basePrice;
  final String? retailerSellingPrice;
  final String? maximumRetailPrice;
  final String? mrp;
  final String? menufacturingCost;
  final String? unitMeasurementId;
  final String? unitMeasurementName;
  final String? variantDescription;
  final String? weightInKg;
  final String? totalOffer;
  final String? gstPercentage;
  final String? cgst;
  final String? sgst;
  final String? igst;
  final bool? isOfferAvailable;

  ProductEntity({
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
}
