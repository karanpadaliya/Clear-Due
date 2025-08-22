import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/encryption/gzip_util.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/core/network/api_client.dart';
import 'package:myco_flutter/core/utils/safe_api_call.dart';
import 'package:myco_flutter/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:myco_flutter/features/dashboard/data/models/attendance_punch_in_response.dart';
import 'package:myco_flutter/features/dashboard/data/models/attendance_punch_out_response.dart';
import 'package:myco_flutter/features/dashboard/data/models/attendance_type_response.dart';
import 'package:myco_flutter/features/dashboard/data/models/break_in_response.dart';
import 'package:myco_flutter/features/dashboard/data/models/break_out_response.dart';
import 'package:myco_flutter/features/dashboard/data/models/home_menu_response.dart';
import 'package:myco_flutter/features/dashboard/data/models/id_card_detail_response.dart';
import 'package:myco_flutter/features/dashboard/data/models/my_unit_response.dart';
import 'package:myco_flutter/features/dashboard/data/models/requests/attendance_requests.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/requests/get_attendance_type_request.dart';

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final ApiClient apiClient;
  final ApiClient masterApiClient;
  final SafeApiCall safeApiCall; // 1. Inject SafeApiCall

  DashboardRemoteDataSourceImpl({
    required this.apiClient,
    required this.masterApiClient,
    required this.safeApiCall, // 2. Add to constructor
  });

  @override
  Future<Either<Failure, IdCardDetailResponse>> getIDCardDetails(
    Map<String, dynamic> dataMap,
  ) async => await safeApiCall.execute<IdCardDetailResponse>(() async {
    final response = await apiClient.postFormDynamic(
      'profileMenuController.php',
      dataMap,
    );
    // This part only runs on a successful API response
    return IdCardDetailResponse.fromJson(json.decode(response));
  });

  @override
  Future<Either<Failure, HomeMenuResponse>> getAppMenuGridWithCategory(
    Map<String, dynamic> dataMap,
  ) async => await safeApiCall.execute<HomeMenuResponse>(() async {
    final encryptedBody = GzipUtil.encryptAES(jsonEncode(dataMap));
    final response = await masterApiClient.postDynamic(
      'app_menu_controller.php',
      encryptedBody,
    );
    final decRes = GzipUtil.decryptAES(response);
    return HomeMenuResponse.fromJson(json.decode(decRes));
  });

  @override
  Future<Either<Failure, MyUnitResponse>> getMyUnits(
    Map<String, dynamic> dataMap,
  ) async => await safeApiCall.execute<MyUnitResponse>(() async {
    final response = await apiClient.postFormDynamic(
      'resident_data_update_controller.php',
      dataMap,
    );
    return MyUnitResponse.fromJson(json.decode(response));
  });

  // NEW IMPLEMENTATION FOR ATTENDANCE TYPE
  @override
  Future<Either<Failure, AttendanceTypeResponse>> getAttendanceType(
    GetAttendanceTypeRequest dataMap,
  ) async => await safeApiCall.execute<AttendanceTypeResponse>(() async {
    final response = await apiClient.postFormDynamic(
      'attendance_controller_new.php',
      dataMap.toMap(),
    );
    return AttendanceTypeResponse.fromJson(json.decode(response));
  });

  @override
  Future<Either<Failure, AttendancePunchInResponse>> attendancePunchIn(
    AttendancePunchInRequest request,
  ) async => await safeApiCall.execute<AttendancePunchInResponse>(() async {
    final response = await apiClient.postGenericMultipart(
      'day_wise_attendance.php',
      await request.toFormData()
    );
    return AttendancePunchInResponse.fromJson(json.decode(response));
  });

  @override
  Future<Either<Failure, AttendancePunchOutResponse>> attendancePunchOut(
    AttendancePunchOutRequest request,
  ) async => await safeApiCall.execute<AttendancePunchOutResponse>(() async {
    final response = await apiClient.postGenericMultipart(
      'day_wise_attendance.php',
      await request.toFormData()
    );
    return AttendancePunchOutResponse.fromJson(json.decode(response));
  });

  @override
  Future<Either<Failure, BreakInResponse>> breakIn(
    BreakInRequest request,
  ) async => await safeApiCall.execute<BreakInResponse>(() async {
    final response = await apiClient.postFormDynamic(
      'day_wise_attendance.php',
      request.toFields(),
    );
    return BreakInResponse.fromJson(json.decode(response));
  });

  @override
  Future<Either<Failure, BreakOutResponse>> breakOut(
    BreakOutRequest request,
  ) async => await safeApiCall.execute<BreakOutResponse>(() async {
    final response = await apiClient.postFormDynamic(
      'day_wise_attendance.php',
      request.toFields(),
    );
    return BreakOutResponse.fromJson(json.decode(response));
  });
}
