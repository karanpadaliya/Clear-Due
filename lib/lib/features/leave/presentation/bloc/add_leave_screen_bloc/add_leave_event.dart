import 'package:myco_flutter/features/leave/data/model/leave_calendar_response_model.dart';

abstract class AddLeaveEvent {}

class SetUpLeaveData extends AddLeaveEvent {
  final int position;

  SetUpLeaveData(this.position);
}

class SetLeaveCalendar extends AddLeaveEvent {
  final LeaveCalendarResponseEntity response;

  SetLeaveCalendar(this.response);
}
