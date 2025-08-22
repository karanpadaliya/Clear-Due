import 'package:myco_flutter/features/dashboard/domain/entites/shift_list_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/shift_data_response_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/wfh_data_response_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/my_unit_response_entity.dart'; // For UserLocationListEntity

class AttendanceTypeResponseEntity {
  List<AttendanceTypeEntity>? attendanceTypes;
  String? message;
  bool? takeOutOfRangeReason;
  bool? attendanceWithDeveloperModeOn;
  String? status;
  String? punchInTimeView24Hours;
  List<TakenBreaksEntity>? takenBreaks;
  String? perDayHourMinutes;
  List<MultiPunchDataEntity>? multiPunchData;
  WFHDataResponseEntity? wfhData;
  bool? isDocumentUploadingPending;
  bool? probationPeriodDaysMandatory;
  String? lastOdometerReading;
  ShiftDataResponseEntity? shiftData;
  String? dateTime;
  String? attendanceId;
  String? totalWorkReport;
  String? totalReportAdded;
  String? remainingWorkReport;
  bool? punchOutLimit;
  bool? isToday;
  bool? hideWorkingHours;
  bool? multiPunchIn;
  String? alreadyPunchOutMsg;
  bool? punchInOdometer;
  String? punchInTime;
  String? punchInTimeView;
  String? attendanceStartDate;
  String? attendanceStartDateView;
  String? timeDifference;
  String? breakDateTime;
  String? attendanceBreakHistoryId;
  String? breakInTime;
  String? attendanceTypeName;
  String? breakTimeDifference;
  String? attendanceTypeId;
  String? yesterdayPunchOutMissingMsg;
  bool? yesterdayPunchOutMissing;
  bool? nightShift;
  bool? addRetailerCityAreaAddAccess;
  bool? punchOutWithTaskCompletion;
  bool? taskComplete;
  bool? alreadyPunchIn;
  bool? alreadyPunchOut;
  bool? workReportAdded;
  bool? isAttendanceRejected;
  String? attendanceRejectedMessage;
  bool? yesterdayAttendanceRejected;
  String? yesterdayAttendanceRejectedMessage;
  String? userFaceData;
  bool? trackUserLocation;
  String? faceDataImageTwo;
  String? faceDataImage;
  String? faceAddedDate;
  String? missingDate;
  String? missingMonth;
  String? missingYear;
  String? punchInLatitude;
  String? punchInLongitude;
  String? serverTime;
  String? fingerDataImage;
  String? userFingerDataUpdatedDate;
  String? faceOrFingerAttendance;
  String? faceScanAccuracy;
  bool? hideDutyHourTimer;
  List<ShiftListEntity>? shiftList;
  bool? onlyAutoApprovedAttendanceField;
  bool? orderWithoutPunchInField;
  String? attendanceTypeField;
  String? takeAttendanceSelfieField;
  String? takeBreakWithApprovalEmployeeApp;
  bool? hideAttendanceFaceMenuField;
  bool? allowAddVisit;
  bool? attendanceWithMatchingFaceField;
  bool? isAmazonFaceMatchField;
  bool? isStartEndVisitFaceMatchField;
  bool? odometerTrackingField;
  bool? allowToPreApplyShortLeaveField;
  List<UserLocationListEntity>? userLocationList;
  String? lastPunchInOdometerImage;
  List<MultiPunchDataViewEntity>? multiPunchDataView;
  String? perDayHour;
  bool? isBreakStart;
  bool? isAutoBreakStart;
  String? autoBreakStartView;
  List<Break1Entity>? breaks;
  String? productiveHoursInSec;
  String? timeDiffSeconds;
  String? productiveHoursView;
  String? breakStartColor;
  String? breakStartName;
  String? attendanceMapType;
  String? visitMapType;
  String? faceBlurDetection;
  String? pastAttendanceLeaveRequest;
  String? iCardFormatType;
  bool? lateInReasonPending;
  bool? searchRetailerWithApi;
  bool? hsnCodeVisible;
  bool? autoLeaveRemoveReasonRequired;
  String? maxAttendancePunchOutTime;

  AttendanceTypeResponseEntity({
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
}

class AttendanceTypeEntity {
  String? attendanceTypeId;
  String? attendanceTypeName;
  String? attendanceBreakKey;
  String? attendanceBreakMinutes;
  bool? breakApprovalRequired;

  AttendanceTypeEntity({
    this.attendanceTypeId,
    this.attendanceTypeName,
    this.attendanceBreakKey,
    this.attendanceBreakMinutes,
    this.breakApprovalRequired,
  });
}

class MultiPunchDataEntity {
  String? punchInDate;
  String? punchInTime;
  String? punchOutDate;
  String? punchOutTime;
  String? workingHour;
  String? workingHourMinute;
  String? punchInTimeView;
  String? punchOutTimeView;
  String? workingHourView;
  List<TakenBreaksEntity>? takenBreaks;

  MultiPunchDataEntity({
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
}

class TakenBreaksEntity {
  String? attendanceBreakHistoryId;
  String? attendanceTypeId;
  String? breakStartDate;
  String? breakInTime;
  String? breakInTimeView;
  String? breakOutTimeview;
  String? totalBreaktimeView;
  String? breakName;
  String? breakEndDate;
  String? breakOutTime;
  String? totalBreakTime;
  String? totalBreakTimeMinutes;
  String? breakColor;
  String? attendanceBreakKey;

  TakenBreaksEntity({
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
}

class Break1Entity {
  String? breakColor;
  String? breakName;
  String? startMinutes;
  String? endMinutes;
  String? totalMinutes;
  String? breakTimeView;

  Break1Entity({
    this.breakColor,
    this.breakName,
    this.startMinutes,
    this.endMinutes,
    this.totalMinutes,
    this.breakTimeView,
  });
}

class MultiPunchDataViewEntity {
  String? punchInDate;
  String? punchInTime;
  String? punchInTimeView;
  String? punchOutDate;
  String? punchOutTime;
  String? punchOutTimeView;
  String? workingHour;
  String? workingHourView;
  String? workingHourMinute;
  List<BreakEntity>? breaks;

  MultiPunchDataViewEntity({
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
}

class BreakEntity {
  String? attendanceBreakHistoryId;
  String? attendanceTypeId;
  String? breakStartDate;
  String? breakInTime;
  String? breakInTimeView;
  String? breakEndDate;
  String? breakOutTime;
  String? breakOutTimeView;
  String? totalBreakTime;
  String? totalBreakTimeView;
  String? attendanceBreakKey;
  String? breakColor;
  String? breakName;
  String? startMinutes;
  String? endMinutes;
  String? totalMinutes;
  String? breakTimeView;

  BreakEntity({
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
}

// Add the GeoArrayEntity and UserLocationListEntity classes here if they don't exist
// based on MyUnitResponse.java's inner classes.
class GeoArrayEntity {
  String? lat;
  String? lng;

  GeoArrayEntity({
    this.lat,
    this.lng,
  });
}

// class UserLocationListEntity {
//   bool? isBranch;
//   bool? isVisit;
//   String? retailerId;
//   String? geoFenceId;
//   String? branchName;
//   String? userGeoAddress;
//   String? userGeofenceRange;
//   String? userGeofenceLongitude;
//   String? userGeofenceLatitude;
//   String? retailerVisitId;
//   String? retailerDailyVisitTimelineId;
//   String? visitStartDateTime;
//   String? physicalOrVirtualVisit;
//   bool? isCustomShape;
//   List<GeoArrayEntity>? geoArray;
//   bool? isUserGeo;
//   bool? isWFH;
//   int? matchCount;
//   int? startEnd;

//   UserLocationListEntity({
//     this.isBranch,
//     this.isVisit,
//     this.retailerId,
//     this.geoFenceId,
//     this.branchName,
//     this.userGeoAddress,
//     this.userGeofenceRange,
//     this.userGeofenceLongitude,
//     this.userGeofenceLatitude,
//     this.retailerVisitId,
//     this.retailerDailyVisitTimelineId,
//     this.visitStartDateTime,
//     this.physicalOrVirtualVisit,
//     this.isCustomShape,
//     this.geoArray,
//     this.isUserGeo,
//     this.isWFH,
//     this.matchCount,
//     this.startEnd,
//   });
// }