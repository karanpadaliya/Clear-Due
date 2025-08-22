import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/core/models/domain/common_response_entity.dart';
import 'package:myco_flutter/features/lost_and_found/domain/entities/lost_and_found_entity.dart';

/// Repository for Lost & Found business logic
abstract class LostAndFoundRepository {
  /// Fetches Lost & Found items
  Future<Either<Failure, List<LostFoundEntity>>> getLostAndFoundItems(
    Map<String, String?> request,
  );

  Future<Either<Failure, CommonResponseModelEntity>> addLostAndFoundItems(
    Map<String, String?> request,
  );

  Future<Either<Failure, CommonResponseModelEntity>> editLostAndFoundItems(
    Map<String, String?> request,
  );

  Future<Either<Failure, CommonResponseModelEntity>> deleteLostAndFoundItems(
    Map<String, String?> request,
  );
}
