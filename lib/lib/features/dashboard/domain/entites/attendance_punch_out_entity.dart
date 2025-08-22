import 'package:equatable/equatable.dart';

class AttendancePunchOutEntity extends Equatable {
  final String? status;
  final String? message;

  const AttendancePunchOutEntity({this.status, this.message});

  @override
  List<Object?> get props => [status, message];
}
