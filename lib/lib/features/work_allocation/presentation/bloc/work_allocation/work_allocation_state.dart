import 'package:equatable/equatable.dart';
import 'package:myco_flutter/features/work_allocation/domain/entities/get_assignee_entity.dart';
import 'package:myco_flutter/features/work_allocation/domain/entities/work_allocation_entity.dart';

abstract class WorkAllocationState extends Equatable {
  const WorkAllocationState();

  @override
  List<Object?> get props => [];
}

class WorkAllocationInitial extends WorkAllocationState {
  const WorkAllocationInitial();
}

// Loading state
class WorkAllocationLoading extends WorkAllocationState {
  const WorkAllocationLoading();
}

// loaded state
class WorkAllocationListLoaded extends WorkAllocationState {
  final WorkAllocationResponseEntity workAllocationList;

  const WorkAllocationListLoaded(this.workAllocationList);

  @override
  List<Object?> get props => [workAllocationList];
}

// Error state
class WorkAllocationError extends WorkAllocationState {
  final String error;

  const WorkAllocationError(this.error);

  @override
  List<Object?> get props => [error];
}

// work allocation data
class WorkAllocationList extends WorkAllocationState {
  final WorkAllocationResponseEntity? workAllocationList;

  const WorkAllocationList({this.workAllocationList});

  @override
  List<Object?> get props => [workAllocationList];
}

// assign details
class AssigneeDetailsLoaded extends WorkAllocationState {
  final GetAssigneeResponseEntity assignee;

  const AssigneeDetailsLoaded(this.assignee);

  @override
  List<Object?> get props => [assignee];
}
