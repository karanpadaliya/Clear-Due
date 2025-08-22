import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/employees/domain/entites/branch_entity.dart';
import 'package:myco_flutter/features/employees/domain/entites/department_entity.dart';
import 'package:myco_flutter/features/employees/domain/entites/employee_entity.dart';

/// Abstract contract for employee-related data sources.
abstract class EmployeeRepository {
  /// Fetches all branches (blocks) available to the user.
  Future<Either<Failure, List<Branch>>> getBranches({
    required String userId,
    required String companyId,
  });

  /// Fetches all departments (floors) for the user.
  Future<Either<Failure, List<Department>>> getDepartments({
    required String userId,
    required String companyId,
  });

  /// Fetches employees filtered by user and optionally by block/floor.
  Future<Either<Failure, List<Employee>>> getEmployees({
    required String userId,
    required String companyId,
    String? branchId,
    String? departmentId,
  });
}
