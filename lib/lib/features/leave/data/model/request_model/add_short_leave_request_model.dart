// 📄 File: add_short_leave_request_model.dart
class AddShortLeaveRequestModel {
  final String action; // addShortLeave
  final String societyId;
  final String userId;
  final String userName;
  final String languageId;
  final String shortLeaveDate;
  final String shortLeaveTime;
  final String shortLeaveApplyReason;

  AddShortLeaveRequestModel({
    required this.societyId,
    required this.userId,
    required this.userName,
    required this.shortLeaveDate,
    required this.shortLeaveTime,
    required this.shortLeaveApplyReason,
    this.action = 'addShortLeave',
    this.languageId = '1',
  });

  Map<String, String> toMap() => {
    'addShortLeave': action,
    'society_id': societyId,
    'user_id': userId,
    'user_name': userName,
    'language_id': languageId,
    'short_leave_date': shortLeaveDate,
    'short_leave_time': shortLeaveTime,
    'short_leave_apply_reason': shortLeaveApplyReason,
  };
}
