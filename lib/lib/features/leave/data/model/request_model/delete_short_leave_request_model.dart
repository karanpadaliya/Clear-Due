// 📄 File: delete_short_leave_request_model.dart
class DeleteShortLeaveRequestModel {
  final String action; // deleteShortLeave
  final String societyId;
  final String userId;
  final String userName;
  final String languageId;
  final String shortLeaveId;
  final String shortLeaveDate;
  final String otherUserId;
  final String otherUserName;

  DeleteShortLeaveRequestModel({
    required this.societyId,
    required this.userId,
    required this.userName,
    required this.shortLeaveId,
    required this.shortLeaveDate,
    required this.otherUserId,
    required this.otherUserName,
    this.action = 'deleteShortLeave',
    this.languageId = '1',
  });

  Map<String, String> toMap() => {
    'deleteShortLeave': action,
    'society_id': societyId,
    'user_id': userId,
    'user_name': userName,
    'language_id': languageId,
    'short_leave_id': shortLeaveId,
    'short_leave_date': shortLeaveDate,
    'other_user_id': otherUserId,
    'other_user_name': otherUserName,
  };
}
