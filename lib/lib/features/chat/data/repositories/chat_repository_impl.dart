// ignore_for_file: avoid_types_as_parameter_names, unnecessary_lambdas

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/core/utils/safe_api_call.dart';
import 'package:myco_flutter/features/chat/data/datasources/chat_datasources.dart';
import 'package:myco_flutter/features/chat/data/models/request/all_department_request_model.dart';
import 'package:myco_flutter/features/chat/data/models/request/all_employee_request_model.dart';
import 'package:myco_flutter/features/chat/data/models/request/group_chat_list_request_model.dart';
import 'package:myco_flutter/features/chat/data/models/request/member_chat_list_request_model.dart';
import 'package:myco_flutter/features/chat/data/models/request/member_list_request_model.dart';
import 'package:myco_flutter/features/chat/domain/entities/all_departments_entities.dart';
import 'package:myco_flutter/features/chat/domain/entities/all_employee_entity.dart';
import 'package:myco_flutter/features/chat/domain/entities/group_chat_list_entities.dart';
import 'package:myco_flutter/features/chat/domain/entities/member_chat_list_entities.dart';
import 'package:myco_flutter/features/chat/domain/entities/member_list_entities.dart';
import 'package:myco_flutter/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository{
  final SafeApiCall safeApiCall;
  final ChatDatasources chatDatasources;

  ChatRepositoryImpl(this.safeApiCall, this.chatDatasources);
  @override
  
  
  @override
  Future<Either<Failure, GroupChatListEntity>> getGroupChatList(GroupChatListRequestModel request) async{
    final result = await chatDatasources.getGroupChatList(request);

    return result.fold((failure) => Left(failure),
     (GroupChatListModel) => Right(GroupChatListModel.toEntity()));
  }
  @override
  Future<Either<Failure, MemberChatListEntity>> getMemberChatList( MemberChatListRequestModel request) async{
    final result = await chatDatasources.getMemberChatList(request);

    return result.fold((failure) => Left(failure),
     (MemberChatListModel) => Right(MemberChatListModel.toEntity()));
  }

  @override
  Future<Either<Failure, AllDepartmentsEntity>> getAllDepartments(
      AllDepartmentRequestModel request
  ) async {
    final result = await chatDatasources.getAllDepartments(request);
    return result.fold((failure) => Left(failure),
     (AllDepartmentsModel) => Right(AllDepartmentsModel.toEntity()));
  } 

  @override
  Future<Either<Failure, MemberListEntity>> getMemberList(MemberListRequestModel request) async{
    final result = await chatDatasources.getMemberList(request);
    return result.fold((failure) => Left(failure),
     (MemberListModel) => Right(MemberListModel.toEntity()));
     
  }

  @override
  Future<Either<Failure, AllEmployeeEntity>> getAllEmployee(AllEmployeeRequestModel request) async{

    final result = await chatDatasources.getAllEmployee(request);

    return result.fold((failure) => Left(failure),
     (AllEmployeeModel) => Right(AllEmployeeModel.toEntity()));
  }
}