// 📄 File: leave_types_with_data_request_model.dart
class LeaveTypesWithDataRequestModel {
  final String action; // getLeaveTypesWithData
  final String societyId;
  final String unitId;
  final String userId;
  final String userName;
  final String languageId;
  final String currentYear;
  final String appliedLeaveDate;

  LeaveTypesWithDataRequestModel({
    required this.societyId,
    required this.unitId,
    required this.userId,
    required this.userName,
    required this.currentYear,
    required this.appliedLeaveDate,
    this.action = 'getLeaveTypesWithData',
    this.languageId = '1',
  });

  Map<String, String> toMap() => {
    'getLeaveTypesWithData': action,
    'society_id': societyId,
    'unit_id': unitId,
    'user_id': userId,
    'user_name': userName,
    'language_id': languageId,
    'currentYear': currentYear,
    'applied_leave_date': appliedLeaveDate,
  };
}
