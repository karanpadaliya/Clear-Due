import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/shift_details_response_entity.dart';

part 'shift_details_response_model.g.dart';

ShiftDetailsResponseModel shiftDetailsResponseModelFromJson(String str) =>
    ShiftDetailsResponseModel.fromJson(json.decode(str));

String shiftDetailsResponseModelToJson(ShiftDetailsResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ShiftDetailsResponseModel {
  @JsonKey(name: 'has_alternate_shift')
  bool? hasAlternateShift;
  @JsonKey(name: 'alternate_shift_name')
  String? alternateShiftName;
  @JsonKey(name: 'alternate_shift_code')
  String? alternateShiftCode;
  @JsonKey(name: 'alt_shift_time_id')
  String? altShiftTimeId;
  @JsonKey(name: 'rotational_week_shift')
  List<dynamic>? rotationalWeekShift;
  @JsonKey(name: 'shift_roster_details')
  List<dynamic>? shiftRosterDetails;
  @JsonKey(name: 'alt_shifts')
  List<AltShift>? altShifts;
  @JsonKey(name: 'shift_time_id')
  String? shiftTimeId;
  @JsonKey(name: 'shift_name')
  String? shiftName;
  @JsonKey(name: 'shift_code')
  String? shiftCode;
  @JsonKey(name: 'late_in_reason')
  String? lateInReason;
  @JsonKey(name: 'early_out_reason')
  String? earlyOutReason;
  @JsonKey(name: 'is_multiple_punch_in')
  String? isMultiplePunchIn;
  @JsonKey(name: 'take_out_of_range_reason')
  String? takeOutOfRangeReason;
  @JsonKey(name: 'allow_short_leave')
  String? allowShortLeave;
  @JsonKey(name: 'monthly_short_leave')
  String? monthlyShortLeave;
  @JsonKey(name: 'short_leave_apply_type')
  String? shortLeaveApplyType;
  @JsonKey(name: 'short_leave_minutes')
  String? shortLeaveMinutes;
  @JsonKey(name: 'short_leave_buffer_minutes')
  String? shortLeaveBufferMinutes;
  @JsonKey(name: 'sandwich_leave_apply')
  String? sandwichLeaveApply;
  @JsonKey(name: 'late_in_early_out_type')
  String? lateInEarlyOutType;
  @JsonKey(name: 'maximum_in_out')
  String? maximumInOut;
  @JsonKey(name: 'maximum_early_out')
  String? maximumEarlyOut;
  @JsonKey(name: 'week_off_days')
  String? weekOffDays;
  @JsonKey(name: 'has_altenate_week_off')
  String? hasAltenateWeekOff;
  @JsonKey(name: 'alternate_week_off')
  String? alternateWeekOff;
  @JsonKey(name: 'alternate_weekoff_days')
  String? alternateWeekoffDays;
  @JsonKey(name: 'take_breaks_setting')
  String? takeBreaksSetting;
  @JsonKey(name: 'paid_leave_on_extra_day')
  String? paidLeaveOnExtraDay;
  @JsonKey(name: 'extra_day_leave_expire_days')
  String? extraDayLeaveExpireDays;
  @JsonKey(name: 'applicable_extra_day_leaves_in_month')
  String? applicableExtraDayLeavesInMonth;
  @JsonKey(name: 'allow_comp_off_leave_on_past_date')
  String? allowCompOffLeaveOnPastDate;
  @JsonKey(name: 'has_auto_week_off')
  String? hasAutoWeekOff;
  @JsonKey(name: 'auto_week_off_count')
  String? autoWeekOffCount;
  @JsonKey(name: 'dayNamesView')
  String? dayNamesView;
  @JsonKey(name: 'apply_half_day_late_in_exceeded')
  String? applyHalfDayLateInExceeded;
  @JsonKey(name: 'late_in_exceeded_leave_type')
  String? lateInExceededLeaveType;
  @JsonKey(name: 'late_in_early_out_apply_on_extra_day')
  String? lateInEarlyOutApplyOnExtraDay;
  @JsonKey(name: 'apply_holiday_leave')
  String? applyHolidayLeave;
  @JsonKey(name: 'apply_weekoff_leave')
  String? applyWeekoffLeave;
  @JsonKey(name: 'apply_half_day_before_fix_time_out')
  String? applyHalfDayBeforeFixTimeOut;
  @JsonKey(name: 'holiday_penalty_apply')
  String? holidayPenaltyApply;
  @JsonKey(name: 'weekoff_penalty_apply')
  String? weekoffPenaltyApply;
  @JsonKey(name: 'paid_leave_on_extra_hour')
  String? paidLeaveOnExtraHour;
  @JsonKey(name: 'remove_late_in_early_out_on_full_working')
  String? removeLateInEarlyOutOnFullWorking;
  @JsonKey(name: 'remove_break_time_if_not_taken')
  String? removeBreakTimeIfNotTaken;
  @JsonKey(name: 'deduct_full_break_time_if_less_taken')
  String? deductFullBreakTimeIfLessTaken;
  @JsonKey(name: 'minumum_half_hours')
  String? minumumHalfHours;
  @JsonKey(name: 'minumum_full_hours')
  String? minumumFullHours;
  @JsonKey(name: 'calculate_leave_balance')
  String? calculateLeaveBalance;
  @JsonKey(name: 'calculate_leave_balance_after_days')
  String? calculateLeaveBalanceAfterDays;
  @JsonKey(name: 'hours_type_in_shift_clock')
  String? hoursTypeInShiftClock;
  @JsonKey(name: 'penalty_on_absent')
  String? penaltyOnAbsent;
  @JsonKey(name: 'penalty_type_on_absent')
  String? penaltyTypeOnAbsent;
  @JsonKey(name: 'penalty_amount_absent')
  String? penaltyAmountAbsent;
  @JsonKey(name: 'need_ot_request')
  String? needOtRequest;
  @JsonKey(name: 'attendance_calculation_on_productive_hours')
  String? attendanceCalculationOnProductiveHours;
  @JsonKey(name: 'need_ot_request_for_working_days')
  String? needOtRequestForWorkingDays;
  @JsonKey(name: 'holiday_weekoff_penalty_apply')
  String? holidayWeekoffPenaltyApply;
  @JsonKey(name: 'short_leave_days')
  String? shortLeaveDays;
  @JsonKey(name: 'take_break_with_approval_face_app')
  String? takeBreakWithApprovalFaceApp;
  @JsonKey(name: 'take_break_with_approval_employee_app')
  String? takeBreakWithApprovalEmployeeApp;
  @JsonKey(name: 'late_in_penalty')
  bool? lateInPenalty;
  @JsonKey(name: 'next_day_gress_time')
  bool? nextDayGressTime;
  @JsonKey(name: 'next_day_gress_time_slab')
  List<dynamic>? nextDayGressTimeSlab;
  @JsonKey(name: 'days')
  List<Day>? days;
  @JsonKey(name: 'message')
  String? message;

  ShiftDetailsResponseModel({
    this.hasAlternateShift,
    this.alternateShiftName,
    this.alternateShiftCode,
    this.altShiftTimeId,
    this.rotationalWeekShift,
    this.shiftRosterDetails,
    this.altShifts,
    this.shiftTimeId,
    this.shiftName,
    this.shiftCode,
    this.lateInReason,
    this.earlyOutReason,
    this.isMultiplePunchIn,
    this.takeOutOfRangeReason,
    this.allowShortLeave,
    this.monthlyShortLeave,
    this.shortLeaveApplyType,
    this.shortLeaveMinutes,
    this.shortLeaveBufferMinutes,
    this.sandwichLeaveApply,
    this.lateInEarlyOutType,
    this.maximumInOut,
    this.maximumEarlyOut,
    this.weekOffDays,
    this.hasAltenateWeekOff,
    this.alternateWeekOff,
    this.alternateWeekoffDays,
    this.takeBreaksSetting,
    this.paidLeaveOnExtraDay,
    this.extraDayLeaveExpireDays,
    this.applicableExtraDayLeavesInMonth,
    this.allowCompOffLeaveOnPastDate,
    this.hasAutoWeekOff,
    this.autoWeekOffCount,
    this.dayNamesView,
    this.applyHalfDayLateInExceeded,
    this.lateInExceededLeaveType,
    this.lateInEarlyOutApplyOnExtraDay,
    this.applyHolidayLeave,
    this.applyWeekoffLeave,
    this.applyHalfDayBeforeFixTimeOut,
    this.holidayPenaltyApply,
    this.weekoffPenaltyApply,
    this.paidLeaveOnExtraHour,
    this.removeLateInEarlyOutOnFullWorking,
    this.removeBreakTimeIfNotTaken,
    this.deductFullBreakTimeIfLessTaken,
    this.minumumHalfHours,
    this.minumumFullHours,
    this.calculateLeaveBalance,
    this.calculateLeaveBalanceAfterDays,
    this.hoursTypeInShiftClock,
    this.penaltyOnAbsent,
    this.penaltyTypeOnAbsent,
    this.penaltyAmountAbsent,
    this.needOtRequest,
    this.attendanceCalculationOnProductiveHours,
    this.needOtRequestForWorkingDays,
    this.holidayWeekoffPenaltyApply,
    this.shortLeaveDays,
    this.takeBreakWithApprovalFaceApp,
    this.takeBreakWithApprovalEmployeeApp,
    this.lateInPenalty,
    this.nextDayGressTime,
    this.nextDayGressTimeSlab,
    this.days,
    this.message,
  });

  factory ShiftDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ShiftDetailsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftDetailsResponseModelToJson(this);

  ShiftDetailsResponseEntity toEntity() => ShiftDetailsResponseEntity(
    hasAlternateShift: hasAlternateShift,
    alternateShiftName: alternateShiftName,
    alternateShiftCode: alternateShiftCode,
    altShiftTimeId: altShiftTimeId,
    rotationalWeekShift: rotationalWeekShift,
    shiftRosterDetails: shiftRosterDetails,
    altShifts: altShifts?.map((e) => e.toEntity()).toList(),
    shiftTimeId: shiftTimeId,
    shiftName: shiftName,
    shiftCode: shiftCode,
    lateInReason: lateInReason,
    earlyOutReason: earlyOutReason,
    isMultiplePunchIn: isMultiplePunchIn,
    takeOutOfRangeReason: takeOutOfRangeReason,
    allowShortLeave: allowShortLeave,
    monthlyShortLeave: monthlyShortLeave,
    shortLeaveApplyType: shortLeaveApplyType,
    shortLeaveMinutes: shortLeaveMinutes,
    shortLeaveBufferMinutes: shortLeaveBufferMinutes,
    sandwichLeaveApply: sandwichLeaveApply,
    lateInEarlyOutType: lateInEarlyOutType,
    maximumInOut: maximumInOut,
    maximumEarlyOut: maximumEarlyOut,
    weekOffDays: weekOffDays,
    hasAltenateWeekOff: hasAltenateWeekOff,
    alternateWeekOff: alternateWeekOff,
    alternateWeekoffDays: alternateWeekoffDays,
    takeBreaksSetting: takeBreaksSetting,
    paidLeaveOnExtraDay: paidLeaveOnExtraDay,
    extraDayLeaveExpireDays: extraDayLeaveExpireDays,
    applicableExtraDayLeavesInMonth: applicableExtraDayLeavesInMonth,
    allowCompOffLeaveOnPastDate: allowCompOffLeaveOnPastDate,
    hasAutoWeekOff: hasAutoWeekOff,
    autoWeekOffCount: autoWeekOffCount,
    dayNamesView: dayNamesView,
    applyHalfDayLateInExceeded: applyHalfDayLateInExceeded,
    lateInExceededLeaveType: lateInExceededLeaveType,
    lateInEarlyOutApplyOnExtraDay: lateInEarlyOutApplyOnExtraDay,
    applyHolidayLeave: applyHolidayLeave,
    applyWeekoffLeave: applyWeekoffLeave,
    applyHalfDayBeforeFixTimeOut: applyHalfDayBeforeFixTimeOut,
    holidayPenaltyApply: holidayPenaltyApply,
    weekoffPenaltyApply: weekoffPenaltyApply,
    paidLeaveOnExtraHour: paidLeaveOnExtraHour,
    removeLateInEarlyOutOnFullWorking: removeLateInEarlyOutOnFullWorking,
    removeBreakTimeIfNotTaken: removeBreakTimeIfNotTaken,
    deductFullBreakTimeIfLessTaken: deductFullBreakTimeIfLessTaken,
    minumumHalfHours: minumumHalfHours,
    minumumFullHours: minumumFullHours,
    calculateLeaveBalance: calculateLeaveBalance,
    calculateLeaveBalanceAfterDays: calculateLeaveBalanceAfterDays,
    hoursTypeInShiftClock: hoursTypeInShiftClock,
    penaltyOnAbsent: penaltyOnAbsent,
    penaltyTypeOnAbsent: penaltyTypeOnAbsent,
    penaltyAmountAbsent: penaltyAmountAbsent,
    needOtRequest: needOtRequest,
    attendanceCalculationOnProductiveHours:
        attendanceCalculationOnProductiveHours,
    needOtRequestForWorkingDays: needOtRequestForWorkingDays,
    holidayWeekoffPenaltyApply: holidayWeekoffPenaltyApply,
    shortLeaveDays: shortLeaveDays,
    takeBreakWithApprovalFaceApp: takeBreakWithApprovalFaceApp,
    takeBreakWithApprovalEmployeeApp: takeBreakWithApprovalEmployeeApp,
    lateInPenalty: lateInPenalty,
    nextDayGressTime: nextDayGressTime,
    nextDayGressTimeSlab: nextDayGressTimeSlab,
    days: days?.map((e) => e.toEntity()).toList(),
    message: message,
  );
}

@JsonSerializable()
class AltShift {
  @JsonKey(name: 'shift_id')
  String? shiftId;
  @JsonKey(name: 'shift_code')
  String? shiftCode;
  @JsonKey(name: 'shift_name')
  String? shiftName;

  AltShift({this.shiftId, this.shiftCode, this.shiftName});

  factory AltShift.fromJson(Map<String, dynamic> json) =>
      _$AltShiftFromJson(json);

  Map<String, dynamic> toJson() => _$AltShiftToJson(this);

  AltShiftEntity toEntity() => AltShiftEntity(
    shiftId: shiftId,
    shiftCode: shiftCode,
    shiftName: shiftName,
  );
}

@JsonSerializable()
class Day {
  @JsonKey(name: 'shift_day_name')
  String? shiftDayName;
  @JsonKey(name: 'shift_type')
  String? shiftType;
  @JsonKey(name: 'per_day_hour_view')
  String? perDayHourView;
  @JsonKey(name: 'shift_start_time_view')
  String? shiftStartTimeView;
  @JsonKey(name: 'shift_end_time_view')
  String? shiftEndTimeView;
  @JsonKey(name: 'lunch_break_start_time_view')
  String? lunchBreakStartTimeView;
  @JsonKey(name: 'lunch_break_end_time_view')
  String? lunchBreakEndTimeView;
  @JsonKey(name: 'take_lunch_break_before_minute')
  String? takeLunchBreakBeforeMinute;
  @JsonKey(name: 'total_lunch_time')
  String? totalLunchTime;
  @JsonKey(name: 'tea_break_start_time_view')
  String? teaBreakStartTimeView;
  @JsonKey(name: 'tea_break_end_time_view')
  String? teaBreakEndTimeView;
  @JsonKey(name: 'take_tea_break_before_minute')
  String? takeTeaBreakBeforeMinute;
  @JsonKey(name: 'total_tea_time')
  String? totalTeaTime;
  @JsonKey(name: 'half_day_time_start_view')
  String? halfDayTimeStartView;
  @JsonKey(name: 'halfday_before_time_view')
  String? halfdayBeforeTimeView;
  @JsonKey(name: 'late_time_start_view')
  String? lateTimeStartView;
  @JsonKey(name: 'early_out_time_view')
  String? earlyOutTimeView;
  @JsonKey(name: 'minimum_quarter_day_hours')
  String? minimumQuarterDayHours;
  @JsonKey(name: 'maximum_halfday_hours_view_total')
  String? maximumHalfdayHoursViewTotal;
  @JsonKey(name: 'minimum_hours_for_full_day_view_total')
  String? minimumHoursForFullDayViewTotal;
  @JsonKey(name: 'minimum_three_quarter_day_hours')
  String? minimumThreeQuarterDayHours;
  @JsonKey(name: 'max_tea_break')
  String? maxTeaBreak;
  @JsonKey(name: 'max_lunch_break')
  String? maxLunchBreak;
  @JsonKey(name: 'max_personal_break')
  String? maxPersonalBreak;
  @JsonKey(name: 'is_week_off')
  bool? isWeekOff;
  @JsonKey(name: 'late_in_time_start')
  String? lateInTimeStart;
  @JsonKey(name: 'early_out_time_start')
  String? earlyOutTimeStart;
  @JsonKey(name: 'late_in_penalty_slab')
  List<dynamic>? lateInPenaltySlab;

  Day({
    this.shiftDayName,
    this.shiftType,
    this.perDayHourView,
    this.shiftStartTimeView,
    this.shiftEndTimeView,
    this.lunchBreakStartTimeView,
    this.lunchBreakEndTimeView,
    this.takeLunchBreakBeforeMinute,
    this.totalLunchTime,
    this.teaBreakStartTimeView,
    this.teaBreakEndTimeView,
    this.takeTeaBreakBeforeMinute,
    this.totalTeaTime,
    this.halfDayTimeStartView,
    this.halfdayBeforeTimeView,
    this.lateTimeStartView,
    this.earlyOutTimeView,
    this.minimumQuarterDayHours,
    this.maximumHalfdayHoursViewTotal,
    this.minimumHoursForFullDayViewTotal,
    this.minimumThreeQuarterDayHours,
    this.maxTeaBreak,
    this.maxLunchBreak,
    this.maxPersonalBreak,
    this.isWeekOff,
    this.lateInTimeStart,
    this.earlyOutTimeStart,
    this.lateInPenaltySlab,
  });

  factory Day.fromJson(Map<String, dynamic> json) => _$DayFromJson(json);

  Map<String, dynamic> toJson() => _$DayToJson(this);

  DayEntity toEntity() => DayEntity(
    shiftDayName: shiftDayName,
    shiftType: shiftType,
    perDayHourView: perDayHourView,
    shiftStartTimeView: shiftStartTimeView,
    shiftEndTimeView: shiftEndTimeView,
    lunchBreakStartTimeView: lunchBreakStartTimeView,
    lunchBreakEndTimeView: lunchBreakEndTimeView,
    takeLunchBreakBeforeMinute: takeLunchBreakBeforeMinute,
    totalLunchTime: totalLunchTime,
    teaBreakStartTimeView: teaBreakStartTimeView,
    teaBreakEndTimeView: teaBreakEndTimeView,
    takeTeaBreakBeforeMinute: takeTeaBreakBeforeMinute,
    totalTeaTime: totalTeaTime,
    halfDayTimeStartView: halfDayTimeStartView,
    halfdayBeforeTimeView: halfdayBeforeTimeView,
    lateTimeStartView: lateTimeStartView,
    earlyOutTimeView: earlyOutTimeView,
    minimumQuarterDayHours: minimumQuarterDayHours,
    maximumHalfdayHoursViewTotal: maximumHalfdayHoursViewTotal,
    minimumHoursForFullDayViewTotal: minimumHoursForFullDayViewTotal,
    minimumThreeQuarterDayHours: minimumThreeQuarterDayHours,
    maxTeaBreak: maxTeaBreak,
    maxLunchBreak: maxLunchBreak,
    maxPersonalBreak: maxPersonalBreak,
    isWeekOff: isWeekOff,
    lateInTimeStart: lateInTimeStart,
    earlyOutTimeStart: earlyOutTimeStart,
    lateInPenaltySlab: lateInPenaltySlab,
  );
}
