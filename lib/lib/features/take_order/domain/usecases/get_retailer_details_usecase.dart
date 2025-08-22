import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/take_order/domain/entities/retailer_details_entity.dart';
import 'package:myco_flutter/features/take_order/domain/repositories/take_order_repository.dart';

class GetRetailerDetailsUsecase {
  final TakeOrderRepository repository;

  GetRetailerDetailsUsecase({required this.repository});

  Future<Either<Failure, RetailerDetailsEntity>> call() async =>
      await repository.getRetailerDetails();
}
