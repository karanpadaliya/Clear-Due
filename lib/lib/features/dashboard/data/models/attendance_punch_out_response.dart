import 'package:equatable/equatable.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/attendance_punch_out_entity.dart';


class AttendancePunchOutResponse extends Equatable {
  final String? status;
  final String? message;

  const AttendancePunchOutResponse({this.status, this.message});

  factory AttendancePunchOutResponse.fromJson(Map<String, dynamic> json) {
    return AttendancePunchOutResponse(
      status: json['status'],
      message: json['message'],
    );
  }

  AttendancePunchOutEntity toEntity() {
    return AttendancePunchOutEntity(
      status: status,
      message: message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}