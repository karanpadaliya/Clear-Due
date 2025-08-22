// 📄 File: leave_calendar_new_request_model.dart
class LeaveCalendarNewRequestModel {
  final String action; // leaveCalendarNew
  final String societyId;
  final String unitId;
  final String userId;
  final String blockId;
  final String floorId;
  final String levelId;
  final String languageId;
  final String shiftTimeId;
  final String monthStartDate;
  final String monthEndDate;

  LeaveCalendarNewRequestModel({
    required this.societyId,
    required this.unitId,
    required this.userId,
    required this.blockId,
    required this.floorId,
    required this.levelId,
    required this.shiftTimeId,
    required this.monthStartDate,
    required this.monthEndDate,
    this.action = 'leaveCalendarNew',
    this.languageId = '1',
  });

  Map<String, String> toMap() => {
    'leaveCalendarNew': action,
    'society_id': societyId,
    'unit_id': unitId,
    'user_id': userId,
    'block_id': blockId,
    'floor_id': floorId,
    'level_id': levelId,
    'language_id': languageId,
    'shift_time_id': shiftTimeId,
    'month_start_date': monthStartDate,
    'month_end_date': monthEndDate,
  };
}
