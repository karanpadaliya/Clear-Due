import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/dashboard/data/models/attendance_punch_in_response.dart';
import 'package:myco_flutter/features/dashboard/data/models/attendance_punch_out_response.dart';
import 'package:myco_flutter/features/dashboard/data/models/attendance_type_response.dart'; // NEW
import 'package:myco_flutter/features/dashboard/data/models/break_in_response.dart';
import 'package:myco_flutter/features/dashboard/data/models/break_out_response.dart';
import 'package:myco_flutter/features/dashboard/data/models/home_menu_response.dart';
import 'package:myco_flutter/features/dashboard/data/models/id_card_detail_response.dart';
import 'package:myco_flutter/features/dashboard/data/models/my_unit_response.dart';
import 'package:myco_flutter/features/dashboard/data/models/requests/attendance_requests.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/requests/get_attendance_type_request.dart';


abstract class DashboardRemoteDataSource {
  /// Fetches the User's ID card details from the remote server.
  ///
  /// Returns a [IdCardDetailResponse] containing the dashboard data.
  // Future<IdCardDetailResponse> getIDCardDetails(Map<String,dynamic> dataMap);
  Future<Either<Failure, IdCardDetailResponse>> getIDCardDetails(
    Map<String, dynamic> dataMap,
  );

  // Change this one as well

  /// Fetches the latest news articles from the remote server.
  ///
  /// Returns a [List<Map<String, dynamic>>] containing the news articles.
  Future<Either<Failure, HomeMenuResponse>> getAppMenuGridWithCategory(
    Map<String, dynamic> dataMap,
  );
  // Future<HomeMenuResponse> getAppMenuGridWithCategory(Map<String,dynamic> dataMap);

  /// Fetches the latest news articles from the remote server.
  ///
  /// Returns a [List<Map<String, dynamic>>] containing the news articles.
  Future<Either<Failure, MyUnitResponse>> getMyUnits(
    Map<String, dynamic> dataMap,
  );

  // NEW ABSTRACT METHOD FOR ATTENDANCE TYPE
  Future<Either<Failure, AttendanceTypeResponse>> getAttendanceType(
    GetAttendanceTypeRequest dataMap,
  );
  
  
  Future<Either<Failure, AttendancePunchInResponse>> attendancePunchIn(
    AttendancePunchInRequest request,
  );

  Future<Either<Failure, AttendancePunchOutResponse>> attendancePunchOut(
    AttendancePunchOutRequest request,
  );

  Future<Either<Failure, BreakInResponse>> breakIn(
    BreakInRequest request,
  );

  Future<Either<Failure, BreakOutResponse>> breakOut(
    BreakOutRequest request,
  );
}
