import 'package:flutter/material.dart';

// Enum to identify specific fields that have validation errors.
enum ErrorField { punchInDate, punchOutDate, punchInTime, punchOutTime }

class PunchEntryModel {
  final String punchInTime;
  final String punchOutTime;
  final String punchInDate; // yyyy-MM-dd format
  final String punchOutDate; // yyyy-MM-dd format
  final String? errorMessage;
  final Set<ErrorField> errorFields;

  PunchEntryModel({
    this.punchInTime = '--:--:--',
    this.punchOutTime = '--:--:--',
    String? punchInDate,
    String? punchOutDate,
    this.errorMessage,
    this.errorFields = const {},
  })  : punchInDate = punchInDate ?? _formattedToday(),
        punchOutDate = punchOutDate ?? _formattedToday();

  PunchEntryModel copyWith({
    String? punchInTime,
    String? punchOutTime,
    String? punchInDate,
    String? punchOutDate,
    ValueGetter<String?>? errorMessage,
    Set<ErrorField>? errorFields,
  }) =>
      PunchEntryModel(
        punchInTime: punchInTime ?? this.punchInTime,
        punchOutTime: punchOutTime ?? this.punchOutTime,
        punchInDate: punchInDate ?? this.punchInDate,
        punchOutDate: punchOutDate ?? this.punchOutDate,
        errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
        errorFields: errorFields ?? this.errorFields,
      );

  static String _formattedToday() {
    final now = DateTime.now().toLocal();
    return now.toIso8601String().split('T')[0]; // yyyy-MM-dd
  }
}