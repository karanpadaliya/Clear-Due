import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/chat/data/models/request/all_department_request_model.dart';
import 'package:myco_flutter/features/chat/data/models/request/all_employee_request_model.dart';
import 'package:myco_flutter/features/chat/data/models/request/group_chat_list_request_model.dart';
import 'package:myco_flutter/features/chat/data/models/request/member_chat_list_request_model.dart';
import 'package:myco_flutter/features/chat/data/models/request/member_list_request_model.dart';
import 'package:myco_flutter/features/chat/data/models/response/group_chat_list_model.dart';
import 'package:myco_flutter/features/chat/domain/entities/all_departments_entities.dart';
import 'package:myco_flutter/features/chat/domain/entities/all_employee_entity.dart';
import 'package:myco_flutter/features/chat/domain/entities/group_chat_list_entities.dart';
import 'package:myco_flutter/features/chat/domain/entities/member_chat_list_entities.dart';
import 'package:myco_flutter/features/chat/domain/entities/member_list_entities.dart';

abstract class ChatRepository {
  // Future<Either<Failure, MemberListEntity>> getMemberList();
  // Future<Either<Failure, GroupChatListEntity>> getGroupChatList();
  // Future<Either<Failure, MemberChatListEntity>> getMemberChatList();
  Future<Either<Failure, AllDepartmentsEntity>> getAllDepartments(AllDepartmentRequestModel request);
  Future<Either<Failure, MemberListEntity>> getMemberList(MemberListRequestModel request);
  Future<Either<Failure, MemberChatListEntity>> getMemberChatList(MemberChatListRequestModel request);
  Future<Either<Failure, GroupChatListEntity>> getGroupChatList(GroupChatListRequestModel request);
  Future<Either<Failure, AllEmployeeEntity>> getAllEmployee(AllEmployeeRequestModel request);
}
