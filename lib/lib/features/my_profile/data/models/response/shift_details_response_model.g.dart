// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_details_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShiftDetailsResponseModel _$ShiftDetailsResponseModelFromJson(
  Map<String, dynamic> json,
) => ShiftDetailsResponseModel(
  hasAlternateShift: json['has_alternate_shift'] as bool?,
  alternateShiftName: json['alternate_shift_name'] as String?,
  alternateShiftCode: json['alternate_shift_code'] as String?,
  altShiftTimeId: json['alt_shift_time_id'] as String?,
  rotationalWeekShift: json['rotational_week_shift'] as List<dynamic>?,
  shiftRosterDetails: json['shift_roster_details'] as List<dynamic>?,
  altShifts:
      (json['alt_shifts'] as List<dynamic>?)
          ?.map((e) => AltShift.fromJson(e as Map<String, dynamic>))
          .toList(),
  shiftTimeId: json['shift_time_id'] as String?,
  shiftName: json['shift_name'] as String?,
  shiftCode: json['shift_code'] as String?,
  lateInReason: json['late_in_reason'] as String?,
  earlyOutReason: json['early_out_reason'] as String?,
  isMultiplePunchIn: json['is_multiple_punch_in'] as String?,
  takeOutOfRangeReason: json['take_out_of_range_reason'] as String?,
  allowShortLeave: json['allow_short_leave'] as String?,
  monthlyShortLeave: json['monthly_short_leave'] as String?,
  shortLeaveApplyType: json['short_leave_apply_type'] as String?,
  shortLeaveMinutes: json['short_leave_minutes'] as String?,
  shortLeaveBufferMinutes: json['short_leave_buffer_minutes'] as String?,
  sandwichLeaveApply: json['sandwich_leave_apply'] as String?,
  lateInEarlyOutType: json['late_in_early_out_type'] as String?,
  maximumInOut: json['maximum_in_out'] as String?,
  maximumEarlyOut: json['maximum_early_out'] as String?,
  weekOffDays: json['week_off_days'] as String?,
  hasAltenateWeekOff: json['has_altenate_week_off'] as String?,
  alternateWeekOff: json['alternate_week_off'] as String?,
  alternateWeekoffDays: json['alternate_weekoff_days'] as String?,
  takeBreaksSetting: json['take_breaks_setting'] as String?,
  paidLeaveOnExtraDay: json['paid_leave_on_extra_day'] as String?,
  extraDayLeaveExpireDays: json['extra_day_leave_expire_days'] as String?,
  applicableExtraDayLeavesInMonth:
      json['applicable_extra_day_leaves_in_month'] as String?,
  allowCompOffLeaveOnPastDate:
      json['allow_comp_off_leave_on_past_date'] as String?,
  hasAutoWeekOff: json['has_auto_week_off'] as String?,
  autoWeekOffCount: json['auto_week_off_count'] as String?,
  dayNamesView: json['dayNamesView'] as String?,
  applyHalfDayLateInExceeded:
      json['apply_half_day_late_in_exceeded'] as String?,
  lateInExceededLeaveType: json['late_in_exceeded_leave_type'] as String?,
  lateInEarlyOutApplyOnExtraDay:
      json['late_in_early_out_apply_on_extra_day'] as String?,
  applyHolidayLeave: json['apply_holiday_leave'] as String?,
  applyWeekoffLeave: json['apply_weekoff_leave'] as String?,
  applyHalfDayBeforeFixTimeOut:
      json['apply_half_day_before_fix_time_out'] as String?,
  holidayPenaltyApply: json['holiday_penalty_apply'] as String?,
  weekoffPenaltyApply: json['weekoff_penalty_apply'] as String?,
  paidLeaveOnExtraHour: json['paid_leave_on_extra_hour'] as String?,
  removeLateInEarlyOutOnFullWorking:
      json['remove_late_in_early_out_on_full_working'] as String?,
  removeBreakTimeIfNotTaken: json['remove_break_time_if_not_taken'] as String?,
  deductFullBreakTimeIfLessTaken:
      json['deduct_full_break_time_if_less_taken'] as String?,
  minumumHalfHours: json['minumum_half_hours'] as String?,
  minumumFullHours: json['minumum_full_hours'] as String?,
  calculateLeaveBalance: json['calculate_leave_balance'] as String?,
  calculateLeaveBalanceAfterDays:
      json['calculate_leave_balance_after_days'] as String?,
  hoursTypeInShiftClock: json['hours_type_in_shift_clock'] as String?,
  penaltyOnAbsent: json['penalty_on_absent'] as String?,
  penaltyTypeOnAbsent: json['penalty_type_on_absent'] as String?,
  penaltyAmountAbsent: json['penalty_amount_absent'] as String?,
  needOtRequest: json['need_ot_request'] as String?,
  attendanceCalculationOnProductiveHours:
      json['attendance_calculation_on_productive_hours'] as String?,
  needOtRequestForWorkingDays:
      json['need_ot_request_for_working_days'] as String?,
  holidayWeekoffPenaltyApply: json['holiday_weekoff_penalty_apply'] as String?,
  shortLeaveDays: json['short_leave_days'] as String?,
  takeBreakWithApprovalFaceApp:
      json['take_break_with_approval_face_app'] as String?,
  takeBreakWithApprovalEmployeeApp:
      json['take_break_with_approval_employee_app'] as String?,
  lateInPenalty: json['late_in_penalty'] as bool?,
  nextDayGressTime: json['next_day_gress_time'] as bool?,
  nextDayGressTimeSlab: json['next_day_gress_time_slab'] as List<dynamic>?,
  days:
      (json['days'] as List<dynamic>?)
          ?.map((e) => Day.fromJson(e as Map<String, dynamic>))
          .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$ShiftDetailsResponseModelToJson(
  ShiftDetailsResponseModel instance,
) => <String, dynamic>{
  'has_alternate_shift': instance.hasAlternateShift,
  'alternate_shift_name': instance.alternateShiftName,
  'alternate_shift_code': instance.alternateShiftCode,
  'alt_shift_time_id': instance.altShiftTimeId,
  'rotational_week_shift': instance.rotationalWeekShift,
  'shift_roster_details': instance.shiftRosterDetails,
  'alt_shifts': instance.altShifts,
  'shift_time_id': instance.shiftTimeId,
  'shift_name': instance.shiftName,
  'shift_code': instance.shiftCode,
  'late_in_reason': instance.lateInReason,
  'early_out_reason': instance.earlyOutReason,
  'is_multiple_punch_in': instance.isMultiplePunchIn,
  'take_out_of_range_reason': instance.takeOutOfRangeReason,
  'allow_short_leave': instance.allowShortLeave,
  'monthly_short_leave': instance.monthlyShortLeave,
  'short_leave_apply_type': instance.shortLeaveApplyType,
  'short_leave_minutes': instance.shortLeaveMinutes,
  'short_leave_buffer_minutes': instance.shortLeaveBufferMinutes,
  'sandwich_leave_apply': instance.sandwichLeaveApply,
  'late_in_early_out_type': instance.lateInEarlyOutType,
  'maximum_in_out': instance.maximumInOut,
  'maximum_early_out': instance.maximumEarlyOut,
  'week_off_days': instance.weekOffDays,
  'has_altenate_week_off': instance.hasAltenateWeekOff,
  'alternate_week_off': instance.alternateWeekOff,
  'alternate_weekoff_days': instance.alternateWeekoffDays,
  'take_breaks_setting': instance.takeBreaksSetting,
  'paid_leave_on_extra_day': instance.paidLeaveOnExtraDay,
  'extra_day_leave_expire_days': instance.extraDayLeaveExpireDays,
  'applicable_extra_day_leaves_in_month':
      instance.applicableExtraDayLeavesInMonth,
  'allow_comp_off_leave_on_past_date': instance.allowCompOffLeaveOnPastDate,
  'has_auto_week_off': instance.hasAutoWeekOff,
  'auto_week_off_count': instance.autoWeekOffCount,
  'dayNamesView': instance.dayNamesView,
  'apply_half_day_late_in_exceeded': instance.applyHalfDayLateInExceeded,
  'late_in_exceeded_leave_type': instance.lateInExceededLeaveType,
  'late_in_early_out_apply_on_extra_day':
      instance.lateInEarlyOutApplyOnExtraDay,
  'apply_holiday_leave': instance.applyHolidayLeave,
  'apply_weekoff_leave': instance.applyWeekoffLeave,
  'apply_half_day_before_fix_time_out': instance.applyHalfDayBeforeFixTimeOut,
  'holiday_penalty_apply': instance.holidayPenaltyApply,
  'weekoff_penalty_apply': instance.weekoffPenaltyApply,
  'paid_leave_on_extra_hour': instance.paidLeaveOnExtraHour,
  'remove_late_in_early_out_on_full_working':
      instance.removeLateInEarlyOutOnFullWorking,
  'remove_break_time_if_not_taken': instance.removeBreakTimeIfNotTaken,
  'deduct_full_break_time_if_less_taken':
      instance.deductFullBreakTimeIfLessTaken,
  'minumum_half_hours': instance.minumumHalfHours,
  'minumum_full_hours': instance.minumumFullHours,
  'calculate_leave_balance': instance.calculateLeaveBalance,
  'calculate_leave_balance_after_days': instance.calculateLeaveBalanceAfterDays,
  'hours_type_in_shift_clock': instance.hoursTypeInShiftClock,
  'penalty_on_absent': instance.penaltyOnAbsent,
  'penalty_type_on_absent': instance.penaltyTypeOnAbsent,
  'penalty_amount_absent': instance.penaltyAmountAbsent,
  'need_ot_request': instance.needOtRequest,
  'attendance_calculation_on_productive_hours':
      instance.attendanceCalculationOnProductiveHours,
  'need_ot_request_for_working_days': instance.needOtRequestForWorkingDays,
  'holiday_weekoff_penalty_apply': instance.holidayWeekoffPenaltyApply,
  'short_leave_days': instance.shortLeaveDays,
  'take_break_with_approval_face_app': instance.takeBreakWithApprovalFaceApp,
  'take_break_with_approval_employee_app':
      instance.takeBreakWithApprovalEmployeeApp,
  'late_in_penalty': instance.lateInPenalty,
  'next_day_gress_time': instance.nextDayGressTime,
  'next_day_gress_time_slab': instance.nextDayGressTimeSlab,
  'days': instance.days,
  'message': instance.message,
};

AltShift _$AltShiftFromJson(Map<String, dynamic> json) => AltShift(
  shiftId: json['shift_id'] as String?,
  shiftCode: json['shift_code'] as String?,
  shiftName: json['shift_name'] as String?,
);

Map<String, dynamic> _$AltShiftToJson(AltShift instance) => <String, dynamic>{
  'shift_id': instance.shiftId,
  'shift_code': instance.shiftCode,
  'shift_name': instance.shiftName,
};

Day _$DayFromJson(Map<String, dynamic> json) => Day(
  shiftDayName: json['shift_day_name'] as String?,
  shiftType: json['shift_type'] as String?,
  perDayHourView: json['per_day_hour_view'] as String?,
  shiftStartTimeView: json['shift_start_time_view'] as String?,
  shiftEndTimeView: json['shift_end_time_view'] as String?,
  lunchBreakStartTimeView: json['lunch_break_start_time_view'] as String?,
  lunchBreakEndTimeView: json['lunch_break_end_time_view'] as String?,
  takeLunchBreakBeforeMinute: json['take_lunch_break_before_minute'] as String?,
  totalLunchTime: json['total_lunch_time'] as String?,
  teaBreakStartTimeView: json['tea_break_start_time_view'] as String?,
  teaBreakEndTimeView: json['tea_break_end_time_view'] as String?,
  takeTeaBreakBeforeMinute: json['take_tea_break_before_minute'] as String?,
  totalTeaTime: json['total_tea_time'] as String?,
  halfDayTimeStartView: json['half_day_time_start_view'] as String?,
  halfdayBeforeTimeView: json['halfday_before_time_view'] as String?,
  lateTimeStartView: json['late_time_start_view'] as String?,
  earlyOutTimeView: json['early_out_time_view'] as String?,
  minimumQuarterDayHours: json['minimum_quarter_day_hours'] as String?,
  maximumHalfdayHoursViewTotal:
      json['maximum_halfday_hours_view_total'] as String?,
  minimumHoursForFullDayViewTotal:
      json['minimum_hours_for_full_day_view_total'] as String?,
  minimumThreeQuarterDayHours:
      json['minimum_three_quarter_day_hours'] as String?,
  maxTeaBreak: json['max_tea_break'] as String?,
  maxLunchBreak: json['max_lunch_break'] as String?,
  maxPersonalBreak: json['max_personal_break'] as String?,
  isWeekOff: json['is_week_off'] as bool?,
  lateInTimeStart: json['late_in_time_start'] as String?,
  earlyOutTimeStart: json['early_out_time_start'] as String?,
  lateInPenaltySlab: json['late_in_penalty_slab'] as List<dynamic>?,
);

Map<String, dynamic> _$DayToJson(Day instance) => <String, dynamic>{
  'shift_day_name': instance.shiftDayName,
  'shift_type': instance.shiftType,
  'per_day_hour_view': instance.perDayHourView,
  'shift_start_time_view': instance.shiftStartTimeView,
  'shift_end_time_view': instance.shiftEndTimeView,
  'lunch_break_start_time_view': instance.lunchBreakStartTimeView,
  'lunch_break_end_time_view': instance.lunchBreakEndTimeView,
  'take_lunch_break_before_minute': instance.takeLunchBreakBeforeMinute,
  'total_lunch_time': instance.totalLunchTime,
  'tea_break_start_time_view': instance.teaBreakStartTimeView,
  'tea_break_end_time_view': instance.teaBreakEndTimeView,
  'take_tea_break_before_minute': instance.takeTeaBreakBeforeMinute,
  'total_tea_time': instance.totalTeaTime,
  'half_day_time_start_view': instance.halfDayTimeStartView,
  'halfday_before_time_view': instance.halfdayBeforeTimeView,
  'late_time_start_view': instance.lateTimeStartView,
  'early_out_time_view': instance.earlyOutTimeView,
  'minimum_quarter_day_hours': instance.minimumQuarterDayHours,
  'maximum_halfday_hours_view_total': instance.maximumHalfdayHoursViewTotal,
  'minimum_hours_for_full_day_view_total':
      instance.minimumHoursForFullDayViewTotal,
  'minimum_three_quarter_day_hours': instance.minimumThreeQuarterDayHours,
  'max_tea_break': instance.maxTeaBreak,
  'max_lunch_break': instance.maxLunchBreak,
  'max_personal_break': instance.maxPersonalBreak,
  'is_week_off': instance.isWeekOff,
  'late_in_time_start': instance.lateInTimeStart,
  'early_out_time_start': instance.earlyOutTimeStart,
  'late_in_penalty_slab': instance.lateInPenaltySlab,
};
