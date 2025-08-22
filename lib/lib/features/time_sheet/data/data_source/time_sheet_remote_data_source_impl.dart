import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/models/data/common_response_model.dart';
import 'package:myco_flutter/core/network/api_client.dart';
import 'package:myco_flutter/features/time_sheet/data/data_source/time_sheet_remote_data_source.dart';
import 'package:myco_flutter/features/time_sheet/data/models/request/attendance_month_request_model.dart';
import 'package:myco_flutter/features/time_sheet/data/models/request/punch_in_request_model.dart';
import 'package:myco_flutter/features/time_sheet/data/models/request/punch_in_request_reminder_model.dart';
import 'package:myco_flutter/features/time_sheet/data/models/response/attendance_month_response_model.dart';

class TimeSheetRemoteDataSourceImpl extends TimeSheetRemoteDataSource {
  @override
  Future<AttendanceMonthResponseModel> monthlyAttendance(
    MonthlyAttendanceRequestModel request,
  ) async {
    final response = await GetIt.I<ApiClient>(
      instanceName: VariableBag.residentApiNew,
    ).postFormDynamic('day_wise_attendance.php', request.toJson());
    return AttendanceMonthResponseModel.fromJson(json.decode(response));
  }

  @override
  Future<CommonResponseModel> punchInRequest(
    PunchInRequestModel request,
  ) async {
    final response = await GetIt.I<ApiClient>(
      instanceName: VariableBag.residentApiNew,
    ).postFormDynamic('day_wise_attendance.php', request.toJson());
    return CommonResponseModel.fromJson(json.decode(response));
  }

  @override
  Future<CommonResponseModel> punchInReqReminder(
    PunchInReqReminderModel request,
  ) async {
    final response = await GetIt.I<ApiClient>(
      instanceName: VariableBag.residentApiNew,
    ).postFormDynamic('attendance_controller.php', request.toJson());
    return CommonResponseModel.fromJson(json.decode(response));
  }
}
