import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/core/utils/safe_api_call.dart';
import 'package:myco_flutter/features/work_from_home/data/data_source/add_wfh/my_wfh_data_source.dart';
import 'package:myco_flutter/features/work_from_home/data/models/add_wfh/add_wfh_model.dart';
import 'package:myco_flutter/features/work_from_home/data/models/add_wfh/add_wfh_request_model.dart';
import 'package:myco_flutter/features/work_from_home/domain/entities/add_wfh/add_wfh_entity.dart';
import 'package:myco_flutter/features/work_from_home/domain/repositories/add_wfh/add_wfh_repository.dart';

class AddWfhRepositoryImpl extends AddWfhRepository {
  final AddWfhRemoteDataSource remoteDataSource;
  final SafeApiCall safeApiCall;

  AddWfhRepositoryImpl(this.safeApiCall, {required this.remoteDataSource});

  @override
  Future<Either<Failure, GetWfhListEntity>> getAddWfh(
    GetMyWfhRequestModel request,
  ) async {
    final result = await safeApiCall.execute(
      () => remoteDataSource.getAddWfh(request),
    );
    return result.map((model) => model.toEntity());
  }

  @override
  Future<Either<Failure, GetWfhListEntity>> deleteWfhRequest(
    DeleteWfhRequestModel request,
  ) async {
    final result = await safeApiCall.execute(
      () => remoteDataSource.deleteWfhRequest(request),
    );
    return result.map((model) => model.toEntity());
  }

  @override
  Future<Either<Failure, GetWfhListEntity>> addWfhRequest(
    AddWfhRequestModel request,
  ) async {
    final result = await safeApiCall.execute(
      () => remoteDataSource.addWfhRequest(request),
    );
    return result.map((model) => model.toEntity());
  }
}
