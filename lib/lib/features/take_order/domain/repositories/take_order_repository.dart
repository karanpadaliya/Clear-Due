import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/take_order/domain/entities/get_frequent_prodcts_entity.dart';
import 'package:myco_flutter/features/take_order/domain/entities/get_product_category_entity.dart';
import 'package:myco_flutter/features/take_order/domain/entities/retailer_details_entity.dart';

abstract class TakeOrderRepository {
  Future<Either<Failure, RetailerDetailsEntity>> getRetailerDetails();
  Future<Either<Failure, GetProductCategoryEntity>> getProductCategory();
  Future<Either<Failure, GetFrequentProductsEntity>> getFrequentProducts();
}
