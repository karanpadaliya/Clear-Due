import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/dashboard/data/models/id_card_detail_response.dart';
import 'package:myco_flutter/features/dashboard/data/models/requests/attendance_requests.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/attendance_punch_in_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/attendance_punch_out_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/attendance_type_response_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/break_in_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/break_out_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/home_menu_response_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/id_card_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/my_unit_response_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/requests/get_attendance_type_request.dart';

abstract class DashboardRepository {
  /// Fetches the User's ID card details from the remote server.
  ///
  /// Returns a [IdCardDetailResponse] containing the dashboard data.
  Future<Either<Failure, IdCardEntity>> getIDCardDetails(
    Map<String, dynamic> dataMap,
  );

  /// Fetches the latest news articles from the remote server.
  ///
  /// Returns a [List<Map<String, dynamic>>] containing the news articles.
  Future<Either<Failure, HomeMenuResponseEntity>> getAppMenuGridWithCategory(
    Map<String, dynamic> dataMap,
  );

  /// Returns a [List<Map<String, dynamic>>] containing the news articles.
  Future<Either<Failure, MyUnitResponseEntity>> getMyUnits(
    Map<String, dynamic> dataMap,
  );

  // NEW ABSTRACT METHOD FOR ATTENDANCE TYPE
  Future<Either<Failure, AttendanceTypeResponseEntity>> getAttendanceType(
    GetAttendanceTypeRequest dataMap,
  );

  Future<Either<Failure, AttendancePunchInEntity>> attendancePunchIn(
    AttendancePunchInRequest request,
  );

  Future<Either<Failure, AttendancePunchOutEntity>> attendancePunchOut(
    AttendancePunchOutRequest request,
  );

  Future<Either<Failure, BreakInEntity>> breakIn(BreakInRequest request);

  Future<Either<Failure, BreakOutEntity>> breakOut(BreakOutRequest request);
}
