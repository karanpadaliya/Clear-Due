import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/time_sheet/domain/entities/attendence_month_entity.dart';
import 'package:myco_flutter/features/time_sheet/presentation/bloc/time_sheet_bloc.dart';
import 'package:myco_flutter/features/time_sheet/presentation/bottom_sheet/absent_day_options_bottom_sheet.dart';
import 'package:myco_flutter/features/time_sheet/presentation/bottom_sheet/attendance_info_bottom_sheet.dart';
import 'package:myco_flutter/features/time_sheet/presentation/widgets/custom_pie_chart.dart';
import 'package:myco_flutter/features/time_sheet/presentation/widgets/pie_chart_card_grid.dart';
import 'package:myco_flutter/features/time_sheet/presentation/widgets/progress_bar_card.dart';
import 'package:myco_flutter/features/time_sheet/presentation/widgets/time_sheet_shimmer.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_calender.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:table_calendar/table_calendar.dart';

class TimeSheetPage extends StatelessWidget {
  const TimeSheetPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => GetIt.I<TimeSheetBloc>()..add(TimeSheetInitialized()),
    child: const TimeSheetView(),
  );
}

class TimeSheetView extends StatelessWidget {
  const TimeSheetView({super.key});

  /// Navigates to the attendance request page.
  void _navigateToAttendanceRequest(
    BuildContext context,
    MonthlyHistoryEntity history,
  ) {
    context.pushNamed(RoutePaths.attendanceRequest, extra: history);
  }

  /// Shows the Absent Day dialog with configurable options.
  void _showAbsentDayOptionsSheet({
    required BuildContext context,
    required MonthlyHistoryEntity history,
    bool isAttendanceEnabled = false,
    bool isLeaveEnabled = false,
  }) {
    showModalBottomSheet<void>(
      context: context,
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      builder: (BuildContext dialogContext) => AbsentDayOptionsBottomSheet(
        history: history,
        isOption1isEnable: isAttendanceEnabled,
        isOption2isEnable: isLeaveEnabled,
        requestForAttendance: () {
          Navigator.pop(dialogContext); // Close the dialog first
          _navigateToAttendanceRequest(context, history);
        },
        requestForLeave: () {
          // TODO: Implement navigation to "applyLeave" page
          // For now, just close the dialog.
          Navigator.pop(dialogContext);
        },
        // Overtime request logic is commented out as requested.
        overTimeRequest: () {
          // TODO: Implement Overtime Request Dialog
          Navigator.pop(dialogContext);
        },
      ),
    );
  }

  /// Shows the Attendance Info screen as a bottom sheet.
  void _showAttendanceInfoSheet(
    BuildContext context,
    MonthlyHistoryEntity history,
    bool isSalaryGenerated,
  ) {
    showModalBottomSheet<void>(
      context: context,
      clipBehavior: Clip.hardEdge,
      builder: (BuildContext dialogContext) => AttendanceInfoBottomSheet(
        history: history,
        isSalaryGenerated: isSalaryGenerated,
      ),
    );
  }

  /// Replicates the logic from Android's `dialogAttendanceLeaveRequestFragmentCall`.
  /// It determines which options (Attendance, Leave) should be enabled in the dialog.
  void _dialogAttendanceLeaveRequestFragmentCall(
    BuildContext context,
    MonthlyHistoryEntity history,
    bool isSalaryGenerated,
  ) async {
    final preferenceManager = GetIt.I<PreferenceManager>();

    final now = DateTime.now();
    final selectedDate = DateTime.parse(history.date!);
    final isPresentOrFutureMonth =
        selectedDate.year > now.year ||
        (selectedDate.year == now.year && selectedDate.month >= now.month);

    // This simulates the preference value from Android.
    // In a real app, this would come from a preference manager.
    final pastAttendanceLeaveRequest = await preferenceManager
        .getKeyValueString(VariableBag.PAST_ATTENDANCE_LEAVE_REQUEST);

    if (isPresentOrFutureMonth && !isSalaryGenerated) {
      // Present month, salary not generated: show both options.
      _showAbsentDayOptionsSheet(
        context: context,
        history: history,
        isAttendanceEnabled: true,
        isLeaveEnabled: true,
      );
    } else if (!isPresentOrFutureMonth && isSalaryGenerated) {
      // Past month, salary generated: check preference.
      switch (pastAttendanceLeaveRequest) {
        case '1': // Attendance only
          _showAbsentDayOptionsSheet(
            context: context,
            history: history,
            isAttendanceEnabled: true,
            isLeaveEnabled: false,
          );
          break;
        case '2': // Leave only
          _showAbsentDayOptionsSheet(
            context: context,
            history: history,
            isAttendanceEnabled: false,
            isLeaveEnabled: true,
          );
          break;
        case '3': // Both
          _showAbsentDayOptionsSheet(
            context: context,
            history: history,
            isAttendanceEnabled: true,
            isLeaveEnabled: true,
          );
          break;
        default: // "0" or any other value: show a toast (or do nothing).
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Salary slip already generated.')),
          );
          break;
      }
    } else {
      // Default case: show both options.
      _showAbsentDayOptionsSheet(
        context: context,
        history: history,
        isAttendanceEnabled: true,
        isLeaveEnabled: true,
      );
    }
  }

  /// Replicates the logic from Android's `handleWeekOffClick` and `handleHolidayClick`.
  void _handleSpecialDayClick(
    BuildContext context,
    MonthlyHistoryEntity history,
    bool isSalaryGenerated,
  ) {
    // NOTE: In Android, this logic checks for `needOtRequest` and `hasOtData` to decide
    // whether to show an Overtime dialog or the Absent Day dialog.
    // Since Overtime is not implemented, we will default to the Absent Day dialog flow.
    // This part can be expanded later to include overtime logic.

    // if (history.hasOtData) {
    //   // TODO: Implement Overtime Details Dialog
    // } else {
    //   if (history.needOtRequest == "1" || history.needOtRequest == "2" || history.needOtRequest == "3") {
    //     // TODO: Implement Overtime Request Dialog
    //   } else {
    _dialogAttendanceLeaveRequestFragmentCall(
      context,
      history,
      isSalaryGenerated,
    );
    //   }
    // }
  }

  /// Main handler for a date tap, replicating `setUpRecyclerViewClicks`.
  void _handleDateTap(BuildContext context, MonthlyHistoryEntity history) {
    final attendanceData = context.read<TimeSheetBloc>().state.attendanceData;
    if (attendanceData == null) return;

    final isSalaryGenerated = attendanceData.salaryGenerated ?? false;
    // NOTE: This simulates the `isFromAdmin` flag from Android.
    const isFromAdmin = false;

    // --- Condition Logic Start ---
    if (history.present == true) {
      _showAttendanceInfoSheet(context, history, isSalaryGenerated);
    } else if (history.leave == true ||
        history.halfDay == true ||
        history.quarterDay == true ||
        history.threeQuarterDay == true &&
            history.present != true &&
            history.attendanceDeclined != true) {
      // TODO: Implement DialogAppliedLeaveInfo equivalent
      debugPrint('Leave details click captured. Implement navigation.');
    } else if (!isFromAdmin &&
        (history.isToday == true || history.isDateGone == true) &&
        history.weekOff == true) {
      _handleSpecialDayClick(context, history, isSalaryGenerated);
    } else if (!isFromAdmin &&
        (history.isToday == true || history.isDateGone == true) &&
        history.holiday == true) {
      _handleSpecialDayClick(context, history, isSalaryGenerated);
    } else if (!isFromAdmin && history.holiday == true) {
      // TODO: Implement Overtime logic for future holidays if needed
      debugPrint('Future holiday click captured. Implement overtime logic.');
    } else if (!isFromAdmin && history.weekOff == true) {
      // TODO: Implement Overtime logic for future week offs if needed
      debugPrint('Future week off click captured. Implement overtime logic.');
    } else if (!isFromAdmin &&
        history.beforeJoiningDate != true &&
        (history.isToday == true || history.isDateGone == true)) {
      _dialogAttendanceLeaveRequestFragmentCall(
        context,
        history,
        isSalaryGenerated,
      );
    } else if (!isFromAdmin &&
        history.isDateGone == false &&
        history.present != true &&
        history.leave != true &&
        history.holiday != true &&
        history.weekOff != true) {
      // TODO: Implement Overtime logic for future working days if needed
      debugPrint(
        'Future working day click captured. Implement overtime logic.',
      );
    }
  }

  List<PieSegment> _generateSegmentsFromData(
    BuildContext context,
    AttendanceMonthEntity data,
  ) {
    final theme = AppTheme.getColor(context);
    final lm = LanguageManager();
    StatusCardData buildData(
      String? count,
      String title,
      String icon,
      Color color,
    ) => StatusCardData(
      count: count ?? '0',
      title: title,
      icon: icon,
      color: color,
    );
    return [
      PieSegment(
        id: 0,
        value: 33,
        color: theme.secondary,
        label: lm.get('hours'),
        data: [
          buildData(
            data.totalPresentWorkingMinutesView,
            'present_days_working_hours',
            AppAssets.calendarHoursPresentDaysWorkingHours,
            AppColors.primary,
          ),
          buildData(
            data.totalExtraHoursView,
            'extra_working_hours',
            AppAssets.calendarHoursExtraHours,
            AppColors.secondary,
          ),
          buildData(
            data.totalRemainingHoursView,
            'remaining_hours',
            AppAssets.calendarHoursRemainingHours,
            AppColors.absentDays,
          ),
          buildData(
            data.totalLeaveHours,
            'leave_hours',
            AppAssets.calendarHoursLeaveHours,
            AppColors.leaveDays,
          ),
          buildData(
            data.totalAdjustedHours,
            'adjusted_hours_remaining',
            AppAssets.calendarHoursAdjustedHours,
            theme.primary,
          ),
        ],
      ),
      PieSegment(
        id: 1,
        value: 33,
        color: theme.primary,
        label: lm.get('irregularities'),
        data: [
          buildData(
            data.totalPunchOutMissing,
            'punch_out_missing',
            AppAssets.calendarIrregularitiesLogOut,
            AppColors.punchMissingDays,
          ),
          buildData(
            data.totalPendingAttendance,
            'pending_attendance_view_month',
            AppAssets.calendarIrregularitiesPendingAttendance,
            AppColors.pendingDays,
          ),
          buildData(
            data.totalRejectedAttendance,
            'rejected_attendance',
            AppAssets.calendarIrregularitiesRejectedAttendance,
            AppColors.absentDays,
          ),
          buildData(
            data.earlyPunchOut,
            'early_out',
            AppAssets.calendarIrregularitiesEarlyOut,
            AppColors.holidayDays,
          ),
          buildData(
            data.latePunchIn,
            'late_in',
            AppAssets.calendarIrregularitiesLateIn,
            AppColors.spanishYellow,
          ),
          buildData(
            data.totalAbsent,
            'absent_day',
            AppAssets.calendarIrregularitiesAbsentDays,
            AppColors.absentDays,
          ),
        ],
      ),
      PieSegment(
        id: 2,
        value: 34,
        color: theme.onTertiaryContainer,
        label: lm.get('days_keyword'),
        data: [
          buildData(
            data.totalWorkingDays,
            'total_working_days',
            AppAssets.calendarDaysWorkingDays,
            AppColors.primary,
          ),
          buildData(
            data.totalPresent,
            'present_days',
            AppAssets.calendarDaysPresentDays,
            AppColors.secondary,
          ),
          buildData(
            data.totalExtraDays,
            'extra_days',
            AppAssets.calendarDaysExtraDays,
            AppColors.secondary,
          ),
          buildData(
            data.totalHolidays,
            'holiday',
            AppAssets.calendarDaysHoliday,
            AppColors.holidayDays,
          ),
          buildData(
            data.totalSalaryDays,
            'salaried_days',
            AppAssets.calendarDaysSalariedDays,
            AppColors.holidayDays,
          ),
          buildData(
            data.totalWeekOff,
            'week_off',
            AppAssets.calendarDaysWeekOff,
            AppColors.weekOffDays,
          ),
          buildData(
            data.totalPaidLeaves,
            'paid_leave',
            AppAssets.calendarDaysPaidLeave,
            AppColors.leaveDays,
          ),
          buildData(
            data.totalUnpaidLeaves,
            'unpaid_leave',
            AppAssets.calendarDaysUnpaidLeave,
            AppColors.leaveDays,
          ),
          buildData(
            data.totalShortLeave,
            'short_leaves',
            AppAssets.calendarDaysShortLeave,
            AppColors.leaveDays,
          ),
        ],
      ),
    ];
  }

  List<StatusCardData> _getSelectedCards(
    List<PieSegment> segments,
    int selectedId,
  ) {
    try {
      return segments.firstWhere((s) => s.id == selectedId).data
          as List<StatusCardData>;
    } catch (e) {
      try {
        return segments.firstWhere((s) => s.id == 2).data
            as List<StatusCardData>;
      } catch (_) {
        return [];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> dispatchRefresh() async {
      final bloc = context.read<TimeSheetBloc>();
      final state = bloc.state;
      bloc.add(
        GetMonthlyAttendanceHistory(
          startDate: state.currentStartDate,
          endDate: state.currentEndDate,
        ),
      );
    }

    double calculateProgress(String? spent, String? total) {
      if (spent == null || total == null) return 0.0;
      final double spentHours = double.tryParse(spent.split(' ')[0]) ?? 0.0;
      final double totalHours = double.tryParse(total.split(' ')[0]) ?? 0.0;
      if (totalHours == 0) return 0.0;
      return (spentHours / totalHours) * 100.0;
    }

    return BlocBuilder<TimeSheetBloc, TimeSheetState>(
      builder: (context, state) {
        if (state.status == TimeSheetStatus.loading) {
          return const TimeSheetShimmer();
        }

        final segments = state.attendanceData != null
            ? _generateSegmentsFromData(context, state.attendanceData!)
            : <PieSegment>[];
        final selectedCards = _getSelectedCards(
          segments,
          state.selectedSegmentId,
        );
        final areCardsOpen = state.selectedSegmentId != -1;

        return Scaffold(
          appBar: CustomAppbar(
            title: 'timesheet',
            isKey: true,
            actions: [
              GestureDetector(
                onTap: () =>
                    context.read<TimeSheetBloc>().add(CalendarFormatChanged()),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        state.calendarFormat == CalendarFormat.month
                            ? 'weekly'
                            : 'monthly',
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ),
              // REMOVED: The temporary dialog trigger from the AppBar.
            ],
          ),
          body: RefreshIndicator(
            onRefresh: dispatchRefresh,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomCalendar(
                    calendarFormat: state.calendarFormat,
                    focusedDay: state.focusedDay,
                    selectedDays: state.selectedDays,
                    allowSaturdaySelection: true,
                    allowSundaySelection: true,
                    allowMultipleSelection: false,
                    presentDays: state.presentDays,
                    pendingDays: state.pendingDays,
                    punchMissingDays: state.punchMissingDays,
                    halfDays: state.halfDays,
                    leaveDays: state.leaveDays,
                    holidayDays: state.holidayDays,
                    weekOffDays: state.weekOffDays,
                    absentDays: state.absentDays,
                    rejectedDays: state.rejectedDays,
                    applyDecoratorOnTap: false,
                    extraDays: state.extraDays,
                    onPageChanged: (newFocusedDay) => context
                        .read<TimeSheetBloc>()
                        .add(FocusedDayChanged(newFocusedDay: newFocusedDay)),
                    onDaySelected: (selectedDay, focusedDay) {
                      // This is the new integration point for the click logic.
                      final history = state.attendanceData?.monthlyHistory
                          ?.firstWhere(
                            (h) => isSameDay(
                              DateTime.tryParse(h.date ?? ''),
                              selectedDay,
                            ),
                            orElse: () => const MonthlyHistoryEntity(),
                          );

                      if (history != null && history.date != null) {
                        _handleDateTap(context, history);
                      }
                      // Also dispatch the original selection event for UI updates
                      context.read<TimeSheetBloc>().add(
                        DaySelected(
                          selectedDay: selectedDay,
                          focusedDay: focusedDay,
                        ),
                      );
                    },
                  ),
                  if (state.status == TimeSheetStatus.loaded &&
                      state.attendanceData != null)
                    ProgressBarCard(
                      totalHours:
                          state.attendanceData?.totalMonthHoursView ??
                          '0 Hours',
                      monthlyHoursSpent:
                          state.attendanceData?.totalMonthHourSpentView ??
                          '0 Hours',
                      progressPercentage: calculateProgress(
                        state.attendanceData?.totalMonthHourSpent,
                        state.attendanceData?.totalMonthHours,
                      ),
                    )
                  else
                    const ProgressBarCard(
                      totalHours: '---',
                      monthlyHoursSpent: '---',
                      progressPercentage: 0,
                    ),
                  SizedBox(height: 0.04 * Responsive.getHeight(context)),
                  if (state.status == TimeSheetStatus.loading)
                    const Center(child: CircularProgressIndicator())
                  else if (state.attendanceData != null)
                    Center(
                      child: CustomPieChart(
                        segments: segments,
                        initialSelectedSegmentId: state.selectedSegmentId,
                        onSegmentSelected: (PieSegment? segment) => context
                            .read<TimeSheetBloc>()
                            .add(PieSegmentSelected(segment: segment)),
                      ),
                    ),
                  SizedBox(height: 0.03 * Responsive.getHeight(context)),
                  EnvelopePeekCardGrid(
                    cards: selectedCards,
                    areCardsOpen: areCardsOpen,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
