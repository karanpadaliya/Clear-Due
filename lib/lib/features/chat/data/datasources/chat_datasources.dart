import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
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

abstract class ChatDatasources {
  // Future<MemberListModel> getMemberList();
  // Future<GroupChatListModel> getGroupChatList();
  // Future<MemberChatListModel> getMemberChatList();
  Future<Either<Failure, AllDepartmentsModel>> getAllDepartments(AllDepartmentRequestModel getAllDepartmentModel);
  Future<Either<Failure, MemberListModel>> getMemberList(MemberListRequestModel getMemberListModelRequest);
  Future<Either<Failure, MemberChatListModel>> getMemberChatList(MemberChatListRequestModel getMemberChatListModelRequest);
  Future<Either<Failure, GroupChatListModel>> getGroupChatList(GroupChatListRequestModel getGroupChatListModelRequest);
  Future<Either<Failure, AllEmployeeModel>> getAllEmployee(AllEmployeeRequestModel getAllEmployeeModelRequest);

}
