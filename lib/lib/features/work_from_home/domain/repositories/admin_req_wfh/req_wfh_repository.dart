import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/work_from_home/data/models/admin_req_wfh/req_wfh_request_model.dart';
import 'package:myco_flutter/features/work_from_home/domain/entities/admin_req_wfh/req_wfh_entity.dart';

abstract class RequestWfhRepository {
  Future<Either<Failure, AdminWfhEntity>> getAllReqWfh(
    GetAdminWfhRequestModel request,
  );

  Future<Either<Failure, AdminWfhEntity>> approveAdminWfhRequest(
    AdminWfhApproveRequestModel request,
  );

  Future<Either<Failure, AdminWfhEntity>> rejectAdminWfhRequest(
    AdminWfhRejectRequestModel request,
  );
}
