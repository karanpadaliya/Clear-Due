import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/employees/domain/entites/branch_entity.dart';
import 'package:myco_flutter/features/employees/domain/entites/department_entity.dart';
import 'package:myco_flutter/features/employees/domain/entites/employee_entity.dart';
import 'package:myco_flutter/features/employees/domain/repositories/employee_repository.dart';

class GetUserDataUseCase {
  final EmployeeRepository repo;

  GetUserDataUseCase(this.repo);

  Future<
    Either<Failure, Tuple3<List<Branch>, List<Department>, List<Employee>>>
  >
  call({required String userId, required String companyId}) async {
    final branchesResult = await repo.getBranches(
      userId: userId,
      companyId: companyId,
    );

    final departmentsResult = await repo.getDepartments(
      userId: userId,
      companyId: companyId,
    );

    final employeesResult = await repo.getEmployees(
      userId: userId,
      companyId: companyId,
    );

    if (branchesResult.isLeft()) {
      return Left(
        branchesResult.fold((l) => l, (r) => throw UnimplementedError()),
      );
    }
    if (departmentsResult.isLeft()) {
      return Left(
        departmentsResult.fold((l) => l, (r) => throw UnimplementedError()),
      );
    }
    if (employeesResult.isLeft()) {
      return Left(
        employeesResult.fold((l) => l, (r) => throw UnimplementedError()),
      );
    }

    // If all succeed, extract the Right values
    final branches = branchesResult.getOrElse(() => []);
    final departments = departmentsResult.getOrElse(() => []);
    final employees = employeesResult.getOrElse(() => []);

    return Right(Tuple3(branches, departments, employees));
  }
}
