import 'package:myco_flutter/core/models/data/common_response_model.dart';
import 'package:myco_flutter/features/time_sheet/data/models/request/attendance_month_request_model.dart';
import 'package:myco_flutter/features/time_sheet/data/models/request/punch_in_request_model.dart';
import 'package:myco_flutter/features/time_sheet/data/models/request/punch_in_request_reminder_model.dart';
import 'package:myco_flutter/features/time_sheet/data/models/response/attendance_month_response_model.dart';

abstract class TimeSheetRemoteDataSource {
  Future<AttendanceMonthResponseModel> monthlyAttendance(
    MonthlyAttendanceRequestModel request,
  );

  Future<CommonResponseModel> punchInRequest(PunchInRequestModel request);

  Future<CommonResponseModel>punchInReqReminder(PunchInReqReminderModel request);
}
