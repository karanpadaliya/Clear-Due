import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/features/time_sheet/data/models/request/attendance_month_request_model.dart';
import 'package:myco_flutter/features/time_sheet/data/models/request/punch_in_request_model.dart';
import 'package:myco_flutter/features/time_sheet/data/models/request/punch_in_request_reminder_model.dart';
import 'package:myco_flutter/features/time_sheet/domain/entities/attendence_month_entity.dart';
import 'package:myco_flutter/features/time_sheet/domain/usecase/time_sheet_use_case.dart';
import 'package:myco_flutter/features/time_sheet/presentation/widgets/custom_pie_chart.dart';
import 'package:myco_flutter/features/time_sheet/presentation/widgets/pie_chart_card_grid.dart';
import 'package:table_calendar/table_calendar.dart';

part 'time_sheet_event.dart';
part 'time_sheet_state.dart';

class TimeSheetBloc extends Bloc<TimeSheetEvent, TimeSheetState> {
  final TimeSheetUseCase useCase;
  final PreferenceManager _preferenceManager = GetIt.I<PreferenceManager>();

  bool _isFetchingHistory = false;

  TimeSheetBloc(this.useCase)
    : super(TimeSheetState(focusedDay: DateTime.now())) {
    on<TimeSheetInitialized>(_onTimeSheetInitialized);
    on<CalendarFormatChanged>(_onCalendarFormatChanged);
    on<FocusedDayChanged>(_onFocusedDayChanged);
    on<DaySelected>(_onDaySelected);
    on<PieSegmentSelected>(_onPieSegmentSelected);
    on<GetMonthlyAttendanceHistory>(_onGetMonthlyAttendanceHistory);
    on<PunchInRequestReminder>(_onPunchInRequestReminder);
    on<PunchInRequest>(_onPunchInRequest);
  }

  // Helper to calculate date range
  ({String startDate, String endDate}) _calculateDateRange(
    DateTime focusedDay,
    CalendarFormat format,
  ) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    if (format == CalendarFormat.month) {
      final startDate = DateTime(focusedDay.year, focusedDay.month);
      final endDate = DateTime(focusedDay.year, focusedDay.month + 1, 0);
      return (
        startDate: dateFormat.format(startDate),
        endDate: dateFormat.format(endDate),
      );
    } else {
      // Week starts on Monday
      final firstDayOfWeek = focusedDay.subtract(
        Duration(days: focusedDay.weekday - 1),
      );
      final lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 6));
      return (
        startDate: dateFormat.format(firstDayOfWeek),
        endDate: dateFormat.format(lastDayOfWeek),
      );
    }
  }

  void _onTimeSheetInitialized(
    TimeSheetInitialized event,
    Emitter<TimeSheetState> emit,
  ) {
    emit(state.copyWith(status: TimeSheetStatus.initial));
    final range = _calculateDateRange(state.focusedDay, state.calendarFormat);
    add(
      GetMonthlyAttendanceHistory(
        startDate: range.startDate,
        endDate: range.endDate,
      ),
    );
  }

  void _onCalendarFormatChanged(
    CalendarFormatChanged event,
    Emitter<TimeSheetState> emit,
  ) {
    final newFormat = state.calendarFormat == CalendarFormat.month
        ? CalendarFormat.week
        : CalendarFormat.month;

    emit(state.copyWith(calendarFormat: newFormat));

    final range = _calculateDateRange(state.focusedDay, newFormat);
    add(
      GetMonthlyAttendanceHistory(
        startDate: range.startDate,
        endDate: range.endDate,
      ),
    );
  }

  void _onFocusedDayChanged(
    FocusedDayChanged event,
    Emitter<TimeSheetState> emit,
  ) {
    // Only fetch if the month/year has changed for month view, or week for week view
    bool shouldFetch = true;
    if (state.calendarFormat == CalendarFormat.month) {
      if (state.focusedDay.year == event.newFocusedDay.year &&
          state.focusedDay.month == event.newFocusedDay.month) {
        shouldFetch = false;
      }
    }

    emit(state.copyWith(focusedDay: event.newFocusedDay));

    if (shouldFetch) {
      final range = _calculateDateRange(
        event.newFocusedDay,
        state.calendarFormat,
      );
      add(
        GetMonthlyAttendanceHistory(
          startDate: range.startDate,
          endDate: range.endDate,
        ),
      );
    }
  }

  void _onDaySelected(DaySelected event, Emitter<TimeSheetState> emit) {
    emit(
      state.copyWith(
        selectedDays: [event.selectedDay],
        focusedDay: event.focusedDay,
      ),
    );
  }

  void _onPieSegmentSelected(
    PieSegmentSelected event,
    Emitter<TimeSheetState> emit,
  ) {
    if (event.segment != null) {
      emit(
        state.copyWith(
          selectedCards: event.segment!.data ?? [],
          shouldOpenCards: true,
          selectedSegmentId: event.segment!.id,
        ),
      );
    } else {
      // If the same segment is tapped again, it becomes null, so we close the cards.
      emit(state.copyWith(shouldOpenCards: false, selectedSegmentId: -1));
    }
  }

  Future<void> _onGetMonthlyAttendanceHistory(
    GetMonthlyAttendanceHistory event,
    Emitter<TimeSheetState> emit,
  ) async {
    if (_isFetchingHistory) return;
    _isFetchingHistory = true;

    emit(
      state.copyWith(
        status: TimeSheetStatus.loading,
        currentStartDate: event.startDate,
        currentEndDate: event.endDate,
      ),
    );

    try {
      final params = MonthlyAttendanceRequestModel(
        tag: 'getMonthlyAttendanceHistoryV2',
        companyId: await _preferenceManager.getCompanyId(),
        unitId: await _preferenceManager.getUnitId(),
        userId: await _preferenceManager.getUserId(),
        branchId: await _preferenceManager.getBranchId(),
        departmentId: await _preferenceManager.getDepartmentId(),
        levelId: await _preferenceManager.getLevelId(),
        languageId: await _preferenceManager.getLanguageId(),
        monthStartDate: event.startDate,
        monthEndDate: event.endDate,
        punchInDate: await _preferenceManager.getPunchInDate() ?? '',
      );

      final result = await useCase.monthlyAttendance(params);
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              status: TimeSheetStatus.error,
              errorMessage: failure.message,
            ),
          );
        },
        (res) {
          final presentDays = <DateTime>[];
          final pendingDays = <DateTime>[];
          final punchMissingDays = <DateTime>[];
          final halfDays = <DateTime>[];
          final leaveDays = <DateTime>[];
          final holidayDays = <DateTime>[];
          final weekOffDays = <DateTime>[];
          final absentDays = <DateTime>[];
          final rejectedDays = <DateTime>[];
          final extraDays = <DateTime>[];

          // Define 'today' to check if a date is in the past
          final now = DateTime.now();
          final today = DateTime(now.year, now.month, now.day);

          for (final history in res.monthlyHistory!) {
            final date = DateTime.tryParse(history.date ?? '');
            if (date == null) continue;

            if (history.present == true &&
                history.halfDay != true &&
                history.quarterDay != true &&
                history.threeQuarterDay != true &&
                history.leave != true &&
                history.isPunchOutMissing != true &&
                history.attendnacePending != true &&
                history.attendanceDeclined != true) {
              presentDays.add(date);
            } else if (history.present == true &&
                history.attendnacePending == true) {
              pendingDays.add(date);
            } else if (history.present == true &&
                history.isPunchOutMissing == true &&
                history.attendanceDeclined != true &&
                history.punchInRequestSent != true) {
              punchMissingDays.add(date);
            } else if (history.halfDay == true ||
                history.quarterDay == true ||
                history.threeQuarterDay == true) {
              halfDays.add(date);
            } else if (history.leave == true &&
                history.attendanceDeclined != true) {
              leaveDays.add(date);
            } else if (history.holiday == true) {
              holidayDays.add(date);
            } else if (history.weekOff == true) {
              weekOffDays.add(date);
            } else if (date.isBefore(today) &&
                history.present != true &&
                history.beforeJoiningDate != true) {
              absentDays.add(date);
            } else if (history.attendanceDeclined == true) {
              rejectedDays.add(date);
            } else if (history.extraDay == true) {
              extraDays.add(date);
            }
          }

          emit(
            state.copyWith(
              status: TimeSheetStatus.loaded,
              attendanceData: res,
              shouldOpenCards: true,
              presentDays: presentDays,
              pendingDays: pendingDays,
              punchMissingDays: punchMissingDays,
              halfDays: halfDays,
              leaveDays: leaveDays,
              holidayDays: holidayDays,
              weekOffDays: weekOffDays,
              absentDays: absentDays,
              rejectedDays: rejectedDays,
              extraDays: extraDays,
            ),
          );
        },
      );
    } finally {
      _isFetchingHistory = false;
    }
  }

  Future<void> _onPunchInRequestReminder(
    PunchInRequestReminder event,
    Emitter<TimeSheetState> emit,
  ) async {
    emit(state.copyWith(status: TimeSheetStatus.loading));
    final params = PunchInReqReminderModel(
      tag: 'punchInReqReminder',
      companyId: await _preferenceManager.getCompanyId(),
      unitId: await _preferenceManager.getUnitId(),
      userId: await _preferenceManager.getUserId(),
      userName:
          '${await _preferenceManager.getUserName()} (${await _preferenceManager.getDesignation()})',
      languageId: await _preferenceManager.getLanguageId(),
      DepartmentId: await _preferenceManager.getDepartmentId(),
      branchId: await _preferenceManager.getBranchId(),
      attendanceId: event.attendanceId,
    );
    final result = await useCase.punchInReqReminder(params);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: TimeSheetStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (res) => emit(
        state.copyWith(
          status: TimeSheetStatus.actionSuccess,
          successMessage: res.message ?? 'Success',
        ),
      ),
    );
  }

  Future<void> _onPunchInRequest(
    PunchInRequest event,
    Emitter<TimeSheetState> emit,
  ) async {
    emit(state.copyWith(status: TimeSheetStatus.loading));
    final params = PunchInRequestModel(
      tag: 'attendanceRequest',
      companyId: await _preferenceManager.getCompanyId(),
      unitId: await _preferenceManager.getUnitId(),
      userId: await _preferenceManager.getUserId(),
      branchId: await _preferenceManager.getBranchId(),
      DepartmentId: await _preferenceManager.getDepartmentId(),
      userName:
          '${await _preferenceManager.getUserName()} (${await _preferenceManager.getDesignation()})',
      languageId: await _preferenceManager.getLanguageId(),
      shiftTimeId: await _preferenceManager.getShiftTimeId(),
      punchInDate: event.punchInDate,
      punchOutDate: event.punchOutDate,
      punchInTime: event.punchInTime,
      punchOutTime: event.punchOutTime,
      locationName: await _preferenceManager.getKeyValueString(
        VariableBag.BRANCH_NAME,
      ),
      appVersion: await _preferenceManager.readString(VariableBag.APP_VERSION),
      punchInReason: event.reason,
      selectedShiftId: event.selectedShiftId,
      multiPunchData: event.multiPunchData,
    );
    final result = await useCase.punchInRequest(params);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: TimeSheetStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (res) {
        emit(
          state.copyWith(
            status: TimeSheetStatus.actionSuccess,
            successMessage: res.message ?? 'Request submitted successfully!',
          ),
        );
        final range = _calculateDateRange(
          state.focusedDay,
          state.calendarFormat,
        );
        add(
          GetMonthlyAttendanceHistory(
            startDate: range.startDate,
            endDate: range.endDate,
          ),
        );
      },
    );
  }
}
