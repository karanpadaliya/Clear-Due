import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/core/utils/safe_api_call.dart';
import 'package:myco_flutter/features/work_from_home/data/data_source/admin_req_wfh/req_wfh_data_source.dart';
import 'package:myco_flutter/features/work_from_home/data/models/admin_req_wfh/req_wfh_model.dart';
import 'package:myco_flutter/features/work_from_home/data/models/admin_req_wfh/req_wfh_request_model.dart';
import 'package:myco_flutter/features/work_from_home/domain/entities/admin_req_wfh/req_wfh_entity.dart';
import 'package:myco_flutter/features/work_from_home/domain/repositories/admin_req_wfh/req_wfh_repository.dart';

class ReqWfhRepositoryImpl extends RequestWfhRepository {
  final AdminReqWfhDataSource remoteDataSource;
  final SafeApiCall safeApiCall;

  ReqWfhRepositoryImpl(this.safeApiCall, this.remoteDataSource);

  @override
  Future<Either<Failure, AdminWfhEntity>> getAllReqWfh(
    GetAdminWfhRequestModel request,
  ) async => safeApiCall.execute(() async {
    final responseModel = await remoteDataSource.getAllReqWfh(request);
    return responseModel.toEntity();
  });

  @override
  Future<Either<Failure, AdminWfhEntity>> approveAdminWfhRequest(
    AdminWfhApproveRequestModel request,
  ) async => safeApiCall.execute(() async {
    final responseModel = await remoteDataSource.approveWfhRequest(request);
    return responseModel.toEntity();
  });

  @override
  Future<Either<Failure, AdminWfhEntity>> rejectAdminWfhRequest(
    AdminWfhRejectRequestModel request,
  ) async => safeApiCall.execute(() async {
    final responseModel = await remoteDataSource.rejectWfhRequest(request);
    return responseModel.toEntity();
  });
}
