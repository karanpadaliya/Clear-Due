import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/core/network/api_client.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/core/utils/safe_api_call.dart';
import 'package:myco_flutter/features/chat/data/datasources/chat_datasources.dart';
import 'package:myco_flutter/features/chat/data/models/request/all_department_request_model.dart';
import 'package:myco_flutter/features/chat/data/models/request/all_employee_request_model.dart';
import 'package:myco_flutter/features/chat/data/models/request/group_chat_list_request_model.dart';
import 'package:myco_flutter/features/chat/data/models/request/member_chat_list_request_model.dart';
import 'package:myco_flutter/features/chat/data/models/request/member_list_request_model.dart';
import 'package:myco_flutter/features/chat/data/models/response/all_departments_model.dart';
import 'package:myco_flutter/features/chat/data/models/response/all_employee_model.dart';
import 'package:myco_flutter/features/chat/data/models/response/group_chat_list_model.dart';
import 'package:myco_flutter/features/chat/data/models/response/member_chat_list_model.dart';
import 'package:myco_flutter/features/chat/data/models/response/member_list_model.dart';

class ChatDatasourcesImpl implements ChatDatasources {
  final ApiClient apiClient;
  final SafeApiCall safeApiCall;
  ChatDatasourcesImpl({required this.apiClient, required this.safeApiCall});
  @override
  // Future<MemberListModel> getMemberList() async {
  //   final body = {
  //     'getMemberListNew': 'getMemberListNew',
  //     'society_id': '1',
  //     'unit_id': '1',
  //     'group_id': '',
  //     'floor_id': '0',
  //     'floor_id_access': '1',
  //     'block_id': '1',
  //     'user_type': '',
  //     'user_id': await PreferenceManager().getUserId(),
  //     'language_id': '1',
  //   };
  //   log(body.toString(), name: "body");
  //   final response = await apiClient.postFormDynamic(
  //     'chat_list_controller.php',
  //     body,
  //   );
  //   return MemberListModel.fromJson(json.decode(response));
  // }
  @override
  // Future<GroupChatListModel> getGroupChatList() async {
  //   final body = {
  //     'getGroupListRecentNew': 'getGroupListRecentNew',
  //     'society_id': '1',
  //     'user_id': '1776',
  //     'unit_id': '2',
  //     'block_id': '30',
  //     'floor_id': '151',
  //     'zone_id': '0',
  //     'level_id': '3',
  //     'user_token':
  //         'f2uTcR19SjSIuBygfK4TOP%3AAPA91bGbY9nHxA0cDE5lnTL4teMy_Nn4p9tH-Pcfnj1ySZM733nvIleUb5xZ8NUrujp8mS2rll8WcYzE65ms3b46kH9e9T9WAhay1Ta-ofYvHzzBj4PsALbN1ug60aBI_3bUlq8JpL3z',
  //     'device': 'android',
  //     'language_id': '1',
  //   };
  //   log(body.toString(), name: "body");
  //   final response = await apiClient.postFormDynamic(
  //     'chat_list_controller.php',
  //     body,
  //   );
  //   return GroupChatListModel.fromJson(json.decode(response));
  // }
  @override
  // Future<MemberChatListModel> getMemberChatList() async {
  //   final body = {
  //     'getRecentChatMember': 'getRecentChatMember',
  //     'society_id': '1',
  //     'unit_id': '1',
  //     'group_id': '',
  //     'floor_id': '0',
  //     'floor_id_access': '1',
  //     'block_id': '1',
  //     'user_type': '',
  //     'user_id': '1776',
  //     'language_id': '1',
  //   };
  //   log(body.toString(), name: "body");
  //   final response = await apiClient.postFormDynamic(
  //     'chat_list_controller.php',
  //     body,
  //   );
  //   return MemberChatListModel.fromJson(json.decode(response));
  // }
  // Future<AllDepartmentsModel> getAllDepartments() async {
  //   final body = {
  //     'getAllDepartments': 'getAllDepartments',
  //     'society_id': '1',
  //     'user_id': '1776',
  //     'language_id': '1',
  //   };
  //   log(body.toString(), name: "body");
  //   final response = await apiClient.postFormDynamic(
  //     'department_controller.php',
  //     body,
  //   );
  //   return AllDepartmentsModel.fromJson(json.decode(response));
  // }
  @override
  Future<Either<Failure, AllDepartmentsModel>> getAllDepartments(
    AllDepartmentRequestModel getAllDepartmentModel,
  ) async => await safeApiCall.execute<AllDepartmentsModel>(() async {
    final response = await apiClient.postFormDynamic(
      'department_controller.php',
      getAllDepartmentModel.toJson(),
    );
    return AllDepartmentsModel.fromJson(json.decode(response));
  });

  @override
  Future<Either<Failure, MemberListModel>> getMemberList(
    MemberListRequestModel getMemberListModelRequest,
  ) async => await safeApiCall.execute<MemberListModel>(() async {
    final response = await apiClient.postFormDynamic(
      'chat_list_controller.php',
      getMemberListModelRequest.toJson(),
    );
    return MemberListModel.fromJson(json.decode(response));
  });

  @override
  Future<Either<Failure, MemberChatListModel>> getMemberChatList(
    MemberChatListRequestModel getMemberChatListModelRequest,
  ) async => await safeApiCall.execute<MemberChatListModel>(() async {
    final response = await apiClient.postFormDynamic(
      'chat_list_controller.php',
      getMemberChatListModelRequest.toJson(),
    );
    return MemberChatListModel.fromJson(json.decode(response));
  });

  @override
  Future<Either<Failure, GroupChatListModel>> getGroupChatList(
    GroupChatListRequestModel getGroupChatListModelRequest,
  ) async => await safeApiCall.execute<GroupChatListModel>(() async {
    final response = await apiClient.postFormDynamic(
      'chat_list_controller.php',
      getGroupChatListModelRequest.toJson(),
    );
    return GroupChatListModel.fromJson(json.decode(response));
  });

  @override
  Future<Either<Failure, AllEmployeeModel>> getAllEmployee(
    AllEmployeeRequestModel getAllEmployeeModel,
  ) async => await safeApiCall.execute<AllEmployeeModel>(() async {
    final response = await apiClient.postFormDynamic(
      'employee_controller.php',
      getAllEmployeeModel.toJson(),
    );

    try {
      final res = AllEmployeeModel.fromJson(json.decode(response));

      return res;
    } catch (e) {
      log(e.toString(), name: 'error in datasource impl');
      return AllEmployeeModel.fromJson(json.decode(response));
    }
  });
}
