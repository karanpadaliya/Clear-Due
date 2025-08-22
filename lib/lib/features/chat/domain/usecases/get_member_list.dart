import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/chat/data/models/request/member_list_request_model.dart';
import 'package:myco_flutter/features/chat/domain/entities/member_list_entities.dart';
import 'package:myco_flutter/features/chat/domain/repositories/chat_repository.dart';

class GetMemberList {
  final ChatRepository repository;
  GetMemberList(this.repository);

  Future<Either<Failure, MemberListEntity>> getMemberList(MemberListRequestModel request) async => await repository.getMemberList(request);
}