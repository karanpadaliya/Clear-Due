import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/payslip/domain/entities/get_other_earnings_entity.dart';
import 'package:myco_flutter/features/payslip/domain/repositories/payslip_repository.dart';

class GetOtherEarningsUsecase {
  final PayslipRepository repository;

  GetOtherEarningsUsecase({required this.repository});

  Future<Either<Failure, GetOtherEarningsEntity>> call(
    String leavePayoutYear,
  ) => repository.getOtherEarnings(leavePayoutYear);
}
