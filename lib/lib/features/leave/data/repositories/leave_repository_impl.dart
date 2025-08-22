import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/core/models/domain/common_response_entity.dart';
import 'package:myco_flutter/core/utils/safe_api_call.dart';
import 'package:myco_flutter/features/leave/data/datasources/leave_remote_data_source.dart';
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
import 'package:myco_flutter/features/leave/domain/entities'
    '/leave_history_response_entity.dart';
import 'package:myco_flutter/features/leave/domain/entities/leave_type_response_entity.dart';
import 'package:myco_flutter/features/leave/domain/repositories/leave_repository.dart';

class LeaveRepositoryImpl implements LeaveRepository {
  final LeaveRemoteDataSource remoteDataSource;
  final SafeApiCall safeApiCall;

  LeaveRepositoryImpl(this.remoteDataSource, this.safeApiCall);

  @override
  Future<Either<Failure, LeaveHistoryResponseEntity>> getNewListType(
    LeaveTypeRequestModel getLeaveTypeList,
  ) async => safeApiCall.execute(() async {
    // Await the response from the data source
    final responseModel = await remoteDataSource.getNewLeaveListType(
      getLeaveTypeList,
    );
    // Convert the Model to an Entity before returning
    return responseModel.toEntity();
  });

  @override
  Future<Either<Failure, MyTeamResponseModel>> getMyTeamLeaves(
    MyTeamLeavesRequestModel myTeamLeavesRequestModel,
  ) async => safeApiCall.execute(() async {
    // Await the response from the data source
    final responseModel = await remoteDataSource.getMyTeamLeaves(
      myTeamLeavesRequestModel,
    );
    // Convert the Model to an Entity before returning
    return responseModel;
  });

  @override
  Future<Either<Failure, LeaveHistoryResponseEntity>> getLeaveHistoryNew(
    LeaveHistoryRequestModel leaveHistoryRequestModel,
  ) async => safeApiCall.execute(() async {
    // Await the response from the data source
    final responseModel = await remoteDataSource.getLeaveHistoryNew(
      leaveHistoryRequestModel,
    );
    // Convert the Model to an Entity before returning
    return responseModel.toEntity();
  });

  @override
  Future<Either<Failure, CommonResponseModelEntity>> addShortLeave(
    AddShortLeaveRequestModel addShortLeaveRequestModel,
  ) async => safeApiCall.execute(() async {
    // Await the response from the data source
    final responseModel = await remoteDataSource.addShortLeave(
      addShortLeaveRequestModel,
    );
    // Convert the Model to an Entity before returning
    return responseModel.toEntity();
  });

  @override
  Future<Either<Failure, CommonResponseModelEntity>> deleteShortLeave(
    DeleteShortLeaveRequestModel deleteShortLeaveRequestModel,
  ) async => safeApiCall.execute(() async {
    // Await the response from the data source
    final responseModel = await remoteDataSource.deleteShortLeave(
      deleteShortLeaveRequestModel,
    );
    // Convert the Model to an Entity before returning
    return responseModel.toEntity();
  });

  @override
  Future<Either<Failure, LeaveTypeResponseEntity>> getLeaveTypesWithData(
    LeaveTypesWithDataRequestModel leaveTypesWithDataRequestModel,
  ) async => safeApiCall.execute(() async {
    // Await the response from the data source
    final responseModel = await remoteDataSource.getLeaveTypesWithData(
      leaveTypesWithDataRequestModel,
    );
    // Convert the Model to an Entity before returning
    return responseModel.toEntity();
  });

  @override
  Future<Either<Failure, CheckLeaveBalanceResponse>>
  getLeaveBalanceForAutoLeave(
    LeaveBalanceForAutoLeaveRequestModel leaveBalanceForAutoLeaveRequestModel,
  ) async => safeApiCall.execute(
    () => remoteDataSource.getLeaveBalanceForAutoLeave(
      leaveBalanceForAutoLeaveRequestModel,
    ),
  );

  @override
  Future<Either<Failure, CommonResponseModelEntity>> deleteLeaveRequest(
    DeleteLeaveRequestModel deleteLeaveRequestModel,
  ) async => safeApiCall.execute(() async {
    // Await the response from the data source
    final responseModel = await remoteDataSource.deleteLeaveRequest(
      deleteLeaveRequestModel,
    );
    // Convert the Model to an Entity before returning
    return responseModel.toEntity();
  });

  @override
  Future<Either<Failure, CommonResponseModelEntity>> changeAutoLeave(
    ChangeAutoLeaveRequestModel changeAutoLeaveRequestModel,
  ) async => safeApiCall.execute(() async {
    // Await the response from the data source
    final responseModel = await remoteDataSource.changeAutoLeave(
      changeAutoLeaveRequestModel,
    );
    // Convert the Model to an Entity before returning
    return responseModel.toEntity();
  });

  @override
  Future<Either<Failure, CommonResponseModelEntity>> changeSandwichLeave(
    ChangeSandwichLeaveRequestModel changeSandwichLeaveRequestModel,
  ) async => safeApiCall.execute(() async {
    // Await the response from the data source
    final responseModel = await remoteDataSource.changeSandwichLeave(
      changeSandwichLeaveRequestModel,
    );
    // Convert the Model to an Entity before returning
    return responseModel.toEntity();
  });

  @override
  Future<Either<Failure, CompOffLeaveResponseEntity>> getCompOffLeaves(
    GetCompOffLeavesRequestModel getCompOffLeavesRequestModel,
  ) async => safeApiCall.execute(() async {
    final responseModel = await remoteDataSource.getCompOffLeaves(
      getCompOffLeavesRequestModel,
    );
    return responseModel.toEntity();
  });

  @override
  Future<Either<Failure, LeaveCalendarResponseEntity>> getLeaveCalendarNew(
    LeaveCalendarNewRequestModel leaveCalendarNewRequestModel,
  ) async => safeApiCall.execute(() async {
    final responseModel = await remoteDataSource.getLeaveCalendarNew(
      leaveCalendarNewRequestModel,
    );
    return responseModel.toEntity();
  });

  @override
  Future<Either<Failure, CommonResponseModelEntity>> editLeave(
    EditLeaveRequestModel editLeaveRequestModel,
  ) async => safeApiCall.execute(() async {
    final responseModel = await remoteDataSource.editLeave(
      editLeaveRequestModel,
    );
    return responseModel.toEntity();
  });
}
