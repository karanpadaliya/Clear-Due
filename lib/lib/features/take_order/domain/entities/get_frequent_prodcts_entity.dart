import 'package:equatable/equatable.dart';

class GetFrequentProductsEntity extends Equatable {
  final List<ProductEntity>? products;
  final String? message;
  final String? status;

  const GetFrequentProductsEntity({this.products, this.message, this.status});

  @override
  List<Object?> get props => [products, message, status];
}

class ProductEntity extends Equatable {
  final String? productId;
  final String? productVariantId;
  final String? productCategoryId;
  final String? productName;
  final String? productVariantName;
  final String? hsnCode;
  final String? frequentCount;
  final String? variantPhoto;
  final String? variantPackingType;
  final String? variantBulkType;
  final String? variantBulkTypeView;
  final String? sku;
  final String? variantPerBoxPiece;
  final String? retailerSellingPrice;
  final String? maximumRetailPrice;
  final String? basePrice;
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

  const ProductEntity({
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

  @override
  List<Object?> get props => [
    productId,
    productVariantId,
    productCategoryId,
    productName,
    productVariantName,
    hsnCode,
    frequentCount,
    variantPhoto,
    variantPackingType,
    variantBulkType,
    variantBulkTypeView,
    sku,
    variantPerBoxPiece,
    retailerSellingPrice,
    maximumRetailPrice,
    basePrice,
    mrp,
    menufacturingCost,
    unitMeasurementId,
    unitMeasurementName,
    variantDescription,
    weightInKg,
    totalOffer,
    gstPercentage,
    cgst,
    sgst,
    igst,
    isOfferAvailable,
  ];
}
