// lib/features/dashboard/data/models/requests/attendance_requests.dart

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

// --- Punch In ---
class AttendancePunchInRequest extends Equatable {
  final String punchInNew;
  final String? attendanceId;
  final String companyId;
  final String unitId;
  final String? floorId;
  final String? blockId;
  final String? levelId;
  final String userId;
  final String userName;
  final String languageId;
  final String shiftTimeId;
  final String punchInLatitude;
  final String punchInLongitude;
  final String? dayType;
  final String? attendanceReason;
  final String? needApproval;
  final String? attendanceStatus;
  final String? radiusInMeter;
  final String? totalKm;
  final String? punchInInRange;
  final String? lateInReason;
  final String? punchInAddress;
  final String? locationName;
  final String? phoneBrand;
  final String? phoneModel;
  final String? appVersion;
  final String? batteryStatus;
  final String? backArea;
  final String? backLocality;
  final String? networkType;
  final String? networkConnection;
  final String? batteryOptimisationStatus;
  final String? punchInGpsAccuracy;
  final String? faceAccuracy;
  final String? scanTime;
  final String? branchInLat;
  final String? branchInLng;
  final String? branchInRadius;
  final File? punchInImage;
  final File? punchInOdometerImage;
  final String? punchInOdometer;
  final String? isSyncRecord;
  final String? mobileTimeZone;
  final String? mobileTimeZoneUtcDiff;
  final String? piDate;
  final String? piTime;
  final String? hasPolygonsIn;
  final String? polygonJsonIn;
  final String? travelModeType;
  final String? selectedShiftId;
  final String? punchInBranchId;
  final String? punchInBranchType;
  final String? shiftTimeZone;

  const AttendancePunchInRequest({
    required this.companyId,
    required this.unitId,
    required this.userId,
    required this.userName,
    required this.languageId,
    required this.shiftTimeId,
    required this.punchInLatitude,
    required this.punchInLongitude,
    this.punchInNew = 'attendancePunchIn',
    this.attendanceId,
    this.floorId,
    this.blockId,
    this.levelId,
    this.dayType,
    this.attendanceReason,
    this.needApproval,
    this.attendanceStatus,
    this.radiusInMeter,
    this.totalKm,
    this.punchInInRange,
    this.lateInReason,
    this.punchInAddress,
    this.locationName,
    this.phoneBrand,
    this.phoneModel,
    this.appVersion,
    this.batteryStatus,
    this.backArea,
    this.backLocality,
    this.networkType,
    this.networkConnection,
    this.batteryOptimisationStatus,
    this.punchInGpsAccuracy,
    this.faceAccuracy,
    this.scanTime,
    this.branchInLat,
    this.branchInLng,
    this.branchInRadius,
    this.punchInImage,
    this.punchInOdometerImage,
    this.punchInOdometer,
    this.isSyncRecord,
    this.mobileTimeZone,
    this.mobileTimeZoneUtcDiff,
    this.piDate,
    this.piTime,
    this.hasPolygonsIn,
    this.polygonJsonIn,
    this.travelModeType,
    this.selectedShiftId,
    this.punchInBranchId,
    this.punchInBranchType,
    this.shiftTimeZone,
  });

  Map<String, dynamic> toFields() {
    final Map<String, dynamic> map = {
      'punchInNew': punchInNew,
      'society_id': companyId,
      'unit_id': unitId,
      'user_id': userId,
      'user_name': userName,
      'language_id': languageId,
      'shift_time_id': shiftTimeId,
      'punch_in_latitude': punchInLatitude,
      'punch_in_longitude': punchInLongitude,
    };
    // Helper to add if not null
    void addIfNonNull(String key, String? value) {
      if (value != null) map[key] = value;
    }

    addIfNonNull('attendance_id', attendanceId);
    addIfNonNull('floor_id', floorId);
    addIfNonNull('block_id', blockId);
    addIfNonNull('level_id', levelId);
    addIfNonNull('day_type', dayType);
    addIfNonNull('attendance_reason', attendanceReason);
    addIfNonNull('need_approval', needApproval);
    addIfNonNull('attendance_status', attendanceStatus);
    addIfNonNull('radiusInMeter', radiusInMeter);
    addIfNonNull('totalKm', totalKm);
    addIfNonNull('punch_in_in_range', punchInInRange);
    addIfNonNull('late_in_reason', lateInReason);
    addIfNonNull('punch_in_address', punchInAddress);
    addIfNonNull('location_name', locationName);
    addIfNonNull('phone_brand', phoneBrand);
    addIfNonNull('phone_model', phoneModel);
    addIfNonNull('app_version', appVersion);
    addIfNonNull('battery_status', batteryStatus);
    addIfNonNull('back_area', backArea);
    addIfNonNull('back_locality', backLocality);
    addIfNonNull('network_type', networkType);
    addIfNonNull('network_connection', networkConnection);
    addIfNonNull('battery_optimisation_status', batteryOptimisationStatus);
    addIfNonNull('punch_in_gps_accuracy', punchInGpsAccuracy);
    addIfNonNull('face_accuracy', faceAccuracy);
    addIfNonNull('scan_time', scanTime);
    addIfNonNull('branch_in_lat', branchInLat);
    addIfNonNull('branch_in_lng', branchInLng);
    addIfNonNull('branch_in_radius', branchInRadius);
    addIfNonNull('punch_in_odometer', punchInOdometer);
    addIfNonNull('is_sync_record', isSyncRecord);
    addIfNonNull('mobile_time_zone', mobileTimeZone);
    addIfNonNull('mobile_time_zone_utc_diff', mobileTimeZoneUtcDiff);
    addIfNonNull('pi_date', piDate);
    addIfNonNull('pi_time', piTime);
    addIfNonNull('has_polygons_in', hasPolygonsIn);
    addIfNonNull('polygon_json_in', polygonJsonIn);
    addIfNonNull('travel_mode_type', travelModeType);
    addIfNonNull('selected_shift_id', selectedShiftId);
    addIfNonNull('punch_in_branch_id', punchInBranchId);
    addIfNonNull('punch_in_branch_type', punchInBranchType);
    addIfNonNull('shift_time_zone', shiftTimeZone);

    return map;
  }

  Future<Map<String, MultipartFile>> toFiles() async {
    final files = <String, MultipartFile>{};
    if (punchInImage != null) {
      files['punchInImage'] = await MultipartFile.fromFile(punchInImage!.path);
    }
    if (punchInOdometerImage != null) {
      files['punchInOdometerImage'] = await MultipartFile.fromFile(
        punchInOdometerImage!.path,
      );
    }
    return files;
  }

  @override
  List<Object?> get props => [
    companyId,
    userId,
    punchInLatitude,
    punchInLongitude,
  ];
}

// --- Punch Out ---
class AttendancePunchOutRequest extends Equatable {
  final String attendancePunchOut;
  final String companyId;
  final String unitId;
  final String userId;
  final String userName;
  final String? floorId;
  final String? blockId;
  final String? levelId;
  final String languageId;
  final String attendanceId;
  final String? workReportTitle;
  final String punchOutLatitude;
  final String punchOutLongitude;
  final String? distanceMeter;
  final String? distanceDuration;
  final String? visitJson;
  final String? punchOutReason;
  final String? workReport;
  final String? punchOutInRange;
  final String? punchOutMeter;
  final String? punchOutKm;
  final String? earlyOutReason;
  final String? punchOutAddress;
  final String? locationName;
  final String? phoneBrand;
  final String? phoneModel;
  final String? appVersion;
  final String? batteryStatus;
  final String? backArea;
  final String? backLocality;
  final String? networkType;
  final String? networkConnection;
  final String? punchOutGpsAccuracy;
  final String? taskReason;
  final String? attendanceStatus;
  final String? faceAccuracy;
  final String? scanTime;
  final String? branchOutLat;
  final String? branchOutLng;
  final String? branchOutRadius;
  final File? punchOutImage;
  final File? punchOutOdometerImage;
  final String? punchOutOdometer;
  final String? isSyncRecord;
  final String? mobileTimeZone;
  final String? mobileTimeZoneUtcDiff;
  final String? poDate;
  final String? poTime;
  final String? url;
  final String? calculateDistanceType;
  final String? hasPolygonsOut;
  final String? polygonJsonOut;
  final String? calculationType;
  final String? punchOutBranchId;
  final String? punchOutBranchType;
  final String? shiftTimeZone;

  const AttendancePunchOutRequest({
    required this.companyId,
    required this.unitId,
    required this.userId,
    required this.userName,
    required this.languageId,
    required this.attendanceId,
    required this.punchOutLatitude,
    required this.punchOutLongitude,
    this.attendancePunchOut = 'attendancePunchOut',
    this.floorId,
    this.blockId,
    this.levelId,
    this.workReportTitle,
    this.distanceMeter,
    this.distanceDuration,
    this.visitJson,
    this.punchOutReason,
    this.workReport,
    this.punchOutInRange,
    this.punchOutMeter,
    this.punchOutKm,
    this.earlyOutReason,
    this.punchOutAddress,
    this.locationName,
    this.phoneBrand,
    this.phoneModel,
    this.appVersion,
    this.batteryStatus,
    this.backArea,
    this.backLocality,
    this.networkType,
    this.networkConnection,
    this.punchOutGpsAccuracy,
    this.taskReason,
    this.attendanceStatus,
    this.faceAccuracy,
    this.scanTime,
    this.branchOutLat,
    this.branchOutLng,
    this.branchOutRadius,
    this.punchOutImage,
    this.punchOutOdometerImage,
    this.punchOutOdometer,
    this.isSyncRecord,
    this.mobileTimeZone,
    this.mobileTimeZoneUtcDiff,
    this.poDate,
    this.poTime,
    this.url,
    this.calculateDistanceType,
    this.hasPolygonsOut,
    this.polygonJsonOut,
    this.calculationType,
    this.punchOutBranchId,
    this.punchOutBranchType,
    this.shiftTimeZone,
  });

  Map<String, dynamic> toFields() {
    final Map<String, dynamic> map = {
      'attendancePunchOut': attendancePunchOut,
      'society_id': companyId,
      'unit_id': unitId,
      'user_id': userId,
      'user_name': userName,
      'language_id': languageId,
      'attendance_id': attendanceId,
      'punch_out_latitude': punchOutLatitude,
      'punch_out_longitude': punchOutLongitude,
    };
    void addIfNonNull(String key, String? value) {
      if (value != null) map[key] = value;
    }

    addIfNonNull('floor_id', floorId);
    addIfNonNull('block_id', blockId);
    addIfNonNull('level_id', levelId);
    addIfNonNull('work_report_title', workReportTitle);
    addIfNonNull('distanceMeter', distanceMeter);
    addIfNonNull('distanceDuration', distanceDuration);
    addIfNonNull('visit_json', visitJson);
    addIfNonNull('punch_out_reason', punchOutReason);
    addIfNonNull('work_report', workReport);
    addIfNonNull('punch_out_in_range', punchOutInRange);
    addIfNonNull('punch_out_meter', punchOutMeter);
    addIfNonNull('punch_out_km', punchOutKm);
    addIfNonNull('early_out_reason', earlyOutReason);
    addIfNonNull('punch_out_address', punchOutAddress);
    addIfNonNull('location_name', locationName);
    addIfNonNull('phone_brand', phoneBrand);
    addIfNonNull('phone_model', phoneModel);
    addIfNonNull('app_version', appVersion);
    addIfNonNull('battery_status', batteryStatus);
    addIfNonNull('back_area', backArea);
    addIfNonNull('back_locality', backLocality);
    addIfNonNull('network_type', networkType);
    addIfNonNull('network_connection', networkConnection);
    addIfNonNull('punch_out_gps_accuracy', punchOutGpsAccuracy);
    addIfNonNull('task_reason', taskReason);
    addIfNonNull('attendance_status', attendanceStatus);
    addIfNonNull('face_accuracy', faceAccuracy);
    addIfNonNull('scan_time', scanTime);
    addIfNonNull('branch_out_lat', branchOutLat);
    addIfNonNull('branch_out_lng', branchOutLng);
    addIfNonNull('branch_out_radius', branchOutRadius);
    addIfNonNull('punch_out_odometer', punchOutOdometer);
    addIfNonNull('is_sync_record', isSyncRecord);
    addIfNonNull('mobile_time_zone', mobileTimeZone);
    addIfNonNull('mobile_time_zone_utc_diff', mobileTimeZoneUtcDiff);
    addIfNonNull('po_date', poDate);
    addIfNonNull('po_time', poTime);
    addIfNonNull('url', url);
    addIfNonNull('calculate_distance_type', calculateDistanceType);
    addIfNonNull('has_polygons_out', hasPolygonsOut);
    addIfNonNull('polygon_json_out', polygonJsonOut);
    addIfNonNull('calculation_type', calculationType);
    addIfNonNull('punch_out_branch_id', punchOutBranchId);
    addIfNonNull('punch_out_branch_type', punchOutBranchType);
    addIfNonNull('shift_time_zone', shiftTimeZone);

    return map;
  }

  Future<Map<String, MultipartFile>> toFiles() async {
    final files = <String, MultipartFile>{};
    if (punchOutImage != null) {
      files['punchOutImage'] = await MultipartFile.fromFile(
        punchOutImage!.path,
      );
    }
    if (punchOutOdometerImage != null) {
      files['punchOutOdometerImage'] = await MultipartFile.fromFile(
        punchOutOdometerImage!.path,
      );
    }
    return files;
  }

  @override
  List<Object?> get props => [companyId, userId, attendanceId];
}

// --- Break In ---
class BreakInRequest extends Equatable {
  final String breakInNewTwo;
  final String companyId;
  final String unitId;
  final String userId;
  final String languageId;
  final String attendanceId;
  final String attendanceTypeId;
  final String? breakAddress;
  final String? breakGpsAccuracy;
  final String? phoneBrand;
  final String? phoneModel;
  final String? appVersion;
  final String? batteryStatus;
  final String? backArea;
  final String? backLocality;
  final String? networkType;
  final String? networkConnection;
  final String? breakInLatitude;
  final String? breakInLongitude;
  final String? breakData;
  final String? isSyncRecord;
  final String? biDate;
  final String? biTime;
  final String? takeBreakWithApprovalEmployeeApp;
  final String? inRangeBreakStart;
  final String? shiftTimezone;
  final String? mobileTimezone;

  const BreakInRequest({
    required this.companyId,
    required this.unitId,
    required this.userId,
    required this.languageId,
    required this.attendanceId,
    required this.attendanceTypeId,
    this.breakInNewTwo = 'breakInNewTwo',
    this.breakAddress,
    this.breakGpsAccuracy,
    this.phoneBrand,
    this.phoneModel,
    this.appVersion,
    this.batteryStatus,
    this.backArea,
    this.backLocality,
    this.networkType,
    this.networkConnection,
    this.breakInLatitude,
    this.breakInLongitude,
    this.breakData,
    this.isSyncRecord,
    this.biDate,
    this.biTime,
    this.takeBreakWithApprovalEmployeeApp,
    this.inRangeBreakStart,
    this.shiftTimezone,
    this.mobileTimezone,
  });

  Map<String, dynamic> toFields() {
    final Map<String, dynamic> map = {
      'breakInNewTwo': breakInNewTwo,
      'society_id': companyId,
      'unit_id': unitId,
      'user_id': userId,
      'language_id': languageId,
      'attendance_id': attendanceId,
      'attendance_type_id': attendanceTypeId,
    };
    void addIfNonNull(String key, String? value) {
      if (value != null) map[key] = value;
    }

    addIfNonNull('break_address', breakAddress);
    addIfNonNull('break_gps_accuracy', breakGpsAccuracy);
    addIfNonNull('phone_brand', phoneBrand);
    addIfNonNull('phone_model', phoneModel);
    addIfNonNull('app_version', appVersion);
    addIfNonNull('battery_status', batteryStatus);
    addIfNonNull('back_area', backArea);
    addIfNonNull('back_locality', backLocality);
    addIfNonNull('network_type', networkType);
    addIfNonNull('network_connection', networkConnection);
    addIfNonNull('break_in_latitude', breakInLatitude);
    addIfNonNull('break_in_longitude', breakInLongitude);
    addIfNonNull('break_data', breakData);
    addIfNonNull('is_sync_record', isSyncRecord);
    addIfNonNull('bi_date', biDate);
    addIfNonNull('bi_time', biTime);
    addIfNonNull(
      'take_break_with_approval_employee_app',
      takeBreakWithApprovalEmployeeApp,
    );
    addIfNonNull('in_range_break_start', inRangeBreakStart);
    addIfNonNull('shift_time_zone', shiftTimezone);
    addIfNonNull('mobile_time_zone', mobileTimezone);
    return map;
  }

  @override
  List<Object?> get props => [
    companyId,
    userId,
    attendanceId,
    attendanceTypeId,
  ];
}

// --- Break Out ---
class BreakOutRequest extends Equatable {
  final String breakOutNew;
  final String companyId;
  final String unitId;
  final String userId;
  final String languageId;
  final String attendanceId;
  final String? breakAddress;
  final String? breakGpsAccuracy;
  final String? phoneBrand;
  final String? phoneModel;
  final String? appVersion;
  final String? batteryStatus;
  final String? backArea;
  final String? backLocality;
  final String? networkType;
  final String? networkConnection;
  final String? breakOutLatitude;
  final String? breakOutLongitude;
  final String attendanceBreakHistoryId;
  final String? breakData;
  final String? isSyncRecord;
  final String? boDate;
  final String? boTime;
  final String? takeBreakWithApprovalEmployeeApp;
  final String? inRangeBreakStart;
  final String? shiftTimezone;
  final String? mobileTimezone;

  const BreakOutRequest({
    required this.companyId,
    required this.unitId,
    required this.userId,
    required this.languageId,
    required this.attendanceId,
    required this.attendanceBreakHistoryId,
    this.breakOutNew = 'breakOutNew',
    this.breakAddress,
    this.breakGpsAccuracy,
    this.phoneBrand,
    this.phoneModel,
    this.appVersion,
    this.batteryStatus,
    this.backArea,
    this.backLocality,
    this.networkType,
    this.networkConnection,
    this.breakOutLatitude,
    this.breakOutLongitude,
    this.breakData,
    this.isSyncRecord,
    this.boDate,
    this.boTime,
    this.takeBreakWithApprovalEmployeeApp,
    this.inRangeBreakStart,
    this.shiftTimezone,
    this.mobileTimezone,
  });

  Map<String, dynamic> toFields() {
    final Map<String, dynamic> map = {
      'breakOutNew': breakOutNew,
      'society_id': companyId,
      'unit_id': unitId,
      'user_id': userId,
      'language_id': languageId,
      'attendance_id': attendanceId,
      'attendance_break_history_id': attendanceBreakHistoryId,
    };
    void addIfNonNull(String key, String? value) {
      if (value != null) map[key] = value;
    }

    addIfNonNull('break_address', breakAddress);
    addIfNonNull('break_gps_accuracy', breakGpsAccuracy);
    addIfNonNull('phone_brand', phoneBrand);
    addIfNonNull('phone_model', phoneModel);
    addIfNonNull('app_version', appVersion);
    addIfNonNull('battery_status', batteryStatus);
    addIfNonNull('back_area', backArea);
    addIfNonNull('back_locality', backLocality);
    addIfNonNull('network_type', networkType);
    addIfNonNull('network_connection', networkConnection);
    addIfNonNull('break_out_latitude', breakOutLatitude);
    addIfNonNull('break_out_longitude', breakOutLongitude);
    addIfNonNull('break_data', breakData);
    addIfNonNull('is_sync_record', isSyncRecord);
    addIfNonNull('bo_date', boDate);
    addIfNonNull('bo_time', boTime);
    addIfNonNull(
      'take_break_with_approval_employee_app',
      takeBreakWithApprovalEmployeeApp,
    );
    addIfNonNull('in_range_break_start', inRangeBreakStart);
    addIfNonNull('shift_time_zone', shiftTimezone);
    addIfNonNull('mobile_time_zone', mobileTimezone);
    return map;
  }

  @override
  List<Object?> get props => [
    companyId,
    userId,
    attendanceId,
    attendanceBreakHistoryId,
  ];
}
