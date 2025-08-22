// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_data_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShiftDataResponseAdapter extends TypeAdapter<ShiftDataResponse> {
  @override
  final int typeId = 12;

  @override
  ShiftDataResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShiftDataResponse(
      shiftName: fields[0] as String?,
      shiftCode: fields[1] as String?,
      shiftTimeId: fields[2] as String?,
      totalMinutesLunch: fields[3] as String?,
      totalMinutestea: fields[4] as String?,
      perDayHour: fields[5] as String?,
      shiftStartTime: fields[6] as String?,
      shiftEndTime: fields[7] as String?,
      lunchBreakStartTime: fields[8] as String?,
      lunchBreakEndTime: fields[9] as String?,
      teaBreakStartTime: fields[10] as String?,
      teaBreakEndTime: fields[11] as String?,
      weekOffDays: fields[12] as String?,
      halfDayTimeStart: fields[13] as String?,
      halfdayBeforeTime: fields[14] as String?,
      lateTimeStart: fields[15] as String?,
      maximumInOut: fields[16] as String?,
      dayNamesView: fields[17] as String?,
      earlyOutTime: fields[18] as String?,
      lateInReason: fields[19] as String?,
      earlyOutReason: fields[20] as String?,
      hasAltenateWeekOff: fields[21] as String?,
      alternateWeekOff: fields[22] as String?,
      alternateWeekoffDays: fields[23] as String?,
      shiftType: fields[24] as String?,
      maximumHalfdayHours: fields[25] as String?,
      minimumHoursForFullDay: fields[26] as String?,
      perDayHourView: fields[27] as String?,
      shiftStartTimeView: fields[28] as String?,
      shiftEndTimeView: fields[29] as String?,
      lunchBreakStartTimeView: fields[30] as String?,
      lunchBreakEndTimeView: fields[31] as String?,
      totalLunchTime: fields[32] as String?,
      teaBreakStartTimeView: fields[33] as String?,
      teaBreakEndTimeView: fields[34] as String?,
      totalTeaTime: fields[35] as String?,
      halfDayTimeStartView: fields[36] as String?,
      halfdayBeforeTimeView: fields[37] as String?,
      lateTimeStartView: fields[38] as String?,
      earlyOutTimeView: fields[39] as String?,
      maximumHalfdayHoursView: fields[40] as String?,
      maximumHalfdayHoursViewTotal: fields[41] as String?,
      minimumHoursForFullDayView: fields[42] as String?,
      minimumHoursForFullDayViewTotal: fields[43] as String?,
      message: fields[44] as String?,
      status: fields[45] as String?,
      shiftTimeZone: fields[46] as String?,
      lateTimeStartMinutes: fields[47] as String?,
      earlyOutTimeMinutes: fields[48] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ShiftDataResponse obj) {
    writer
      ..writeByte(49)
      ..writeByte(0)
      ..write(obj.shiftName)
      ..writeByte(1)
      ..write(obj.shiftCode)
      ..writeByte(2)
      ..write(obj.shiftTimeId)
      ..writeByte(3)
      ..write(obj.totalMinutesLunch)
      ..writeByte(4)
      ..write(obj.totalMinutestea)
      ..writeByte(5)
      ..write(obj.perDayHour)
      ..writeByte(6)
      ..write(obj.shiftStartTime)
      ..writeByte(7)
      ..write(obj.shiftEndTime)
      ..writeByte(8)
      ..write(obj.lunchBreakStartTime)
      ..writeByte(9)
      ..write(obj.lunchBreakEndTime)
      ..writeByte(10)
      ..write(obj.teaBreakStartTime)
      ..writeByte(11)
      ..write(obj.teaBreakEndTime)
      ..writeByte(12)
      ..write(obj.weekOffDays)
      ..writeByte(13)
      ..write(obj.halfDayTimeStart)
      ..writeByte(14)
      ..write(obj.halfdayBeforeTime)
      ..writeByte(15)
      ..write(obj.lateTimeStart)
      ..writeByte(16)
      ..write(obj.maximumInOut)
      ..writeByte(17)
      ..write(obj.dayNamesView)
      ..writeByte(18)
      ..write(obj.earlyOutTime)
      ..writeByte(19)
      ..write(obj.lateInReason)
      ..writeByte(20)
      ..write(obj.earlyOutReason)
      ..writeByte(21)
      ..write(obj.hasAltenateWeekOff)
      ..writeByte(22)
      ..write(obj.alternateWeekOff)
      ..writeByte(23)
      ..write(obj.alternateWeekoffDays)
      ..writeByte(24)
      ..write(obj.shiftType)
      ..writeByte(25)
      ..write(obj.maximumHalfdayHours)
      ..writeByte(26)
      ..write(obj.minimumHoursForFullDay)
      ..writeByte(27)
      ..write(obj.perDayHourView)
      ..writeByte(28)
      ..write(obj.shiftStartTimeView)
      ..writeByte(29)
      ..write(obj.shiftEndTimeView)
      ..writeByte(30)
      ..write(obj.lunchBreakStartTimeView)
      ..writeByte(31)
      ..write(obj.lunchBreakEndTimeView)
      ..writeByte(32)
      ..write(obj.totalLunchTime)
      ..writeByte(33)
      ..write(obj.teaBreakStartTimeView)
      ..writeByte(34)
      ..write(obj.teaBreakEndTimeView)
      ..writeByte(35)
      ..write(obj.totalTeaTime)
      ..writeByte(36)
      ..write(obj.halfDayTimeStartView)
      ..writeByte(37)
      ..write(obj.halfdayBeforeTimeView)
      ..writeByte(38)
      ..write(obj.lateTimeStartView)
      ..writeByte(39)
      ..write(obj.earlyOutTimeView)
      ..writeByte(40)
      ..write(obj.maximumHalfdayHoursView)
      ..writeByte(41)
      ..write(obj.maximumHalfdayHoursViewTotal)
      ..writeByte(42)
      ..write(obj.minimumHoursForFullDayView)
      ..writeByte(43)
      ..write(obj.minimumHoursForFullDayViewTotal)
      ..writeByte(44)
      ..write(obj.message)
      ..writeByte(45)
      ..write(obj.status)
      ..writeByte(46)
      ..write(obj.shiftTimeZone)
      ..writeByte(47)
      ..write(obj.lateTimeStartMinutes)
      ..writeByte(48)
      ..write(obj.earlyOutTimeMinutes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShiftDataResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShiftDataResponse _$ShiftDataResponseFromJson(Map<String, dynamic> json) =>
    ShiftDataResponse(
      shiftName: json['shift_name'] as String?,
      shiftCode: json['shift_code'] as String?,
      shiftTimeId: json['shift_time_id'] as String?,
      totalMinutesLunch: json['total_minutes_lunch'] as String?,
      totalMinutestea: json['total_minutes_tea'] as String?,
      perDayHour: json['per_day_hour'] as String?,
      shiftStartTime: json['shift_start_time'] as String?,
      shiftEndTime: json['shift_end_time'] as String?,
      lunchBreakStartTime: json['lunch_break_start_time'] as String?,
      lunchBreakEndTime: json['lunch_break_end_time'] as String?,
      teaBreakStartTime: json['tea_break_start_time'] as String?,
      teaBreakEndTime: json['tea_break_end_time'] as String?,
      weekOffDays: json['week_off_days'] as String?,
      halfDayTimeStart: json['half_day_time_start'] as String?,
      halfdayBeforeTime: json['halfday_before_time'] as String?,
      lateTimeStart: json['late_time_start'] as String?,
      maximumInOut: json['maximum_in_out'] as String?,
      dayNamesView: json['dayNamesView'] as String?,
      earlyOutTime: json['early_out_time'] as String?,
      lateInReason: json['late_in_reason'] as String?,
      earlyOutReason: json['early_out_reason'] as String?,
      hasAltenateWeekOff: json['has_altenate_week_off'] as String?,
      alternateWeekOff: json['alternate_week_off'] as String?,
      alternateWeekoffDays: json['alternate_weekoff_days'] as String?,
      shiftType: json['shift_type'] as String?,
      maximumHalfdayHours: json['maximum_halfday_hours'] as String?,
      minimumHoursForFullDay: json['minimum_hours_for_full_day'] as String?,
      perDayHourView: json['per_day_hour_view'] as String?,
      shiftStartTimeView: json['shift_start_time_view'] as String?,
      shiftEndTimeView: json['shift_end_time_view'] as String?,
      lunchBreakStartTimeView: json['lunch_break_start_time_view'] as String?,
      lunchBreakEndTimeView: json['lunch_break_end_time_view'] as String?,
      totalLunchTime: json['total_lunch_time'] as String?,
      teaBreakStartTimeView: json['tea_break_start_time_view'] as String?,
      teaBreakEndTimeView: json['tea_break_end_time_view'] as String?,
      totalTeaTime: json['total_tea_time'] as String?,
      halfDayTimeStartView: json['half_day_time_start_view'] as String?,
      halfdayBeforeTimeView: json['halfday_before_time_view'] as String?,
      lateTimeStartView: json['late_time_start_view'] as String?,
      earlyOutTimeView: json['early_out_time_view'] as String?,
      maximumHalfdayHoursView: json['maximum_halfday_hours_view'] as String?,
      maximumHalfdayHoursViewTotal:
          json['maximum_halfday_hours_view_total'] as String?,
      minimumHoursForFullDayView:
          json['minimum_hours_for_full_day_view'] as String?,
      minimumHoursForFullDayViewTotal:
          json['minimum_hours_for_full_day_view_total'] as String?,
      message: json['message'] as String?,
      status: json['status'] as String?,
      shiftTimeZone: json['shift_time_zone'] as String?,
      lateTimeStartMinutes: json['late_time_start_minutes'] as String?,
      earlyOutTimeMinutes: json['early_out_time_minutes'] as String?,
    );

Map<String, dynamic> _$ShiftDataResponseToJson(ShiftDataResponse instance) =>
    <String, dynamic>{
      'shift_name': instance.shiftName,
      'shift_code': instance.shiftCode,
      'shift_time_id': instance.shiftTimeId,
      'total_minutes_lunch': instance.totalMinutesLunch,
      'total_minutes_tea': instance.totalMinutestea,
      'per_day_hour': instance.perDayHour,
      'shift_start_time': instance.shiftStartTime,
      'shift_end_time': instance.shiftEndTime,
      'lunch_break_start_time': instance.lunchBreakStartTime,
      'lunch_break_end_time': instance.lunchBreakEndTime,
      'tea_break_start_time': instance.teaBreakStartTime,
      'tea_break_end_time': instance.teaBreakEndTime,
      'week_off_days': instance.weekOffDays,
      'half_day_time_start': instance.halfDayTimeStart,
      'halfday_before_time': instance.halfdayBeforeTime,
      'late_time_start': instance.lateTimeStart,
      'maximum_in_out': instance.maximumInOut,
      'dayNamesView': instance.dayNamesView,
      'early_out_time': instance.earlyOutTime,
      'late_in_reason': instance.lateInReason,
      'early_out_reason': instance.earlyOutReason,
      'has_altenate_week_off': instance.hasAltenateWeekOff,
      'alternate_week_off': instance.alternateWeekOff,
      'alternate_weekoff_days': instance.alternateWeekoffDays,
      'shift_type': instance.shiftType,
      'maximum_halfday_hours': instance.maximumHalfdayHours,
      'minimum_hours_for_full_day': instance.minimumHoursForFullDay,
      'per_day_hour_view': instance.perDayHourView,
      'shift_start_time_view': instance.shiftStartTimeView,
      'shift_end_time_view': instance.shiftEndTimeView,
      'lunch_break_start_time_view': instance.lunchBreakStartTimeView,
      'lunch_break_end_time_view': instance.lunchBreakEndTimeView,
      'total_lunch_time': instance.totalLunchTime,
      'tea_break_start_time_view': instance.teaBreakStartTimeView,
      'tea_break_end_time_view': instance.teaBreakEndTimeView,
      'total_tea_time': instance.totalTeaTime,
      'half_day_time_start_view': instance.halfDayTimeStartView,
      'halfday_before_time_view': instance.halfdayBeforeTimeView,
      'late_time_start_view': instance.lateTimeStartView,
      'early_out_time_view': instance.earlyOutTimeView,
      'maximum_halfday_hours_view': instance.maximumHalfdayHoursView,
      'maximum_halfday_hours_view_total': instance.maximumHalfdayHoursViewTotal,
      'minimum_hours_for_full_day_view': instance.minimumHoursForFullDayView,
      'minimum_hours_for_full_day_view_total':
          instance.minimumHoursForFullDayViewTotal,
      'message': instance.message,
      'status': instance.status,
      'shift_time_zone': instance.shiftTimeZone,
      'late_time_start_minutes': instance.lateTimeStartMinutes,
      'early_out_time_minutes': instance.earlyOutTimeMinutes,
    };
