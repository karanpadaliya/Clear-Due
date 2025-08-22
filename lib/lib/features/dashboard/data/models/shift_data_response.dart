import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/shift_data_response_entity.dart';

part 'shift_data_response.g.dart';

ShiftDataResponse shiftDataResponseFromJson(String str) => ShiftDataResponse.fromJson(json.decode(str));

String shiftDataResponseToJson(ShiftDataResponse data) => json.encode(data.toJson());

@HiveType(typeId: 12) // Assign a new unique typeId
@JsonSerializable()
class ShiftDataResponse {
  @HiveField(0)
  @JsonKey(name: "shift_name")
  String? shiftName;
  @HiveField(1)
  @JsonKey(name: "shift_code")
  String? shiftCode;
  @HiveField(2)
  @JsonKey(name: "shift_time_id")
  String? shiftTimeId;
  @HiveField(3)
  @JsonKey(name: "total_minutes_lunch")
  String? totalMinutesLunch;
  @HiveField(4)
  @JsonKey(name: "total_minutes_tea")
  String? totalMinutestea;
  @HiveField(5)
  @JsonKey(name: "per_day_hour")
  String? perDayHour;
  @HiveField(6)
  @JsonKey(name: "shift_start_time")
  String? shiftStartTime;
  @HiveField(7)
  @JsonKey(name: "shift_end_time")
  String? shiftEndTime;
  @HiveField(8)
  @JsonKey(name: "lunch_break_start_time")
  String? lunchBreakStartTime;
  @HiveField(9)
  @JsonKey(name: "lunch_break_end_time")
  String? lunchBreakEndTime;
  @HiveField(10)
  @JsonKey(name: "tea_break_start_time")
  String? teaBreakStartTime;
  @HiveField(11)
  @JsonKey(name: "tea_break_end_time")
  String? teaBreakEndTime;
  @HiveField(12)
  @JsonKey(name: "week_off_days")
  String? weekOffDays;
  @HiveField(13)
  @JsonKey(name: "half_day_time_start")
  String? halfDayTimeStart;
  @HiveField(14)
  @JsonKey(name: "halfday_before_time")
  String? halfdayBeforeTime;
  @HiveField(15)
  @JsonKey(name: "late_time_start")
  String? lateTimeStart;
  @HiveField(16)
  @JsonKey(name: "maximum_in_out")
  String? maximumInOut;
  @HiveField(17)
  @JsonKey(name: "dayNamesView")
  String? dayNamesView;
  @HiveField(18)
  @JsonKey(name: "early_out_time")
  String? earlyOutTime;
  @HiveField(19)
  @JsonKey(name: "late_in_reason")
  String? lateInReason;
  @HiveField(20)
  @JsonKey(name: "early_out_reason")
  String? earlyOutReason;
  @HiveField(21)
  @JsonKey(name: "has_altenate_week_off")
  String? hasAltenateWeekOff;
  @HiveField(22)
  @JsonKey(name: "alternate_week_off")
  String? alternateWeekOff;
  @HiveField(23)
  @JsonKey(name: "alternate_weekoff_days")
  String? alternateWeekoffDays;
  @HiveField(24)
  @JsonKey(name: "shift_type")
  String? shiftType;
  @HiveField(25)
  @JsonKey(name: "maximum_halfday_hours")
  String? maximumHalfdayHours;
  @HiveField(26)
  @JsonKey(name: "minimum_hours_for_full_day")
  String? minimumHoursForFullDay;
  @HiveField(27)
  @JsonKey(name: "per_day_hour_view")
  String? perDayHourView;
  @HiveField(28)
  @JsonKey(name: "shift_start_time_view")
  String? shiftStartTimeView;
  @HiveField(29)
  @JsonKey(name: "shift_end_time_view")
  String? shiftEndTimeView;
  @HiveField(30)
  @JsonKey(name: "lunch_break_start_time_view")
  String? lunchBreakStartTimeView;
  @HiveField(31)
  @JsonKey(name: "lunch_break_end_time_view")
  String? lunchBreakEndTimeView;
  @HiveField(32)
  @JsonKey(name: "total_lunch_time")
  String? totalLunchTime;
  @HiveField(33)
  @JsonKey(name: "tea_break_start_time_view")
  String? teaBreakStartTimeView;
  @HiveField(34)
  @JsonKey(name: "tea_break_end_time_view")
  String? teaBreakEndTimeView;
  @HiveField(35)
  @JsonKey(name: "total_tea_time")
  String? totalTeaTime;
  @HiveField(36)
  @JsonKey(name: "half_day_time_start_view")
  String? halfDayTimeStartView;
  @HiveField(37)
  @JsonKey(name: "halfday_before_time_view")
  String? halfdayBeforeTimeView;
  @HiveField(38)
  @JsonKey(name: "late_time_start_view")
  String? lateTimeStartView;
  @HiveField(39)
  @JsonKey(name: "early_out_time_view")
  String? earlyOutTimeView;
  @HiveField(40)
  @JsonKey(name: "maximum_halfday_hours_view")
  String? maximumHalfdayHoursView;
  @HiveField(41)
  @JsonKey(name: "maximum_halfday_hours_view_total")
  String? maximumHalfdayHoursViewTotal;
  @HiveField(42)
  @JsonKey(name: "minimum_hours_for_full_day_view")
  String? minimumHoursForFullDayView;
  @HiveField(43)
  @JsonKey(name: "minimum_hours_for_full_day_view_total")
  String? minimumHoursForFullDayViewTotal;
  @HiveField(44)
  @JsonKey(name: "message")
  String? message;
  @HiveField(45)
  @JsonKey(name: "status")
  String? status;
  @HiveField(46)
  @JsonKey(name: "shift_time_zone")
  String? shiftTimeZone;
  @HiveField(47)
  @JsonKey(name: "late_time_start_minutes")
  String? lateTimeStartMinutes;
  @HiveField(48)
  @JsonKey(name: "early_out_time_minutes")
  String? earlyOutTimeMinutes;

  ShiftDataResponse({
    this.shiftName,
    this.shiftCode,
    this.shiftTimeId,
    this.totalMinutesLunch,
    this.totalMinutestea,
    this.perDayHour,
    this.shiftStartTime,
    this.shiftEndTime,
    this.lunchBreakStartTime,
    this.lunchBreakEndTime,
    this.teaBreakStartTime,
    this.teaBreakEndTime,
    this.weekOffDays,
    this.halfDayTimeStart,
    this.halfdayBeforeTime,
    this.lateTimeStart,
    this.maximumInOut,
    this.dayNamesView,
    this.earlyOutTime,
    this.lateInReason,
    this.earlyOutReason,
    this.hasAltenateWeekOff,
    this.alternateWeekOff,
    this.alternateWeekoffDays,
    this.shiftType,
    this.maximumHalfdayHours,
    this.minimumHoursForFullDay,
    this.perDayHourView,
    this.shiftStartTimeView,
    this.shiftEndTimeView,
    this.lunchBreakStartTimeView,
    this.lunchBreakEndTimeView,
    this.totalLunchTime,
    this.teaBreakStartTimeView,
    this.teaBreakEndTimeView,
    this.totalTeaTime,
    this.halfDayTimeStartView,
    this.halfdayBeforeTimeView,
    this.lateTimeStartView,
    this.earlyOutTimeView,
    this.maximumHalfdayHoursView,
    this.maximumHalfdayHoursViewTotal,
    this.minimumHoursForFullDayView,
    this.minimumHoursForFullDayViewTotal,
    this.message,
    this.status,
    this.shiftTimeZone,
    this.lateTimeStartMinutes,
    this.earlyOutTimeMinutes,
  });

  factory ShiftDataResponse.fromJson(Map<String, dynamic> json) => _$ShiftDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftDataResponseToJson(this);

  ShiftDataResponseEntity toEntity() => ShiftDataResponseEntity(
    shiftName: shiftName,
    shiftCode: shiftCode,
    shiftTimeId: shiftTimeId,
    totalMinutesLunch: totalMinutesLunch,
    totalMinutestea: totalMinutestea,
    perDayHour: perDayHour,
    shiftStartTime: shiftStartTime,
    shiftEndTime: shiftEndTime,
    lunchBreakStartTime: lunchBreakStartTime,
    lunchBreakEndTime: lunchBreakEndTime,
    teaBreakStartTime: teaBreakStartTime,
    teaBreakEndTime: teaBreakEndTime,
    weekOffDays: weekOffDays,
    halfDayTimeStart: halfDayTimeStart,
    halfdayBeforeTime: halfdayBeforeTime,
    lateTimeStart: lateTimeStart,
    maximumInOut: maximumInOut,
    dayNamesView: dayNamesView,
    earlyOutTime: earlyOutTime,
    lateInReason: lateInReason,
    earlyOutReason: earlyOutReason,
    hasAltenateWeekOff: hasAltenateWeekOff,
    alternateWeekOff: alternateWeekOff,
    alternateWeekoffDays: alternateWeekoffDays,
    shiftType: shiftType,
    maximumHalfdayHours: maximumHalfdayHours,
    minimumHoursForFullDay: minimumHoursForFullDay,
    perDayHourView: perDayHourView,
    shiftStartTimeView: shiftStartTimeView,
    shiftEndTimeView: shiftEndTimeView,
    lunchBreakStartTimeView: lunchBreakStartTimeView,
    lunchBreakEndTimeView: lunchBreakEndTimeView,
    totalLunchTime: totalLunchTime,
    teaBreakStartTimeView: teaBreakStartTimeView,
    teaBreakEndTimeView: teaBreakEndTimeView,
    totalTeaTime: totalTeaTime,
    halfDayTimeStartView: halfDayTimeStartView,
    halfdayBeforeTimeView: halfdayBeforeTimeView,
    lateTimeStartView: lateTimeStartView,
    earlyOutTimeView: earlyOutTimeView,
    maximumHalfdayHoursView: maximumHalfdayHoursView,
    maximumHalfdayHoursViewTotal: maximumHalfdayHoursViewTotal,
    minimumHoursForFullDayView: minimumHoursForFullDayView,
    minimumHoursForFullDayViewTotal: minimumHoursForFullDayViewTotal,
    message: message,
    status: status,
    shiftTimeZone: shiftTimeZone,
    lateTimeStartMinutes: lateTimeStartMinutes,
    earlyOutTimeMinutes: earlyOutTimeMinutes,
  );
}