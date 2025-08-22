// 📄 File: change_sandwich_leave_request_model.dart
class ChangeSandwichLeaveRequestModel {
  final String action; // changeSandwichLeave
  final String societyId;
  final String leaveUserId;
  final String languageId;
  final String paidUnpaid;
  final String leaveTypeId;
  final String leaveTypeName;
  final String sandwichLeaveId;
  final String userName;
  final String userId;
  final String isWeb;
  final String unitId;
  final String myLeave;
  final String leaveUserName;
  final String leavePercentage;

  ChangeSandwichLeaveRequestModel({
    required this.societyId,
    required this.leaveUserId,
    required this.paidUnpaid,
    required this.leaveTypeId,
    required this.leaveTypeName,
    required this.sandwichLeaveId,
    required this.userName,
    required this.userId,
    required this.unitId,
    required this.leaveUserName,
    required this.leavePercentage,
    this.action = 'changeSandwichLeave',
    this.languageId = '1',
    this.isWeb = '0',
    this.myLeave = '1',
  });

  Map<String, String> toMap() => {
    'changeSandwichLeave': action,
    'society_id': societyId,
    'leave_user_id': leaveUserId,
    'language_id': languageId,
    'paid_unpaid': paidUnpaid,
    'leave_type_id': leaveTypeId,
    'leave_type_name': leaveTypeName,
    'sandwich_leave_id': sandwichLeaveId,
    'user_name': userName,
    'user_id': userId,
    'isWeb': isWeb,
    'unit_id': unitId,
    'my_leave': myLeave,
    'leave_user_name': leaveUserName,
    'leave_percentage': leavePercentage,
  };
}
