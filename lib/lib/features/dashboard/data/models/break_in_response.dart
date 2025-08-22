import 'package:equatable/equatable.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/break_in_entity.dart';

class BreakInResponse extends Equatable {
  final String? status;
  final String? message;
  final String? attendanceBreakHistoryId;

  const BreakInResponse({
    this.status,
    this.message,
    this.attendanceBreakHistoryId,
  });

  factory BreakInResponse.fromJson(Map<String, dynamic> json) {
    return BreakInResponse(
      status: json['status'],
      message: json['message'],
      attendanceBreakHistoryId: json['attendance_break_history_id'],
    );
  }

  BreakInEntity toEntity() {
    return BreakInEntity(
      status: status,
      message: message,
      attendanceBreakHistoryId: attendanceBreakHistoryId,
    );
  }

  @override
  List<Object?> get props => [status, message, attendanceBreakHistoryId];
}
