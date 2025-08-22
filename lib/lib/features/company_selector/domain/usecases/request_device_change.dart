import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/core/models/domain/common_response_entity.dart';
import 'package:myco_flutter/features/company_selector/data/models/request_device_change_model.dart';
import 'package:myco_flutter/features/company_selector/domain/repositories/request_device_change_repository.dart';

class RequestDeviceChange {
  final RequestDeviceChangeRepository repository;

  RequestDeviceChange({required this.repository});

  Future<Either<Failure, CommonResponseModelEntity>> call(
      RequestDeviceChangeModel model,
      ) => repository.requestDeviceChange(model);
}
