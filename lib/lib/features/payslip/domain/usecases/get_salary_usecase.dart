import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/payslip/domain/entities/salary_entity.dart';
import 'package:myco_flutter/features/payslip/domain/repositories/payslip_repository.dart';

class GetSalaryUsecase {
  final PayslipRepository repository;

  GetSalaryUsecase({required this.repository});

  Future<Either<Failure, SalaryEntity>> call(String salaryYear) =>
      repository.getSalary(salaryYear);
}
