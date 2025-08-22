import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/core/utils/safe_api_call.dart';
import 'package:myco_flutter/features/my_visit/data/datasources/myvisit_remote_data_source.dart';
import 'package:myco_flutter/features/my_visit/data/models/request/add_new_visit_Request_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/request/branch_department_request_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/request/get_branch_response_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/request/get_department_response_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/request/get_employee_request_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/request/get_members_by_department_request_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/request/visit_request_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/response/branch_department_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/response/visit_model.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/branch_department_entity.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/get_branch_entity.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/get_department_entity.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/get_employee_detail_entity.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/get_members_by_department_entity.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/myvisit_entity.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/visit_entity.dart';
import 'package:myco_flutter/features/my_visit/domain/repositories/my_visit_repository.dart';

class MyVisitRepositoryImpl implements MyVisitRepository {
  final MyVisitRemoteDataSource remoteDataSource;
  final SafeApiCall safeApiCall;

  MyVisitRepositoryImpl(this.remoteDataSource, this.safeApiCall);

  @override
  Future<Either<Failure, AddNewVisitEntity>> addMyVisit(
    AddNewVisitRequestModel request,
  ) async {
    final result = await remoteDataSource.addMyVisit(request);

    return result.fold(
      Left.new,
      (AddNewVisitResponseModel) => Right(AddNewVisitResponseModel.toEntity()),
    );
  }

  @override
  Future<Either<Failure, MyVisitModelEntity>> getVisitData(
    VisitRequestModel request,
  ) async {
    final result = await remoteDataSource.getVisitData(request);

    return result.fold(
      Left.new,
      (MyVisitModel) => Right(MyVisitModel.toEntity()),
    );
  }

  @override
  Future<Either<Failure, BranchDepartmentEntity>> getBranchDepartmentData(
    BranchDepartmentRequestModel request,
  ) async {
    final result = await remoteDataSource.getBranchDepartmentData(request);

    return result.fold(
      Left.new,
      (BranchDepartmentModel) => Right(BranchDepartmentModel.toEntity()),
    );
  }

  @override
  Future<Either<Failure, GetDepartmentEntity>> getDepartmentData(
    GetDepartmentRequestModel request,
  ) async {
    final result = await remoteDataSource.getDepartmentData(request);

    return result.fold(
      Left.new,
      (GetDepartmentModel) => Right(GetDepartmentModel.toEntity()),
    );
  }

  @override
  Future<Either<Failure, GetBranchEntity>> getBranchData(
    GetBranchRequestModel request,
  ) async {
    final result = await remoteDataSource.getBranchData(request);

    return result.fold(
      Left.new,
      (GetBranchModel) => Right(GetBranchModel.toEntity()),
    );
  }

  @override
  Future<Either<Failure, GetMembersByDepartmentEntity>> getMembersByDepartment(
    GetMembersByDepartmentRequestModel request,
  ) async {
    final result = await remoteDataSource.getMembersByDepartment(request);

    return result.fold(
      Left.new,
      (model) => Right(
        GetMembersByDepartmentEntity(
          employees: model.employees?.map((e) => e.toEntity()).toList(),
          message: model.message,
          status: model.status,
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, GetEmployeeDetailEntity>> getEmployeeDetail(
    GetEmployeeRequestModel request,
  ) async {
    final result = await remoteDataSource.getEmployeeDetail(request);
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(
        GetEmployeeDetailEntity(
          employees: model.employees?.map((e) => e.toEntity()).toList(),
          message: model.message,
          status: model.status,
        ),
      ),
    );
  }
}
