import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/core/utils/safe_api_call.dart';
import 'package:myco_flutter/features/take_order/data/datasources/take_order_remote_datasource.dart';
import 'package:myco_flutter/features/take_order/domain/entities/get_frequent_prodcts_entity.dart';
import 'package:myco_flutter/features/take_order/domain/entities/get_product_category_entity.dart';
import 'package:myco_flutter/features/take_order/domain/entities/retailer_details_entity.dart';
import 'package:myco_flutter/features/take_order/domain/repositories/take_order_repository.dart';

class TakeOrderRepositoryImpl extends TakeOrderRepository {
  final TakeOrderRemoteDatasource remoteDatasource;
  final SafeApiCall safeApiCall;

  TakeOrderRepositoryImpl({
    required this.remoteDatasource,
    required this.safeApiCall,
  });

  @override
  Future<Either<Failure, RetailerDetailsEntity>> getRetailerDetails() async {
    final result = await safeApiCall.execute(
      remoteDatasource.getRetailerDetails,
    );

    return result.map((responseModel) => responseModel.toEntity());
  }

  @override
  Future<Either<Failure, GetProductCategoryEntity>> getProductCategory() async {
    final result = await safeApiCall.execute(
      remoteDatasource.getProductCategory,
    );
    return result.map((responseModel) => responseModel.toEntity());
  }

  @override
  Future<Either<Failure, GetFrequentProductsEntity>> getFrequentProducts() async {
    final result = await safeApiCall.execute(
      remoteDatasource.getFrequentProducts,
    );

    return result.map((responseModel) => responseModel.toEntity());
  }
}
