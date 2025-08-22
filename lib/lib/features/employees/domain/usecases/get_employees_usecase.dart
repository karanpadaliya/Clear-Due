import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/employees/domain/entites/employee_entity.dart';
import 'package:myco_flutter/features/employees/domain/repositories/employee_repository.dart';

class GetEmployeesUseCase {
  final EmployeeRepository repository;

  GetEmployeesUseCase({required this.repository});

  Future<Either<Failure, List<Employee>>> call(
    GetEmployeesParams params,
  ) async => await repository.getEmployees(
    userId: params.userId,
    companyId: params.companyId,
    branchId: params.branchId,
    departmentId: params.departmentId,
  );
}

class GetEmployeesParams extends Equatable {
  final String userId;
  final String companyId;
  final String? branchId;
  final String? departmentId;

  const GetEmployeesParams({
    required this.userId,
    required this.companyId,
    this.branchId,
    this.departmentId,
  });

  @override
  List<Object?> get props => [userId, companyId, branchId, departmentId];
}
