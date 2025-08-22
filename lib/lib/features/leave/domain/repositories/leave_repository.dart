import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/core/models/domain/common_response_entity.dart';
import 'package:myco_flutter/features/leave/data/model/check_leave_balance_response.dart';
import 'package:myco_flutter/features/leave/data/model/comp_off_leave_response_model.dart';
import 'package:myco_flutter/features/leave/data/model/leave_calendar_response_model.dart';
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
import 'package:myco_flutter/features/leave/domain/entities/leave_history_response_entity.dart';
import 'package:myco_flutter/features/leave/domain/entities/leave_type_response_entity.dart';

abstract class LeaveRepository {
  Future<Either<Failure, LeaveHistoryResponseEntity>> getNewListType(
    LeaveTypeRequestModel query,
  );

  Future<Either<Failure, MyTeamResponseModel>> getMyTeamLeaves(
    MyTeamLeavesRequestModel myTeamLeavesRequestModel,
  );

  Future<Either<Failure, LeaveHistoryResponseEntity>> getLeaveHistoryNew(
    LeaveHistoryRequestModel leaveHistoryRequestModel,
  );

  Future<Either<Failure, CommonResponseModelEntity>> addShortLeave(
    AddShortLeaveRequestModel addShortLeaveRequestModel,
  );

  Future<Either<Failure, CommonResponseModelEntity>> deleteShortLeave(
    DeleteShortLeaveRequestModel deleteShortLeaveRequestModel,
  );

  Future<Either<Failure, LeaveTypeResponseEntity>> getLeaveTypesWithData(
    LeaveTypesWithDataRequestModel requestModel,
  );

  Future<Either<Failure, CheckLeaveBalanceResponse>>
  getLeaveBalanceForAutoLeave(
    LeaveBalanceForAutoLeaveRequestModel leaveBalanceForAutoLeaveRequestModel,
  );

  Future<Either<Failure, CommonResponseModelEntity>> deleteLeaveRequest(
    DeleteLeaveRequestModel deleteLeaveRequestModel,
  );

  Future<Either<Failure, CommonResponseModelEntity>> changeAutoLeave(
    ChangeAutoLeaveRequestModel changeAutoLeaveRequestModel,
  );

  Future<Either<Failure, CommonResponseModelEntity>> changeSandwichLeave(
    ChangeSandwichLeaveRequestModel changeSandwichLeaveRequestModel,
  );

  Future<Either<Failure, CompOffLeaveResponseEntity>> getCompOffLeaves(
    GetCompOffLeavesRequestModel getCompOffLeavesRequestModel,
  );

  Future<Either<Failure, LeaveCalendarResponseEntity>> getLeaveCalendarNew(
    LeaveCalendarNewRequestModel leaveCalendarNewRequestModel,
  );

  Future<Either<Failure, CommonResponseModelEntity>> editLeave(
    EditLeaveRequestModel editLeaveRequestModel,
  );
}
