class PunchInReqReminderModel {
  final String? tag;
  final String? companyId;
  final String? unitId;
  final String? userId;
  final String? userName;
  final String? languageId;
  final String? DepartmentId;
  final String? branchId;
  final String? attendanceId;

  PunchInReqReminderModel({
    this.tag,
    this.companyId,
    this.unitId,
    this.userId,
    this.userName,
    this.languageId,
    this.DepartmentId,
    this.branchId,
    this.attendanceId,
  });

  Map<String, String?> toJson() => {
    'punchInReqReminder': tag,
    'society_id': companyId,
    'unit_id': unitId,
    'user_id': userId,
    'user_name': userName,
    'language_id': languageId,
    'floor_id': DepartmentId,
    'block_id': branchId,
    'attendance_id': attendanceId,
  };
}
