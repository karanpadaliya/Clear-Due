import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/error/global_error_handler/global_error_cubit.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/features/dashboard/data/models/requests/attendance_requests.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/attendance_punch_in_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/attendance_punch_out_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/attendance_type_response_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/break_in_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/break_out_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/home_menu_response_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/my_unit_response_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/requests/my_unit_request_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/usecases/dashboard_usecases.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardUsecases dashboardUsecases;
  final GlobalErrorCubit globalErrorCubit;
  final PreferenceManager preferenceManager;

  DashboardBloc(
    this.dashboardUsecases,
    this.globalErrorCubit,
    this.preferenceManager,
  ) : super(DashboardInitial()) {
    on<GetIDCardDetails>(onGetIdCardDetail);
    on<GetAppMenuGridWithCategory>(getAppMenuGridWithCategory);
    on<GetMyUnits>(getMyUnits);
    // on<GetAttendanceType>(onGetAttendanceType);
    on<PunchIn>(_onPunchIn);
    on<PunchOut>(_onPunchOut);
    on<BreakIn>(_onBreakIn);
    on<BreakOut>(_onBreakOut);
  }

  Future<void> onGetIdCardDetail(
    GetIDCardDetails event,
    Emitter<DashboardState> emit,
  ) async {
    final Map<String, dynamic> dataMap = {
      'getIDCardDetails': event.getIDCardDetails,
      'user_id': event.userId,
      'company_id': event.companyId,
      'language_id': event.languageId,
    };
    final result = await dashboardUsecases.getIDCardDetails(dataMap);
    result.fold((failure) {
      globalErrorCubit.showGlobalError(failure.message);
      emit(DashboardError(failure.message));
    }, (res) => emit(const IdCardDetailLoaded('')));
  }

  Future<void> getAppMenuGridWithCategory(
    GetAppMenuGridWithCategory event,
    Emitter<DashboardState> emit,
  ) async {
    if (state is! DashboardLoaded) {
      emit(const DashboardLoaded());
    }
    final Map<String, dynamic> dataMap = {
      'getAppMenuGridWithCategory': event.getAppMenuGridWithCat,
      'user_id': event.userId,
      'company_id': event.companyId,
      'language_id': event.languageId,
      'society_id': event.society_id,
      'unit_id': event.unit_id,
      'country_id': event.country_id,
      'state_id': event.state_id,
      'city_id': event.city_id,
      'device': event.device,
    };

    // var result = await dashboardUsecases.getAppMenuGridWithCategory(dataMap);
    // result.fold((failure)=>emit(DashboardError(failure.message)), (res)=>emit(AppMenuGridLoaded(res)));

    final result = await dashboardUsecases.getAppMenuGridWithCategory(dataMap);
    result.fold(
      (failure) {
        globalErrorCubit.showGlobalError(failure.message);

        emit(DashboardError(failure.message));
      },
      (res) {
        final currentState = state as DashboardLoaded;
        emit(currentState.copyWith(homeMenuData: res));
      },
    );
  }

  Future<void> getMyUnits(
    GetMyUnits event,
    Emitter<DashboardState> emit,
  ) async {
    if (state is! DashboardLoaded) {
      emit(const DashboardLoaded());
    }
    // var result = await dashboardUsecases.getMyUnits(event.request.toJson());
    // result.fold((failure)=>emit(DashboardError(failure.message)), (res)=>emit(MyUnitsLoaded(res)));

    final result = await dashboardUsecases.getMyUnits(event.request.toJson());
    result.fold(
      (failure) {
        globalErrorCubit.showGlobalError(failure.message);
        emit(DashboardError(failure.message));
      },
      (res) {
        final currentState = state as DashboardLoaded;
        emit(currentState.copyWith(myUnitData: res));
        preferenceManager.writeString(
          'viewOtherAssets',
          res.viewOtherAssets ?? '',
        );
        preferenceManager.writeBool(
          VariableBag.IS_FINANCE_YEAR,
          res.isFinanceYear ?? false,
        );
        preferenceManager.setMenuChat(res.hideChat ?? false);
      },
    );
  }

  // Future<void> onGetAttendanceType(
  //   GetAttendanceType event,
  //   Emitter<DashboardState> emit,
  // ) async {
  //   if (state is! DashboardLoaded) {
  //     emit(const DashboardLoaded());
  //   }

  //   final Map<String, dynamic> dataMap = {
  //     'getAttendanceType': event.getAttendanceTypeNew,
  //     'society_id': event.companyId,
  //     'unit_id': event.unitId,
  //     'user_id': event.registeredUserId,
  //     'attendance_id': '0',
  //     'language_id': event.languageId,
  //     'latitude': event.lastFetchLocationLatitude,
  //     'longitude': event.lastFetchLocationLongitude,
  //     'gps_accuracy': event.lastFetchLocationAccuracy,
  //     'shift_time_id': event.shiftTimeId,
  //   };

  //   final result = await dashboardUsecases.getAttendanceType(dataMap);

  //   result.fold(
  //     (failure) {
  //       globalErrorCubit.showGlobalError(failure.message);
  //       emit(DashboardError(failure.message));
  //     },
  //     (attendanceTypeData) {
  //       final currentState = state as DashboardLoaded;
  //       emit(currentState.copyWith(attendanceTypeData: attendanceTypeData));

  //       // Translate primitive values to PreferenceManager
  //       if (attendanceTypeData.shiftData != null) {
  //         if (attendanceTypeData.shiftData!.totalMinutestea != null) {
  //           preferenceManager.writeString(
  //             'tea_break_time',
  //             attendanceTypeData.shiftData!.totalMinutestea!,
  //           );
  //         }
  //         if (attendanceTypeData.shiftData!.shiftTimeZone != null) {
  //           preferenceManager.writeString(
  //             'current_shift_time_zone',
  //             attendanceTypeData.shiftData!.shiftTimeZone!,
  //           );
  //         }
  //         if (attendanceTypeData.shiftData!.totalMinutesLunch != null) {
  //           preferenceManager.writeString(
  //             'lunch_break_time',
  //             attendanceTypeData.shiftData!.totalMinutesLunch!,
  //           );
  //         }
  //       }

  //       preferenceManager.writeBool(
  //         'only_auto_approved_attendance',
  //         attendanceTypeData.onlyAutoApprovedAttendanceField ?? false,
  //       );
  //       preferenceManager.writeString(
  //         'attendance_type',
  //         attendanceTypeData.attendanceTypeField ?? '',
  //       );
  //     },
  //   );
  // }

  Future<void> _onPunchIn(PunchIn event, Emitter<DashboardState> emit) async {
    // emit(const AttendanceLoading());
    final result = await dashboardUsecases.attendancePunchIn(event.request);
    result.fold((failure) {
      globalErrorCubit.showGlobalError(failure.message);
      emit(DashboardError(failure.message));
    }, (entity) => emit(PunchInSuccess(entity)));
  }

  Future<void> _onPunchOut(PunchOut event, Emitter<DashboardState> emit) async {
    emit(const AttendanceLoading());
    final result = await dashboardUsecases.attendancePunchOut(event.request);
    result.fold((failure) {
      globalErrorCubit.showGlobalError(failure.message);
      emit(DashboardError(failure.message));
    }, (entity) => emit(PunchOutSuccess(entity)));
  }

  Future<void> _onBreakIn(BreakIn event, Emitter<DashboardState> emit) async {
    emit(const AttendanceLoading());
    final result = await dashboardUsecases.breakIn(event.request);
    result.fold((failure) {
      globalErrorCubit.showGlobalError(failure.message);
      emit(DashboardError(failure.message));
    }, (entity) => emit(BreakInSuccess(entity)));
  }

  Future<void> _onBreakOut(BreakOut event, Emitter<DashboardState> emit) async {
    emit(const AttendanceLoading());
    final result = await dashboardUsecases.breakOut(event.request);
    result.fold((failure) {
      globalErrorCubit.showGlobalError(failure.message);
      emit(DashboardError(failure.message));
    }, (entity) => emit(BreakOutSuccess(entity)));
  }
}
