import 'package:equatable/equatable.dart';
import 'package:myco_flutter/features/work_from_home/domain/entities/admin_req_wfh/req_wfh_entity.dart';

abstract class RequestWfhState extends Equatable {
  const RequestWfhState();
  @override
  List<Object?> get props => [];
}

class WFHInitial extends RequestWfhState {
  const WFHInitial();
}

class WFHLoading extends RequestWfhState {
  const WFHLoading();
}

class WFHLoaded extends RequestWfhState {
  final List<AdminWfhItemEntity> fullList;

  const WFHLoaded({required this.fullList});
}

class WFHError extends RequestWfhState {
  final String message;
  const WFHError(this.message);
  @override
  List<Object?> get props => [message];
}
