import 'package:equatable/equatable.dart';

class BreakInEntity extends Equatable {
  final String? status;
  final String? message;
  final String? attendanceBreakHistoryId;

  const BreakInEntity({
    this.status,
    this.message,
    this.attendanceBreakHistoryId,
  });

  @override
  List<Object?> get props => [status, message, attendanceBreakHistoryId];
}
