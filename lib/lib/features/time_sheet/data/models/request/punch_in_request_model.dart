class PunchInRequestModel {
  final String? tag;
  final String? companyId;
  final String? unitId;
  final String? userId;
  final String? branchId;
  final String? DepartmentId;
  final String? userName;
  final String? languageId;
  final String? shiftTimeId;
  final String? punchInDate;
  final String? punchOutDate;
  final String? punchInTime;
  final String? punchOutTime;
  final String? locationName;
  final String? appVersion;
  final String? punchInReason;
  final String? selectedShiftId;
  final String? multiPunchData;

  PunchInRequestModel({
    this.tag,
    this.companyId,
    this.unitId,
    this.userId,
    this.branchId,
    this.DepartmentId,
    this.userName,
    this.languageId,
    this.shiftTimeId,
    this.punchInDate,
    this.punchOutDate,
    this.punchInTime,
    this.punchOutTime,
    this.locationName,
    this.appVersion,
    this.punchInReason,
    this.selectedShiftId,
    this.multiPunchData,
  });

  Map<String, String?> toJson() => {
    'attendanceRequest': tag,
    'society_id': companyId,
    'unit_id': unitId,
    'user_id': userId,
    'block_id': branchId,
    'floor_id': DepartmentId,
    'user_name': userName,
    'language_id': languageId,
    'shift_time_id': shiftTimeId,
    'punch_in_date': punchInDate,
    'punch_out_date': punchOutDate,
    'punch_in_time': punchInTime,
    'punch_out_time': punchOutTime,
    'location_name': locationName,
    'app_version': appVersion,
    'punch_in_reason': punchInReason,
    'selected_shift_id': selectedShiftId,
    'multi_punch_data': multiPunchData,
  };
}
