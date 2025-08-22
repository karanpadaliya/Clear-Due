import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/core/utils/safe_api_call.dart';
import 'package:myco_flutter/features/admin_view/dashboard/data/data_source/admin_view_local_data_source.dart';
import 'package:myco_flutter/features/admin_view/dashboard/data/data_source/admin_view_remote_data_source.dart';
import 'package:myco_flutter/features/admin_view/dashboard/data/models/admin_view_request.dart';
import 'package:myco_flutter/features/admin_view/dashboard/domain/entities/admin_view_entity.dart';
import 'package:myco_flutter/features/admin_view/dashboard/domain/repositories/admin_view_repository.dart';

class AdminViewRepositoryImpl extends AdminViewRepository {
  final AdminViewRemoteDataSource remoteDataSource;
  final AdminViewLocalDataSource localDataSource;
  final SafeApiCall safeApiCall;

  AdminViewRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.safeApiCall,
  });

  @override
  Future<Either<Failure, AdminViewResponseEntity>> getAdminView(
    AdminViewRequest request,
  ) async {
    final result = await safeApiCall.execute(
      () => remoteDataSource.getAdminViewNew(request),
    );

    return result.fold(
      (failure) {
        if (failure is NetworkFailure) {
          return getCachedAdminView(request.companyId ?? '');
        }
        return Left(failure);
      },
      (remoteModel) async {
        if (request.shouldCache && request.companyId != null) {
          await localDataSource.cacheAdminView(request.companyId!, remoteModel);
        }
        return Right(remoteModel.toEntity());
      },
    );
  }

  @override
  Future<Either<Failure, AdminViewResponseEntity>> getCachedAdminView(
    String companyId,
  ) async {
    try {
      final localModel = await localDataSource.getLastAdminView(companyId);
      return Right(localModel.toEntity());
    } on CacheException {
      return const Left(CacheFailure('No cached data found.'));
    }
  }
}
