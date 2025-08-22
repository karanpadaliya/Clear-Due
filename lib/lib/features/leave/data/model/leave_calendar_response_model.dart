import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leave_calendar_response_model.g.dart';

LeaveCalendarResponseModel leaveCalendarResponseModelFromJson(String str) =>
    LeaveCalendarResponseModel.fromJson(json.decode(str));

@JsonSerializable()
class LeaveCalendarResponseModel {
  @JsonKey(name: 'monthly_history')
  final List<MonthlyHistoryModel>? monthlyHistory;

  @JsonKey(name: 'month_year')
  final String? monthYear;

  @JsonKey(name: 'apply_holiday_leave')
  final String? applyHolidayLeave;

  @JsonKey(name: 'apply_weekoff_leave')
  final String? applyWeekOffLeave;

  @JsonKey(name: 'sandwich_leave_apply')
  final bool? sandwichLeaveApply;

  @JsonKey(name: 'is_salary_generated')
  final bool? isSalaryGenerated;

  LeaveCalendarResponseModel({
    this.monthlyHistory,
    this.monthYear,
    this.applyHolidayLeave,
    this.applyWeekOffLeave,
    this.sandwichLeaveApply,
    this.isSalaryGenerated,
  });

  factory LeaveCalendarResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveCalendarResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveCalendarResponseModelToJson(this);

  LeaveCalendarResponseEntity toEntity() => LeaveCalendarResponseEntity(
    monthlyHistory: monthlyHistory?.map((model) => model.toEntity()).toList(),
    monthYear: monthYear,
    applyHolidayLeave: applyHolidayLeave,
    applyWeekOffLeave: applyWeekOffLeave,
    sandwichLeaveApply: sandwichLeaveApply,
    isSalaryGenerated: isSalaryGenerated,
  );
}

@JsonSerializable()
class MonthlyHistoryModel {
  @JsonKey(name: 'date')
  final String? date;

  @JsonKey(name: 'holiday')
  final bool? holiday;

  @JsonKey(name: 'week_off')
  final bool? weekOff;

  @JsonKey(name: 'leave_applied')
  final bool? leaveApplied;

  @JsonKey(name: 'is_optional_holiday')
  final bool? isOptionalHoliday;

  @JsonKey(name: 'has_attendance')
  final bool? hasAttendance;

  @JsonKey(name: 'attendance_pending')
  final bool? attendancePending;

  @JsonKey(name: 'attendance_approved')
  final bool? attendanceApproved;

  @JsonKey(name: 'attendance_rejected')
  final bool? attendanceRejected;

  @JsonKey(name: 'multiple_leave')
  final bool? multipleLeave;

  @JsonKey(name: 'multiple_leave_data')
  final List<MultipleLeaveDataModel>? multipleLeaveData;

  @JsonKey(name: 'total_leaves')
  final String? totalLeaves;

  @JsonKey(name: 'leave_reason')
  final String? leaveReason;

  @JsonKey(name: 'holiday_name')
  final String? holidayName;

  MonthlyHistoryModel({
    this.date,
    this.holiday,
    this.weekOff,
    this.leaveApplied,
    this.isOptionalHoliday,
    this.hasAttendance,
    this.attendancePending,
    this.attendanceApproved,
    this.attendanceRejected,
    this.multipleLeave,
    this.multipleLeaveData,
    this.totalLeaves,
    this.leaveReason,
    this.holidayName,
  });

  factory MonthlyHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$MonthlyHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$MonthlyHistoryModelToJson(this);

  MonthlyHistoryEntity toEntity() => MonthlyHistoryEntity(
    date: date,
    holiday: holiday,
    weekOff: weekOff,
    leaveApplied: leaveApplied,
    isOptionalHoliday: isOptionalHoliday,
    hasAttendance: hasAttendance,
    attendancePending: attendancePending,
    attendanceApproved: attendanceApproved,
    attendanceRejected: attendanceRejected,
    multipleLeave: multipleLeave,
    multipleLeaveData: multipleLeaveData
        ?.map((model) => model.toEntity())
        .toList(),
    totalLeaves: totalLeaves,
    leaveReason: leaveReason,
    holidayName: holidayName,
  );
}

@JsonSerializable()
class MultipleLeaveDataModel {
  @JsonKey(name: 'leave_type_id')
  final String? leaveTypeId;

  @JsonKey(name: 'leave_date')
  final String? leaveDate;

  @JsonKey(name: 'leave_type_name')
  final String? leaveTypeName;

  @JsonKey(name: 'leave_reason')
  final String? leaveReason;

  @JsonKey(name: 'leave_percentage')
  final String? leavePercentage;

  @JsonKey(name: 'leave_holiday_weekoff_type')
  final String? leaveHolidayWeekoffType;

  @JsonKey(name: 'half_day_session')
  final String? halfDaySession;

  @JsonKey(name: 'leave_start_date')
  final String? leaveStartDate;

  @JsonKey(name: 'paid_unpaid')
  final String? paidUnpaid;

  @JsonKey(name: 'paid_unpaid_view')
  final String? paidUnpaidView;

  @JsonKey(name: 'leave_day_type')
  final String? leaveDayType;

  @JsonKey(name: 'leave_status')
  final String? leaveStatus;

  @JsonKey(name: 'leave_status_view')
  final String? leaveStatusView;

  MultipleLeaveDataModel({
    this.leaveTypeId,
    this.leaveDate,
    this.leaveTypeName,
    this.leaveReason,
    this.leavePercentage,
    this.leaveHolidayWeekoffType,
    this.halfDaySession,
    this.leaveStartDate,
    this.paidUnpaid,
    this.paidUnpaidView,
    this.leaveDayType,
    this.leaveStatus,
    this.leaveStatusView,
  });

  factory MultipleLeaveDataModel.fromJson(Map<String, dynamic> json) =>
      _$MultipleLeaveDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$MultipleLeaveDataModelToJson(this);

  MultipleLeaveDataEntity toEntity() => MultipleLeaveDataEntity(
    leaveTypeId: leaveTypeId,
    leaveDate: leaveDate,
    leaveTypeName: leaveTypeName,
    leaveReason: leaveReason,
    leavePercentage: leavePercentage,
    leaveHolidayWeekoffType: leaveHolidayWeekoffType,
    halfDaySession: halfDaySession,
    leaveStartDate: leaveStartDate,
    paidUnpaid: paidUnpaid,
    paidUnpaidView: paidUnpaidView,
    leaveDayType: leaveDayType,
    leaveStatus: leaveStatus,
    leaveStatusView: leaveStatusView,
  );
}

class LeaveCalendarResponseEntity extends Equatable {
  final List<MonthlyHistoryEntity>? monthlyHistory;
  final String? monthYear;
  final String? applyHolidayLeave;
  final String? applyWeekOffLeave;
  final bool? sandwichLeaveApply;
  final bool? isSalaryGenerated;

  // Add the new property here
  final Set<DateTime> allLeaveDates;

  const LeaveCalendarResponseEntity({
    this.monthlyHistory,
    this.monthYear,
    this.applyHolidayLeave,
    this.applyWeekOffLeave,
    this.sandwichLeaveApply,
    this.isSalaryGenerated,

    // Initialize the new property in the constructor
    Set<DateTime>? allLeaveDates,
  }) : allLeaveDates = allLeaveDates ?? const <DateTime>{};

  @override
  List<Object?> get props => [
    monthlyHistory,
    monthYear,
    applyHolidayLeave,
    applyWeekOffLeave,
    sandwichLeaveApply,
    isSalaryGenerated,

    // Add the new property to the props list
    allLeaveDates,
  ];
}

class MonthlyHistoryEntity extends Equatable {
  final String? date;
  final bool? holiday;
  final bool? weekOff;
  final bool? leaveApplied;
  final bool? isOptionalHoliday;
  final bool? hasAttendance;
  final bool? attendancePending;
  final bool? attendanceApproved;
  final bool? attendanceRejected;
  final bool? multipleLeave;
  final List<MultipleLeaveDataEntity>? multipleLeaveData;
  final String? totalLeaves;
  final String? leaveReason;
  final String? holidayName;

  const MonthlyHistoryEntity({
    this.date,
    this.holiday,
    this.weekOff,
    this.leaveApplied,
    this.isOptionalHoliday,
    this.hasAttendance,
    this.attendancePending,
    this.attendanceApproved,
    this.attendanceRejected,
    this.multipleLeave,
    this.multipleLeaveData,
    this.totalLeaves,
    this.leaveReason,
    this.holidayName,
  });

  @override
  List<Object?> get props => [
    date,
    holiday,
    weekOff,
    leaveApplied,
    isOptionalHoliday,
    hasAttendance,
    attendancePending,
    attendanceApproved,
    attendanceRejected,
    multipleLeave,
    multipleLeaveData,
    totalLeaves,
    leaveReason,
    holidayName,
  ];
}

class MultipleLeaveDataEntity extends Equatable {
  final String? leaveTypeId;
  final String? leaveDate;
  final String? leaveTypeName;
  final String? leaveReason;
  final String? leavePercentage;
  final String? leaveHolidayWeekoffType;
  final String? halfDaySession;
  final String? leaveStartDate;
  final String? paidUnpaid;
  final String? paidUnpaidView;
  final String? leaveDayType;
  final String? leaveStatus;
  final String? leaveStatusView;

  const MultipleLeaveDataEntity({
    this.leaveTypeId,
    this.leaveDate,
    this.leaveTypeName,
    this.leaveReason,
    this.leavePercentage,
    this.leaveHolidayWeekoffType,
    this.halfDaySession,
    this.leaveStartDate,
    this.paidUnpaid,
    this.paidUnpaidView,
    this.leaveDayType,
    this.leaveStatus,
    this.leaveStatusView,
  });

  @override
  List<Object?> get props => [
    leaveTypeId,
    leaveDate,
    leaveTypeName,
    leaveReason,
    leavePercentage,
    leaveHolidayWeekoffType,
    halfDaySession,
    leaveStartDate,
    paidUnpaid,
    paidUnpaidView,
    leaveDayType,
    leaveStatus,
    leaveStatusView,
  ];
}
