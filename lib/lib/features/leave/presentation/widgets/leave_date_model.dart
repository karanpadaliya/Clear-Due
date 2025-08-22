// lib/features/leave/presentation/widgets/leave_date_model.dart

import 'package:myco_flutter/features/leave/data/model/leave_calendar_response_model.dart';

class LeaveDateModel {
   String selectedDate;
   String? selectedDateDay;
   String? leaveTypeId;
   String? leaveTypeName;
   String normalHolidayWeek;
   String specialLeave;
   String leaveReason;
   double totalAlreadyLeaveApplied;
   double leavePercentage;

   bool isAttachmentRequired;
   bool isSandwichLeave;
   bool unpaidLimitReached;

   MonthlyHistoryEntity? monthlyHistory;

  bool isSelected;
  bool isPaidLeave;
  bool isFullDay;
  bool isUnpaidRestrictionON;
  bool isPastDateAllowed;
  bool isPastDateConditionTrue;
  bool takeQuarterLeave;
  bool changedSelection;

  String leaveDayTypeTemp;
  String halfDaySession;
  String weekOffHoliday;
  String extraDataInfo;

  LeaveDateModel({
    required this.selectedDate,
    this.selectedDateDay,
    this.leaveTypeId,
    this.leaveTypeName,
    this.normalHolidayWeek = '',
    this.specialLeave = '0',
    this.leaveReason = '',
    this.totalAlreadyLeaveApplied = 0,
    this.leavePercentage = 100,
    this.isSelected = false,
    this.isPaidLeave = false,
    this.isFullDay = true,
    this.isUnpaidRestrictionON = false,
    this.isPastDateAllowed = true,
    this.isPastDateConditionTrue = false,
    this.takeQuarterLeave = true,
    this.changedSelection = false,
    this.leaveDayTypeTemp = '0',
    this.halfDaySession = '0',
    this.weekOffHoliday = '',
    this.extraDataInfo = '',
    this.isAttachmentRequired = false,
    this.isSandwichLeave = false,
    this.unpaidLimitReached = false,
    this.monthlyHistory,
  });

  LeaveDateModel copyWith({
    String? selectedDate,
    String? selectedDateDay,
    String? leaveTypeId,
    String? leaveTypeName,
    String? normalHolidayWeek,
    String? specialLeave,
    String? leaveReason,
    double? totalAlreadyLeaveApplied,
    double? leavePercentage,
    bool? isSelected,
    bool? isPaidLeave,
    bool? isFullDay,
    bool? isUnpaidRestrictionON,
    bool? isPastDateAllowed,
    bool? isPastDateConditionTrue,
    bool? takeQuarterLeave,
    bool? changedSelection,
    String? leaveDayTypeTemp,
    String? halfDaySession,
    String? weekOffHoliday,
    String? extraDataInfo,
    bool? isAttachmentRequired,
    bool? isSandwichLeave,
    bool? unpaidLimitReached,
    MonthlyHistoryEntity? monthlyHistory,
  }) => LeaveDateModel(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedDateDay: selectedDateDay ?? this.selectedDateDay,
      leaveTypeId: leaveTypeId ?? this.leaveTypeId,
      leaveTypeName: leaveTypeName ?? this.leaveTypeName,
      normalHolidayWeek: normalHolidayWeek ?? this.normalHolidayWeek,
      specialLeave: specialLeave ?? this.specialLeave,
      leaveReason: leaveReason ?? this.leaveReason,
      totalAlreadyLeaveApplied: totalAlreadyLeaveApplied ?? this.totalAlreadyLeaveApplied,
      leavePercentage: leavePercentage ?? this.leavePercentage,
      isSelected: isSelected ?? this.isSelected,
      isPaidLeave: isPaidLeave ?? this.isPaidLeave,
      isFullDay: isFullDay ?? this.isFullDay,
      isUnpaidRestrictionON: isUnpaidRestrictionON ?? this.isUnpaidRestrictionON,
      isPastDateAllowed: isPastDateAllowed ?? this.isPastDateAllowed,
      isPastDateConditionTrue: isPastDateConditionTrue ?? this.isPastDateConditionTrue,
      takeQuarterLeave: takeQuarterLeave ?? this.takeQuarterLeave,
      changedSelection: changedSelection ?? this.changedSelection,
      leaveDayTypeTemp: leaveDayTypeTemp ?? this.leaveDayTypeTemp,
      halfDaySession: halfDaySession ?? this.halfDaySession,
      weekOffHoliday: weekOffHoliday ?? this.weekOffHoliday,
      extraDataInfo: extraDataInfo ?? this.extraDataInfo,
      isAttachmentRequired: isAttachmentRequired ?? this.isAttachmentRequired,
      isSandwichLeave: isSandwichLeave ?? this.isSandwichLeave,
      unpaidLimitReached: unpaidLimitReached ?? this.unpaidLimitReached,
      monthlyHistory: monthlyHistory ?? this.monthlyHistory,
    );
}
