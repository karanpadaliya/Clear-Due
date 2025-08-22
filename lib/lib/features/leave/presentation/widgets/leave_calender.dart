import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/features/leave/data/model/leave_calendar_response_model.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/leave_bloc.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/leave_event.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/leave_state.dart';
import 'package:myco_flutter/features/leave/presentation/widgets/leave_date_model.dart';
import 'package:myco_flutter/features/leave/presentation/widgets/leave_half_day_full_day_change.dart';
import 'package:table_calendar/table_calendar.dart';

class LeaveCalendar extends StatefulWidget {
  final LeaveBloc leaveBloc;

  const LeaveCalendar({super.key, required this.leaveBloc});

  @override
  State<LeaveCalendar> createState() => _LeaveCalendarState();
}

class _LeaveCalendarState extends State<LeaveCalendar> {
  final LeaveCalendarData _calendarData = LeaveCalendarData();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedStartDay;
  DateTime? _selectedEndDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  List<DateTime> _currentlySelectedDays = [];
  LeaveCalendarResponseEntity? _currentCalendarData;
  List<double> usedLeaveBalanceWithMultipleLeave = [];

  @override
  void initState() {
    super.initState();
    _fetchMonthData(_focusedDay);
  }

  void _setLeaveCalendar(LeaveCalendarResponseEntity response) {
    _calendarData.monthYear = response.monthYear!;
    _calendarData.holidayList.clear();
    _calendarData.holidayListName.clear();
    _calendarData.holidayIsOptional.clear();
    _calendarData.weekOffList.clear();
    _calendarData.leaveAppliedList.clear();
    _calendarData.allLeaveDates.clear();

    _calendarData.applyHolidayLeave = response.applyHolidayLeave!;
    _calendarData.applyWeekOffLeave = response.applyWeekOffLeave!;

    bool isSalary = _calendarData.salaryGeneratedMY.contains(
      _calendarData.monthYear,
    );
    if (!isSalary) {
      _calendarData.salaryGeneratedMY.add(_calendarData.monthYear);
    }

    for (var monthlyHistory in response.monthlyHistory!) {
      final dateParts = monthlyHistory.date!.split('-');
      final date = DateTime(
        int.parse(dateParts[0]),
        int.parse(dateParts[1]),
        int.parse(dateParts[2]),
      );

      _calendarData.allLeaveDates.add(date);

      if (monthlyHistory.holiday == true && monthlyHistory.weekOff == false) {
        _calendarData.holidayList.add(monthlyHistory.date!);
        _calendarData.holidayListName.add(monthlyHistory.holidayName!);
        _calendarData.holidayIsOptional.add(
          monthlyHistory.isOptionalHoliday == true,
        );
      }

      if (monthlyHistory.weekOff! && !monthlyHistory.holiday!) {
        _calendarData.weekOffList.add(monthlyHistory.date!);
      }

      if (monthlyHistory.holiday! && monthlyHistory.weekOff!) {
        _calendarData.holidayList.add(monthlyHistory.date!);
        _calendarData.holidayListName.add(monthlyHistory.holidayName!);
        _calendarData.holidayIsOptional.add(
          monthlyHistory.isOptionalHoliday!,
        );
      }

      if (monthlyHistory.leaveApplied!) {
        _calendarData.leaveAppliedList.add(monthlyHistory.date!);
        usedLeaveBalanceWithMultipleLeave.add(double.parse(monthlyHistory.totalLeaves!));      }

      if (monthlyHistory.hasAttendance!) {
        _calendarData.hasAttendanceList.add(date);
      }
    }

    _currentCalendarData = response;
  }

  List<DateTime> _getDaysInRange(DateTime startDate, DateTime endDate) {
    final days = <DateTime>[];
    var current = startDate;

    while (!current.isAfter(endDate)) {
      days.add(current);
      current = current.add(const Duration(days: 1));
    }

    return days;
  }

  void _fetchMonthData(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);

    final startDate = DateFormat('yyyy-MM-dd').format(firstDayOfMonth);
    final endDate = DateFormat('yyyy-MM-dd').format(lastDayOfMonth);

    widget.leaveBloc.add(FetchLeaveCalendarNew(startDate, endDate));
  }

  String _formattedHeaderDate(DateTime date) =>
      DateFormat('MMMM yyyy').format(date);

  void _removeSelectedDate(LeaveDateModel model) {
    setState(() {
      final dateToRemove = DateTime.parse(model.selectedDate);
      _currentlySelectedDays.removeWhere((date) => isSameDay(date, dateToRemove));
      _calendarData.leaveDateModelList.removeWhere(
              (leaveModel) => leaveModel.selectedDate == model.selectedDate);

      // Reset selection if the removed date was part of the range
      if (_selectedStartDay != null && isSameDay(_selectedStartDay!, dateToRemove)) {
        _selectedStartDay = null;
        _selectedEndDay = null;
      } else if (_selectedEndDay != null && isSameDay(_selectedEndDay!, dateToRemove)) {
        _selectedEndDay = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<LeaveBloc, LeaveState>(
    bloc: widget.leaveBloc,
    builder: (context, state) {
      if (state is LeaveLoading) {
        return const Center(child: CupertinoActivityIndicator());
      } else if (state is LeaveCalendarNewFetched) {
        if (_currentCalendarData != state.leaveCalendarResponseEntity) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _setLeaveCalendar(state.leaveCalendarResponseEntity);
          });
        }

        String? getExtraDataInfo(String dateStr) {
          if (_calendarData.weekOffList.contains(dateStr)) return 'Week Off';
          if (_calendarData.holidayList.contains(dateStr)) return 'Holiday';
          return null;
        }

        String getWeekOffHoliday(String dateStr) {
          if (_calendarData.weekOffList.contains(dateStr)) return '2';
          if (_calendarData.holidayList.contains(dateStr)) return '1';
          return '0';
        }

        _calendarData.leaveDateModelList = _currentlySelectedDays.map((date) {
          final dateStr = DateFormat('yyyy-MM-dd').format(date);
          return LeaveDateModel(
            selectedDate: dateStr,
            isSelected: true,
            isPaidLeave: false,
            isFullDay: true,
            takeQuarterLeave: true,
            leaveDayTypeTemp: '0',
            isPastDateConditionTrue: date.isBefore(DateTime.now()),
            isPastDateAllowed: false,
            weekOffHoliday: getWeekOffHoliday(dateStr),
            extraDataInfo: getExtraDataInfo(dateStr) ?? '',
          );
        }).toList();

        return SingleChildScrollView(
          child: Column(
            children: [
              _buildCalendar(state.leaveCalendarResponseEntity),
              if (_currentlySelectedDays.isNotEmpty) ...[
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Selected Leave Dates',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

              ],
            ],
          ),
        );
      } else if (state is LeaveError) {
        return Center(child: Text(state.message));
      } else {
        return Container();
      }
    },
  );

  Widget _buildCalendar(LeaveCalendarResponseEntity data) => TableCalendar(
    firstDay: DateTime.utc(2020, 1),
    lastDay: DateTime.utc(2030, 12, 31),
    focusedDay: _focusedDay,
    selectedDayPredicate: (day) =>
        _currentlySelectedDays.any((d) => isSameDay(d, day)),
    startingDayOfWeek: StartingDayOfWeek.monday,
    calendarFormat: _calendarFormat,
    onFormatChanged: (format) {
      setState(() {
        _calendarFormat = format;
      });
    },
    onPageChanged: (focusedDay) {
      _focusedDay = focusedDay;
      _fetchMonthData(focusedDay);
    },
    onDaySelected: (selectedDay, focusedDay) {
      setState(() {
        _focusedDay = focusedDay;

        final isSingleSelection =
            _currentlySelectedDays.length == 1 &&
                isSameDay(_currentlySelectedDays.first, selectedDay);

        if (isSingleSelection) {
          _selectedStartDay = null;
          _selectedEndDay = null;
          _currentlySelectedDays = [];
        } else if (_selectedStartDay == null) {
          _selectedStartDay = selectedDay;
          _selectedEndDay = null;
          _currentlySelectedDays = [selectedDay];
        } else if (_selectedEndDay == null) {
          if (selectedDay.isAfter(_selectedStartDay!)) {
            _selectedEndDay = selectedDay;
          } else {
            _selectedEndDay = _selectedStartDay;
            _selectedStartDay = selectedDay;
          }
          _currentlySelectedDays = _getDaysInRange(
            _selectedStartDay!,
            _selectedEndDay!,
          );
        } else {
          _selectedStartDay = selectedDay;
          _selectedEndDay = null;
          _currentlySelectedDays = [selectedDay];
        }
      });
    },
    calendarStyle: const CalendarStyle(
      outsideDaysVisible: false,
      todayDecoration: BoxDecoration(
        color: Colors.teal,
        shape: BoxShape.circle,
      ),
      selectedDecoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      rangeStartDecoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      rangeEndDecoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      rangeHighlightColor: Color(0x553F51B5),
    ),
    headerStyle: const HeaderStyle(
      formatButtonVisible: false,
      titleCentered: true,
    ),
    calendarBuilders: CalendarBuilders(
      headerTitleBuilder: (context, day) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _formattedHeaderDate(day),
            style: const TextStyle(
              fontSize: 20,
              color: AppColors.black,
              fontFamily: 'Gilroy-semiBold',
            ),
          ),
        ],
      ),
      defaultBuilder: (context, day, focusedDay) {
        final now = DateTime.now();
        final isPast = day.isBefore(DateTime(now.year, now.month, now.day));
        final isSelected = _currentlySelectedDays.any((d) => isSameDay(d, day));
        final isInRange =
            _selectedStartDay != null &&
                _selectedEndDay != null &&
                (day.isAfter(_selectedStartDay!) && day.isBefore(_selectedEndDay!));

        if (isPast) {
          return Container(
            margin: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black26),
                BoxShadow(
                  color: Color(0xFFE6E6E6),
                  blurRadius: 3,
                  offset: Offset(1, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              '${day.day}',
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Gilroy-semiBold',
              ),
            ),
          );
        }

        if (isSelected) {
          return Container(
            margin: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(3, 3),
                  blurRadius: 2,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              '${day.day}',
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Gilroy-semiBold',
              ),
            ),
          );
        }

        if (isInRange) {
          return Container(
            margin: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Color(0x553F51B5),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '${day.day}',
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Gilroy-semiBold',
              ),
            ),
          );
        }

        return Container(
          margin: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.black26),
              BoxShadow(
                color: Colors.white,
                blurRadius: 3,
                offset: Offset(1.5, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            '${day.day}',
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Gilroy-semiBold',
            ),
          ),
        );
      },
    ),
  );



  void _setDateData(List<DateTime> dates) {
    _bifurcateSelectedDates(dates);

    if (_calendarData.leaveDateModelList.isNotEmpty) {
      // Get leave type for the last selected date
      final lastDate = _calendarData.leaveDateModelList.last.selectedDate;
      // You would call your getLeaveType equivalent here
    }

    _setRecyclerViewData();
  }

  void _setRecyclerViewData() {
    if (_calendarData.leaveDateModelList.isNotEmpty) {
      for (final model in _calendarData.leaveDateModelList) {
        model.isPaidLeave = false;
        model.isFullDay = true;
        model.takeQuarterLeave = true;
        model.leaveDayTypeTemp = '0';
        model.leavePercentage = 100;
      }

      // Update your UI here to show the selected dates
      setState(() {
        // This will rebuild the widget with the updated data
      });
    }
    }

  void _bifurcateSelectedDates(List<DateTime> dates) {
    _calendarData.leaveDateModelList.clear();

    for (final date in dates) {
      final dateStr = DateFormat('yyyy-MM-dd').format(date);
      final leaveDateModel = LeaveDateModel(
        selectedDate: dateStr,
        isSelected: true,
        isPaidLeave: false,
        isFullDay: true,
        takeQuarterLeave: true,
        leaveDayTypeTemp: '0',
        isPastDateConditionTrue: date.isBefore(DateTime.now()),
        isPastDateAllowed: true,
        weekOffHoliday: '0',
        extraDataInfo: '',
      );

      _setOtherTypeData(dateStr, leaveDateModel);
      _calendarData.leaveDateModelList.add(leaveDateModel);
    }
  }

  void _setOtherTypeData(String dateStr, LeaveDateModel leaveDateModel) {
    // Set holiday data
    final holidayIndex = _calendarData.holidayList.indexOf(dateStr);
    _setHolidayData(holidayIndex, leaveDateModel);

    // Set week off data
    final isWeekOff = _calendarData.weekOffList.contains(dateStr);
    _setWeekOffData(isWeekOff, holidayIndex, leaveDateModel);

    // Set leave data
    _setLeaveData(dateStr, leaveDateModel);

    // Set attendance data
    final hasAttendance = _calendarData.hasAttendanceList.any((d) =>
    DateFormat('yyyy-MM-dd').format(d) == dateStr);
    _setAttendanceData(isWeekOff, dateStr, leaveDateModel);
  }

  void _setHolidayData(int index, LeaveDateModel leaveDateModel) {
    if (index != -1) {
      if (_calendarData.holidayIsOptional[index]) {
        leaveDateModel.extraDataInfo = 'Optional leave applied';
        leaveDateModel.isSelected = false;
      } else {
        leaveDateModel.extraDataInfo = 'Holiday';
        leaveDateModel.weekOffHoliday = '2';
        leaveDateModel.isSelected = _calendarData.applyHolidayLeave == '1';
      }
    }
  }

  void _setWeekOffData(bool isWeekOff, int holidayIndex, LeaveDateModel leaveDateModel) {
    if (isWeekOff) {
      leaveDateModel.extraDataInfo = 'Week Off';
      leaveDateModel.isSelected = _calendarData.applyWeekOffLeave == '1';
      leaveDateModel.weekOffHoliday = '1';
    }

    if (isWeekOff && _calendarData.applyWeekOffLeave == '1') {
      leaveDateModel.normalHolidayWeek = '1';
    } else if (holidayIndex != -1 && _calendarData.applyHolidayLeave == '1') {
      leaveDateModel.normalHolidayWeek = '2';
    } else {
      leaveDateModel.normalHolidayWeek = '0';
    }
  }

  void _setLeaveData(String dateStr, LeaveDateModel leaveDateModel) {
    final leaveIndex = _calendarData.leaveAppliedList.indexOf(dateStr);
    if (leaveIndex != -1) {
      leaveDateModel.extraDataInfo = 'Leave already added';
      leaveDateModel.isSelected = false;
      leaveDateModel.weekOffHoliday = '4';

      if (usedLeaveBalanceWithMultipleLeave != null &&
          usedLeaveBalanceWithMultipleLeave.isNotEmpty) {
        final totalLeave = usedLeaveBalanceWithMultipleLeave[leaveIndex];
        leaveDateModel.totalAlreadyLeaveApplied = totalLeave;

        if (totalLeave < 1) {
          leaveDateModel.isSelected = true;
        }
      }
    }
  }

  void _setAttendanceData(bool isWeekOff, String dateStr, LeaveDateModel leaveDateModel) {
    final hasAttendance = _calendarData.hasAttendanceList.any((d) =>
    DateFormat('yyyy-MM-dd').format(d) == dateStr);

    if (hasAttendance) {
      leaveDateModel.extraDataInfo = 'You were already present';
      leaveDateModel.weekOffHoliday = '3';

      if (isWeekOff) {
        leaveDateModel.isSelected = true;
      }
    }
  }

  void _applyUnpaidRestrictionLogic() {
    double usedUnpaidLeaveInMonthTemp = 0; // You would get this from your data

    for (final model in _calendarData.leaveDateModelList) {
      model.isUnpaidRestrictionON = false;
    }

    for (final model in _calendarData.leaveDateModelList) {
      if (!model.isSelected || model.isPaidLeave ||
          model.isPastDateConditionTrue || !model.isPastDateAllowed) {
        continue;
      }

      bool restrict = false;
      bool unpaidLimitReached = false;
      String message = '';

      // Implement your unpaid leave restriction logic here
      // Similar to the Android version but adapted for Flutter

      if (restrict) {
        model.isUnpaidRestrictionON = true;
        model.extraDataInfo = message;
      }
    }
  }
}


class LeaveCalendarData {
  String monthYear = '';
  List<String> holidayList = [];
  List<bool> holidayIsOptional = [];
  List<String> holidayListName = [];
  List<String> weekOffList = [];
  List<String> leaveAppliedList = [];
  Set<DateTime> allLeaveDates = {};
  String applyHolidayLeave = '';
  String applyWeekOffLeave = '';
  List<String> salaryGeneratedMY = [];
  List<DateTime> hasAttendanceList = [];
  List<LeaveDateModel> leaveDateModelList = [];
}