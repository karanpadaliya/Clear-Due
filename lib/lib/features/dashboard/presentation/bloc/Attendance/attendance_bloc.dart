import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/error/global_error_handler/global_error_cubit.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/features/dashboard/data/models/requests/attendance_requests.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/attendance_type_response_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/requests/get_attendance_type_request.dart';
import 'package:myco_flutter/features/dashboard/domain/usecases/dashboard_usecases.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final DashboardUsecases dashboardUsecases;
  final GlobalErrorCubit globalError;
  final PreferenceManager preferenceManager;

  AttendanceBloc(
    this.dashboardUsecases,
    this.globalError,
    this.preferenceManager,
  ) : super(AttendanceInitial()) {
    on<FetchAttendanceData>(_onFetchAttendanceData);
    on<PunchInRequested>(_onPunchIn);
    on<PunchOutRequested>(_onPunchOut);
    on<BreakInRequested>(_onBreakIn);
    on<BreakOutRequested>(_onBreakOut);
  }

  Future<void> _onFetchAttendanceData(
    FetchAttendanceData event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(AttendanceLoading());
    final userId = await preferenceManager.getUserId() ?? '';
    final companyId = await preferenceManager.getCompanyId() ?? '';
    final unitId = await preferenceManager.getUnitId() ?? '';
    final languageId = await preferenceManager.getLanguageId() ?? '';
    final shiftTimeId = '3';

    // These values would normally be fetched from a location service in a real app.
    // We'll use dummy values for this example.
    final lastFetchLocationLatitude = '0.0';
    final lastFetchLocationLongitude = '0.0';
    final lastFetchLocationAccuracy = '0.0';
    final GetAttendanceTypeRequest request = GetAttendanceTypeRequest(
      userId: userId,
      companyId: companyId,
      unitId: unitId,
      languageId: languageId,
      shiftTimeId: shiftTimeId,
      latitude: lastFetchLocationLatitude,
      longitude: lastFetchLocationLongitude,
      gpsAccuracy: lastFetchLocationAccuracy,
    );
    final result = await dashboardUsecases.getAttendanceType(request);
    result.fold((failure) => emit(AttendanceError(failure.message)), (data) {
      emit(AttendanceStateUpdated(data));
      // Translate primitive values to PreferenceManager
      if (data.shiftData != null) {
        if (data.shiftData!.totalMinutestea != null) {
          preferenceManager.writeString(
            'tea_break_time',
            data.shiftData!.totalMinutestea!,
          );
        }
        if (data.shiftData!.shiftTimeZone != null) {
          preferenceManager.writeString(
            'current_shift_time_zone',
            data.shiftData!.shiftTimeZone!,
          );
        }
        if (data.shiftData!.totalMinutesLunch != null) {
          preferenceManager.writeString(
            'lunch_break_time',
            data.shiftData!.totalMinutesLunch!,
          );
        }
      }

      preferenceManager.writeBool(
        'only_auto_approved_attendance',
        data.onlyAutoApprovedAttendanceField ?? false,
      );
      preferenceManager.writeString(
        'attendance_type',
        data.attendanceTypeField ?? '',
      );
      PreferenceManager().writeString(
        VariableBag.PAST_ATTENDANCE_LEAVE_REQUEST,
        data.pastAttendanceLeaveRequest ?? '',
      );
    });
  }

  Future<void> _onPunchIn(
    PunchInRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(AttendanceLoading());
    final result = await dashboardUsecases.attendancePunchIn(event.request);
    result.fold((failure) => emit(AttendanceError(failure.message)), (entity) {
      // After a successful punch-in, refetch the attendance data to update the UI
      add(const FetchAttendanceData());
    });
  }

  Future<void> _onPunchOut(
    PunchOutRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(AttendanceLoading());
    final result = await dashboardUsecases.attendancePunchOut(event.request);
    result.fold((failure) => emit(AttendanceError(failure.message)), (entity) {
      add(const FetchAttendanceData());
    });
  }

  Future<void> _onBreakIn(
    BreakInRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(AttendanceLoading());
    final result = await dashboardUsecases.breakIn(event.request);
    result.fold((failure) => emit(AttendanceError(failure.message)), (entity) {
      add(const FetchAttendanceData());
    });
  }

  Future<void> _onBreakOut(
    BreakOutRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(AttendanceLoading());
    final result = await dashboardUsecases.breakOut(event.request);
    result.fold((failure) => emit(AttendanceError(failure.message)), (entity) {
      add(const FetchAttendanceData());
    });
  }
}
