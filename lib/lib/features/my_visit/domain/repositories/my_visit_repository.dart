import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/my_visit/data/models/request/add_new_visit_Request_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/request/branch_department_request_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/request/get_branch_response_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/request/get_department_response_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/request/get_employee_request_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/request/get_members_by_department_request_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/request/visit_request_model.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/branch_department_entity.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/get_branch_entity.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/get_department_entity.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/get_employee_detail_entity.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/get_members_by_department_entity.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/myvisit_entity.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/visit_entity.dart';

abstract class MyVisitRepository {
  Future<Either<Failure, AddNewVisitEntity>> addMyVisit(
    AddNewVisitRequestModel request,
  );

  Future<Either<Failure, MyVisitModelEntity>> getVisitData(
    VisitRequestModel request,
  );

  Future<Either<Failure, BranchDepartmentEntity>> getBranchDepartmentData(
    BranchDepartmentRequestModel request,
  );

  Future<Either<Failure, GetDepartmentEntity>> getDepartmentData(
    GetDepartmentRequestModel request,
  );

  Future<Either<Failure, GetBranchEntity>> getBranchData(
    GetBranchRequestModel request,
  );

  Future<Either<Failure, GetMembersByDepartmentEntity>> getMembersByDepartment(
    GetMembersByDepartmentRequestModel request,
  );

  Future<Either<Failure, GetEmployeeDetailEntity>> getEmployeeDetail(
    GetEmployeeRequestModel request,
  );
}
