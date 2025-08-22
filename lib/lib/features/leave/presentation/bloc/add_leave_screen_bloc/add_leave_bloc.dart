import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/add_leave_screen_bloc/add_leave_event.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/add_leave_screen_bloc/add_leave_state.dart';
import 'package:myco_flutter/features/leave/presentation/pages/add_leave_screen.dart';

class AddLeaveBloc extends Bloc<AddLeaveEvent, AddLeaveState> {
  final List<String> leaveTypeIds;
  final List<String> leaveTypeNames;
  final LeaveCalendarData calendarData;
  final List<double> usedLeaveBalanceWithMultipleLeave = [];

  AddLeaveBloc({
    required this.leaveTypeIds,
    required this.leaveTypeNames,
    required this.calendarData,
  }) : super(AddLeaveInitial()) {
    on<SetUpLeaveData>(_onSetUpLeaveData);
    on<SetLeaveCalendar>(_onSetLeaveCalendar);
  }

  Future<void> _onSetUpLeaveData(
    SetUpLeaveData event,
    Emitter<AddLeaveState> emit,
  ) async {
    try {
      emit(LeaveDataLoading());

      final int position = event.position;

      final String leaveId = leaveTypeIds[position];
      final String leaveName = leaveTypeNames[position];
      final bool isAttachmentRequired = false;
      final String specialLeave = '0';
      final bool selectedLeaveApplyDate = false;
      final int selectedLeaveTypePosition = position;

      if (calendarData.leaveDateModelList.isNotEmpty) {
        for (final model in calendarData.leaveDateModelList) {
          model.leaveTypeId = leaveId;
          model.leaveTypeName = leaveName;
        }
      }

      // if (selectedLeaveApplyDate) {
      //   // Dispatch another event or call a method to check leave date
      //   // add(CheckSelectedLeaveDate());
      // } else {
      //   if (position > 0) {
      //     // Fetch balance logic, you can add another event here if needed
      //     // add(GetLeaveBalance(specialLeave));
      //   }
      // }

      emit(
        LeaveDataLoaded(
          leaveId: leaveId,
          leaveName: leaveName,
          isAttachmentRequired: isAttachmentRequired,
          specialLeave: specialLeave,
          selectedLeaveApplyDate: selectedLeaveApplyDate,
          selectedLeaveTypePosition: selectedLeaveTypePosition,
        ),
      );
    } catch (e) {
      emit(LeaveDataError('Error in setting up leave data: $e'));
    }
  }

  void _onSetLeaveCalendar(
    SetLeaveCalendar event,
    Emitter<AddLeaveState> emit,
  ) {
    try {
      final response = event.response;

      calendarData.monthYear = response.monthYear ?? '';
      calendarData.holidayList.clear();
      calendarData.holidayListName.clear();
      calendarData.holidayIsOptional.clear();
      calendarData.weekOffList.clear();
      calendarData.leaveAppliedList.clear();
      calendarData.allLeaveDates.clear();
      calendarData.hasAttendanceList.clear();

      calendarData.applyHolidayLeave = response.applyHolidayLeave ?? '';
      calendarData.applyWeekOffLeave = response.applyWeekOffLeave ?? '';

      final bool isSalary = calendarData.salaryGeneratedMY.contains(
        calendarData.monthYear,
      );
      if (!isSalary) {
        calendarData.salaryGeneratedMY.add(calendarData.monthYear);
      }

      for (var monthlyHistory in response.monthlyHistory!) {
        final dateParts = monthlyHistory.date!.split('-');
        final date = DateTime(
          int.parse(dateParts[0]),
          int.parse(dateParts[1]),
          int.parse(dateParts[2]),
        );

        calendarData.allLeaveDates.add(date);

        final isHoliday = monthlyHistory.holiday == true;
        final isWeekOff = monthlyHistory.weekOff == true;

        if (isHoliday && !isWeekOff) {
          calendarData.holidayList.add(monthlyHistory.date!);
          calendarData.holidayListName.add(monthlyHistory.holidayName!);
          calendarData.holidayIsOptional.add(
            monthlyHistory.isOptionalHoliday ?? false,
          );
        }

        if (isWeekOff && !isHoliday) {
          calendarData.weekOffList.add(monthlyHistory.date!);
        }

        if (isWeekOff && isHoliday) {
          calendarData.holidayList.add(monthlyHistory.date!);
          calendarData.holidayListName.add(monthlyHistory.holidayName!);
          calendarData.holidayIsOptional.add(
            monthlyHistory.isOptionalHoliday ?? false,
          );
        }

        if (monthlyHistory.leaveApplied == true) {
          calendarData.leaveAppliedList.add(monthlyHistory.date!);
          usedLeaveBalanceWithMultipleLeave.add(
            double.tryParse(monthlyHistory.totalLeaves ?? '0') ?? 0.0,
          );
        }

        if (monthlyHistory.hasAttendance == true) {
          calendarData.hasAttendanceList.add(date);
        }
      }

      // _currentCalendarData = response;

      emit(LeaveCalendarUpdated(response));
    } catch (e) {
      emit(LeaveDataError('Error setting calendar data: $e'));
    }
  }
}
