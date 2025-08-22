import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/dashboard/data/models/requests/attendance_requests.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/attendance_punch_in_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/attendance_punch_out_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/attendance_type_response_entity.dart'; // NEW
import 'package:myco_flutter/features/dashboard/domain/entites/break_in_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/break_out_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/home_menu_response_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/id_card_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/my_unit_response_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/requests/get_attendance_type_request.dart';
import 'package:myco_flutter/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardUsecases {
  DashboardRepository repository;
  DashboardUsecases({required this.repository});

  /// Fetches the User's ID card details from the remote server.
  ///
  /// Returns a [IdCardEntity] containing the dashboard data.
  Future<Either<Failure, IdCardEntity>> getIDCardDetails(
    Map<String, dynamic> dataMap,
  ) async => await repository.getIDCardDetails(dataMap);

  ///
  /// Fetches the App Menu Grid with Category from the remote server.
  Future<Either<Failure, HomeMenuResponseEntity>> getAppMenuGridWithCategory(
    Map<String, dynamic> dataMap,
  ) async => await repository.getAppMenuGridWithCategory(dataMap);

  /// Fetches the App Menu Grid with Category from the remote server.
  Future<Either<Failure, MyUnitResponseEntity>> getMyUnits(
    Map<String, dynamic> dataMap,
  ) async => await repository.getMyUnits(dataMap);

  // NEW USE CASE FOR ATTENDANCE TYPE
  /// Fetches the Attendance Type details from the remote server.
  Future<Either<Failure, AttendanceTypeResponseEntity>> getAttendanceType(
    GetAttendanceTypeRequest dataMap,
  ) async => await repository.getAttendanceType(dataMap);

  Future<Either<Failure, AttendancePunchInEntity>> attendancePunchIn(
    AttendancePunchInRequest dataMap,
  ) async => await repository.attendancePunchIn(dataMap);
  Future<Either<Failure, AttendancePunchOutEntity>> attendancePunchOut(
    AttendancePunchOutRequest dataMap,
  ) async => await repository.attendancePunchOut(dataMap);
  Future<Either<Failure, BreakInEntity>> breakIn(
    BreakInRequest dataMap,
  ) async => await repository.breakIn(dataMap);
  Future<Either<Failure, BreakOutEntity>> breakOut(
    BreakOutRequest dataMap,
  ) async => await repository.breakOut(dataMap);
}
