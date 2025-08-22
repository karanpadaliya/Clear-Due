import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/core/models/domain/common_response_entity.dart';
import 'package:myco_flutter/features/lost_and_found/domain/repositories/lost_and_found_repository.dart';

class DeleteLostAndFoundItemUseCase {
  final LostAndFoundRepository repository;

  DeleteLostAndFoundItemUseCase(this.repository);

  Future<Either<Failure, CommonResponseModelEntity>> call(
    Map<String, String?> request,
  ) async => repository.deleteLostAndFoundItems(request);
}
