import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/core/models/domain/common_response_entity.dart';
import 'package:myco_flutter/core/utils/safe_api_call.dart';
import 'package:myco_flutter/features/lost_and_found/data/data_sources/lost_and_found_data_source.dart';
import 'package:myco_flutter/features/lost_and_found/domain/entities/lost_and_found_entity.dart';
import 'package:myco_flutter/features/lost_and_found/domain/repositories/lost_and_found_repository.dart';

class LostAndFoundRepositoryImpl implements LostAndFoundRepository {
  final LostAndFoundDataSource dataSource;
  final SafeApiCall safeApiCall;

  LostAndFoundRepositoryImpl(this.dataSource, this.safeApiCall);

  @override
  Future<Either<Failure, List<LostFoundEntity>>> getLostAndFoundItems(
    Map<String, String?> request,
  ) async => safeApiCall.execute(() async {
    final responseModel = await dataSource.getLostAndFoundItems(request);
    final lostAndFoundEntity = responseModel.toEntity();
    return lostAndFoundEntity.lostFoundItems ?? [];
  });

  @override
  Future<Either<Failure, CommonResponseModelEntity>> addLostAndFoundItems(
    Map<String, String?> request,
  ) async => safeApiCall.execute(() async {
    final responseModel = await dataSource.addLostAndFoundItems(request);
    final lostAndFoundEntity = responseModel.toEntity();
    return lostAndFoundEntity;
  });

  @override
  Future<Either<Failure, CommonResponseModelEntity>> editLostAndFoundItems(
    Map<String, String?> request,
  ) async => safeApiCall.execute(() async {
    final responseModel = await dataSource.editLostAndFoundItems(request);
    final lostAndFoundEntity = responseModel.toEntity();
    return lostAndFoundEntity;
  });

  @override
  Future<Either<Failure, CommonResponseModelEntity>> deleteLostAndFoundItems(
    Map<String, String?> request,
  ) async => safeApiCall.execute(() async {
    final responseModel = await dataSource.deleteLostAndFoundItems(request);
    final lostAndFoundEntity = responseModel.toEntity();
    return lostAndFoundEntity;
  });
}
