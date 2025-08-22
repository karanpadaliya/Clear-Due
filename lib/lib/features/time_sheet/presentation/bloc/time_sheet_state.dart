part of 'time_sheet_bloc.dart';

// Enum to represent the different statuses of the state
enum TimeSheetStatus { initial, loading, loaded, error, actionSuccess }

class TimeSheetState extends Equatable {
  final TimeSheetStatus status;
  final AttendanceMonthEntity? attendanceData;
  final String errorMessage;
  final String successMessage;

  final CalendarFormat calendarFormat;
  final DateTime focusedDay;
  final List<DateTime> selectedDays;
  final int selectedSegmentId;
  final String currentStartDate;
  final String currentEndDate;

  // Lists for calendar day decoration
  final List<DateTime> presentDays;
  final List<DateTime> pendingDays;
  final List<DateTime> punchMissingDays;
  final List<DateTime> halfDays;
  final List<DateTime> leaveDays;
  final List<DateTime> holidayDays;
  final List<DateTime> weekOffDays;
  final List<DateTime> absentDays;
  final List<DateTime> rejectedDays;
  final List<DateTime> extraDays;


  const TimeSheetState({
    required this.focusedDay, this.status = TimeSheetStatus.initial,
    this.attendanceData,
    this.errorMessage = '',
    this.successMessage = '',
    this.calendarFormat = CalendarFormat.month,
    this.selectedDays = const [],
    this.selectedSegmentId = 2, // Default segment ID
    this.currentStartDate = '',
    this.currentEndDate = '',
    this.presentDays = const [],
    this.pendingDays = const [],
    this.punchMissingDays = const [],
    this.halfDays = const [],
    this.leaveDays = const [],
    this.holidayDays = const [],
    this.weekOffDays = const [],
    this.absentDays = const [],
    this.rejectedDays = const [],
    this.extraDays = const [],
  });

  TimeSheetState copyWith({
    TimeSheetStatus? status,
    AttendanceMonthEntity? attendanceData,
    String? errorMessage,
    String? successMessage,
    CalendarFormat? calendarFormat,
    DateTime? focusedDay,
    List<DateTime>? selectedDays,
    List<PieSegment>? segments,
    List<StatusCardData>? selectedCards,
    bool? shouldOpenCards,
    int? selectedSegmentId,
    String? currentStartDate,
    String? currentEndDate,
    List<DateTime>? presentDays,
    List<DateTime>? pendingDays,
    List<DateTime>? punchMissingDays,
    List<DateTime>? halfDays,
    List<DateTime>? leaveDays,
    List<DateTime>? holidayDays,
    List<DateTime>? weekOffDays,
    List<DateTime>? absentDays,
    List<DateTime>? rejectedDays,
    List<DateTime>? extraDays,
  }) =>
      TimeSheetState(
        status: status ?? this.status,
        attendanceData: attendanceData ?? this.attendanceData,
        errorMessage: errorMessage ?? this.errorMessage,
        successMessage: successMessage ?? this.successMessage,
        calendarFormat: calendarFormat ?? this.calendarFormat,
        focusedDay: focusedDay ?? this.focusedDay,
        selectedDays: selectedDays ?? this.selectedDays,
        selectedSegmentId: selectedSegmentId ?? this.selectedSegmentId,
        currentStartDate: currentStartDate ?? this.currentStartDate,
        currentEndDate: currentEndDate ?? this.currentEndDate,
        presentDays: presentDays ?? this.presentDays,
        pendingDays: pendingDays ?? this.pendingDays,
        punchMissingDays: punchMissingDays ?? this.punchMissingDays,
        halfDays: halfDays ?? this.halfDays,
        leaveDays: leaveDays ?? this.leaveDays,
        holidayDays: holidayDays ?? this.holidayDays,
        weekOffDays: weekOffDays ?? this.weekOffDays,
        absentDays: absentDays ?? this.absentDays,
        rejectedDays: rejectedDays ?? this.rejectedDays,
        extraDays: extraDays ?? this.extraDays,
      );

  @override
  List<Object?> get props =>
      [
        status,
        attendanceData,
        errorMessage,
        successMessage,
        calendarFormat,
        focusedDay,
        selectedDays,
        selectedSegmentId,
        currentStartDate,
        currentEndDate,
        presentDays,
        pendingDays,
        punchMissingDays,
        halfDays,
        leaveDays,
        holidayDays,
        weekOffDays,
        absentDays,
        rejectedDays,
        extraDays,
      ];
}