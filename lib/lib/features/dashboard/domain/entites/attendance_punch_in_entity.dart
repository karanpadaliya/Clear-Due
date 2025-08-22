import 'package:equatable/equatable.dart';

class AttendancePunchInEntity extends Equatable {
  final String? status;
  final String? message;
  final String? punchInTime;
  final String? attendanceId;

  const AttendancePunchInEntity({
    this.status,
    this.message,
    this.punchInTime,
    this.attendanceId,
  });

  @override
  List<Object?> get props => [status, message, punchInTime, attendanceId];
}