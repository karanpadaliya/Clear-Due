import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
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
import 'package:myco_flutter/features/leave/domain/use_case/leave_use_case.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/leave_event.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  final LeaveUseCase leaveUseCase;

  LeaveBloc(this.leaveUseCase) : super(LeaveInitial()) {
    on<FetchNewLeaveListType>((event, emit) async {
      emit(LeaveLoading());
      final preferenceManager = GetIt.I<PreferenceManager>();
      final societyId = await preferenceManager.getCompanyId();
      final languageId = await preferenceManager.getLanguageId();
      final unitId = await preferenceManager.getUnitId();
      final userId = await preferenceManager.getUserId();
      final floorId = await preferenceManager.getDepartmentId();
      final getLeaveTypeList = LeaveTypeRequestModel(
        societyId: societyId ?? '',
        unitId: unitId ?? '',
        userId: userId ?? '',
        floorId: floorId ?? '',
        currentYear: event.query,
        languageId: languageId ?? '',
      );
      try {
        final results = await leaveUseCase.getNewListType(getLeaveTypeList);
        results.fold(
          (failure) => emit(LeaveError(failure.message)),
          (leaveType) => emit(LeaveListTypeFetched(leaveType)),
        );
      } catch (e) {
        emit(const LeaveError('Failed to load getNewListType'));
      }
    });

    on<FetchMyTeamLeaveList>((event, emit) async {
      emit(LeaveLoading());
      final preferenceManager = GetIt.I<PreferenceManager>();
      final societyId = await preferenceManager.getCompanyId();
      final languageId = await preferenceManager.getLanguageId();
      final levelId = await preferenceManager.getLevelId();
      final userId = await preferenceManager.getUserId();
      final myTeamLeavesRequestModel = MyTeamLeavesRequestModel(
        societyId: societyId ?? '',
        userId: userId ?? '',
        levelId: levelId ?? '',
        languageId: languageId ?? '',
      );
      try {
        final results = await leaveUseCase.getMyTeamLeaves(
          myTeamLeavesRequestModel,
        );
        results.fold(
          (failure) => emit(LeaveError(failure.message)),
          (leaveType) => emit(TeamLeaveListFetched(leaveType)),
        );
      } catch (e) {
        emit(const LeaveError('Failed to load getMyTeamLeaves'));
      }
    });

    on<InitialView>((event, emit) async {
      emit(LeaveInitial());
    });

    on<FetchLeaveHistoryNew>((event, emit) async {
      emit(LeaveLoading());

      final preferenceManager = GetIt.I<PreferenceManager>();
      final societyId = await preferenceManager.getCompanyId();
      final languageId = await preferenceManager.getLanguageId();
      final unitId = await preferenceManager.getUnitId();
      final userId = await preferenceManager.getUserId();
      final floorId = await preferenceManager.getDepartmentId();
      final levelId = await preferenceManager.getLevelId();

      final leaveHistoryRequestModel = LeaveHistoryRequestModel(
        societyId: societyId ?? '',
        unitId: unitId ?? '',
        userId: userId ?? '',
        languageId: languageId ?? '',
        floorId: floorId ?? '',
        levelId: levelId ?? '',
        month: event.monthName,
        year: event.year,
      );

      try {
        final results = await leaveUseCase.getLeaveHistoryNew(
          leaveHistoryRequestModel,
        );
        results.fold(
          (failure) => emit(LeaveError(failure.message)),
          (model) => emit(LeaveHistoryNewFetched(model)),
        );
      } catch (e) {
        emit(LeaveError('Failed to load leave history: $e'));
      }
    });

    on<AddShortLeave>((event, emit) async {
      emit(LeaveLoading());
      final preferenceManager = GetIt.I<PreferenceManager>();
      final societyId = await preferenceManager.getCompanyId();
      final languageId = await preferenceManager.getLanguageId();
      final userName = await preferenceManager.getUserFullName();
      final userId = await preferenceManager.getUserId();

      final addShortLeaveRequestModel = AddShortLeaveRequestModel(
        societyId: societyId ?? '',
        userId: userId ?? '',
        userName: userName ?? '',
        shortLeaveDate: event.date,
        shortLeaveTime: event.time,
        shortLeaveApplyReason: event.reason,
        languageId: languageId ?? '',
      );
      try {
        final results = await leaveUseCase.addShortLeave(
          addShortLeaveRequestModel,
        );
        results.fold(
          (failure) => emit(LeaveError(failure.message)),
          (model) => emit(ShortLeaveAdded(model)),
        );
      } catch (e) {
        emit(LeaveError('Failed to add short leave: $e'));
      }
    });

    on<DeleteShortLeave>((event, emit) async {
      emit(LeaveLoading());
      final preferenceManager = GetIt.I<PreferenceManager>();

      final societyId = await preferenceManager.getCompanyId();
      final languageId = await preferenceManager.getLanguageId();
      final userName = await preferenceManager.getUserFullName();
      final userId = await preferenceManager.getUserId();

      final deleteShortLeaveRequestModel = DeleteShortLeaveRequestModel(
        shortLeaveId: event.shortLeaveId,
        shortLeaveDate: event.shortLeaveDate,
        otherUserId: event.otherUserId,
        otherUserName: event.otherUserName,
        societyId: societyId ?? '',
        userId: userId ?? '',
        userName: userName ?? '',
        languageId: languageId ?? '',
      );

      try {
        final results = await leaveUseCase.deleteShortLeave(
          deleteShortLeaveRequestModel,
        );
        results.fold(
          (failure) => emit(LeaveError(failure.message)),
          (model) => emit(ShortLeaveDeleted(model)),
        );
      } catch (e) {
        emit(LeaveError('Failed to delete short leave: $e'));
      }
    });

    on<LeaveTypesWithData>((event, emit) async {
      emit(LeaveLoading());

      final preferenceManager = GetIt.I<PreferenceManager>();
      final societyId = await preferenceManager.getCompanyId();
      final languageId = await preferenceManager.getLanguageId();
      final userName = await preferenceManager.getUserFullName();
      final userId = await preferenceManager.getUserId();
      final unitId = await preferenceManager.getUnitId();

      final leaveTypesWithDataRequestModel = LeaveTypesWithDataRequestModel(
        societyId: societyId ?? '',
        unitId: unitId ?? '',
        userId: userId ?? '',
        userName: userName ?? '',
        currentYear: event.currentYear,
        appliedLeaveDate: event.appliedLeaveDate,
        languageId: languageId ?? '',
      );

      try {
        final results = await leaveUseCase.getLeaveTypesWithData(
          leaveTypesWithDataRequestModel,
        );
        results.fold(
          (failure) => emit(LeaveError(failure.message)),
          (model) => emit(LeaveTypeWithDataFetched(model)),
        );
      } catch (e) {
        emit(LeaveError('Failed to fetch leave types: $e'));
      }
    });
    on<CheckAutoLeaveBalance>((event, emit) async {
      emit(LeaveLoading());

      final preferenceManager = GetIt.I<PreferenceManager>();
      final societyId = await preferenceManager.getCompanyId();
      final languageId = await preferenceManager.getLanguageId();
      final userId = await preferenceManager.getUserId();

      final leaveBalanceForAutoLeaveRequestModel =
          LeaveBalanceForAutoLeaveRequestModel(
            societyId: societyId ?? '',
            userId: userId ?? '',
            leaveDate: event.leaveDate,
            leaveTypeId: event.leaveId,
            languageId: languageId ?? '',
          );

      try {
        final results = await leaveUseCase.getLeaveBalanceForAutoLeave(
          leaveBalanceForAutoLeaveRequestModel,
        );
        results.fold(
          (failure) => emit(LeaveError(failure.message)),
          (model) => emit(CheckAutoLeaveBalanceFetched(model)),
        );
      } catch (e) {
        emit(LeaveError('Failed to fetch leave balance: $e'));
      }
    });

    on<DeleteLeaveRequest>((event, emit) async {
      emit(LeaveLoading());

      final preferenceManager = GetIt.I<PreferenceManager>();
      final societyId = await preferenceManager.getCompanyId();
      final languageId = await preferenceManager.getLanguageId();
      final userName = await preferenceManager.getUserFullName();
      final userId = await preferenceManager.getUserId();

      final deleteLeaveRequestModel = DeleteLeaveRequestModel(
        leaveId: event.leaveId,
        societyId: societyId ?? '',
        userId: userId ?? '',
        userName: userName ?? '',
        languageId: languageId ?? '',
        otherUserName: userName ?? '',
        myUserId: userId ?? '',
      );

      try {
        final results = await leaveUseCase.deleteLeaveRequest(
          deleteLeaveRequestModel,
        );
        results.fold(
          (failure) => emit(LeaveError(failure.message)),
          (model) => emit(LeaveRequestDeleted(model)),
        );
      } catch (e) {
        emit(LeaveError('Failed to delete leave request: $e'));
      }
    });

    on<ChangeAutoLeave>((event, emit) async {
      emit(LeaveLoading());

      final preferenceManager = GetIt.I<PreferenceManager>();
      final societyId = await preferenceManager.getCompanyId();
      final languageId = await preferenceManager.getLanguageId();
      final userName = await preferenceManager.getUserFullName();
      final userId = await preferenceManager.getUserId();

      final changeAutoLeaveRequestModel = ChangeAutoLeaveRequestModel(
        societyId: societyId ?? '',
        userId: userId ?? '',
        paidUnpaid: event.paid,
        leaveTypeId: event.leaveTypeId,
        leaveDate: event.leaveDate,
        leaveDayType: event.leaveDay,
        isExtraDay: event.extraDay,
        isSpecialLeave: event.isSpecialDay,
        attendanceId: event.attendanceId,
        userName: userName ?? '',
        leaveId: event.leaveId,
        leavePercentage: event.leavePercentage,
        languageId: languageId ?? '',
      );

      try {
        final results = await leaveUseCase.changeAutoLeave(
          changeAutoLeaveRequestModel,
        );
        results.fold(
          (failure) => emit(LeaveError(failure.message)),
          (model) => emit(AutoLeaveChanged(model)),
        );
      } catch (e) {
        emit(LeaveError('Failed to change auto leave: $e'));
      }
    });

    on<ChangeSandwichLeave>((event, emit) async {
      emit(LeaveLoading());

      final preferenceManager = GetIt.I<PreferenceManager>();
      final societyId = await preferenceManager.getCompanyId();
      final languageId = await preferenceManager.getLanguageId();
      final userName = await preferenceManager.getUserFullName();
      final userId = await preferenceManager.getUserId();
      final unitId = await preferenceManager.getUnitId();

      final changeSandwichLeaveRequestModel = ChangeSandwichLeaveRequestModel(
        societyId: societyId ?? '',
        leaveUserId: userId ?? '',
        paidUnpaid: event.paid,
        leaveTypeId: event.leaveId,
        leaveTypeName: event.leaveName,
        sandwichLeaveId: event.sandwichId,
        userName: userName ?? '',
        userId: userId ?? '',
        unitId: unitId ?? '',
        leaveUserName: event.userFullName,
        leavePercentage: event.leavePercentage,
        languageId: languageId ?? '',
      );

      try {
        final results = await leaveUseCase.changeSandwichLeave(
          changeSandwichLeaveRequestModel,
        );
        results.fold(
          (failure) => emit(LeaveError(failure.message)),
          (model) => emit(SandwichLeaveChanged(model)),
        );
      } catch (e) {
        emit(LeaveError('Failed to change sandwich leave: $e'));
      }
    });
    on<FetchCompOffLeaves>((event, emit) async {
      emit(LeaveLoading());

      final preferenceManager = GetIt.I<PreferenceManager>();
      final societyId = await preferenceManager.getCompanyId();
      final languageId = await preferenceManager.getLanguageId();
      final userId = await preferenceManager.getUserId();

      final compOffLeaveRequestModel = GetCompOffLeavesRequestModel(
        societyId: societyId ?? '',
        userId: userId ?? '',
        startDate: event.starDate,
        endDate: event.endDate,
        languageId: languageId ?? '',
      );

      try {
        final results = await leaveUseCase.getCompOffLeaves(
          compOffLeaveRequestModel,
        );
        results.fold(
          (failure) => emit(LeaveError(failure.message)),
          (model) => emit(CompOffLeavesFetched(model)),
        );
      } catch (e) {
        emit(LeaveError('Failed to fetch comp off leaves: $e'));
      }
    });

    on<FetchLeaveCalendarNew>((event, emit) async {
      emit(LeaveLoading());

      final preferenceManager = GetIt.I<PreferenceManager>();
      final societyId = await preferenceManager.getCompanyId();
      final languageId = await preferenceManager.getLanguageId();
      final userId = await preferenceManager.getUserId();
      final unitId = await preferenceManager.getUnitId();
      final floorId = await preferenceManager.getDepartmentId();
      final levelId = await preferenceManager.getLevelId();
      final shiftTimeId = await preferenceManager.getShiftTimeId();

      final leaveCalendarNewRequestModel = LeaveCalendarNewRequestModel(
        societyId: societyId ?? '',
        unitId: unitId ?? '',
        userId: userId ?? '',
        blockId: '1',
        floorId: floorId ?? '',
        levelId: levelId ?? '',
        shiftTimeId: shiftTimeId ?? '',
        monthStartDate: event.startDate,
        monthEndDate: event.startDate,
        languageId: languageId ?? '',
      );

      try {
        final results = await leaveUseCase.getLeaveCalendarNew(
          leaveCalendarNewRequestModel,
        );
        results.fold(
          (failure) => emit(LeaveError(failure.message)),
          (model) => emit(LeaveCalendarNewFetched(model)),
        );
      } catch (e) {
        emit(LeaveError('Failed to fetch leave calendar: $e'));
      }
    });

    on<EditLeaveAttachmentEvent>((event, emit) async {
      emit(LeaveLoading());
      final preferenceManager = GetIt.I<PreferenceManager>();
      final societyId = await preferenceManager.getCompanyId();
      final languageId = await preferenceManager.getLanguageId();
      final userName = await preferenceManager.getUserFullName();
      final userId = await preferenceManager.getUserId();
      final unitId = await preferenceManager.getUnitId();

      final editLeaveRequestModel = EditLeaveRequestModel(
        societyId: societyId ?? '',
        userId: userId ?? '',
        userName: userName ?? '',
        leaveId: event.leaveId,
        oldAttachmentName: event.oldAttachmentName ?? '',
        leaveAttachment: event.leaveAttachment ?? null,
      );

      try {
        final results = await leaveUseCase.editLeave(editLeaveRequestModel);
        results.fold(
          (failure) => emit(LeaveError(failure.message)),
          (model) => emit(EditLeaveAttachmentState(model)),
        );
      } catch (e) {
        emit(LeaveError('Failed to fetch leave calendar: $e'));
      }
    });
  }
}
