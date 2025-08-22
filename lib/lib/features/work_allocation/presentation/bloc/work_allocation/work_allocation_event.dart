import 'package:equatable/equatable.dart';
import 'package:myco_flutter/features/work_allocation/data/models/request/get_assignee_details_request.dart';
import 'package:myco_flutter/features/work_allocation/data/models/request/work_allocation_request.dart';

abstract class WorkAllocationEvent extends Equatable {
  const WorkAllocationEvent();

  @override
  List<Object?> get props => [];
}

//for work allocation data
class FetchWorkAllocationListEvent extends WorkAllocationEvent {
  final WorkAllocationRequest params;

  const FetchWorkAllocationListEvent(this.params);

  @override
  List<Object?> get props => [params];
}

// fetch assign details
class FetchAssigneeDetailsEvent extends WorkAllocationEvent {
  final GetAssigneeDetailsRequest params;

  const FetchAssigneeDetailsEvent(this.params);

  @override
  List<Object?> get props => [params];
}
