import 'package:myco_flutter/features/leave/domain/entities/leave_history_response_entity.dart';

abstract class LeaveScreenEvent {}

class LoadLeaves extends LeaveScreenEvent {}

class ChangeFilter extends LeaveScreenEvent {
  final String filter;

  ChangeFilter(this.filter);
}

class ChangeMonthYear extends LeaveScreenEvent {
  final int month;
  final int year;

  ChangeMonthYear(this.month, this.year);
}

// Internal event to update leaves & teamLeave flag from LeaveBloc state streams
class LeavesLoaded extends LeaveScreenEvent {
  final List<LeaveHistoryEntity> leaves;
  final bool isTeamLeave;

  LeavesLoaded({required this.leaves, required this.isTeamLeave});
}
