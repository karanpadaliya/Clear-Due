import 'package:myco_flutter/core/models/data/common_response_model.dart';
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

abstract class LeaveRemoteDataSource {
  Future<LeaveHistoryResponseModel> getNewLeaveListType(
    LeaveTypeRequestModel query,
  );

  Future<MyTeamResponseModel> getMyTeamLeaves(
    MyTeamLeavesRequestModel myTeamLeavesRequestModel,
  );

  Future<LeaveHistoryResponseModel> getLeaveHistoryNew(
    LeaveHistoryRequestModel leaveHistoryRequestModel,
  );

  Future<CommonResponseModel> addShortLeave(
    AddShortLeaveRequestModel addShortLeaveRequestModel,
  );

  Future<CommonResponseModel> deleteShortLeave(
    DeleteShortLeaveRequestModel deleteShortLeaveRequestModel,
  );

  Future<LeaveTypeResponse> getLeaveTypesWithData(
    LeaveTypesWithDataRequestModel leaveTypesWithDataRequestModel,
  );

  Future<CheckLeaveBalanceResponse> getLeaveBalanceForAutoLeave(
    LeaveBalanceForAutoLeaveRequestModel leaveBalanceForAutoLeaveRequestModel,
  );

  Future<CommonResponseModel> deleteLeaveRequest(
    DeleteLeaveRequestModel deleteLeaveRequestModel,
  );

  Future<CommonResponseModel> changeAutoLeave(
    ChangeAutoLeaveRequestModel changeAutoLeaveRequestModel,
  );

  Future<CommonResponseModel> changeSandwichLeave(
    ChangeSandwichLeaveRequestModel changeSandwichLeaveRequestModel,
  );

  Future<CompOffLeaveResponseModel> getCompOffLeaves(
    GetCompOffLeavesRequestModel getCompOffLeavesRequestModel,
  );

  Future<LeaveCalendarResponseModel> getLeaveCalendarNew(
    LeaveCalendarNewRequestModel leaveCalendarNewRequestModel,
  );

  Future<CommonResponseModel> editLeave(
    EditLeaveRequestModel editLeaveRequestModel,
  );
}
