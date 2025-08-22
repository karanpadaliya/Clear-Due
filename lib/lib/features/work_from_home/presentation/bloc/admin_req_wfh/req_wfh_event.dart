import 'package:equatable/equatable.dart';
import 'package:myco_flutter/features/work_from_home/domain/entities/admin_req_wfh/req_wfh_entity.dart';

abstract class RequestWfhEvent extends Equatable {
  const RequestWfhEvent();
  // Default implementation, can be overridden
  @override
  List<Object?> get props => [];
}

class InitializeWfhTab extends RequestWfhEvent {
  final int index;
  const InitializeWfhTab({required this.index});
}

class FetchWFHList extends RequestWfhEvent {
  final String month;
  final String year;
  const FetchWFHList({this.month = 'All', this.year = '2025'});
}

class RefreshWFHList extends RequestWfhEvent {}

class ApproveRequest extends RequestWfhEvent {
  final AdminWfhItemEntity wfhItemEntity;
  const ApproveRequest(this.wfhItemEntity);
}

class RejectRequest extends RequestWfhEvent {
  final AdminWfhItemEntity wfhItemEntity;
  final String reason;
  const RejectRequest(this.wfhItemEntity, this.reason);
}

class OnSearchWfh extends RequestWfhEvent {
  final String status; // "0", "1", "2/3"
  const OnSearchWfh(this.status);
}
