import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/take_order/domain/entities/get_product_category_entity.dart';
import 'package:myco_flutter/features/take_order/domain/repositories/take_order_repository.dart';

class GetProductCategoryUsecase {
  TakeOrderRepository repository;

  GetProductCategoryUsecase(this.repository);

  Future<Either<Failure, GetProductCategoryEntity>> call() async =>
      await repository.getProductCategory();
}
