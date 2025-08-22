class LeaveHistoryRequestModel {
  final String action; // getLeaveHistoryNew
  final String societyId;
  final String unitId;
  final String userId;
  final String floorId;
  final String levelId;
  final String languageId;
  final String month;
  final String year;

  LeaveHistoryRequestModel({
    required this.societyId,
    required this.unitId,
    required this.userId,
    required this.floorId,
    required this.levelId,
    required this.month,
    required this.year,
    this.action = 'getLeaveHistoryNew',
    this.languageId = '1',
  });

  Map<String, String> toMap() => {
    'getLeaveHistoryNew': action,
    'society_id': societyId,
    'unit_id': unitId,
    'user_id': userId,
    'floor_id': floorId,
    'level_id': levelId,
    'language_id': languageId,
    'month': month,
    'year': year,
  };
}
