class GetAttendanceTypeRequest {
  final String getAttendanceTypeNew;
  final String companyId;
  final String unitId;
  final String userId;
  final String attendanceId;
  final String languageId;
  final String latitude;
  final String longitude;
  final String gpsAccuracy;
  final String shiftTimeId;

  const GetAttendanceTypeRequest({
    required this.companyId,
    required this.unitId,
    required this.userId,
    required this.languageId,
    required this.latitude,
    required this.longitude,
    required this.gpsAccuracy,
    required this.shiftTimeId,
    this.getAttendanceTypeNew = 'getAttendanceTypeNew',
    this.attendanceId = '0', // Default as per native code
  });

  Map<String, dynamic> toMap() => {
    'getAttendanceType': getAttendanceTypeNew,
    'society_id': companyId,
    'unit_id': unitId,
    'user_id': userId,
    'attendance_id': attendanceId,
    'language_id': languageId,
    'latitude': latitude,
    'longitude': longitude,
    'gps_accuracy': gpsAccuracy,
    'shift_time_id': shiftTimeId,
  };
}
