import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/chat/data/models/request/all_employee_request_model.dart';
import 'package:myco_flutter/features/chat/domain/entities/all_employee_entity.dart';
import 'package:myco_flutter/features/chat/domain/repositories/chat_repository.dart';

class GetAllEmployee {
  final ChatRepository chatRepository;
  GetAllEmployee(this.chatRepository);

  Future<Either<Failure, AllEmployeeEntity>> getAllEmployee(AllEmployeeRequestModel request) async => await chatRepository.getAllEmployee(request);
}