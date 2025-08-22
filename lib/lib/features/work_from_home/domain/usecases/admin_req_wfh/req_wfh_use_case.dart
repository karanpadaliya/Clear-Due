import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/work_from_home/data/models/admin_req_wfh/req_wfh_request_model.dart';
import 'package:myco_flutter/features/work_from_home/domain/entities/admin_req_wfh/req_wfh_entity.dart';
import 'package:myco_flutter/features/work_from_home/domain/repositories/admin_req_wfh/req_wfh_repository.dart';

class ReqWfhUseCases {
  final RequestWfhRepository repository;

  ReqWfhUseCases({required this.repository});

  Future<Either<Failure, AdminWfhEntity>> getAllReqWfhCall(
    GetAdminWfhRequestModel params,
  ) async => await repository.getAllReqWfh(params);

  Future<Either<Failure, AdminWfhEntity>> approveAdminWfhRequestCall(
    AdminWfhApproveRequestModel params,
  ) async => await repository.approveAdminWfhRequest(params);

  Future<Either<Failure, AdminWfhEntity>> rejectAdminWfhRequestCall(
    AdminWfhRejectRequestModel params,
  ) async => await repository.rejectAdminWfhRequest(params);
}
