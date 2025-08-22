import 'package:equatable/equatable.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/break_out_entity.dart';

class BreakOutResponse extends Equatable {
  final String? status;
  final String? message;

  const BreakOutResponse({this.status, this.message});

  factory BreakOutResponse.fromJson(Map<String, dynamic> json) {
    return BreakOutResponse(status: json['status'], message: json['message']);
  }

  BreakOutEntity toEntity() {
    return BreakOutEntity(status: status, message: message);
  }

  @override
  List<Object?> get props => [status, message];
}
