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
import 'package:myco_flutter/features/my_visit/domain/repositories/my_visit_repository.dart';

class GetVisitData {
  final MyVisitRepository repository;

  GetVisitData(this.repository);

  Future<Either<Failure, MyVisitModelEntity>> getVisitData(
    VisitRequestModel request,
  ) async => await repository.getVisitData(request);

  Future<Either<Failure, AddNewVisitEntity>> addMyVisit(
    AddNewVisitRequestModel request,
  ) async => await repository.addMyVisit(request);

  Future<Either<Failure, BranchDepartmentEntity>> getBranchDepartmentData(
    BranchDepartmentRequestModel request,
  ) async => await repository.getBranchDepartmentData(request);

  Future<Either<Failure, GetDepartmentEntity>> getDepartmentData(
    GetDepartmentRequestModel request,
  ) async => await repository.getDepartmentData(request);

  Future<Either<Failure, GetBranchEntity>> getBranchData(
    GetBranchRequestModel request,
  ) async => await repository.getBranchData(request);

  Future<Either<Failure, GetMembersByDepartmentEntity>> getMembers(
    GetMembersByDepartmentRequestModel request,
  ) async => await repository.getMembersByDepartment(request);

  Future<Either<Failure, GetEmployeeDetailEntity>> getEmployeeDetail(
    GetEmployeeRequestModel request,
  ) async => await repository.getEmployeeDetail(request);
}
