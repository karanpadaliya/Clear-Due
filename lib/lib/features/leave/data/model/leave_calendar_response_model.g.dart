// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_calendar_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveCalendarResponseModel _$LeaveCalendarResponseModelFromJson(
  Map<String, dynamic> json,
) => LeaveCalendarResponseModel(
  monthlyHistory:
      (json['monthly_history'] as List<dynamic>?)
          ?.map((e) => MonthlyHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  monthYear: json['month_year'] as String?,
  applyHolidayLeave: json['apply_holiday_leave'] as String?,
  applyWeekOffLeave: json['apply_weekoff_leave'] as String?,
  sandwichLeaveApply: json['sandwich_leave_apply'] as bool?,
  isSalaryGenerated: json['is_salary_generated'] as bool?,
);

Map<String, dynamic> _$LeaveCalendarResponseModelToJson(
  LeaveCalendarResponseModel instance,
) => <String, dynamic>{
  'monthly_history': instance.monthlyHistory,
  'month_year': instance.monthYear,
  'apply_holiday_leave': instance.applyHolidayLeave,
  'apply_weekoff_leave': instance.applyWeekOffLeave,
  'sandwich_leave_apply': instance.sandwichLeaveApply,
  'is_salary_generated': instance.isSalaryGenerated,
};

MonthlyHistoryModel _$MonthlyHistoryModelFromJson(Map<String, dynamic> json) =>
    MonthlyHistoryModel(
      date: json['date'] as String?,
      holiday: json['holiday'] as bool?,
      weekOff: json['week_off'] as bool?,
      leaveApplied: json['leave_applied'] as bool?,
      isOptionalHoliday: json['is_optional_holiday'] as bool?,
      hasAttendance: json['has_attendance'] as bool?,
      attendancePending: json['attendance_pending'] as bool?,
      attendanceApproved: json['attendance_approved'] as bool?,
      attendanceRejected: json['attendance_rejected'] as bool?,
      multipleLeave: json['multiple_leave'] as bool?,
      multipleLeaveData:
          (json['multiple_leave_data'] as List<dynamic>?)
              ?.map(
                (e) =>
                    MultipleLeaveDataModel.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      totalLeaves: json['total_leaves'] as String?,
      leaveReason: json['leave_reason'] as String?,
      holidayName: json['holiday_name'] as String?,
    );

Map<String, dynamic> _$MonthlyHistoryModelToJson(
  MonthlyHistoryModel instance,
) => <String, dynamic>{
  'date': instance.date,
  'holiday': instance.holiday,
  'week_off': instance.weekOff,
  'leave_applied': instance.leaveApplied,
  'is_optional_holiday': instance.isOptionalHoliday,
  'has_attendance': instance.hasAttendance,
  'attendance_pending': instance.attendancePending,
  'attendance_approved': instance.attendanceApproved,
  'attendance_rejected': instance.attendanceRejected,
  'multiple_leave': instance.multipleLeave,
  'multiple_leave_data': instance.multipleLeaveData,
  'total_leaves': instance.totalLeaves,
  'leave_reason': instance.leaveReason,
  'holiday_name': instance.holidayName,
};

MultipleLeaveDataModel _$MultipleLeaveDataModelFromJson(
  Map<String, dynamic> json,
) => MultipleLeaveDataModel(
  leaveTypeId: json['leave_type_id'] as String?,
  leaveDate: json['leave_date'] as String?,
  leaveTypeName: json['leave_type_name'] as String?,
  leaveReason: json['leave_reason'] as String?,
  leavePercentage: json['leave_percentage'] as String?,
  leaveHolidayWeekoffType: json['leave_holiday_weekoff_type'] as String?,
  halfDaySession: json['half_day_session'] as String?,
  leaveStartDate: json['leave_start_date'] as String?,
  paidUnpaid: json['paid_unpaid'] as String?,
  paidUnpaidView: json['paid_unpaid_view'] as String?,
  leaveDayType: json['leave_day_type'] as String?,
  leaveStatus: json['leave_status'] as String?,
  leaveStatusView: json['leave_status_view'] as String?,
);

Map<String, dynamic> _$MultipleLeaveDataModelToJson(
  MultipleLeaveDataModel instance,
) => <String, dynamic>{
  'leave_type_id': instance.leaveTypeId,
  'leave_date': instance.leaveDate,
  'leave_type_name': instance.leaveTypeName,
  'leave_reason': instance.leaveReason,
  'leave_percentage': instance.leavePercentage,
  'leave_holiday_weekoff_type': instance.leaveHolidayWeekoffType,
  'half_day_session': instance.halfDaySession,
  'leave_start_date': instance.leaveStartDate,
  'paid_unpaid': instance.paidUnpaid,
  'paid_unpaid_view': instance.paidUnpaidView,
  'leave_day_type': instance.leaveDayType,
  'leave_status': instance.leaveStatus,
  'leave_status_view': instance.leaveStatusView,
};
