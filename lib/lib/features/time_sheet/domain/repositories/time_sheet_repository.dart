import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/core/models/domain/common_response_entity.dart';
import 'package:myco_flutter/features/time_sheet/data/models/request/attendance_month_request_model.dart';
import 'package:myco_flutter/features/time_sheet/data/models/request/punch_in_request_model.dart';
import 'package:myco_flutter/features/time_sheet/data/models/request/punch_in_request_reminder_model.dart';
import 'package:myco_flutter/features/time_sheet/domain/entities/attendence_month_entity.dart';

abstract class TimeSheetRepository {
  Future<Either<Failure, AttendanceMonthEntity>> monthlyAttendance(
    MonthlyAttendanceRequestModel request,
  );

  Future<Either<Failure, CommonResponseModelEntity>> punchInRequest(
    PunchInRequestModel request,
  );

  Future<Either<Failure, CommonResponseModelEntity>> punchInReqReminder(
    PunchInReqReminderModel request,
  );
}
