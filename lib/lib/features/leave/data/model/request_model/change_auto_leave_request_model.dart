// 📄 File: change_auto_leave_request_model.dart
class ChangeAutoLeaveRequestModel {
  final String action; // changeAutoLeave
  final String societyId;
  final String userId;
  final String languageId;
  final String paidUnpaid;
  final String leaveTypeId;
  final String leaveDate;
  final String leaveDayType;
  final String isExtraDay;
  final String isSpecialLeave;
  final String attendanceId;
  final String userName;
  final String leaveId;
  final String leavePercentage;
  final String isFromAdmin;

  ChangeAutoLeaveRequestModel({
    required this.societyId,
    required this.userId,
    required this.paidUnpaid,
    required this.leaveTypeId,
    required this.leaveDate,
    required this.leaveDayType,
    required this.isExtraDay,
    required this.isSpecialLeave,
    required this.attendanceId,
    required this.userName,
    required this.leaveId,
    required this.leavePercentage,
    this.action = 'changeAutoLeave',
    this.languageId = '1',
    this.isFromAdmin = '0',
  });

  Map<String, String> toMap() => {
    'changeAutoLeave': action,
    'society_id': societyId,
    'user_id': userId,
    'language_id': languageId,
    'paid_unpaid': paidUnpaid,
    'leave_type_id': leaveTypeId,
    'leave_date': leaveDate,
    'leave_day_type': leaveDayType,
    'is_extra_day': isExtraDay,
    'is_special_leave': isSpecialLeave,
    'attendance_id': attendanceId,
    'user_name': userName,
    'leave_id': leaveId,
    'leave_percentage': leavePercentage,
    'is_from_admin': isFromAdmin,
  };
}
