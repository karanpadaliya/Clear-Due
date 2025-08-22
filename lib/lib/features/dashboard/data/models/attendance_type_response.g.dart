// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_type_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttendanceTypeResponseAdapter
    extends TypeAdapter<AttendanceTypeResponse> {
  @override
  final int typeId = 13;

  @override
  AttendanceTypeResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AttendanceTypeResponse(
      attendanceTypes: (fields[0] as List?)?.cast<AttendanceType>(),
      message: fields[1] as String?,
      takeOutOfRangeReason: fields[2] as bool?,
      attendanceWithDeveloperModeOn: fields[3] as bool?,
      status: fields[4] as String?,
      punchInTimeView24Hours: fields[5] as String?,
      takenBreaks: (fields[6] as List?)?.cast<TakenBreaks>(),
      perDayHourMinutes: fields[7] as String?,
      multiPunchData: (fields[8] as List?)?.cast<MultiPunchData>(),
      wfhData: fields[9] as WFHDataResponse?,
      isDocumentUploadingPending: fields[10] as bool?,
      probationPeriodDaysMandatory: fields[11] as bool?,
      lastOdometerReading: fields[12] as String?,
      shiftData: fields[13] as ShiftDataResponse?,
      dateTime: fields[14] as String?,
      attendanceId: fields[15] as String?,
      totalWorkReport: fields[16] as String?,
      totalReportAdded: fields[17] as String?,
      remainingWorkReport: fields[18] as String?,
      punchOutLimit: fields[19] as bool?,
      isToday: fields[20] as bool?,
      hideWorkingHours: fields[21] as bool?,
      multiPunchIn: fields[22] as bool?,
      alreadyPunchOutMsg: fields[23] as String?,
      punchInOdometer: fields[24] as bool?,
      punchInTime: fields[25] as String?,
      punchInTimeView: fields[26] as String?,
      attendanceStartDate: fields[27] as String?,
      attendanceStartDateView: fields[28] as String?,
      timeDifference: fields[29] as String?,
      breakDateTime: fields[30] as String?,
      attendanceBreakHistoryId: fields[31] as String?,
      breakInTime: fields[32] as String?,
      attendanceTypeName: fields[33] as String?,
      breakTimeDifference: fields[34] as String?,
      attendanceTypeId: fields[35] as String?,
      yesterdayPunchOutMissingMsg: fields[36] as String?,
      yesterdayPunchOutMissing: fields[37] as bool?,
      nightShift: fields[38] as bool?,
      addRetailerCityAreaAddAccess: fields[39] as bool?,
      punchOutWithTaskCompletion: fields[40] as bool?,
      taskComplete: fields[41] as bool?,
      alreadyPunchIn: fields[42] as bool?,
      alreadyPunchOut: fields[43] as bool?,
      workReportAdded: fields[44] as bool?,
      isAttendanceRejected: fields[45] as bool?,
      attendanceRejectedMessage: fields[46] as String?,
      yesterdayAttendanceRejected: fields[47] as bool?,
      yesterdayAttendanceRejectedMessage: fields[48] as String?,
      userFaceData: fields[49] as String?,
      trackUserLocation: fields[50] as bool?,
      faceDataImageTwo: fields[51] as String?,
      faceDataImage: fields[52] as String?,
      faceAddedDate: fields[53] as String?,
      missingDate: fields[54] as String?,
      missingMonth: fields[55] as String?,
      missingYear: fields[56] as String?,
      punchInLatitude: fields[57] as String?,
      punchInLongitude: fields[58] as String?,
      serverTime: fields[59] as String?,
      fingerDataImage: fields[60] as String?,
      userFingerDataUpdatedDate: fields[61] as String?,
      faceOrFingerAttendance: fields[62] as String?,
      faceScanAccuracy: fields[63] as String?,
      hideDutyHourTimer: fields[64] as bool?,
      shiftList: (fields[65] as List?)?.cast<ShiftList>(),
      onlyAutoApprovedAttendanceField: fields[66] as bool?,
      orderWithoutPunchInField: fields[67] as bool?,
      attendanceTypeField: fields[68] as String?,
      takeAttendanceSelfieField: fields[69] as String?,
      takeBreakWithApprovalEmployeeApp: fields[70] as String?,
      hideAttendanceFaceMenuField: fields[71] as bool?,
      allowAddVisit: fields[72] as bool?,
      attendanceWithMatchingFaceField: fields[73] as bool?,
      isAmazonFaceMatchField: fields[74] as bool?,
      isStartEndVisitFaceMatchField: fields[75] as bool?,
      odometerTrackingField: fields[76] as bool?,
      allowToPreApplyShortLeaveField: fields[77] as bool?,
      userLocationList: (fields[78] as List?)?.cast<UserLocationList>(),
      lastPunchInOdometerImage: fields[79] as String?,
      multiPunchDataView: (fields[80] as List?)?.cast<MultiPunchDataView>(),
      perDayHour: fields[81] as String?,
      isBreakStart: fields[82] as bool?,
      isAutoBreakStart: fields[83] as bool?,
      autoBreakStartView: fields[84] as String?,
      breaks: (fields[85] as List?)?.cast<Break__1>(),
      productiveHoursInSec: fields[86] as String?,
      timeDiffSeconds: fields[87] as String?,
      productiveHoursView: fields[88] as String?,
      breakStartColor: fields[89] as String?,
      breakStartName: fields[90] as String?,
      attendanceMapType: fields[91] as String?,
      visitMapType: fields[92] as String?,
      faceBlurDetection: fields[93] as String?,
      pastAttendanceLeaveRequest: fields[94] as String?,
      iCardFormatType: fields[95] as String?,
      lateInReasonPending: fields[96] as bool?,
      searchRetailerWithApi: fields[97] as bool?,
      hsnCodeVisible: fields[98] as bool?,
      autoLeaveRemoveReasonRequired: fields[99] as bool?,
      maxAttendancePunchOutTime: fields[100] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AttendanceTypeResponse obj) {
    writer
      ..writeByte(101)
      ..writeByte(0)
      ..write(obj.attendanceTypes)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.takeOutOfRangeReason)
      ..writeByte(3)
      ..write(obj.attendanceWithDeveloperModeOn)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.punchInTimeView24Hours)
      ..writeByte(6)
      ..write(obj.takenBreaks)
      ..writeByte(7)
      ..write(obj.perDayHourMinutes)
      ..writeByte(8)
      ..write(obj.multiPunchData)
      ..writeByte(9)
      ..write(obj.wfhData)
      ..writeByte(10)
      ..write(obj.isDocumentUploadingPending)
      ..writeByte(11)
      ..write(obj.probationPeriodDaysMandatory)
      ..writeByte(12)
      ..write(obj.lastOdometerReading)
      ..writeByte(13)
      ..write(obj.shiftData)
      ..writeByte(14)
      ..write(obj.dateTime)
      ..writeByte(15)
      ..write(obj.attendanceId)
      ..writeByte(16)
      ..write(obj.totalWorkReport)
      ..writeByte(17)
      ..write(obj.totalReportAdded)
      ..writeByte(18)
      ..write(obj.remainingWorkReport)
      ..writeByte(19)
      ..write(obj.punchOutLimit)
      ..writeByte(20)
      ..write(obj.isToday)
      ..writeByte(21)
      ..write(obj.hideWorkingHours)
      ..writeByte(22)
      ..write(obj.multiPunchIn)
      ..writeByte(23)
      ..write(obj.alreadyPunchOutMsg)
      ..writeByte(24)
      ..write(obj.punchInOdometer)
      ..writeByte(25)
      ..write(obj.punchInTime)
      ..writeByte(26)
      ..write(obj.punchInTimeView)
      ..writeByte(27)
      ..write(obj.attendanceStartDate)
      ..writeByte(28)
      ..write(obj.attendanceStartDateView)
      ..writeByte(29)
      ..write(obj.timeDifference)
      ..writeByte(30)
      ..write(obj.breakDateTime)
      ..writeByte(31)
      ..write(obj.attendanceBreakHistoryId)
      ..writeByte(32)
      ..write(obj.breakInTime)
      ..writeByte(33)
      ..write(obj.attendanceTypeName)
      ..writeByte(34)
      ..write(obj.breakTimeDifference)
      ..writeByte(35)
      ..write(obj.attendanceTypeId)
      ..writeByte(36)
      ..write(obj.yesterdayPunchOutMissingMsg)
      ..writeByte(37)
      ..write(obj.yesterdayPunchOutMissing)
      ..writeByte(38)
      ..write(obj.nightShift)
      ..writeByte(39)
      ..write(obj.addRetailerCityAreaAddAccess)
      ..writeByte(40)
      ..write(obj.punchOutWithTaskCompletion)
      ..writeByte(41)
      ..write(obj.taskComplete)
      ..writeByte(42)
      ..write(obj.alreadyPunchIn)
      ..writeByte(43)
      ..write(obj.alreadyPunchOut)
      ..writeByte(44)
      ..write(obj.workReportAdded)
      ..writeByte(45)
      ..write(obj.isAttendanceRejected)
      ..writeByte(46)
      ..write(obj.attendanceRejectedMessage)
      ..writeByte(47)
      ..write(obj.yesterdayAttendanceRejected)
      ..writeByte(48)
      ..write(obj.yesterdayAttendanceRejectedMessage)
      ..writeByte(49)
      ..write(obj.userFaceData)
      ..writeByte(50)
      ..write(obj.trackUserLocation)
      ..writeByte(51)
      ..write(obj.faceDataImageTwo)
      ..writeByte(52)
      ..write(obj.faceDataImage)
      ..writeByte(53)
      ..write(obj.faceAddedDate)
      ..writeByte(54)
      ..write(obj.missingDate)
      ..writeByte(55)
      ..write(obj.missingMonth)
      ..writeByte(56)
      ..write(obj.missingYear)
      ..writeByte(57)
      ..write(obj.punchInLatitude)
      ..writeByte(58)
      ..write(obj.punchInLongitude)
      ..writeByte(59)
      ..write(obj.serverTime)
      ..writeByte(60)
      ..write(obj.fingerDataImage)
      ..writeByte(61)
      ..write(obj.userFingerDataUpdatedDate)
      ..writeByte(62)
      ..write(obj.faceOrFingerAttendance)
      ..writeByte(63)
      ..write(obj.faceScanAccuracy)
      ..writeByte(64)
      ..write(obj.hideDutyHourTimer)
      ..writeByte(65)
      ..write(obj.shiftList)
      ..writeByte(66)
      ..write(obj.onlyAutoApprovedAttendanceField)
      ..writeByte(67)
      ..write(obj.orderWithoutPunchInField)
      ..writeByte(68)
      ..write(obj.attendanceTypeField)
      ..writeByte(69)
      ..write(obj.takeAttendanceSelfieField)
      ..writeByte(70)
      ..write(obj.takeBreakWithApprovalEmployeeApp)
      ..writeByte(71)
      ..write(obj.hideAttendanceFaceMenuField)
      ..writeByte(72)
      ..write(obj.allowAddVisit)
      ..writeByte(73)
      ..write(obj.attendanceWithMatchingFaceField)
      ..writeByte(74)
      ..write(obj.isAmazonFaceMatchField)
      ..writeByte(75)
      ..write(obj.isStartEndVisitFaceMatchField)
      ..writeByte(76)
      ..write(obj.odometerTrackingField)
      ..writeByte(77)
      ..write(obj.allowToPreApplyShortLeaveField)
      ..writeByte(78)
      ..write(obj.userLocationList)
      ..writeByte(79)
      ..write(obj.lastPunchInOdometerImage)
      ..writeByte(80)
      ..write(obj.multiPunchDataView)
      ..writeByte(81)
      ..write(obj.perDayHour)
      ..writeByte(82)
      ..write(obj.isBreakStart)
      ..writeByte(83)
      ..write(obj.isAutoBreakStart)
      ..writeByte(84)
      ..write(obj.autoBreakStartView)
      ..writeByte(85)
      ..write(obj.breaks)
      ..writeByte(86)
      ..write(obj.productiveHoursInSec)
      ..writeByte(87)
      ..write(obj.timeDiffSeconds)
      ..writeByte(88)
      ..write(obj.productiveHoursView)
      ..writeByte(89)
      ..write(obj.breakStartColor)
      ..writeByte(90)
      ..write(obj.breakStartName)
      ..writeByte(91)
      ..write(obj.attendanceMapType)
      ..writeByte(92)
      ..write(obj.visitMapType)
      ..writeByte(93)
      ..write(obj.faceBlurDetection)
      ..writeByte(94)
      ..write(obj.pastAttendanceLeaveRequest)
      ..writeByte(95)
      ..write(obj.iCardFormatType)
      ..writeByte(96)
      ..write(obj.lateInReasonPending)
      ..writeByte(97)
      ..write(obj.searchRetailerWithApi)
      ..writeByte(98)
      ..write(obj.hsnCodeVisible)
      ..writeByte(99)
      ..write(obj.autoLeaveRemoveReasonRequired)
      ..writeByte(100)
      ..write(obj.maxAttendancePunchOutTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceTypeResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AttendanceTypeAdapter extends TypeAdapter<AttendanceType> {
  @override
  final int typeId = 14;

  @override
  AttendanceType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AttendanceType(
      attendanceTypeId: fields[0] as String?,
      attendanceTypeName: fields[1] as String?,
      attendanceBreakKey: fields[2] as String?,
      attendanceBreakMinutes: fields[3] as String?,
      breakApprovalRequired: fields[4] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, AttendanceType obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.attendanceTypeId)
      ..writeByte(1)
      ..write(obj.attendanceTypeName)
      ..writeByte(2)
      ..write(obj.attendanceBreakKey)
      ..writeByte(3)
      ..write(obj.attendanceBreakMinutes)
      ..writeByte(4)
      ..write(obj.breakApprovalRequired);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MultiPunchDataAdapter extends TypeAdapter<MultiPunchData> {
  @override
  final int typeId = 15;

  @override
  MultiPunchData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MultiPunchData(
      punchInDate: fields[0] as String?,
      punchInTime: fields[1] as String?,
      punchOutDate: fields[2] as String?,
      punchOutTime: fields[3] as String?,
      workingHour: fields[4] as String?,
      workingHourMinute: fields[5] as String?,
      punchInTimeView: fields[6] as String?,
      punchOutTimeView: fields[7] as String?,
      workingHourView: fields[8] as String?,
      takenBreaks: (fields[9] as List?)?.cast<TakenBreaks>(),
    );
  }

  @override
  void write(BinaryWriter writer, MultiPunchData obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.punchInDate)
      ..writeByte(1)
      ..write(obj.punchInTime)
      ..writeByte(2)
      ..write(obj.punchOutDate)
      ..writeByte(3)
      ..write(obj.punchOutTime)
      ..writeByte(4)
      ..write(obj.workingHour)
      ..writeByte(5)
      ..write(obj.workingHourMinute)
      ..writeByte(6)
      ..write(obj.punchInTimeView)
      ..writeByte(7)
      ..write(obj.punchOutTimeView)
      ..writeByte(8)
      ..write(obj.workingHourView)
      ..writeByte(9)
      ..write(obj.takenBreaks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MultiPunchDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TakenBreaksAdapter extends TypeAdapter<TakenBreaks> {
  @override
  final int typeId = 16;

  @override
  TakenBreaks read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TakenBreaks(
      attendanceBreakHistoryId: fields[0] as String?,
      attendanceTypeId: fields[1] as String?,
      breakStartDate: fields[2] as String?,
      breakInTime: fields[3] as String?,
      breakInTimeView: fields[4] as String?,
      breakOutTimeview: fields[5] as String?,
      totalBreaktimeView: fields[6] as String?,
      breakName: fields[7] as String?,
      breakEndDate: fields[8] as String?,
      breakOutTime: fields[9] as String?,
      totalBreakTime: fields[10] as String?,
      totalBreakTimeMinutes: fields[11] as String?,
      breakColor: fields[12] as String?,
      attendanceBreakKey: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TakenBreaks obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.attendanceBreakHistoryId)
      ..writeByte(1)
      ..write(obj.attendanceTypeId)
      ..writeByte(2)
      ..write(obj.breakStartDate)
      ..writeByte(3)
      ..write(obj.breakInTime)
      ..writeByte(4)
      ..write(obj.breakInTimeView)
      ..writeByte(5)
      ..write(obj.breakOutTimeview)
      ..writeByte(6)
      ..write(obj.totalBreaktimeView)
      ..writeByte(7)
      ..write(obj.breakName)
      ..writeByte(8)
      ..write(obj.breakEndDate)
      ..writeByte(9)
      ..write(obj.breakOutTime)
      ..writeByte(10)
      ..write(obj.totalBreakTime)
      ..writeByte(11)
      ..write(obj.totalBreakTimeMinutes)
      ..writeByte(12)
      ..write(obj.breakColor)
      ..writeByte(13)
      ..write(obj.attendanceBreakKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TakenBreaksAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class Break1Adapter extends TypeAdapter<Break__1> {
  @override
  final int typeId = 17;

  @override
  Break__1 read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Break__1(
      breakColor: fields[0] as String?,
      breakName: fields[1] as String?,
      startMinutes: fields[2] as String?,
      endMinutes: fields[3] as String?,
      totalMinutes: fields[4] as String?,
      breakTimeView: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Break__1 obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.breakColor)
      ..writeByte(1)
      ..write(obj.breakName)
      ..writeByte(2)
      ..write(obj.startMinutes)
      ..writeByte(3)
      ..write(obj.endMinutes)
      ..writeByte(4)
      ..write(obj.totalMinutes)
      ..writeByte(5)
      ..write(obj.breakTimeView);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Break1Adapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MultiPunchDataViewAdapter extends TypeAdapter<MultiPunchDataView> {
  @override
  final int typeId = 18;

  @override
  MultiPunchDataView read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MultiPunchDataView(
      punchInDate: fields[0] as String?,
      punchInTime: fields[1] as String?,
      punchInTimeView: fields[2] as String?,
      punchOutDate: fields[3] as String?,
      punchOutTime: fields[4] as String?,
      punchOutTimeView: fields[5] as String?,
      workingHour: fields[6] as String?,
      workingHourView: fields[7] as String?,
      workingHourMinute: fields[8] as String?,
      breaks: (fields[9] as List?)?.cast<Break>(),
    );
  }

  @override
  void write(BinaryWriter writer, MultiPunchDataView obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.punchInDate)
      ..writeByte(1)
      ..write(obj.punchInTime)
      ..writeByte(2)
      ..write(obj.punchInTimeView)
      ..writeByte(3)
      ..write(obj.punchOutDate)
      ..writeByte(4)
      ..write(obj.punchOutTime)
      ..writeByte(5)
      ..write(obj.punchOutTimeView)
      ..writeByte(6)
      ..write(obj.workingHour)
      ..writeByte(7)
      ..write(obj.workingHourView)
      ..writeByte(8)
      ..write(obj.workingHourMinute)
      ..writeByte(9)
      ..write(obj.breaks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MultiPunchDataViewAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BreakAdapter extends TypeAdapter<Break> {
  @override
  final int typeId = 19;

  @override
  Break read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Break(
      attendanceBreakHistoryId: fields[0] as String?,
      attendanceTypeId: fields[1] as String?,
      breakStartDate: fields[2] as String?,
      breakInTime: fields[3] as String?,
      breakInTimeView: fields[4] as String?,
      breakEndDate: fields[5] as String?,
      breakOutTime: fields[6] as String?,
      breakOutTimeView: fields[7] as String?,
      totalBreakTime: fields[8] as String?,
      totalBreakTimeView: fields[9] as String?,
      attendanceBreakKey: fields[10] as String?,
      breakColor: fields[11] as String?,
      breakName: fields[12] as String?,
      startMinutes: fields[13] as String?,
      endMinutes: fields[14] as String?,
      totalMinutes: fields[15] as String?,
      breakTimeView: fields[16] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Break obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.attendanceBreakHistoryId)
      ..writeByte(1)
      ..write(obj.attendanceTypeId)
      ..writeByte(2)
      ..write(obj.breakStartDate)
      ..writeByte(3)
      ..write(obj.breakInTime)
      ..writeByte(4)
      ..write(obj.breakInTimeView)
      ..writeByte(5)
      ..write(obj.breakEndDate)
      ..writeByte(6)
      ..write(obj.breakOutTime)
      ..writeByte(7)
      ..write(obj.breakOutTimeView)
      ..writeByte(8)
      ..write(obj.totalBreakTime)
      ..writeByte(9)
      ..write(obj.totalBreakTimeView)
      ..writeByte(10)
      ..write(obj.attendanceBreakKey)
      ..writeByte(11)
      ..write(obj.breakColor)
      ..writeByte(12)
      ..write(obj.breakName)
      ..writeByte(13)
      ..write(obj.startMinutes)
      ..writeByte(14)
      ..write(obj.endMinutes)
      ..writeByte(15)
      ..write(obj.totalMinutes)
      ..writeByte(16)
      ..write(obj.breakTimeView);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BreakAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceTypeResponse _$AttendanceTypeResponseFromJson(
  Map<String, dynamic> json,
) => AttendanceTypeResponse(
  attendanceTypes:
      (json['attendance_types'] as List<dynamic>?)
          ?.map((e) => AttendanceType.fromJson(e as Map<String, dynamic>))
          .toList(),
  message: json['message'] as String?,
  takeOutOfRangeReason: json['take_out_of_range_reason'] as bool?,
  attendanceWithDeveloperModeOn:
      json['attendance_with_developer_mode_on'] as bool?,
  status: json['status'] as String?,
  punchInTimeView24Hours: json['punch_in_time_view_24_hours'] as String?,
  takenBreaks:
      (json['taken_breaks'] as List<dynamic>?)
          ?.map((e) => TakenBreaks.fromJson(e as Map<String, dynamic>))
          .toList(),
  perDayHourMinutes: json['per_day_hour_minutes'] as String?,
  multiPunchData:
      (json['multi_punch_data'] as List<dynamic>?)
          ?.map((e) => MultiPunchData.fromJson(e as Map<String, dynamic>))
          .toList(),
  wfhData:
      json['wfh_data'] == null
          ? null
          : WFHDataResponse.fromJson(json['wfh_data'] as Map<String, dynamic>),
  isDocumentUploadingPending: json['is_document_uploading_pending'] as bool?,
  probationPeriodDaysMandatory:
      json['probation_period_days_mandatory'] as bool?,
  lastOdometerReading: json['last_odometer_reading'] as String?,
  shiftData:
      json['shift_data'] == null
          ? null
          : ShiftDataResponse.fromJson(
            json['shift_data'] as Map<String, dynamic>,
          ),
  dateTime: json['date_time'] as String?,
  attendanceId: json['attendance_id'] as String?,
  totalWorkReport: json['total_work_report'] as String?,
  totalReportAdded: json['total_report_added'] as String?,
  remainingWorkReport: json['remaining_work_report'] as String?,
  punchOutLimit: json['punch_out_limit'] as bool?,
  isToday: json['is_today'] as bool?,
  hideWorkingHours: json['hide_working_hours'] as bool?,
  multiPunchIn: json['multi_punch_in'] as bool?,
  alreadyPunchOutMsg: json['already_punch_out_msg'] as String?,
  punchInOdometer: json['punch_in_odometer'] as bool?,
  punchInTime: json['punch_in_time'] as String?,
  punchInTimeView: json['punch_in_time_view'] as String?,
  attendanceStartDate: json['attendance_start_date'] as String?,
  attendanceStartDateView: json['attendance_start_date_view'] as String?,
  timeDifference: json['time_diff'] as String?,
  breakDateTime: json['break_date_time'] as String?,
  attendanceBreakHistoryId: json['attendance_break_history_id'] as String?,
  breakInTime: json['break_in_time'] as String?,
  attendanceTypeName: json['attendance_type_name'] as String?,
  breakTimeDifference: json['break_time_diff'] as String?,
  attendanceTypeId: json['attendance_type_id'] as String?,
  yesterdayPunchOutMissingMsg:
      json['yesterday_punch_out_missing_msg'] as String?,
  yesterdayPunchOutMissing: json['yesterday_punch_out_missing'] as bool?,
  nightShift: json['night_shift'] as bool?,
  addRetailerCityAreaAddAccess:
      json['add_retailer_city_area_add_access'] as bool?,
  punchOutWithTaskCompletion: json['punch_out_with_task_completion'] as bool?,
  taskComplete: json['task_completed'] as bool?,
  alreadyPunchIn: json['already_punch_in'] as bool?,
  alreadyPunchOut: json['already_punch_out'] as bool?,
  workReportAdded: json['work_report_added'] as bool?,
  isAttendanceRejected: json['is_attendance_rejected'] as bool?,
  attendanceRejectedMessage: json['attendance_rejected_message'] as String?,
  yesterdayAttendanceRejected: json['yesterday_attendance_rejected'] as bool?,
  yesterdayAttendanceRejectedMessage:
      json['yesterday_attendance_rejected_message'] as String?,
  userFaceData: json['user_face_data'] as String?,
  trackUserLocation: json['track_user_location'] as bool?,
  faceDataImageTwo: json['face_data_image_two'] as String?,
  faceDataImage: json['face_data_image'] as String?,
  faceAddedDate: json['face_added_date'] as String?,
  missingDate: json['missing_date'] as String?,
  missingMonth: json['missing_month'] as String?,
  missingYear: json['missing_year'] as String?,
  punchInLatitude: json['punch_in_latitude'] as String?,
  punchInLongitude: json['punch_in_longitude'] as String?,
  serverTime: json['server_time'] as String?,
  fingerDataImage: json['finger_data_image'] as String?,
  userFingerDataUpdatedDate: json['user_finger_data_updated_date'] as String?,
  faceOrFingerAttendance: json['face_or_finger_attendance'] as String?,
  faceScanAccuracy: json['face_scan_accuracy'] as String?,
  hideDutyHourTimer: json['hide_duty_hour_timer'] as bool?,
  shiftList:
      (json['shift_list'] as List<dynamic>?)
          ?.map((e) => ShiftList.fromJson(e as Map<String, dynamic>))
          .toList(),
  onlyAutoApprovedAttendanceField:
      json['only_auto_approved_attendance'] as bool?,
  orderWithoutPunchInField: json['order_without_punch_in'] as bool?,
  attendanceTypeField: json['attendance_type'] as String?,
  takeAttendanceSelfieField: json['take_attendance_selfie'] as String?,
  takeBreakWithApprovalEmployeeApp:
      json['take_break_with_approval_employee_app'] as String?,
  hideAttendanceFaceMenuField: json['hide_attendance_face_menu'] as bool?,
  allowAddVisit: json['allow_add_visit'] as bool?,
  attendanceWithMatchingFaceField:
      json['attendance_with_matching_face'] as bool?,
  isAmazonFaceMatchField: json['is_amazon_face_match'] as bool?,
  isStartEndVisitFaceMatchField:
      json['start_end_visit_with_face_match'] as bool?,
  odometerTrackingField: json['odometer_tracking'] as bool?,
  allowToPreApplyShortLeaveField:
      json['allow_to_pre_apply_short_leave'] as bool?,
  userLocationList:
      (json['user_location_list'] as List<dynamic>?)
          ?.map((e) => UserLocationList.fromJson(e as Map<String, dynamic>))
          .toList(),
  lastPunchInOdometerImage: json['last_punch_in_odometer_image'] as String?,
  multiPunchDataView:
      (json['multi_punch_data_view'] as List<dynamic>?)
          ?.map((e) => MultiPunchDataView.fromJson(e as Map<String, dynamic>))
          .toList(),
  perDayHour: json['per_day_hour'] as String?,
  isBreakStart: json['is_break_start'] as bool?,
  isAutoBreakStart: json['is_auto_break_start'] as bool?,
  autoBreakStartView: json['auto_break_start_view'] as String?,
  breaks:
      (json['breaks'] as List<dynamic>?)
          ?.map((e) => Break__1.fromJson(e as Map<String, dynamic>))
          .toList(),
  productiveHoursInSec: json['productive_hours_in_sec'] as String?,
  timeDiffSeconds: json['time_diff_seconds'] as String?,
  productiveHoursView: json['productive_hours_view'] as String?,
  breakStartColor: json['break_start_color'] as String?,
  breakStartName: json['break_start_name'] as String?,
  attendanceMapType: json['attendance_map_type'] as String?,
  visitMapType: json['visit_map_type'] as String?,
  faceBlurDetection: json['face_blur_detection'] as String?,
  pastAttendanceLeaveRequest: json['past_attendance_leave_request'] as String?,
  iCardFormatType: json['i_card_format_type'] as String?,
  lateInReasonPending: json['late_in_reason_pending'] as bool?,
  searchRetailerWithApi: json['search_retailer_with_api'] as bool?,
  hsnCodeVisible: json['hsn_code_visible'] as bool?,
  autoLeaveRemoveReasonRequired:
      json['auto_leave_remove_reason_required'] as bool?,
  maxAttendancePunchOutTime: json['max_attendance_punchout_time'] as String?,
);

Map<String, dynamic> _$AttendanceTypeResponseToJson(
  AttendanceTypeResponse instance,
) => <String, dynamic>{
  'attendance_types': instance.attendanceTypes,
  'message': instance.message,
  'take_out_of_range_reason': instance.takeOutOfRangeReason,
  'attendance_with_developer_mode_on': instance.attendanceWithDeveloperModeOn,
  'status': instance.status,
  'punch_in_time_view_24_hours': instance.punchInTimeView24Hours,
  'taken_breaks': instance.takenBreaks,
  'per_day_hour_minutes': instance.perDayHourMinutes,
  'multi_punch_data': instance.multiPunchData,
  'wfh_data': instance.wfhData,
  'is_document_uploading_pending': instance.isDocumentUploadingPending,
  'probation_period_days_mandatory': instance.probationPeriodDaysMandatory,
  'last_odometer_reading': instance.lastOdometerReading,
  'shift_data': instance.shiftData,
  'date_time': instance.dateTime,
  'attendance_id': instance.attendanceId,
  'total_work_report': instance.totalWorkReport,
  'total_report_added': instance.totalReportAdded,
  'remaining_work_report': instance.remainingWorkReport,
  'punch_out_limit': instance.punchOutLimit,
  'is_today': instance.isToday,
  'hide_working_hours': instance.hideWorkingHours,
  'multi_punch_in': instance.multiPunchIn,
  'already_punch_out_msg': instance.alreadyPunchOutMsg,
  'punch_in_odometer': instance.punchInOdometer,
  'punch_in_time': instance.punchInTime,
  'punch_in_time_view': instance.punchInTimeView,
  'attendance_start_date': instance.attendanceStartDate,
  'attendance_start_date_view': instance.attendanceStartDateView,
  'time_diff': instance.timeDifference,
  'break_date_time': instance.breakDateTime,
  'attendance_break_history_id': instance.attendanceBreakHistoryId,
  'break_in_time': instance.breakInTime,
  'attendance_type_name': instance.attendanceTypeName,
  'break_time_diff': instance.breakTimeDifference,
  'attendance_type_id': instance.attendanceTypeId,
  'yesterday_punch_out_missing_msg': instance.yesterdayPunchOutMissingMsg,
  'yesterday_punch_out_missing': instance.yesterdayPunchOutMissing,
  'night_shift': instance.nightShift,
  'add_retailer_city_area_add_access': instance.addRetailerCityAreaAddAccess,
  'punch_out_with_task_completion': instance.punchOutWithTaskCompletion,
  'task_completed': instance.taskComplete,
  'already_punch_in': instance.alreadyPunchIn,
  'already_punch_out': instance.alreadyPunchOut,
  'work_report_added': instance.workReportAdded,
  'is_attendance_rejected': instance.isAttendanceRejected,
  'attendance_rejected_message': instance.attendanceRejectedMessage,
  'yesterday_attendance_rejected': instance.yesterdayAttendanceRejected,
  'yesterday_attendance_rejected_message':
      instance.yesterdayAttendanceRejectedMessage,
  'user_face_data': instance.userFaceData,
  'track_user_location': instance.trackUserLocation,
  'face_data_image_two': instance.faceDataImageTwo,
  'face_data_image': instance.faceDataImage,
  'face_added_date': instance.faceAddedDate,
  'missing_date': instance.missingDate,
  'missing_month': instance.missingMonth,
  'missing_year': instance.missingYear,
  'punch_in_latitude': instance.punchInLatitude,
  'punch_in_longitude': instance.punchInLongitude,
  'server_time': instance.serverTime,
  'finger_data_image': instance.fingerDataImage,
  'user_finger_data_updated_date': instance.userFingerDataUpdatedDate,
  'face_or_finger_attendance': instance.faceOrFingerAttendance,
  'face_scan_accuracy': instance.faceScanAccuracy,
  'hide_duty_hour_timer': instance.hideDutyHourTimer,
  'shift_list': instance.shiftList,
  'only_auto_approved_attendance': instance.onlyAutoApprovedAttendanceField,
  'order_without_punch_in': instance.orderWithoutPunchInField,
  'attendance_type': instance.attendanceTypeField,
  'take_attendance_selfie': instance.takeAttendanceSelfieField,
  'take_break_with_approval_employee_app':
      instance.takeBreakWithApprovalEmployeeApp,
  'hide_attendance_face_menu': instance.hideAttendanceFaceMenuField,
  'allow_add_visit': instance.allowAddVisit,
  'attendance_with_matching_face': instance.attendanceWithMatchingFaceField,
  'is_amazon_face_match': instance.isAmazonFaceMatchField,
  'start_end_visit_with_face_match': instance.isStartEndVisitFaceMatchField,
  'odometer_tracking': instance.odometerTrackingField,
  'allow_to_pre_apply_short_leave': instance.allowToPreApplyShortLeaveField,
  'user_location_list': instance.userLocationList,
  'last_punch_in_odometer_image': instance.lastPunchInOdometerImage,
  'multi_punch_data_view': instance.multiPunchDataView,
  'per_day_hour': instance.perDayHour,
  'is_break_start': instance.isBreakStart,
  'is_auto_break_start': instance.isAutoBreakStart,
  'auto_break_start_view': instance.autoBreakStartView,
  'breaks': instance.breaks,
  'productive_hours_in_sec': instance.productiveHoursInSec,
  'time_diff_seconds': instance.timeDiffSeconds,
  'productive_hours_view': instance.productiveHoursView,
  'break_start_color': instance.breakStartColor,
  'break_start_name': instance.breakStartName,
  'attendance_map_type': instance.attendanceMapType,
  'visit_map_type': instance.visitMapType,
  'face_blur_detection': instance.faceBlurDetection,
  'past_attendance_leave_request': instance.pastAttendanceLeaveRequest,
  'i_card_format_type': instance.iCardFormatType,
  'late_in_reason_pending': instance.lateInReasonPending,
  'search_retailer_with_api': instance.searchRetailerWithApi,
  'hsn_code_visible': instance.hsnCodeVisible,
  'auto_leave_remove_reason_required': instance.autoLeaveRemoveReasonRequired,
  'max_attendance_punchout_time': instance.maxAttendancePunchOutTime,
};

AttendanceType _$AttendanceTypeFromJson(Map<String, dynamic> json) =>
    AttendanceType(
      attendanceTypeId: json['attendance_type_id'] as String?,
      attendanceTypeName: json['attendance_type_name'] as String?,
      attendanceBreakKey: json['attendance_break_key'] as String?,
      attendanceBreakMinutes: json['attendance_break_minutes'] as String?,
      breakApprovalRequired: json['break_approval_required'] as bool?,
    );

Map<String, dynamic> _$AttendanceTypeToJson(AttendanceType instance) =>
    <String, dynamic>{
      'attendance_type_id': instance.attendanceTypeId,
      'attendance_type_name': instance.attendanceTypeName,
      'attendance_break_key': instance.attendanceBreakKey,
      'attendance_break_minutes': instance.attendanceBreakMinutes,
      'break_approval_required': instance.breakApprovalRequired,
    };

MultiPunchData _$MultiPunchDataFromJson(Map<String, dynamic> json) =>
    MultiPunchData(
      punchInDate: json['punch_in_date'] as String?,
      punchInTime: json['punch_in_time'] as String?,
      punchOutDate: json['punch_out_date'] as String?,
      punchOutTime: json['punch_out_time'] as String?,
      workingHour: json['working_hour'] as String?,
      workingHourMinute: json['working_hour_minute'] as String?,
      punchInTimeView: json['punch_in_time_view'] as String?,
      punchOutTimeView: json['punch_out_time_view'] as String?,
      workingHourView: json['working_hour_view'] as String?,
      takenBreaks:
          (json['taken_breaks'] as List<dynamic>?)
              ?.map((e) => TakenBreaks.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$MultiPunchDataToJson(MultiPunchData instance) =>
    <String, dynamic>{
      'punch_in_date': instance.punchInDate,
      'punch_in_time': instance.punchInTime,
      'punch_out_date': instance.punchOutDate,
      'punch_out_time': instance.punchOutTime,
      'working_hour': instance.workingHour,
      'working_hour_minute': instance.workingHourMinute,
      'punch_in_time_view': instance.punchInTimeView,
      'punch_out_time_view': instance.punchOutTimeView,
      'working_hour_view': instance.workingHourView,
      'taken_breaks': instance.takenBreaks,
    };

TakenBreaks _$TakenBreaksFromJson(Map<String, dynamic> json) => TakenBreaks(
  attendanceBreakHistoryId: json['attendance_break_history_id'] as String?,
  attendanceTypeId: json['attendance_type_id'] as String?,
  breakStartDate: json['break_start_date'] as String?,
  breakInTime: json['break_in_time'] as String?,
  breakInTimeView: json['break_in_time_view'] as String?,
  breakOutTimeview: json['break_out_time_view'] as String?,
  totalBreaktimeView: json['total_break_time_view'] as String?,
  breakName: json['break_name'] as String?,
  breakEndDate: json['break_end_date'] as String?,
  breakOutTime: json['break_out_time'] as String?,
  totalBreakTime: json['total_break_time'] as String?,
  totalBreakTimeMinutes: json['total_break_time_minutes'] as String?,
  breakColor: json['break_color'] as String?,
  attendanceBreakKey: json['attendance_break_key'] as String?,
);

Map<String, dynamic> _$TakenBreaksToJson(TakenBreaks instance) =>
    <String, dynamic>{
      'attendance_break_history_id': instance.attendanceBreakHistoryId,
      'attendance_type_id': instance.attendanceTypeId,
      'break_start_date': instance.breakStartDate,
      'break_in_time': instance.breakInTime,
      'break_in_time_view': instance.breakInTimeView,
      'break_out_time_view': instance.breakOutTimeview,
      'total_break_time_view': instance.totalBreaktimeView,
      'break_name': instance.breakName,
      'break_end_date': instance.breakEndDate,
      'break_out_time': instance.breakOutTime,
      'total_break_time': instance.totalBreakTime,
      'total_break_time_minutes': instance.totalBreakTimeMinutes,
      'break_color': instance.breakColor,
      'attendance_break_key': instance.attendanceBreakKey,
    };

Break__1 _$Break__1FromJson(Map<String, dynamic> json) => Break__1(
  breakColor: json['break_color'] as String?,
  breakName: json['break_name'] as String?,
  startMinutes: json['start_minutes'] as String?,
  endMinutes: json['end_minutes'] as String?,
  totalMinutes: json['total_minutes'] as String?,
  breakTimeView: json['break_time_view'] as String?,
);

Map<String, dynamic> _$Break__1ToJson(Break__1 instance) => <String, dynamic>{
  'break_color': instance.breakColor,
  'break_name': instance.breakName,
  'start_minutes': instance.startMinutes,
  'end_minutes': instance.endMinutes,
  'total_minutes': instance.totalMinutes,
  'break_time_view': instance.breakTimeView,
};

MultiPunchDataView _$MultiPunchDataViewFromJson(Map<String, dynamic> json) =>
    MultiPunchDataView(
      punchInDate: json['punch_in_date'] as String?,
      punchInTime: json['punch_in_time'] as String?,
      punchInTimeView: json['punch_in_time_view'] as String?,
      punchOutDate: json['punch_out_date'] as String?,
      punchOutTime: json['punch_out_time'] as String?,
      punchOutTimeView: json['punch_out_time_view'] as String?,
      workingHour: json['working_hour'] as String?,
      workingHourView: json['working_hour_view'] as String?,
      workingHourMinute: json['working_hour_minute'] as String?,
      breaks:
          (json['breaks'] as List<dynamic>?)
              ?.map((e) => Break.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$MultiPunchDataViewToJson(MultiPunchDataView instance) =>
    <String, dynamic>{
      'punch_in_date': instance.punchInDate,
      'punch_in_time': instance.punchInTime,
      'punch_in_time_view': instance.punchInTimeView,
      'punch_out_date': instance.punchOutDate,
      'punch_out_time': instance.punchOutTime,
      'punch_out_time_view': instance.punchOutTimeView,
      'working_hour': instance.workingHour,
      'working_hour_view': instance.workingHourView,
      'working_hour_minute': instance.workingHourMinute,
      'breaks': instance.breaks,
    };

Break _$BreakFromJson(Map<String, dynamic> json) => Break(
  attendanceBreakHistoryId: json['attendance_break_history_id'] as String?,
  attendanceTypeId: json['attendance_type_id'] as String?,
  breakStartDate: json['break_start_date'] as String?,
  breakInTime: json['break_in_time'] as String?,
  breakInTimeView: json['break_in_time_view'] as String?,
  breakEndDate: json['break_end_date'] as String?,
  breakOutTime: json['break_out_time'] as String?,
  breakOutTimeView: json['break_out_time_view'] as String?,
  totalBreakTime: json['total_break_time'] as String?,
  totalBreakTimeView: json['total_break_time_view'] as String?,
  attendanceBreakKey: json['attendance_break_key'] as String?,
  breakColor: json['break_color'] as String?,
  breakName: json['break_name'] as String?,
  startMinutes: json['start_minutes'] as String?,
  endMinutes: json['end_minutes'] as String?,
  totalMinutes: json['total_minutes'] as String?,
  breakTimeView: json['break_time_view'] as String?,
);

Map<String, dynamic> _$BreakToJson(Break instance) => <String, dynamic>{
  'attendance_break_history_id': instance.attendanceBreakHistoryId,
  'attendance_type_id': instance.attendanceTypeId,
  'break_start_date': instance.breakStartDate,
  'break_in_time': instance.breakInTime,
  'break_in_time_view': instance.breakInTimeView,
  'break_end_date': instance.breakEndDate,
  'break_out_time': instance.breakOutTime,
  'break_out_time_view': instance.breakOutTimeView,
  'total_break_time': instance.totalBreakTime,
  'total_break_time_view': instance.totalBreakTimeView,
  'attendance_break_key': instance.attendanceBreakKey,
  'break_color': instance.breakColor,
  'break_name': instance.breakName,
  'start_minutes': instance.startMinutes,
  'end_minutes': instance.endMinutes,
  'total_minutes': instance.totalMinutes,
  'break_time_view': instance.breakTimeView,
};
