import 'package:equatable/equatable.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/attendance_punch_in_entity.dart';


class AttendancePunchInResponse extends Equatable {
  final String? status;
  final String? message;
  final String? punchInTime;
  final String? attendanceId;

  const AttendancePunchInResponse({
    this.status,
    this.message,
    this.punchInTime,
    this.attendanceId,
  });

  factory AttendancePunchInResponse.fromJson(Map<String, dynamic> json) {
    return AttendancePunchInResponse(
      status: json['status'],
      message: json['message'],
      punchInTime: json['punch_in_time'],
      attendanceId: json['attendance_id'],
    );
  }

  AttendancePunchInEntity toEntity() {
    return AttendancePunchInEntity(
      status: status,
      message: message,
      punchInTime: punchInTime,
      attendanceId: attendanceId,
    );
  }

  @override
  List<Object?> get props => [status, message, punchInTime, attendanceId];
}