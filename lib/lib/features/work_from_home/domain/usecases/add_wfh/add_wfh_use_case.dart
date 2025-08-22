import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/work_from_home/data/models/add_wfh/add_wfh_request_model.dart';
import 'package:myco_flutter/features/work_from_home/domain/entities/add_wfh/add_wfh_entity.dart';
import 'package:myco_flutter/features/work_from_home/domain/repositories/add_wfh/add_wfh_repository.dart';

class WfhUseCases {
  final AddWfhRepository repository;

  WfhUseCases({required this.repository});

  Future<Either<Failure, GetWfhListEntity>> getAddWfhCall(
    GetMyWfhRequestModel request,
  ) async => await repository.getAddWfh(request);

  Future<Either<Failure, GetWfhListEntity>> deleteWfhRequestCall(
    DeleteWfhRequestModel request,
  ) async => await repository.deleteWfhRequest(request);
}
