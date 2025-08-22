// 📄 File: leave_balance_for_auto_leave_request_model.dart
class LeaveBalanceForAutoLeaveRequestModel {
  final String action; // getLeaveBalanceForAutoLeave
  final String societyId;
  final String userId;
  final String languageId;
  final String leaveDate;
  final String leaveTypeId;
  final String leaveStatus;

  LeaveBalanceForAutoLeaveRequestModel({
    required this.societyId,
    required this.userId,
    required this.leaveDate,
    required this.leaveTypeId,
    this.action = 'getLeaveBalanceForAutoLeave',
    this.languageId = '1',
    this.leaveStatus = '0',
  });

  Map<String, String> toMap() => {
    'getLeaveBalanceForAutoLeave': action,
    'society_id': societyId,
    'user_id': userId,
    'language_id': languageId,
    'leave_date': leaveDate,
    'leave_type_id': leaveTypeId,
    'leave_status': leaveStatus,
  };
}
