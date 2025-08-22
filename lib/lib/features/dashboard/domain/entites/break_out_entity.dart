import 'package:equatable/equatable.dart';

class BreakOutEntity extends Equatable {
  final String? status;
  final String? message;

  const BreakOutEntity({this.status, this.message});

  @override
  List<Object?> get props => [status, message];
}
