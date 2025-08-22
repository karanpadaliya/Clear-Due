import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/models/data/common_response_model.dart';
import 'package:myco_flutter/core/network/api_client.dart';
import 'package:myco_flutter/features/leave/data/datasources/leave_remote_data_source.dart';
import 'package:myco_flutter/features/leave/data/model/check_leave_balance_response.dart';
import 'package:myco_flutter/features/leave/data/model/comp_off_leave_response_model.dart';
import 'package:myco_flutter/features/leave/data/model/leave_calendar_response_model.dart';
import 'package:myco_flutter/features/leave/data/model/leave_history_response_model.dart';
import 'package:myco_flutter/features/leave/data/model/leave_type_response.dart';
import 'package:myco_flutter/features/leave/data/model/my_team_response_model.dart';
import 'package:myco_flutter/features/leave/data/model/request_model/add_short_leave_request_model.dart';
import 'package:myco_flutter/features/leave/data/model/request_model/change_auto_leave_request_model.dart';
import 'package:myco_flutter/features/leave/data/model/request_model/change_sandwich_leave_request_model.dart';
import 'package:myco_flutter/features/leave/data/model/request_model/delete_leave_request_model.dart';
import 'package:myco_flutter/features/leave/data/model/request_model/delete_short_leave_request_model.dart';
import 'package:myco_flutter/features/leave/data/model/request_model/edit_leave_request_model.dart';
import 'package:myco_flutter/features/leave/data/model/request_model/get_comp_off_leaves_request_model.dart';
import 'package:myco_flutter/features/leave/data/model/request_model/leave_balance_for_auto_leave_request_model.dart';
import 'package:myco_flutter/features/leave/data/model/request_model/leave_calendar_new_request_model.dart';
import 'package:myco_flutter/features/leave/data/model/request_model/leave_history_request_model.dart';
import 'package:myco_flutter/features/leave/data/model/request_model/leave_type_request_model.dart';
import 'package:myco_flutter/features/leave/data/model/request_model/leave_types_with_data_request_model.dart';
import 'package:myco_flutter/features/leave/data/model/request_model/my_team_leaves_request_model.dart';

class LeaveRemoteDataSourceImpl implements LeaveRemoteDataSource {
  @override
  Future<LeaveHistoryResponseModel> getNewLeaveListType(
    LeaveTypeRequestModel getLeaveTypeList,
  ) async {
    // final dataMap = {
    //   'getLeaveTypeList': 'getLeaveTypeList',
    //   'society_id': '1',
    //   'unit_id': '1387',
    //   'user_id': '1365',
    //   'floor_id': '1',
    //   'currentYear': query,
    //   'language_id': '1',
    // };

    final response = await GetIt.I<ApiClient>(
      instanceName: VariableBag.residentApiNew,
    ).postFormDynamic('leave_controller.php', getLeaveTypeList.toMap());

    return LeaveHistoryResponseModel.fromJson(json.decode(response));
  }

  @override
  Future<MyTeamResponseModel> getMyTeamLeaves(
    MyTeamLeavesRequestModel myTeamLeavesRequestModel,
  ) async {
    // final dataMap = {
    //   'getMyTeamLeaves': 'getMyTeamLeaves',
    //   'society_id': '1',
    //   'user_id': '1365',
    //   'language_id': '1',
    //   'limit': '',
    //   'level_id': '26',
    // };

    final response = await GetIt.I<ApiClient>(
      instanceName: VariableBag.residentApiNew,
    ).postFormDynamic('team_controller.php', myTeamLeavesRequestModel.toMap());

    return MyTeamResponseModel.fromJson(json.decode(response));
  }

  @override
  Future<LeaveHistoryResponseModel> getLeaveHistoryNew(
    LeaveHistoryRequestModel leaveHistoryRequestModel,
  ) async {
    // final dataMap = {
    //   'getLeaveHistoryNew': 'getLeaveHistoryNew',
    //   'society_id': '1',
    //   'unit_id': '1387',
    //   'user_id': '1365',
    //   'floor_id': '1',
    //   'level_id': '26',
    //   'language_id': '1',
    //   'month': monthName,
    //   'year': year,
    // };

    final response = await GetIt.I<ApiClient>(
      instanceName: VariableBag.residentApiNew,
    ).postFormDynamic('leave_controller.php', leaveHistoryRequestModel.toMap());

    return LeaveHistoryResponseModel.fromJson(json.decode(response));
  }

  @override
  Future<CommonResponseModel> addShortLeave(
    AddShortLeaveRequestModel addShortLeaveRequestModel,
  ) async {
    final response =
        await GetIt.I<ApiClient>(
          instanceName: VariableBag.residentApiNew,
        ).postFormDynamic(
          'leave_controller.php',
          addShortLeaveRequestModel.toMap(),
        );
    return CommonResponseModel.fromJson(json.decode(response));
  }

  @override
  Future<CommonResponseModel> deleteShortLeave(
    DeleteShortLeaveRequestModel deleteShortLeaveRequestModel,
  ) async {
    // final dataMap = {
    //   'deleteShortLeave': 'deleteShortLeave',
    //   'society_id': '1',
    //   'user_id': '1365',
    //   'user_name': 'Lucky Katre',
    //   'language_id': '1',
    //   'short_leave_id': shortLeaveId,
    //   'short_leave_date': shortLeaveDate,
    //   'other_user_id': otherUserId,
    //   'other_user_name': otherUserName,
    // };

    final response =
        await GetIt.I<ApiClient>(
          instanceName: VariableBag.residentApiNew,
        ).postFormDynamic(
          'leave_controller.php',
          deleteShortLeaveRequestModel.toMap(),
        );
    return CommonResponseModel.fromJson(json.decode(response));
  }

  @override
  Future<LeaveTypeResponse> getLeaveTypesWithData(
    LeaveTypesWithDataRequestModel leaveTypesWithDataRequestModel,
  ) async {
    // final dataMap = {
    //   'getLeaveTypesWithData': 'getLeaveTypesWithData',
    //   'society_id': '1',
    //   'unit_id': unitId,
    //   'user_id': useId,
    //   'user_name': userName,
    //   'language_id': '1',
    //   'currentYear': currentYear,
    //   'applied_leave_date': appliedLeaveDate,
    // };
    final response =
        await GetIt.I<ApiClient>(
          instanceName: VariableBag.residentApiNew,
        ).postFormDynamic(
          'leave_controller.php',
          leaveTypesWithDataRequestModel.toMap(),
        );
    return LeaveTypeResponse.fromJson(json.decode(response));
  }

  @override
  Future<CheckLeaveBalanceResponse> getLeaveBalanceForAutoLeave(
    LeaveBalanceForAutoLeaveRequestModel leaveBalanceForAutoLeaveRequestModel,
  ) async {
    // final dataMap = {
    //   'getLeaveBalanceForAutoLeave': 'getLeaveBalanceForAutoLeave',
    //   'society_id': '1',
    //   'user_id': userId,
    //   'language_id': '1',
    //   'leave_date': leaveDate,
    //   'leave_type_id': leaveId,
    //   'leave_status': '0',
    // };
    final response =
        await GetIt.I<ApiClient>(
          instanceName: VariableBag.residentApiNew,
        ).postFormDynamic(
          'leave_controller.php',
          leaveBalanceForAutoLeaveRequestModel.toMap(),
        );
    return CheckLeaveBalanceResponse.fromJson(json.decode(response));
  }

  @override
  Future<CommonResponseModel> deleteLeaveRequest(
    DeleteLeaveRequestModel deleteLeaveRequestModel,
  ) async {
    // final dataMap = {
    //   'deleteLeaveRequest': 'deleteLeaveRequest',
    //   'society_id': '1',
    //   'user_id': '1365',
    //   'language_id': '1',
    //   'other_user_name': 'Lucky Katre',
    //   'user_name': 'Lucky Katre',
    //   'leave_id': leaveId,
    //   'my_user_id': '1365',
    //   'delete_restrict': '1',
    //   'remove_late_in': '',
    //   'remove_early_out': '',
    // };

    final response = await GetIt.I<ApiClient>(
      instanceName: VariableBag.residentApiNew,
    ).postFormDynamic('leave_controller.php', deleteLeaveRequestModel.toMap());
    return CommonResponseModel.fromJson(json.decode(response));
  }

  @override
  Future<CommonResponseModel> changeAutoLeave(
    ChangeAutoLeaveRequestModel changeAutoLeaveRequestModel,
  ) async {
    // final dataMap = {
    // 'changeAutoLeave': 'changeAutoLeave',
    // 'society_id': '1',
    // 'user_id': userId,
    // 'language_id': '1',
    // 'paid_unpaid': paid,
    // 'leave_type_id': leaveTypeId,
    // 'leave_date': leaveDate,
    // 'leave_day_type': leaveDay,
    // 'is_extra_day': extraDay,
    // 'is_special_leave': isSpecialDay,
    // 'attendance_id': attendanceId,
    // 'user_name': 'Lucky Katre',
    // 'leave_id': leaveId,
    // 'leave_percentage': leavePercentage,
    // 'is_from_admin': '0',
    // };
    final response =
        await GetIt.I<ApiClient>(
          instanceName: VariableBag.residentApiNew,
        ).postFormDynamic(
          'leave_controller.php',
          changeAutoLeaveRequestModel.toMap(),
        );
    return CommonResponseModel.fromJson(json.decode(response));
  }

  @override
  Future<CommonResponseModel> changeSandwichLeave(
    ChangeSandwichLeaveRequestModel changeSandwichLeaveRequestModel,
  ) async {
    // final dataMap = {
    //   'changeSandwichLeave': 'changeSandwichLeave',
    //   'society_id': '1',
    //   'leave_user_id': userId,
    //   'language_id': '1',
    //   'paid_unpaid': paid,
    //   'leave_type_id': leaveTypeId,
    //   'leave_type_name': leaveName,
    //   'sandwich_leave_id': sandwichId,
    //   'user_name': 'Lucky Katre',
    //   'user_id': '1365',
    //   'isWeb': '0',
    //   'unit_id': unitId,
    //   'my_leave': '1',
    //   'leave_user_name': userFullName,
    //   'leave_percentage': leavePercentage,
    // };
    final response =
        await GetIt.I<ApiClient>(
          instanceName: VariableBag.residentApiNew,
        ).postFormDynamic(
          'leave_controller.php',
          changeSandwichLeaveRequestModel.toMap(),
        );
    return CommonResponseModel.fromJson(json.decode(response));
  }

  @override
  Future<CompOffLeaveResponseModel> getCompOffLeaves(
    GetCompOffLeavesRequestModel getCompOffLeavesRequestModel,
  )
  // final dataMap = {
  //   'getCompOffLeaves': 'getCompOffLeaves',
  //   'society_id': '1',
  //   'user_id': '1365',
  //   'language_id': '1',
  //   'start_date': startDate,
  //   'end_date': endDate,
  // };
  => GetIt.I<ApiClient>(instanceName: VariableBag.residentApiNew)
      .postFormDynamic(
        'leave_controller.php',
        getCompOffLeavesRequestModel.toMap(),
      )
      .then((value) => CompOffLeaveResponseModel.fromJson(json.decode(value)));

  @override
  Future<LeaveCalendarResponseModel> getLeaveCalendarNew(
    LeaveCalendarNewRequestModel leaveCalendarNewRequestModel,
  )
  // final dataMap = {
  //   'leaveCalendarNew': 'leaveCalendarNew',
  //   'society_id': '1',
  //   'unit_id': '1387',
  //   'user_id': '1365',
  //   'block_id': '1',
  //   'floor_id': '1',
  //   'level_id': '26',
  //   'language_id': '1',
  //   'shift_time_id': '3',
  //   'month_start_date': startDate,
  //   'month_end_date': endDate,
  // };
  => GetIt.I<ApiClient>(instanceName: VariableBag.residentApiNew)
      .postFormDynamic(
        'leave_controller.php',
        leaveCalendarNewRequestModel.toMap(),
      )
      .then((value) => LeaveCalendarResponseModel.fromJson(json.decode(value)));

  @override
  Future<CommonResponseModel> editLeave(
    EditLeaveRequestModel editLeaveRequestModel,
  ) async {
    final response =
        await GetIt.I<ApiClient>(
          instanceName: VariableBag.residentApiNew,
        ).postGenericMultipart(
          'leave_controller.php',
          await editLeaveRequestModel.toFormData(),
        );
    return CommonResponseModel.fromJson(json.decode(response));
  }
}
