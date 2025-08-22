import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myco_flutter/features/dashboard/data/models/my_unit_response.dart';
import 'package:myco_flutter/features/dashboard/data/models/shift_data_response.dart';
import 'package:myco_flutter/features/dashboard/data/models/shift_list.dart';
import 'package:myco_flutter/features/dashboard/data/models/wfh_data_response.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/attendance_type_response_entity.dart';

part 'attendance_type_response.g.dart';

AttendanceTypeResponse attendanceTypeResponseFromJson(String str) =>
    AttendanceTypeResponse.fromJson(json.decode(str));

String attendanceTypeResponseToJson(AttendanceTypeResponse data) =>
    json.encode(data.toJson());

@HiveType(typeId: 13) // Assign a new unique typeId
@JsonSerializable()
class AttendanceTypeResponse {
  @HiveField(0)
  @JsonKey(name: "attendance_types")
  List<AttendanceType>? attendanceTypes;
  @HiveField(1)
  @JsonKey(name: "message")
  String? message;
  @HiveField(2)
  @JsonKey(name: "take_out_of_range_reason")
  bool? takeOutOfRangeReason;
  @HiveField(3)
  @JsonKey(name: "attendance_with_developer_mode_on")
  bool? attendanceWithDeveloperModeOn;
  @HiveField(4)
  @JsonKey(name: "status")
  String? status;
  @HiveField(5)
  @JsonKey(name: "punch_in_time_view_24_hours")
  String? punchInTimeView24Hours;
  @HiveField(6)
  @JsonKey(name: "taken_breaks")
  List<TakenBreaks>? takenBreaks;
  @HiveField(7)
  @JsonKey(name: "per_day_hour_minutes")
  String? perDayHourMinutes;
  @HiveField(8)
  @JsonKey(name: "multi_punch_data")
  List<MultiPunchData>? multiPunchData;
  @HiveField(9)
  @JsonKey(name: "wfh_data")
  WFHDataResponse? wfhData;
  @HiveField(10)
  @JsonKey(name: "is_document_uploading_pending")
  bool? isDocumentUploadingPending;
  @HiveField(11)
  @JsonKey(name: "probation_period_days_mandatory")
  bool? probationPeriodDaysMandatory;
  @HiveField(12)
  @JsonKey(name: "last_odometer_reading")
  String? lastOdometerReading;
  @HiveField(13)
  @JsonKey(name: "shift_data")
  ShiftDataResponse? shiftData;
  @HiveField(14)
  @JsonKey(name: "date_time")
  String? dateTime;
  @HiveField(15)
  @JsonKey(name: "attendance_id")
  String? attendanceId;
  @HiveField(16)
  @JsonKey(name: "total_work_report")
  String? totalWorkReport;
  @HiveField(17)
  @JsonKey(name: "total_report_added")
  String? totalReportAdded;
  @HiveField(18)
  @JsonKey(name: "remaining_work_report")
  String? remainingWorkReport;
  @HiveField(19)
  @JsonKey(name: "punch_out_limit")
  bool? punchOutLimit;
  @HiveField(20)
  @JsonKey(name: "is_today")
  bool? isToday;
  @HiveField(21)
  @JsonKey(name: "hide_working_hours")
  bool? hideWorkingHours;
  @HiveField(22)
  @JsonKey(name: "multi_punch_in")
  bool? multiPunchIn;
  @HiveField(23)
  @JsonKey(name: "already_punch_out_msg")
  String? alreadyPunchOutMsg;
  @HiveField(24)
  @JsonKey(name: "punch_in_odometer")
  bool? punchInOdometer;
  @HiveField(25)
  @JsonKey(name: "punch_in_time")
  String? punchInTime;
  @HiveField(26)
  @JsonKey(name: "punch_in_time_view")
  String? punchInTimeView;
  @HiveField(27)
  @JsonKey(name: "attendance_start_date")
  String? attendanceStartDate;
  @HiveField(28)
  @JsonKey(name: "attendance_start_date_view")
  String? attendanceStartDateView;
  @HiveField(29)
  @JsonKey(name: "time_diff")
  String? timeDifference;
  @HiveField(30)
  @JsonKey(name: "break_date_time")
  String? breakDateTime;
  @HiveField(31)
  @JsonKey(name: "attendance_break_history_id")
  String? attendanceBreakHistoryId;
  @HiveField(32)
  @JsonKey(name: "break_in_time")
  String? breakInTime;
  @HiveField(33)
  @JsonKey(name: "attendance_type_name")
  String? attendanceTypeName;
  @HiveField(34)
  @JsonKey(name: "break_time_diff")
  String? breakTimeDifference;
  @HiveField(35)
  @JsonKey(name: "attendance_type_id")
  String? attendanceTypeId;
  @HiveField(36)
  @JsonKey(name: "yesterday_punch_out_missing_msg")
  String? yesterdayPunchOutMissingMsg;
  @HiveField(37)
  @JsonKey(name: "yesterday_punch_out_missing")
  bool? yesterdayPunchOutMissing;
  @HiveField(38)
  @JsonKey(name: "night_shift")
  bool? nightShift;
  @HiveField(39)
  @JsonKey(name: "add_retailer_city_area_add_access")
  bool? addRetailerCityAreaAddAccess;
  @HiveField(40)
  @JsonKey(name: "punch_out_with_task_completion")
  bool? punchOutWithTaskCompletion;
  @HiveField(41)
  @JsonKey(name: "task_completed")
  bool? taskComplete;
  @HiveField(42)
  @JsonKey(name: "already_punch_in")
  bool? alreadyPunchIn;
  @HiveField(43)
  @JsonKey(name: "already_punch_out")
  bool? alreadyPunchOut;
  @HiveField(44)
  @JsonKey(name: "work_report_added")
  bool? workReportAdded;
  @HiveField(45)
  @JsonKey(name: "is_attendance_rejected")
  bool? isAttendanceRejected;
  @HiveField(46)
  @JsonKey(name: "attendance_rejected_message")
  String? attendanceRejectedMessage;
  @HiveField(47)
  @JsonKey(name: "yesterday_attendance_rejected")
  bool? yesterdayAttendanceRejected;
  @HiveField(48)
  @JsonKey(name: "yesterday_attendance_rejected_message")
  String? yesterdayAttendanceRejectedMessage;
  @HiveField(49)
  @JsonKey(name: "user_face_data")
  String? userFaceData;
  @HiveField(50)
  @JsonKey(name: "track_user_location")
  bool? trackUserLocation;
  @HiveField(51)
  @JsonKey(name: "face_data_image_two")
  String? faceDataImageTwo;
  @HiveField(52)
  @JsonKey(name: "face_data_image")
  String? faceDataImage;
  @HiveField(53)
  @JsonKey(name: "face_added_date")
  String? faceAddedDate;
  @HiveField(54)
  @JsonKey(name: "missing_date")
  String? missingDate;
  @HiveField(55)
  @JsonKey(name: "missing_month")
  String? missingMonth;
  @HiveField(56)
  @JsonKey(name: "missing_year")
  String? missingYear;
  @HiveField(57)
  @JsonKey(name: "punch_in_latitude")
  String? punchInLatitude;
  @HiveField(58)
  @JsonKey(name: "punch_in_longitude")
  String? punchInLongitude;
  @HiveField(59)
  @JsonKey(name: "server_time")
  String? serverTime;
  @HiveField(60)
  @JsonKey(name: "finger_data_image")
  String? fingerDataImage;
  @HiveField(61)
  @JsonKey(name: "user_finger_data_updated_date")
  String? userFingerDataUpdatedDate;
  @HiveField(62)
  @JsonKey(name: "face_or_finger_attendance")
  String? faceOrFingerAttendance;
  @HiveField(63)
  @JsonKey(name: "face_scan_accuracy")
  String? faceScanAccuracy;
  @HiveField(64)
  @JsonKey(name: "hide_duty_hour_timer")
  bool? hideDutyHourTimer;
  @HiveField(65)
  @JsonKey(name: "shift_list")
  List<ShiftList>? shiftList;
  @HiveField(66)
  @JsonKey(name: "only_auto_approved_attendance")
  bool? onlyAutoApprovedAttendanceField; // Renamed to avoid conflict
  @HiveField(67)
  @JsonKey(name: "order_without_punch_in")
  bool? orderWithoutPunchInField; // Renamed to avoid conflict
  @HiveField(68)
  @JsonKey(name: "attendance_type")
  String? attendanceTypeField; // Renamed to avoid conflict
  @HiveField(69)
  @JsonKey(name: "take_attendance_selfie")
  String? takeAttendanceSelfieField; // Renamed to avoid conflict
  @HiveField(70)
  @JsonKey(name: "take_break_with_approval_employee_app")
  String? takeBreakWithApprovalEmployeeApp;
  @HiveField(71)
  @JsonKey(name: "hide_attendance_face_menu")
  bool? hideAttendanceFaceMenuField; // Renamed to avoid conflict
  @HiveField(72)
  @JsonKey(name: "allow_add_visit")
  bool? allowAddVisit;
  @HiveField(73)
  @JsonKey(name: "attendance_with_matching_face")
  bool? attendanceWithMatchingFaceField; // Renamed to avoid conflict
  @HiveField(74)
  @JsonKey(name: "is_amazon_face_match")
  bool? isAmazonFaceMatchField; // Renamed to avoid conflict
  @HiveField(75)
  @JsonKey(name: "start_end_visit_with_face_match")
  bool? isStartEndVisitFaceMatchField; // Renamed to avoid conflict
  @HiveField(76)
  @JsonKey(name: "odometer_tracking")
  bool? odometerTrackingField; // Renamed to avoid conflict
  @HiveField(77)
  @JsonKey(name: "allow_to_pre_apply_short_leave")
  bool? allowToPreApplyShortLeaveField; // Renamed to avoid conflict
  @HiveField(78)
  @JsonKey(name: "user_location_list")
  List<UserLocationList>? userLocationList;
  @HiveField(79)
  @JsonKey(name: "last_punch_in_odometer_image")
  String? lastPunchInOdometerImage;
  @HiveField(80)
  @JsonKey(name: "multi_punch_data_view")
  List<MultiPunchDataView>? multiPunchDataView;
  @HiveField(81)
  @JsonKey(name: "per_day_hour")
  String? perDayHour;
  @HiveField(82)
  @JsonKey(name: "is_break_start")
  bool? isBreakStart;
  @HiveField(83)
  @JsonKey(name: "is_auto_break_start")
  bool? isAutoBreakStart;
  @HiveField(84)
  @JsonKey(name: "auto_break_start_view")
  String? autoBreakStartView;
  @HiveField(85)
  @JsonKey(name: "breaks")
  List<Break__1>? breaks;
  @HiveField(86)
  @JsonKey(name: "productive_hours_in_sec")
  String? productiveHoursInSec;
  @HiveField(87)
  @JsonKey(name: "time_diff_seconds")
  String? timeDiffSeconds;
  @HiveField(88)
  @JsonKey(name: "productive_hours_view")
  String? productiveHoursView;
  @HiveField(89)
  @JsonKey(name: "break_start_color")
  String? breakStartColor;
  @HiveField(90)
  @JsonKey(name: "break_start_name")
  String? breakStartName;
  @HiveField(91)
  @JsonKey(name: "attendance_map_type")
  String? attendanceMapType;
  @HiveField(92)
  @JsonKey(name: "visit_map_type")
  String? visitMapType;
  @HiveField(93)
  @JsonKey(name: "face_blur_detection")
  String? faceBlurDetection;
  @HiveField(94)
  @JsonKey(name: "past_attendance_leave_request")
  String? pastAttendanceLeaveRequest;
  @HiveField(95)
  @JsonKey(name: "i_card_format_type")
  String? iCardFormatType;
  @HiveField(96)
  @JsonKey(name: "late_in_reason_pending")
  bool? lateInReasonPending;
  @HiveField(97)
  @JsonKey(name: "search_retailer_with_api")
  bool? searchRetailerWithApi;
  @HiveField(98)
  @JsonKey(name: "hsn_code_visible")
  bool? hsnCodeVisible;
  @HiveField(99)
  @JsonKey(name: "auto_leave_remove_reason_required")
  bool? autoLeaveRemoveReasonRequired;
  @HiveField(100)
  @JsonKey(name: "max_attendance_punchout_time")
  String? maxAttendancePunchOutTime;

  AttendanceTypeResponse({
    this.attendanceTypes,
    this.message,
    this.takeOutOfRangeReason,
    this.attendanceWithDeveloperModeOn,
    this.status,
    this.punchInTimeView24Hours,
    this.takenBreaks,
    this.perDayHourMinutes,
    this.multiPunchData,
    this.wfhData,
    this.isDocumentUploadingPending,
    this.probationPeriodDaysMandatory,
    this.lastOdometerReading,
    this.shiftData,
    this.dateTime,
    this.attendanceId,
    this.totalWorkReport,
    this.totalReportAdded,
    this.remainingWorkReport,
    this.punchOutLimit,
    this.isToday,
    this.hideWorkingHours,
    this.multiPunchIn,
    this.alreadyPunchOutMsg,
    this.punchInOdometer,
    this.punchInTime,
    this.punchInTimeView,
    this.attendanceStartDate,
    this.attendanceStartDateView,
    this.timeDifference,
    this.breakDateTime,
    this.attendanceBreakHistoryId,
    this.breakInTime,
    this.attendanceTypeName,
    this.breakTimeDifference,
    this.attendanceTypeId,
    this.yesterdayPunchOutMissingMsg,
    this.yesterdayPunchOutMissing,
    this.nightShift,
    this.addRetailerCityAreaAddAccess,
    this.punchOutWithTaskCompletion,
    this.taskComplete,
    this.alreadyPunchIn,
    this.alreadyPunchOut,
    this.workReportAdded,
    this.isAttendanceRejected,
    this.attendanceRejectedMessage,
    this.yesterdayAttendanceRejected,
    this.yesterdayAttendanceRejectedMessage,
    this.userFaceData,
    this.trackUserLocation,
    this.faceDataImageTwo,
    this.faceDataImage,
    this.faceAddedDate,
    this.missingDate,
    this.missingMonth,
    this.missingYear,
    this.punchInLatitude,
    this.punchInLongitude,
    this.serverTime,
    this.fingerDataImage,
    this.userFingerDataUpdatedDate,
    this.faceOrFingerAttendance,
    this.faceScanAccuracy,
    this.hideDutyHourTimer,
    this.shiftList,
    this.onlyAutoApprovedAttendanceField,
    this.orderWithoutPunchInField,
    this.attendanceTypeField,
    this.takeAttendanceSelfieField,
    this.takeBreakWithApprovalEmployeeApp,
    this.hideAttendanceFaceMenuField,
    this.allowAddVisit,
    this.attendanceWithMatchingFaceField,
    this.isAmazonFaceMatchField,
    this.isStartEndVisitFaceMatchField,
    this.odometerTrackingField,
    this.allowToPreApplyShortLeaveField,
    this.userLocationList,
    this.lastPunchInOdometerImage,
    this.multiPunchDataView,
    this.perDayHour,
    this.isBreakStart,
    this.isAutoBreakStart,
    this.autoBreakStartView,
    this.breaks,
    this.productiveHoursInSec,
    this.timeDiffSeconds,
    this.productiveHoursView,
    this.breakStartColor,
    this.breakStartName,
    this.attendanceMapType,
    this.visitMapType,
    this.faceBlurDetection,
    this.pastAttendanceLeaveRequest,
    this.iCardFormatType,
    this.lateInReasonPending,
    this.searchRetailerWithApi,
    this.hsnCodeVisible,
    this.autoLeaveRemoveReasonRequired,
    this.maxAttendancePunchOutTime,
  });

  factory AttendanceTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$AttendanceTypeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceTypeResponseToJson(this);

  AttendanceTypeResponseEntity toEntity() => AttendanceTypeResponseEntity(
    attendanceTypes: attendanceTypes?.map((e) => e.toEntity()).toList(),
    message: message,
    takeOutOfRangeReason: takeOutOfRangeReason,
    attendanceWithDeveloperModeOn: attendanceWithDeveloperModeOn,
    status: status,
    punchInTimeView24Hours: punchInTimeView24Hours,
    takenBreaks: takenBreaks?.map((e) => e.toEntity()).toList(),
    perDayHourMinutes: perDayHourMinutes,
    multiPunchData: multiPunchData?.map((e) => e.toEntity()).toList(),
    wfhData: wfhData?.toEntity(),
    isDocumentUploadingPending: isDocumentUploadingPending,
    probationPeriodDaysMandatory: probationPeriodDaysMandatory,
    lastOdometerReading: lastOdometerReading,
    shiftData: shiftData?.toEntity(),
    dateTime: dateTime,
    attendanceId: attendanceId,
    totalWorkReport: totalWorkReport,
    totalReportAdded: totalReportAdded,
    remainingWorkReport: remainingWorkReport,
    punchOutLimit: punchOutLimit,
    isToday: isToday,
    hideWorkingHours: hideWorkingHours,
    multiPunchIn: multiPunchIn,
    alreadyPunchOutMsg: alreadyPunchOutMsg,
    punchInOdometer: punchInOdometer,
    punchInTime: punchInTime,
    punchInTimeView: punchInTimeView,
    attendanceStartDate: attendanceStartDate,
    attendanceStartDateView: attendanceStartDateView,
    timeDifference: timeDifference,
    breakDateTime: breakDateTime,
    attendanceBreakHistoryId: attendanceBreakHistoryId,
    breakInTime: breakInTime,
    attendanceTypeName: attendanceTypeName,
    breakTimeDifference: breakTimeDifference,
    attendanceTypeId: attendanceTypeId,
    yesterdayPunchOutMissingMsg: yesterdayPunchOutMissingMsg,
    yesterdayPunchOutMissing: yesterdayPunchOutMissing,
    nightShift: nightShift,
    addRetailerCityAreaAddAccess: addRetailerCityAreaAddAccess,
    punchOutWithTaskCompletion: punchOutWithTaskCompletion,
    taskComplete: taskComplete,
    alreadyPunchIn: alreadyPunchIn,
    alreadyPunchOut: alreadyPunchOut,
    workReportAdded: workReportAdded,
    isAttendanceRejected: isAttendanceRejected,
    attendanceRejectedMessage: attendanceRejectedMessage,
    yesterdayAttendanceRejected: yesterdayAttendanceRejected,
    yesterdayAttendanceRejectedMessage: yesterdayAttendanceRejectedMessage,
    userFaceData: userFaceData,
    trackUserLocation: trackUserLocation,
    faceDataImageTwo: faceDataImageTwo,
    faceDataImage: faceDataImage,
    faceAddedDate: faceAddedDate,
    missingDate: missingDate,
    missingMonth: missingMonth,
    missingYear: missingYear,
    punchInLatitude: punchInLatitude,
    punchInLongitude: punchInLongitude,
    serverTime: serverTime,
    fingerDataImage: fingerDataImage,
    userFingerDataUpdatedDate: userFingerDataUpdatedDate,
    faceOrFingerAttendance: faceOrFingerAttendance,
    faceScanAccuracy: faceScanAccuracy,
    hideDutyHourTimer: hideDutyHourTimer,
    shiftList: shiftList?.map((e) => e.toEntity()).toList(),
    onlyAutoApprovedAttendanceField: onlyAutoApprovedAttendanceField,
    orderWithoutPunchInField: orderWithoutPunchInField,
    attendanceTypeField: attendanceTypeField,
    takeAttendanceSelfieField: takeAttendanceSelfieField,
    takeBreakWithApprovalEmployeeApp: takeBreakWithApprovalEmployeeApp,
    hideAttendanceFaceMenuField: hideAttendanceFaceMenuField,
    allowAddVisit: allowAddVisit,
    attendanceWithMatchingFaceField: attendanceWithMatchingFaceField,
    isAmazonFaceMatchField: isAmazonFaceMatchField,
    isStartEndVisitFaceMatchField: isStartEndVisitFaceMatchField,
    odometerTrackingField: odometerTrackingField,
    allowToPreApplyShortLeaveField: allowToPreApplyShortLeaveField,
    userLocationList: userLocationList?.map((e) => e.toEntity()).toList(),
    lastPunchInOdometerImage: lastPunchInOdometerImage,
    multiPunchDataView: multiPunchDataView?.map((e) => e.toEntity()).toList(),
    perDayHour: perDayHour,
    isBreakStart: isBreakStart,
    isAutoBreakStart: isAutoBreakStart,
    autoBreakStartView: autoBreakStartView,
    breaks: breaks?.map((e) => e.toEntity()).toList(),
    productiveHoursInSec: productiveHoursInSec,
    timeDiffSeconds: timeDiffSeconds,
    productiveHoursView: productiveHoursView,
    breakStartColor: breakStartColor,
    breakStartName: breakStartName,
    attendanceMapType: attendanceMapType,
    visitMapType: visitMapType,
    faceBlurDetection: faceBlurDetection,
    pastAttendanceLeaveRequest: pastAttendanceLeaveRequest,
    iCardFormatType: iCardFormatType,
    lateInReasonPending: lateInReasonPending,
    searchRetailerWithApi: searchRetailerWithApi,
    hsnCodeVisible: hsnCodeVisible,
    autoLeaveRemoveReasonRequired: autoLeaveRemoveReasonRequired,
    maxAttendancePunchOutTime: maxAttendancePunchOutTime,
  );
}

@HiveType(typeId: 14) // Assign a new unique typeId
@JsonSerializable()
class AttendanceType {
  @HiveField(0)
  @JsonKey(name: "attendance_type_id")
  String? attendanceTypeId;
  @HiveField(1)
  @JsonKey(name: "attendance_type_name")
  String? attendanceTypeName;
  @HiveField(2)
  @JsonKey(name: "attendance_break_key")
  String? attendanceBreakKey;
  @HiveField(3)
  @JsonKey(name: "attendance_break_minutes")
  String? attendanceBreakMinutes;
  @HiveField(4)
  @JsonKey(name: "break_approval_required")
  bool? breakApprovalRequired;

  AttendanceType({
    this.attendanceTypeId,
    this.attendanceTypeName,
    this.attendanceBreakKey,
    this.attendanceBreakMinutes,
    this.breakApprovalRequired,
  });

  factory AttendanceType.fromJson(Map<String, dynamic> json) =>
      _$AttendanceTypeFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceTypeToJson(this);

  AttendanceTypeEntity toEntity() => AttendanceTypeEntity(
    attendanceTypeId: attendanceTypeId,
    attendanceTypeName: attendanceTypeName,
    attendanceBreakKey: attendanceBreakKey,
    attendanceBreakMinutes: attendanceBreakMinutes,
    breakApprovalRequired: breakApprovalRequired,
  );
}

@HiveType(typeId: 15) // Assign a new unique typeId
@JsonSerializable()
class MultiPunchData {
  @HiveField(0)
  @JsonKey(name: "punch_in_date")
  String? punchInDate;
  @HiveField(1)
  @JsonKey(name: "punch_in_time")
  String? punchInTime;
  @HiveField(2)
  @JsonKey(name: "punch_out_date")
  String? punchOutDate;
  @HiveField(3)
  @JsonKey(name: "punch_out_time")
  String? punchOutTime;
  @HiveField(4)
  @JsonKey(name: "working_hour")
  String? workingHour;
  @HiveField(5)
  @JsonKey(name: "working_hour_minute")
  String? workingHourMinute;
  @HiveField(6)
  @JsonKey(name: "punch_in_time_view")
  String? punchInTimeView;
  @HiveField(7)
  @JsonKey(name: "punch_out_time_view")
  String? punchOutTimeView;
  @HiveField(8)
  @JsonKey(name: "working_hour_view")
  String? workingHourView;
  @HiveField(9)
  @JsonKey(name: "taken_breaks")
  List<TakenBreaks>? takenBreaks;

  MultiPunchData({
    this.punchInDate,
    this.punchInTime,
    this.punchOutDate,
    this.punchOutTime,
    this.workingHour,
    this.workingHourMinute,
    this.punchInTimeView,
    this.punchOutTimeView,
    this.workingHourView,
    this.takenBreaks,
  });

  factory MultiPunchData.fromJson(Map<String, dynamic> json) =>
      _$MultiPunchDataFromJson(json);

  Map<String, dynamic> toJson() => _$MultiPunchDataToJson(this);

  MultiPunchDataEntity toEntity() => MultiPunchDataEntity(
    punchInDate: punchInDate,
    punchInTime: punchInTime,
    punchOutDate: punchOutDate,
    punchOutTime: punchOutTime,
    workingHour: workingHour,
    workingHourMinute: workingHourMinute,
    punchInTimeView: punchInTimeView,
    punchOutTimeView: punchOutTimeView,
    workingHourView: workingHourView,
    takenBreaks: takenBreaks?.map((e) => e.toEntity()).toList(),
  );
}

@HiveType(typeId: 16) // Assign a new unique typeId
@JsonSerializable()
class TakenBreaks {
  @HiveField(0)
  @JsonKey(name: "attendance_break_history_id")
  String? attendanceBreakHistoryId;
  @HiveField(1)
  @JsonKey(name: "attendance_type_id")
  String? attendanceTypeId;
  @HiveField(2)
  @JsonKey(name: "break_start_date")
  String? breakStartDate;
  @HiveField(3)
  @JsonKey(name: "break_in_time")
  String? breakInTime;
  @HiveField(4)
  @JsonKey(name: "break_in_time_view")
  String? breakInTimeView;
  @HiveField(5)
  @JsonKey(name: "break_out_time_view")
  String? breakOutTimeview;
  @HiveField(6)
  @JsonKey(name: "total_break_time_view")
  String? totalBreaktimeView;
  @HiveField(7)
  @JsonKey(name: "break_name")
  String? breakName;
  @HiveField(8)
  @JsonKey(name: "break_end_date")
  String? breakEndDate;
  @HiveField(9)
  @JsonKey(name: "break_out_time")
  String? breakOutTime;
  @HiveField(10)
  @JsonKey(name: "total_break_time")
  String? totalBreakTime;
  @HiveField(11)
  @JsonKey(name: "total_break_time_minutes")
  String? totalBreakTimeMinutes;
  @HiveField(12)
  @JsonKey(name: "break_color")
  String? breakColor;
  @HiveField(13)
  @JsonKey(name: "attendance_break_key")
  String? attendanceBreakKey;

  TakenBreaks({
    this.attendanceBreakHistoryId,
    this.attendanceTypeId,
    this.breakStartDate,
    this.breakInTime,
    this.breakInTimeView,
    this.breakOutTimeview,
    this.totalBreaktimeView,
    this.breakName,
    this.breakEndDate,
    this.breakOutTime,
    this.totalBreakTime,
    this.totalBreakTimeMinutes,
    this.breakColor,
    this.attendanceBreakKey,
  });

  factory TakenBreaks.fromJson(Map<String, dynamic> json) =>
      _$TakenBreaksFromJson(json);

  Map<String, dynamic> toJson() => _$TakenBreaksToJson(this);

  TakenBreaksEntity toEntity() => TakenBreaksEntity(
    attendanceBreakHistoryId: attendanceBreakHistoryId,
    attendanceTypeId: attendanceTypeId,
    breakStartDate: breakStartDate,
    breakInTime: breakInTime,
    breakInTimeView: breakInTimeView,
    breakOutTimeview: breakOutTimeview,
    totalBreaktimeView: totalBreaktimeView,
    breakName: breakName,
    breakEndDate: breakEndDate,
    breakOutTime: breakOutTime,
    totalBreakTime: totalBreakTime,
    totalBreakTimeMinutes: totalBreakTimeMinutes,
    breakColor: breakColor,
    attendanceBreakKey: attendanceBreakKey,
  );
}

@HiveType(typeId: 17) // Assign a new unique typeId
@JsonSerializable()
class Break__1 {
  @HiveField(0)
  @JsonKey(name: "break_color")
  String? breakColor;
  @HiveField(1)
  @JsonKey(name: "break_name")
  String? breakName;
  @HiveField(2)
  @JsonKey(name: "start_minutes")
  String? startMinutes;
  @HiveField(3)
  @JsonKey(name: "end_minutes")
  String? endMinutes;
  @HiveField(4)
  @JsonKey(name: "total_minutes")
  String? totalMinutes;
  @HiveField(5)
  @JsonKey(name: "break_time_view")
  String? breakTimeView;

  Break__1({
    this.breakColor,
    this.breakName,
    this.startMinutes,
    this.endMinutes,
    this.totalMinutes,
    this.breakTimeView,
  });

  factory Break__1.fromJson(Map<String, dynamic> json) =>
      _$Break__1FromJson(json);

  Map<String, dynamic> toJson() => _$Break__1ToJson(this);

  Break1Entity toEntity() => Break1Entity(
    breakColor: breakColor,
    breakName: breakName,
    startMinutes: startMinutes,
    endMinutes: endMinutes,
    totalMinutes: totalMinutes,
    breakTimeView: breakTimeView,
  );
}

@HiveType(typeId: 18) // Assign a new unique typeId
@JsonSerializable()
class MultiPunchDataView {
  @HiveField(0)
  @JsonKey(name: "punch_in_date")
  String? punchInDate;
  @HiveField(1)
  @JsonKey(name: "punch_in_time")
  String? punchInTime;
  @HiveField(2)
  @JsonKey(name: "punch_in_time_view")
  String? punchInTimeView;
  @HiveField(3)
  @JsonKey(name: "punch_out_date")
  String? punchOutDate;
  @HiveField(4)
  @JsonKey(name: "punch_out_time")
  String? punchOutTime;
  @HiveField(5)
  @JsonKey(name: "punch_out_time_view")
  String? punchOutTimeView;
  @HiveField(6)
  @JsonKey(name: "working_hour")
  String? workingHour;
  @HiveField(7)
  @JsonKey(name: "working_hour_view")
  String? workingHourView;
  @HiveField(8)
  @JsonKey(name: "working_hour_minute")
  String? workingHourMinute;
  @HiveField(9)
  @JsonKey(name: "breaks")
  List<Break>? breaks; // Note: This refers to the Break class within this file

  MultiPunchDataView({
    this.punchInDate,
    this.punchInTime,
    this.punchInTimeView,
    this.punchOutDate,
    this.punchOutTime,
    this.punchOutTimeView,
    this.workingHour,
    this.workingHourView,
    this.workingHourMinute,
    this.breaks,
  });

  factory MultiPunchDataView.fromJson(Map<String, dynamic> json) =>
      _$MultiPunchDataViewFromJson(json);

  Map<String, dynamic> toJson() => _$MultiPunchDataViewToJson(this);

  MultiPunchDataViewEntity toEntity() => MultiPunchDataViewEntity(
    punchInDate: punchInDate,
    punchInTime: punchInTime,
    punchInTimeView: punchInTimeView,
    punchOutDate: punchOutDate,
    punchOutTime: punchOutTime,
    punchOutTimeView: punchOutTimeView,
    workingHour: workingHour,
    workingHourView: workingHourView,
    workingHourMinute: workingHourMinute,
    breaks: breaks?.map((e) => e.toEntity()).toList(),
  );
}

@HiveType(typeId: 19) // Assign a new unique typeId
@JsonSerializable()
class Break {
  @HiveField(0)
  @JsonKey(name: "attendance_break_history_id")
  String? attendanceBreakHistoryId;
  @HiveField(1)
  @JsonKey(name: "attendance_type_id")
  String? attendanceTypeId;
  @HiveField(2)
  @JsonKey(name: "break_start_date")
  String? breakStartDate;
  @HiveField(3)
  @JsonKey(name: "break_in_time")
  String? breakInTime;
  @HiveField(4)
  @JsonKey(name: "break_in_time_view")
  String? breakInTimeView;
  @HiveField(5)
  @JsonKey(name: "break_end_date")
  String? breakEndDate;
  @HiveField(6)
  @JsonKey(name: "break_out_time")
  String? breakOutTime;
  @HiveField(7)
  @JsonKey(name: "break_out_time_view")
  String? breakOutTimeView;
  @HiveField(8)
  @JsonKey(name: "total_break_time")
  String? totalBreakTime;
  @HiveField(9)
  @JsonKey(name: "total_break_time_view")
  String? totalBreakTimeView;
  @HiveField(10)
  @JsonKey(name: "attendance_break_key")
  String? attendanceBreakKey;
  @HiveField(11)
  @JsonKey(name: "break_color")
  String? breakColor;
  @HiveField(12)
  @JsonKey(name: "break_name")
  String? breakName;
  @HiveField(13)
  @JsonKey(name: "start_minutes")
  String? startMinutes;
  @HiveField(14)
  @JsonKey(name: "end_minutes")
  String? endMinutes;
  @HiveField(15)
  @JsonKey(name: "total_minutes")
  String? totalMinutes;
  @HiveField(16)
  @JsonKey(name: "break_time_view")
  String? breakTimeView;

  Break({
    this.attendanceBreakHistoryId,
    this.attendanceTypeId,
    this.breakStartDate,
    this.breakInTime,
    this.breakInTimeView,
    this.breakEndDate,
    this.breakOutTime,
    this.breakOutTimeView,
    this.totalBreakTime,
    this.totalBreakTimeView,
    this.attendanceBreakKey,
    this.breakColor,
    this.breakName,
    this.startMinutes,
    this.endMinutes,
    this.totalMinutes,
    this.breakTimeView,
  });

  factory Break.fromJson(Map<String, dynamic> json) => _$BreakFromJson(json);

  Map<String, dynamic> toJson() => _$BreakToJson(this);

  BreakEntity toEntity() => BreakEntity(
    attendanceBreakHistoryId: attendanceBreakHistoryId,
    attendanceTypeId: attendanceTypeId,
    breakStartDate: breakStartDate,
    breakInTime: breakInTime,
    breakInTimeView: breakInTimeView,
    breakEndDate: breakEndDate,
    breakOutTime: breakOutTime,
    breakOutTimeView: breakOutTimeView,
    totalBreakTime: totalBreakTime,
    totalBreakTimeView: totalBreakTimeView,
    attendanceBreakKey: attendanceBreakKey,
    breakColor: breakColor,
    breakName: breakName,
    startMinutes: startMinutes,
    endMinutes: endMinutes,
    totalMinutes: totalMinutes,
    breakTimeView: breakTimeView,
  );
}
