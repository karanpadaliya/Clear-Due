import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/core/network/api_client.dart';
import 'package:myco_flutter/core/utils/safe_api_call.dart';
import 'package:myco_flutter/features/my_visit/data/datasources/myvisit_remote_data_source.dart';
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

class MyVisitRemoteDataSourceImpl implements MyVisitRemoteDataSource {
  final ApiClient apiClient;
  final SafeApiCall safeApiCall;

  MyVisitRemoteDataSourceImpl({
    required this.apiClient,
    required this.safeApiCall,
  });

  @override
  Future<Either<Failure, AddNewVisitResponseModel>> addMyVisit(
    AddNewVisitRequestModel request,
  ) async => await safeApiCall.execute<AddNewVisitResponseModel>(() async {
    final Map<String, dynamic> requestMap = request.toJson();

    final response = await apiClient.postFormDynamic(
      'my_visits_controller.php',
      requestMap,
    );
    return AddNewVisitResponseModel.fromJson(jsonDecode(response));
  });

  @override
  Future<Either<Failure, MyVisitModel>> getVisitData(
    VisitRequestModel request,
  ) async => await safeApiCall.execute<MyVisitModel>(() async {
    final requestData = request.toJson();
    final response = await apiClient.postFormDynamic(
      'my_visits_controller.php',
      requestData,
    );
    return MyVisitModel.fromJson(jsonDecode(response));
  });

  @override
  Future<Either<Failure, BranchDepartmentModel>> getBranchDepartmentData(
    BranchDepartmentRequestModel request,
  ) async => await safeApiCall.execute<BranchDepartmentModel>(() async {
    final requestData = request.toJson();
    final response = await apiClient.postFormDynamic(
      'my_visits_controller.php',
      requestData,
    );
    return BranchDepartmentModel.fromJson(jsonDecode(response));
  });

  @override
  Future<Either<Failure, GetDepartmentModel>> getDepartmentData(
    GetDepartmentRequestModel request,
  ) async => await safeApiCall.execute<GetDepartmentModel>(() async {
    final requestData = request.toJson();
    final response = await apiClient.postFormDynamic(
      'view_member_list_controller.php',
      requestData,
    );
    return GetDepartmentModel.fromJson(jsonDecode(response));
  });

  @override
  Future<Either<Failure, GetBranchModel>> getBranchData(
    GetBranchRequestModel request,
  ) async => await safeApiCall.execute<GetBranchModel>(() async {
    final requestData = request.toJson();
    final response = await apiClient.postFormDynamic(
      'view_member_list_controller.php',
      requestData,
    );
    return GetBranchModel.fromJson(jsonDecode(response));
  });

  @override
  Future<Either<Failure, GetMembersByDepartmentResponseModel>>
  getMembersByDepartment(GetMembersByDepartmentRequestModel request) async =>
      await safeApiCall.execute<GetMembersByDepartmentResponseModel>(() async {
        final Map<String, dynamic> requestMap = request.toJson();
        final response = await apiClient.postFormDynamic(
          'view_member_list_controller.php',
          requestMap,
        );
        return GetMembersByDepartmentResponseModel.fromJson(
          jsonDecode(response),
        );
      });

  @override
  Future<Either<Failure, GetEmployeeDetail>> getEmployeeDetail(
    GetEmployeeRequestModel request,
  ) async => await safeApiCall.execute<GetEmployeeDetail>(() async {
    final requestMap = request.toJson();
    final response = await apiClient.postFormDynamic(
      'view_member_list_controller.php',
      requestMap,
    );
    return GetEmployeeDetail.fromJson(jsonDecode(response));
  });
}
