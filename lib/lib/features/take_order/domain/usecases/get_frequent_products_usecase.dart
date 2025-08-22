import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/take_order/domain/entities/get_frequent_prodcts_entity.dart';
import 'package:myco_flutter/features/take_order/domain/entities/get_product_category_entity.dart';
import 'package:myco_flutter/features/take_order/domain/repositories/take_order_repository.dart';

class GetFrequentProductsUsecase {
  TakeOrderRepository repository;

  GetFrequentProductsUsecase(this.repository);

  Future<Either<Failure, GetFrequentProductsEntity>> call() async =>
      await repository.getFrequentProducts();
}
