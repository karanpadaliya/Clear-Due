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
import 'package:myco_flutter/features/leave/domain/repositories/leave_repository.dart';

class LeaveUseCase {
  final LeaveRepository repository;

  LeaveUseCase({required this.repository});

  Future<Either<Failure, LeaveHistoryResponseEntity>> getNewListType(
    LeaveTypeRequestModel query,
  ) => repository.getNewListType(query);

  Future<Either<Failure, MyTeamResponseModel>> getMyTeamLeaves(
    MyTeamLeavesRequestModel myTeamLeavesRequestModel,
  ) => repository.getMyTeamLeaves(myTeamLeavesRequestModel);

  Future<Either<Failure, LeaveHistoryResponseEntity>> getLeaveHistoryNew(
    LeaveHistoryRequestModel leaveHistoryRequestModel,
  ) => repository.getLeaveHistoryNew(leaveHistoryRequestModel);

  Future<Either<Failure, CommonResponseModelEntity>> addShortLeave(
    AddShortLeaveRequestModel addShortLeaveRequestModel,
  ) => repository.addShortLeave(addShortLeaveRequestModel);

  Future<Either<Failure, CommonResponseModelEntity>> deleteShortLeave(
    DeleteShortLeaveRequestModel deleteShortLeaveRequestModel,
  ) => repository.deleteShortLeave(deleteShortLeaveRequestModel);

  Future<Either<Failure, LeaveTypeResponseEntity>> getLeaveTypesWithData(
    LeaveTypesWithDataRequestModel requestModel,
  ) => repository.getLeaveTypesWithData(requestModel);

  Future<Either<Failure, CheckLeaveBalanceResponse>>
  getLeaveBalanceForAutoLeave(
    LeaveBalanceForAutoLeaveRequestModel leaveBalanceForAutoLeaveRequestModel,
  ) => repository.getLeaveBalanceForAutoLeave(
    leaveBalanceForAutoLeaveRequestModel,
  );

  Future<Either<Failure, CommonResponseModelEntity>> deleteLeaveRequest(
    DeleteLeaveRequestModel deleteLeaveRequestModel,
  ) => repository.deleteLeaveRequest(deleteLeaveRequestModel);

  Future<Either<Failure, CommonResponseModelEntity>> changeAutoLeave(
    ChangeAutoLeaveRequestModel changeAutoLeaveRequestModel,
  ) => repository.changeAutoLeave(changeAutoLeaveRequestModel);

  Future<Either<Failure, CommonResponseModelEntity>> changeSandwichLeave(
    ChangeSandwichLeaveRequestModel changeSandwichLeaveRequestModel,
  ) => repository.changeSandwichLeave(changeSandwichLeaveRequestModel);

  Future<Either<Failure, CompOffLeaveResponseEntity>> getCompOffLeaves(
    GetCompOffLeavesRequestModel getCompOffLeavesRequestModel,
  ) => repository.getCompOffLeaves(getCompOffLeavesRequestModel);

  Future<Either<Failure, LeaveCalendarResponseEntity>> getLeaveCalendarNew(
    LeaveCalendarNewRequestModel leaveCalendarNewRequestModel,
  ) => repository.getLeaveCalendarNew(leaveCalendarNewRequestModel);

  Future<Either<Failure, CommonResponseModelEntity>> editLeave(
    EditLeaveRequestModel editLeaveRequestModel,
  ) => repository.editLeave(editLeaveRequestModel);
}
