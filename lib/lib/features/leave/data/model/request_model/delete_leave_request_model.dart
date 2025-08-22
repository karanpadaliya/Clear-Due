// 📄 File: delete_leave_request_model.dart
class DeleteLeaveRequestModel {
  final String action; // deleteLeaveRequest
  final String societyId;
  final String userId;
  final String languageId;
  final String otherUserName;
  final String userName;
  final String leaveId;
  final String myUserId;
  final String deleteRestrict;
  final String removeLateIn;
  final String removeEarlyOut;

  DeleteLeaveRequestModel({
    required this.societyId,
    required this.userId,
    required this.otherUserName,
    required this.userName,
    required this.leaveId,
    required this.myUserId,
    this.action = 'deleteLeaveRequest',
    this.languageId = '1',
    this.deleteRestrict = '1',
    this.removeLateIn = '',
    this.removeEarlyOut = '',
  });

  Map<String, String> toMap() => {
    'deleteLeaveRequest': action,
    'society_id': societyId,
    'user_id': userId,
    'language_id': languageId,
    'other_user_name': otherUserName,
    'user_name': userName,
    'leave_id': leaveId,
    'my_user_id': myUserId,
    'delete_restrict': deleteRestrict,
    'remove_late_in': removeLateIn,
    'remove_early_out': removeEarlyOut,
  };
}
