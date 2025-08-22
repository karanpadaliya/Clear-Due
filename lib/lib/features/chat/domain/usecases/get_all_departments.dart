import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/chat/data/models/request/all_department_request_model.dart';
import 'package:myco_flutter/features/chat/domain/entities/all_departments_entities.dart';
import 'package:myco_flutter/features/chat/domain/repositories/chat_repository.dart';

class GetAllDepartments {
  final ChatRepository repository;

  GetAllDepartments(this.repository);

  Future<Either<Failure, AllDepartmentsEntity>> getAllDepartments(AllDepartmentRequestModel request) async => await repository.getAllDepartments(request);
}