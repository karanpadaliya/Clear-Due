import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/work_from_home/data/models/add_wfh/add_wfh_request_model.dart';
import 'package:myco_flutter/features/work_from_home/domain/entities/add_wfh/add_wfh_entity.dart';

abstract class AddWfhRepository {
  Future<Either<Failure, GetWfhListEntity>> getAddWfh(
    GetMyWfhRequestModel request,
  );

  Future<Either<Failure, GetWfhListEntity>> addWfhRequest(
    AddWfhRequestModel request,
  );

  Future<Either<Failure, GetWfhListEntity>> deleteWfhRequest(
    DeleteWfhRequestModel request,
  );
}
