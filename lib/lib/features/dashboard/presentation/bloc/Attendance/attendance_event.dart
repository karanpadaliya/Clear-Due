part of 'attendance_bloc.dart';

sealed class AttendanceEvent extends Equatable {
  const AttendanceEvent();
  @override
  List<Object> get props => [];
}

class FetchAttendanceData extends AttendanceEvent {

  const FetchAttendanceData();
}

class PunchInRequested extends AttendanceEvent {
  final AttendancePunchInRequest request;
  const PunchInRequested({required this.request,});
}

class PunchOutRequested extends AttendanceEvent {
  final AttendancePunchOutRequest request;
  const PunchOutRequested({
    required this.request,
  });
}

class BreakInRequested extends AttendanceEvent {
  final BreakInRequest request;
  const BreakInRequested({required this.request, });
}

class BreakOutRequested extends AttendanceEvent {
  final BreakOutRequest request;
  const BreakOutRequested({
    required this.request,
  });
}
