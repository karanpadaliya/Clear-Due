import 'package:equatable/equatable.dart';

class ShiftDetailsResponseEntity extends Equatable {
  final bool? hasAlternateShift;
  final String? alternateShiftName;
  final String? alternateShiftCode;
  final String? altShiftTimeId;
  final List<dynamic>? rotationalWeekShift;
  final List<dynamic>? shiftRosterDetails;
  final List<AltShiftEntity>? altShifts;
  final String? shiftTimeId;
  final String? shiftName;
  final String? shiftCode;

  final String? lateInReason;
  final String? earlyOutReason;
  final String? isMultiplePunchIn;
  final String? takeOutOfRangeReason;
  final String? allowShortLeave;
  final String? monthlyShortLeave;
  final String? shortLeaveApplyType;
  final String? shortLeaveMinutes;
  final String? shortLeaveBufferMinutes;
  final String? sandwichLeaveApply;
  final String? lateInEarlyOutType;
  final String? maximumInOut;
  final String? maximumEarlyOut;
  final String? weekOffDays;
  final String? hasAltenateWeekOff;
  final String? alternateWeekOff;
  final String? alternateWeekoffDays;
  final String? takeBreaksSetting;
  final String? paidLeaveOnExtraDay;
  final String? extraDayLeaveExpireDays;
  final String? applicableExtraDayLeavesInMonth;
  final String? allowCompOffLeaveOnPastDate;
  final String? hasAutoWeekOff;
  final String? autoWeekOffCount;
  final String? dayNamesView;
  final String? applyHalfDayLateInExceeded;
  final String? lateInExceededLeaveType;
  final String? lateInEarlyOutApplyOnExtraDay;
  final String? applyHolidayLeave;
  final String? applyWeekoffLeave;
  final String? applyHalfDayBeforeFixTimeOut;
  final String? holidayPenaltyApply;
  final String? weekoffPenaltyApply;
  final String? paidLeaveOnExtraHour;
  final String? removeLateInEarlyOutOnFullWorking;
  final String? removeBreakTimeIfNotTaken;
  final String? deductFullBreakTimeIfLessTaken;
  final String? minumumHalfHours;
  final String? minumumFullHours;
  final String? calculateLeaveBalance;
  final String? calculateLeaveBalanceAfterDays;
  final String? hoursTypeInShiftClock;
  final String? penaltyOnAbsent;
  final String? penaltyTypeOnAbsent;
  final String? penaltyAmountAbsent;
  final String? needOtRequest;
  final String? attendanceCalculationOnProductiveHours;
  final String? needOtRequestForWorkingDays;
  final String? holidayWeekoffPenaltyApply;
  final String? shortLeaveDays;
  final String? takeBreakWithApprovalFaceApp;
  final String? takeBreakWithApprovalEmployeeApp;
  final bool? lateInPenalty;
  final bool? nextDayGressTime;
  final List<dynamic>? nextDayGressTimeSlab;
  final List<DayEntity>? days;
  final String? message;

  const ShiftDetailsResponseEntity({
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

  @override
  List<Object?> get props => [
    hasAlternateShift,
    alternateShiftName,
    alternateShiftCode,
    altShiftTimeId,
    rotationalWeekShift,
    shiftRosterDetails,
    altShifts,
    shiftTimeId,
    shiftName,
    shiftCode,
    lateInReason,
    earlyOutReason,
    isMultiplePunchIn,
    takeOutOfRangeReason,
    allowShortLeave,
    monthlyShortLeave,
    shortLeaveApplyType,
    shortLeaveMinutes,
    shortLeaveBufferMinutes,
    sandwichLeaveApply,
    lateInEarlyOutType,
    maximumInOut,
    maximumEarlyOut,
    weekOffDays,
    hasAltenateWeekOff,
    alternateWeekOff,
    alternateWeekoffDays,
    takeBreaksSetting,
    paidLeaveOnExtraDay,
    extraDayLeaveExpireDays,
    applicableExtraDayLeavesInMonth,
    allowCompOffLeaveOnPastDate,
    hasAutoWeekOff,
    autoWeekOffCount,
    dayNamesView,
    applyHalfDayLateInExceeded,
    lateInExceededLeaveType,
    lateInEarlyOutApplyOnExtraDay,
    applyHolidayLeave,
    applyWeekoffLeave,
    applyHalfDayBeforeFixTimeOut,
    holidayPenaltyApply,
    weekoffPenaltyApply,
    paidLeaveOnExtraHour,
    removeLateInEarlyOutOnFullWorking,
    removeBreakTimeIfNotTaken,
    deductFullBreakTimeIfLessTaken,
    minumumHalfHours,
    minumumFullHours,
    calculateLeaveBalance,
    calculateLeaveBalanceAfterDays,
    hoursTypeInShiftClock,
    penaltyOnAbsent,
    penaltyTypeOnAbsent,
    penaltyAmountAbsent,
    needOtRequest,
    attendanceCalculationOnProductiveHours,
    needOtRequestForWorkingDays,
    holidayWeekoffPenaltyApply,
    shortLeaveDays,
    takeBreakWithApprovalFaceApp,
    takeBreakWithApprovalEmployeeApp,
    lateInPenalty,
    nextDayGressTime,
    nextDayGressTimeSlab,
    days,
    message,
  ];
}

class AltShiftEntity extends Equatable {
  final String? shiftId;
  final String? shiftCode;
  final String? shiftName;

  const AltShiftEntity({this.shiftId, this.shiftCode, this.shiftName});

  @override
  List<Object?> get props => [shiftId, shiftCode, shiftName];
}

class DayEntity extends Equatable {
  final String? shiftDayName;
  final String? shiftType;
  final String? perDayHourView;
  final String? shiftStartTimeView;
  final String? shiftEndTimeView;
  final String? lunchBreakStartTimeView;
  final String? lunchBreakEndTimeView;
  final String? takeLunchBreakBeforeMinute;
  final String? totalLunchTime;
  final String? teaBreakStartTimeView;
  final String? teaBreakEndTimeView;
  final String? takeTeaBreakBeforeMinute;
  final String? totalTeaTime;
  final String? halfDayTimeStartView;
  final String? halfdayBeforeTimeView;
  final String? lateTimeStartView;
  final String? earlyOutTimeView;
  final String? minimumQuarterDayHours;
  final String? maximumHalfdayHoursViewTotal;
  final String? minimumHoursForFullDayViewTotal;
  final String? minimumThreeQuarterDayHours;
  final String? maxTeaBreak;
  final String? maxLunchBreak;
  final String? maxPersonalBreak;
  final bool? isWeekOff;
  final String? lateInTimeStart;
  final String? earlyOutTimeStart;
  final List<dynamic>? lateInPenaltySlab;

  const DayEntity({
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

  @override
  List<Object?> get props => [
    shiftDayName,
    shiftType,
    perDayHourView,
    shiftStartTimeView,
    shiftEndTimeView,
    lunchBreakStartTimeView,
    lunchBreakEndTimeView,
    takeLunchBreakBeforeMinute,
    totalLunchTime,
    teaBreakStartTimeView,
    teaBreakEndTimeView,
    takeTeaBreakBeforeMinute,
    totalTeaTime,
    halfDayTimeStartView,
    halfdayBeforeTimeView,
    lateTimeStartView,
    earlyOutTimeView,
    minimumQuarterDayHours,
    maximumHalfdayHoursViewTotal,
    minimumHoursForFullDayViewTotal,
    minimumThreeQuarterDayHours,
    maxTeaBreak,
    maxLunchBreak,
    maxPersonalBreak,
    isWeekOff,
    lateInTimeStart,
    earlyOutTimeStart,
    lateInPenaltySlab,
  ];
}
