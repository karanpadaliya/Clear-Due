part of 'time_sheet_bloc.dart';

sealed class TimeSheetEvent extends Equatable {
  const TimeSheetEvent();

  @override
  List<Object?> get props => [];
}

// Event to initialize the BLoC and page state
class TimeSheetInitialized extends TimeSheetEvent {}

// Event to fetch the monthly attendance history
class GetMonthlyAttendanceHistory extends TimeSheetEvent {
  final String startDate;
  final String endDate;

  const GetMonthlyAttendanceHistory({
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object> get props => [startDate, endDate];
}

// Event to change the calendar format (week/month)
class CalendarFormatChanged extends TimeSheetEvent {}

// Event for when the focused day/page in the calendar changes
class FocusedDayChanged extends TimeSheetEvent {
  final DateTime newFocusedDay;

  const FocusedDayChanged({required this.newFocusedDay});

  @override
  List<Object> get props => [newFocusedDay];
}

// Event for when a day is selected
class DaySelected extends TimeSheetEvent {
  final DateTime selectedDay;
  final DateTime focusedDay;

  const DaySelected({required this.selectedDay, required this.focusedDay});

  @override
  List<Object> get props => [selectedDay, focusedDay];
}

// Event for when a pie chart segment is selected
class PieSegmentSelected extends TimeSheetEvent {
  final PieSegment? segment;

  const PieSegmentSelected({this.segment});

  @override
  List<Object?> get props => [segment];
}

// Event to send a punch-in request reminder
class PunchInRequestReminder extends TimeSheetEvent {
  final String attendanceId;

  const PunchInRequestReminder({required this.attendanceId});

  @override
  List<Object> get props => [attendanceId];
}

// Event to submit a punch-in request
class PunchInRequest extends TimeSheetEvent {
  final String punchInDate;
  final String punchOutDate;
  final String punchInTime;
  final String punchOutTime;
  final String reason;
  final String selectedShiftId;
  final String multiPunchData;

  const PunchInRequest({
    required this.punchInDate,
    required this.punchOutDate,
    required this.punchInTime,
    required this.punchOutTime,
    required this.reason,
    required this.selectedShiftId,
    required this.multiPunchData,
  });

  @override
  List<Object> get props => [
    punchInDate,
    punchOutDate,
    punchInTime,
    punchOutTime,
    reason,
    selectedShiftId,
    multiPunchData,
  ];
}