import 'package:myco_flutter/features/leave/data/model/leave_calendar_response_model.dart';

abstract class AddLeaveState {}

class AddLeaveInitial extends AddLeaveState {}

class LeaveDataLoading extends AddLeaveState {}

class LeaveDataLoaded extends AddLeaveState {
  final String leaveId;
  final String leaveName;
  final bool isAttachmentRequired;
  final String specialLeave;
  final bool selectedLeaveApplyDate;
  final int selectedLeaveTypePosition;

  LeaveDataLoaded({
    required this.leaveId,
    required this.leaveName,
    required this.isAttachmentRequired,
    required this.specialLeave,
    required this.selectedLeaveApplyDate,
    required this.selectedLeaveTypePosition,
  });
}

class LeaveCalendarUpdated extends AddLeaveState {
  final LeaveCalendarResponseEntity calendarData;

  LeaveCalendarUpdated(this.calendarData);
}

class LeaveDataError extends AddLeaveState {
  final String error;

  LeaveDataError(this.error);
}
