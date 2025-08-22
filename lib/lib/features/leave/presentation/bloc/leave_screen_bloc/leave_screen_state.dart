import 'package:myco_flutter/features/leave/domain/entities/leave_history_response_entity.dart';

class LeaveScreenState {
  final bool isLoading;
  final String filter;
  final int month;
  final int year;
  final bool isTeamLeave;
  final List<LeaveHistoryEntity> leaves;

  LeaveScreenState({
    required this.isLoading,
    required this.filter,
    required this.month,
    required this.year,
    required this.isTeamLeave,
    required this.leaves,
  });

  LeaveScreenState copyWith({
    bool? isLoading,
    String? filter,
    int? month,
    int? year,
    bool? isTeamLeave,
    List<LeaveHistoryEntity>? leaves,
  }) => LeaveScreenState(
    isLoading: isLoading ?? this.isLoading,
    filter: filter ?? this.filter,
    month: month ?? this.month,
    year: year ?? this.year,
    isTeamLeave: isTeamLeave ?? this.isTeamLeave,
    leaves: leaves ?? this.leaves,
  );

  factory LeaveScreenState.initial() => LeaveScreenState(
    isLoading: true,
    filter: 'All Leaves',
    month: 0,
    year: DateTime.now().year,
    isTeamLeave: false,
    leaves: [],
  );
}
