import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/chat/data/models/request/group_chat_list_request_model.dart';
import 'package:myco_flutter/features/chat/domain/entities/group_chat_list_entities.dart';
import 'package:myco_flutter/features/chat/domain/repositories/chat_repository.dart';

class GetGroupChatList {
  final ChatRepository repository;
  GetGroupChatList(this.repository);

  Future<Either<Failure, GroupChatListEntity>> getGroupChatList(GroupChatListRequestModel request) async => await repository.getGroupChatList(request);
}