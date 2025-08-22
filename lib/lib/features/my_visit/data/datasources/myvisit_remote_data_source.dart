import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/my_visit/data/models/add_new_visit.dart';
import 'package:myco_flutter/features/my_visit/data/models/request/add_new_visit_Request_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/request/branch_department_request_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/request/get_branch_response_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/request/get_department_response_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/request/get_employee_request_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/request/get_members_by_department_request_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/request/visit_request_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/response/branch_department_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/response/get_branch_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/response/get_department_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/response/get_employee_detail.dart';
import 'package:myco_flutter/features/my_visit/data/models/response/get_members_by_department_response_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/response/visit_model.dart';

abstract class MyVisitRemoteDataSource {
  Future<Either<Failure, MyVisitModel>> getVisitData(VisitRequestModel request);

  Future<Either<Failure, AddNewVisitResponseModel>> addMyVisit(
    AddNewVisitRequestModel request,
  );

  Future<Either<Failure, BranchDepartmentModel>> getBranchDepartmentData(
    BranchDepartmentRequestModel request,
  );

  Future<Either<Failure, GetDepartmentModel>> getDepartmentData(
    GetDepartmentRequestModel request,
  );

  Future<Either<Failure, GetBranchModel>> getBranchData(
    GetBranchRequestModel request,
  );

  Future<Either<Failure, GetMembersByDepartmentResponseModel>>
  getMembersByDepartment(GetMembersByDepartmentRequestModel request);

  Future<Either<Failure, GetEmployeeDetail>> getEmployeeDetail(
    GetEmployeeRequestModel request,
  );
}
