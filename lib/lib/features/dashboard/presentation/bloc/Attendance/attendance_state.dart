part of 'attendance_bloc.dart';

sealed class AttendanceState extends Equatable {
  const AttendanceState();
  @override
  List<Object?> get props => [];
}

final class AttendanceInitial extends AttendanceState {}

final class AttendanceLoading extends AttendanceState {}

final class AttendanceError extends AttendanceState {
  final String message;
  const AttendanceError(this.message);
  @override
  List<Object> get props => [message];
}

final class AttendanceStateUpdated extends AttendanceState {
  final AttendanceTypeResponseEntity attendanceData;
  const AttendanceStateUpdated(this.attendanceData);
  @override
  List<Object> get props => [attendanceData];
}
