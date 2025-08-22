import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/company_info/domain/entities/company_info_entity.dart';

abstract class CompanyInfoRepository {
  Future<Either<Failure, CompanyInfoEntity>> getCompanyInfo();
}
