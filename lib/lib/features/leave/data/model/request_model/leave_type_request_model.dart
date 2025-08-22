class LeaveTypeRequestModel {
  final String action; // getLeaveTypeList
  final String societyId;
  final String unitId;
  final String userId;
  final String floorId;
  final String currentYear;
  final String languageId;

  LeaveTypeRequestModel({
    required this.societyId,
    required this.unitId,
    required this.userId,
    required this.floorId,
    required this.currentYear,
    this.action = 'getLeaveTypeList',
    this.languageId = '1',
  });

  Map<String, String> toMap() => {
    'getLeaveTypeList': action,
    'society_id': societyId,
    'unit_id': unitId,
    'user_id': userId,
    'floor_id': floorId,
    'currentYear': currentYear,
    'language_id': languageId,
  };
}
