// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/leave/data/model/check_leave_balance_response.dart';
import 'package:myco_flutter/features/leave/data/model/leave_calendar_response_model.dart';
import 'package:myco_flutter/features/leave/domain/entities/leave_type_response_entity.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/add_leave_screen_bloc/add_leave_bloc.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/add_leave_screen_bloc/add_leave_event.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/add_leave_screen_bloc/add_leave_state.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/leave_bloc.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/leave_event.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/leave_state.dart';
import 'package:myco_flutter/features/leave/presentation/widgets/leave_date_model.dart';
import 'package:myco_flutter/features/leave/presentation/widgets/leave_filter_bottom_sheet.dart';
import 'package:myco_flutter/features/leave/presentation/widgets/leave_half_day_full_day_change.dart';
import 'package:myco_flutter/features/leave/presentation/widgets/required_text_label.dart';
import 'package:myco_flutter/features/payslip/presentation/widgets/custom_piechart.dart';
import 'package:myco_flutter/widgets/custom_countrycodetextfield.dart';
import 'package:myco_flutter/widgets/custom_loader_dialog.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_text_field.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';
import 'package:myco_flutter/widgets/custom_text_radio_button.dart';
import 'package:table_calendar/table_calendar.dart';

class AddLeaveScreen extends StatefulWidget {
  const AddLeaveScreen({super.key});

  @override
  State<AddLeaveScreen> createState() => _AddLeaveScreenState();
}

class _AddLeaveScreenState extends State<AddLeaveScreen> {
  late final LeaveBloc leaveBloc;
  final TextEditingController _leaveTypeController = TextEditingController();
  final FocusNode _leaveTypeFocusNode = FocusNode();
  String selectedValue = 'All Leaves';
  String taskDependencyValue = 'No';
  String selectedCountry = 'IND';
  String totalApplicableLeave = '';

  final TextEditingController phoneController = TextEditingController();
  final Map<String, String> countryMap = {
    'IND': '+91',
    'USA': '+1',
    'INA': '+62',
  };
  final TextEditingController _reasonController = TextEditingController();

  bool totalApplicableLeaveVisibility = false;
  bool otherDataVisibility = false;
  bool isSalaryGenerated = false;
  bool howManyPaidLeaveVisibility = false;
  bool info = false;

  final LeaveCalendarData _calendarData = LeaveCalendarData();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedStartDay;
  DateTime? _selectedEndDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  List<DateTime> _currentlySelectedDays = [];
  LeaveCalendarResponseEntity? _currentCalendarData;
  List<double> usedLeaveBalanceWithMultipleLeave = [];

  List<String> leaveTypeNames = ['Select'];
  List<String> leaveTypeIds = ['0'];
  bool _isLeaveTypesLoading = false;

  String? leaveIdForApi;

  bool isAttachmentRequired = false;
  String leaveName = '';
  String leaveId = '';
  String specialLeave = '0';
  bool selectedLeaveApplyDate = false;
  int selectedLeaveTypePosition = 0;

  CheckLeaveBalanceResponse globalCheckLeaveBalanceResponse =
  CheckLeaveBalanceResponse();
  int selectedFilterPositionPaidLeave = 0;
  List<RadioFilterItemList> applicablePaidLeaveFilterItems = [];
  double totalApplicablePaidLeavesMain = 0;
  double totalApplicablePaidLeaves = 0;
  bool isUserReasonRequired = false;

  // New state variables
  bool _showLeaveTypeSelector = false;
  bool _showPaidLeaveSelector = false;
  bool layoutInfo = false;
  double? _selectedPaidLeaveValue;
  String? _selectedLeaveReasonValue;

  int leaveApplyType = 0;
  int quarterLeaveApplyType = 0;
  bool applyLeaveWithActualDecimalLeaveBalance = false;
  String? unpaidLeaveAvailable;
  double usedUnpaidLeaveInMonth = 0;
  double unpaidLeaveAllowed = 0;
  bool checkUnpaidCondition = false;

  List<LeaveTypeEntity> leaveTypesArray = [];
  String fullDayKey = '';
  String firstHalfKey = '';
  String secondHalfKey = '';
  String quarterKey = '';
  String threeQuarterKey = '';

  bool showFirstSecondHalf = false;
  bool showQuarterDay = false;

  List<RadioFilterItemList> leaveReasonLeaveFilterItems = [];
  bool showDependencyHandleContainer = false;

  @override
  void initState() {
    super.initState();
    leaveBloc = BlocProvider.of<LeaveBloc>(context);
    _fetchMonthData(_focusedDay);
  }

  void _fetchMonthData(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);

    final startDate = DateFormat('yyyy-MM-dd').format(firstDayOfMonth);
    final endDate = DateFormat('yyyy-MM-dd').format(lastDayOfMonth);

    leaveBloc.add(FetchLeaveCalendarNew(startDate, endDate));
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
        _calendarData.holidayIsOptional.add(monthlyHistory.isOptionalHoliday!);
      }

      if (monthlyHistory.leaveApplied!) {
        _calendarData.leaveAppliedList.add(monthlyHistory.date!);
        usedLeaveBalanceWithMultipleLeave.add(
          double.parse(monthlyHistory.totalLeaves!),
        );
      }

      if (monthlyHistory.hasAttendance!) {
        _calendarData.hasAttendanceList.add(date);
      }
    }

    _currentCalendarData = response;
  }

  void _setUpLeaveData(int position) {
    try {
      setState(() {
        leaveId = leaveTypeIds[position];
        isAttachmentRequired = false;
        leaveName = leaveTypeNames[position];
        specialLeave = '0';
        selectedLeaveApplyDate = false;
        selectedLeaveTypePosition = position;
      });

      if (_calendarData.leaveDateModelList.isNotEmpty) {
        for (final model in _calendarData.leaveDateModelList) {
          model.leaveTypeId = leaveId;
          model.leaveTypeName = leaveName;
        }
      }

      if (selectedLeaveApplyDate) {
        _checkSelectedLeaveDate();
      } else {
        if (position > 0) {
          _getLeaveBalanceForAutoLeave(specialLeave);
        }
      }
    } catch (e) {
      debugPrint('Error in _setUpLeaveData: $e');
    }
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

  void _fetchLeaveTypesWithData(String currentYear, String appliedLeaveDate) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isLeaveTypesLoading = true;
        leaveTypeNames = [];
        leaveTypeIds = [];
      });
    });

    leaveBloc.add(
      LeaveTypesWithData(
        '1387', // companyId - replace with actual value
        '1365', // employeeId - replace with actual value
        'Lucky Katre', // employeeName - replace with actual value
        currentYear,
        appliedLeaveDate,
      ),
    );
  }

  void _getLeaveBalanceForAutoLeave(String specialLeave) {
    if (_currentlySelectedDays.isNotEmpty) {
      final appliedLeaveDate = DateFormat(
        'yyyy-MM-dd',
      ).format(_currentlySelectedDays.first);
      leaveIdForApi = leaveId;

      setState(() {
        _showPaidLeaveSelector = true;
      });

      leaveBloc.add(
        CheckAutoLeaveBalance(
          '1365', // employeeId - replace with actual value
          appliedLeaveDate,
          leaveId,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        title: const Text('Add Leave'),
        centerTitle: false,
        elevation: 0,
      ),
      body: MultiBlocListener(
        listeners: [
          /// 🟦 LISTENER: LeaveBloc
          BlocListener<LeaveBloc, LeaveState>(
            listener: (context, state) {
              if (state is LeaveError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }

              if (state is LeaveLoading) {
                CustomLoaderDialog.show(context);
              } else {
                context.pop(); // hides loader
              }

              // Calendar fetched → send to AddLeaveBloc
              if (state is LeaveCalendarNewFetched) {
                context.read<AddLeaveBloc>().add(
                  SetLeaveCalendar(state.leaveCalendarResponseEntity),
                );
                _setLeaveCalendar(state.leaveCalendarResponseEntity);
              }

              // Leave type fetched
              if (state is LeaveTypeWithDataFetched) {
                leaveTypesArray = state.leaveType.leaveTypes!;
                _setLeaveTypes(state.leaveType);
              }

              // Leave balance fetched
              if (state is CheckAutoLeaveBalanceFetched) {
                globalCheckLeaveBalanceResponse =
                    state.checkLeaveBalanceResponse;
                setDataCall(globalCheckLeaveBalanceResponse, specialLeave);
                // Trigger UI update
                (context as Element)
                    .markNeedsBuild(); // or use setState if inside StatefulWidget
              }
            },
          ),

          /// 🟩 LISTENER: AddLeaveBloc (optional, if you handle any errors or actions)
          BlocListener<AddLeaveBloc, AddLeaveState>(
            listener: (context, state) {
              if (state is LeaveDataError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
          ),
        ],
        child: BlocBuilder<AddLeaveBloc, AddLeaveState>(
          builder: (context, addLeaveState) {
            if (addLeaveState is LeaveCalendarUpdated) {
              return _buildMainContent(addLeaveState.calendarData);
            }
            if (addLeaveState is LeaveDataError) {
              log('LeaveDataError: ${addLeaveState.error}');
              return Center(child: Text(addLeaveState.error));
            }
            // Optional: show loading indicator while waiting
            return const Center(child: Text('Loading...'));
          },
        ),
      ),
    );
  }

  Widget _buildMainContent(LeaveCalendarResponseEntity? data) {
    if (data == null) return Container();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildCalendar(data),
            if (_currentlySelectedDays.isNotEmpty) ...[
              const SizedBox(height: 20),
              if (_showLeaveTypeSelector) _buildLeaveTypeSelector(),
              if (_leaveTypeController.text.isNotEmpty &&
                  _leaveTypeController.text != 'Select') ...[
                const SizedBox(height: 10),

                if (layoutInfo) _layOutInfo(context),
                const SizedBox(height: 10),
                _layOutInfoData(),
                const SizedBox(height: 10),
                LeaveDatesHalfDayChangeWidget(
                  leaveDateModelList: _calendarData.leaveDateModelList,
                  leaveApplyType: leaveApplyType,
                  isUnpaidRestrictionON: false,
                  isQuarterTriggersFullDay: quarterLeaveApplyType,
                  onAppliedLeaveClick: (int, LeaveDateModel) {},
                  onDayTypeChangeClick: () {
                    onDayTypeChangeClick();
                  },
                ),
                if (_showPaidLeaveSelector) ...[
                  const SizedBox(height: 10),
                  paidLeaveSelector(),
                ],
                const SizedBox(height: 10),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget _layOutInfoData() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(
            child: Row(
              children: [
                const SizedBox(
                  width: 115,
                  child: Center(
                    child: Icon(
                      Icons.calendar_month,
                      color: Colors.cyan,
                      size: 26,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: CustomText(
                          fullDayKey,
                          isKey: true,
                          textAlign: TextAlign.center,
                          color: Colors.cyan,
                        ),
                      ),
                      if (showFirstSecondHalf)
                        Expanded(
                          child: CustomText(
                            firstHalfKey,
                            textAlign: TextAlign.center,
                            color: Colors.cyan,
                          ),
                        ),
                      if (showFirstSecondHalf)
                        Expanded(
                          child: CustomText(
                            secondHalfKey,
                            textAlign: TextAlign.center,
                            color: Colors.cyan,
                          ),
                        ),
                      if (showQuarterDay)
                        Expanded(
                          child: CustomText(
                            quarterKey,
                            textAlign: TextAlign.center,
                            color: Colors.cyan,
                          ),
                        ),
                      if (showQuarterDay)
                        Expanded(
                          child: CustomText(
                            threeQuarterKey,
                            textAlign: TextAlign.center,
                            color: Colors.cyan,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );

  Widget _layOutInfo(BuildContext context) => Wrap(
    spacing: 16, // horizontal spacing
    runSpacing: 8, // vertical spacing
    children: [
      _buildAbbreviationItem(context, 'FD', 'Full Day'),
      _buildAbbreviationItem(context, '1H', 'First Half'),
      _buildAbbreviationItem(context, '2H', 'Second Half'),
      _buildAbbreviationItem(context, 'Qtr.', 'Quarter Day'),
      _buildAbbreviationItem(context, '3Qtr.', 'Three Quarter Day'),
    ],
  );

  Widget _buildAbbreviationItem(
      BuildContext context,
      String abbr,
      String meaning,
      ) => RichText(
    text: TextSpan(
      style: TextStyle(
        color: Colors.orange,
        // match the yellow/orange color in the image
        fontSize: 13 * Responsive.getResponsiveText(context),
        fontWeight: FontWeight.bold,
      ),
      children: [
        TextSpan(text: '$abbr = '),
        TextSpan(
          text: meaning,
          style: const TextStyle(fontWeight: FontWeight.normal),
        ),
      ],
    ),
  );

  // Helper method to build each abbreviation row
  Widget _buildAbbreviationRow(String abbreviation, String meaning) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: RichText(
      text: TextSpan(
        style: TextStyle(
          color: AppTheme.getColor(context).onSurfaceVariant,
          fontSize: 13 * Responsive.getResponsiveText(context),
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: '$abbreviation = ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: meaning),
        ],
      ),
    ),
  );

  Widget _buildLeaveTypeSelector() {
    if (_isLeaveTypesLoading) {
      return const CircularProgressIndicator();
    }

    if (leaveTypeNames.isEmpty) {
      return const Text('No leave types available');
    }

    return Column(
      children: [
        NewTextField(
          label: 'select_leave_type',
          focusNode: _leaveTypeFocusNode,
          isRequired: true,
          validator: (value) => value == null || value.isEmpty
              ? 'Please select a type of leave'
              : null,
          controller: _leaveTypeController,
          hintText: 'Select',
          onTap: () {
            _showLeaveTypeSelection();
          },
          suffix: Icon(
            Icons.keyboard_arrow_down_sharp,
            color: AppTheme.getColor(context).primary,
            size: 30 * Responsive.getResponsive(context),
          ),
        ),
        const SizedBox(height: 8),
        // Add some spacing
        if (totalApplicableLeaveVisibility)
          CustomText(
            'Applicable Paid Leave Till This Month  $totalApplicablePaidLeavesMain',
            color: AppTheme.getColor(context).onSurfaceVariant,
            fontSize: 13 * Responsive.getResponsiveText(context),
            fontWeight: FontWeight.bold,
          ),
      ],
    );
  }

  void _showLeaveTypeSelection() {
    if (leaveTypeNames.isEmpty) return;

    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) => Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Leave Type',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: leaveTypeNames.length,
                  itemBuilder: (context, index) => RadioListTile<int>(
                    title: Text(leaveTypeNames[index]),
                    value: index,
                    groupValue: selectedLeaveTypePosition,
                    onChanged: (int? value) {
                      if (value != null) {
                        // Navigator.pop(context);
                        _handleLeaveTypeSelection(value);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 5. Handle the leave type selection
  void _handleLeaveTypeSelection(int position) {
    setState(() {
      selectedLeaveTypePosition = position;

      if (position == 0) {
        // "Select" option chosen
        _leaveTypeController.text = '';
        _leaveTypeController.text = leaveTypeNames[0];
        _showPaidLeaveSelector = false;
        return;
      }

      _leaveTypeController.text = leaveTypeNames[position];
      _showPaidLeaveSelector = true;

      // Reset date data if we have selected dates
      if (_currentlySelectedDays.isNotEmpty) {
        _setDateData(_currentlySelectedDays);
      }

      // Check if we need to validate dates
      final leaveType = leaveTypesArray[position - 1];
      if (leaveType.pastDaysLeaveAppliedDays!.isNotEmpty &&
          leaveType.maxPastDateAllowed!.isNotEmpty) {
        validateLeaveDates(leaveType.maxPastDateAllowed!, position);
      } else {
        _setUpLeaveData(position);
      }
    });
  }

  void setLeaveDayType() {
    // Clear and rebuild the actual leave types list
    final actualLeaveTypes = <String>[];

    /*for (int i = 0; i < tempLeaveTypes.length; i++) {
      if (i == 0) {
        actualLeaveTypes.add(tempLeaveTypes[i]);
      } else {
        if (leaveApplyType == 0 && (i == 1 || i == 2)) {
          // Full Day & Half Day
          actualLeaveTypes.add(tempLeaveTypes[i]);
        } else if (leaveApplyType == 1 && i == 1) {
          // Only Full Day
          actualLeaveTypes.add(tempLeaveTypes[i]);
        } else if (leaveApplyType == 2) {
          // All Leave Day Types
          actualLeaveTypes.add(tempLeaveTypes[i]);
        }
      }
    }*/

    final showQuarterTypes = leaveApplyType > 1;

    // Update the adapter/view with the leave types
    // Assuming you have a way to update your Flutter widget's state
    setState(() {
      setPaid(0);
    });

    // Set visibility based on leaveApplyType
    final isFullDayOnly = leaveApplyType == 1;
    layoutInfo = true;

    showFirstSecondHalf = leaveApplyType != 1;
    showQuarterDay = leaveApplyType > 1;

    // Set text based on leaveApplyType
    fullDayKey = showQuarterTypes ? 'full_day_fd' : 'fullday';
    firstHalfKey = showQuarterTypes ? 'half_day_f_h' : 'wfh_first_half';
    secondHalfKey = showQuarterTypes ? 'half_day_s_h' : 'wfh_second_half';

    // In Flutter, you would set these text values in your widget's build method
    // based on the current state

    if (showQuarterTypes) {
      quarterKey = 'qtr';
      threeQuarterKey = 'three_qtr';
      // Set these text values in your widget
    }

    // setPieChartData(); // Uncomment if you implement this
  }

  void validateLeaveDates(String pastAllowedDate, int position) {
    if (_calendarData.leaveDateModelList.isNotEmpty) {
      try {
        final allowedDate = DateFormat('yyyy-MM-dd').parse(pastAllowedDate);

        for (final model in _calendarData.leaveDateModelList) {
          if (model.selectedDate != null) {
            final selectedDate = DateFormat(
              'yyyy-MM-dd',
            ).parse(model.selectedDate);

            if (selectedDate.isBefore(allowedDate)) {
              model.isPastDateAllowed = false;
              model.isPastDateConditionTrue = true;
              model.extraDataInfo =
              'Past date alert message${DateFormat('dd-MM-yyyy').format(allowedDate)}';
            }
          }
        }

        _setUpLeaveData(position); // Call function if no past date is found
      } catch (e) {
        debugPrint('Date parsing error: $e');
      }
    }
  }

  void _setLeaveTypes(LeaveTypeResponseEntity response) {
    if (!mounted) return;

    setState(() {
      _isLeaveTypesLoading = false;
      leaveTypeNames = ['Select'];
      leaveTypeIds = ['0'];

      for (var leaveType in response.leaveTypes!) {
        leaveTypeNames.add(leaveType.leaveTypeName ?? '');
        leaveTypeIds.add(leaveType.leaveTypeId ?? '');
      }
    });
  }

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
        _showLeaveTypeSelector = false;
        _showPaidLeaveSelector = false;
        _selectedPaidLeaveValue = null;

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

        if (_currentlySelectedDays.isNotEmpty) {
          final isSalary = _calendarData.salaryGeneratedMY.contains(
            DateFormat('MM-yyyy').format(selectedDay),
          );

          if (!isSalary) {
            _setDateData(_currentlySelectedDays);
            setState(() {
              _showLeaveTypeSelector = true;
            });
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Salary Generated'),
                content: Text('Leave month salary has already been generated'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Close'),
                  ),
                ],
              ),
            );
          }
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
    _setRecyclerViewData();
    final currentYear = _currentlySelectedDays.first.year.toString();
    final appliedLeaveDate = DateFormat(
      'yyyy-MM-dd',
    ).format(_currentlySelectedDays.first);
    _fetchLeaveTypesWithData(currentYear, appliedLeaveDate);
    _bifurcateSelectedDates(dates);
  }

  void setDataCall(CheckLeaveBalanceResponse response, String specialLeave) {
    try {
      leaveApplyType = int.parse(response.leave?.leaveApplyType ?? '0');
      quarterLeaveApplyType = int.parse(
        response.leave?.quarterLeaveApplyType ?? '0',
      );
      applyLeaveWithActualDecimalLeaveBalance =
          response.leave?.applyLeaveWithActualDecimalLeaveBalance == true;

      if (response.leave?.applicableUnpaidLeave != null &&
          response.leave!.applicableUnpaidLeave!.isNotEmpty) {
        unpaidLeaveAvailable = response.leave!.applicableUnpaidLeave;
      }

      if (response.leave?.usedUnpaidLeaveInMonth != null &&
          response.leave!.usedUnpaidLeaveInMonth!.isNotEmpty) {
        usedUnpaidLeaveInMonth = double.parse(
          response.leave!.usedUnpaidLeaveInMonth!,
        );
      }

      if (response.leave?.unpaidLeaveAllowed != null &&
          response.leave!.unpaidLeaveAllowed!.isNotEmpty) {
        checkUnpaidCondition = true;
        unpaidLeaveAllowed = double.parse(response.leave!.unpaidLeaveAllowed!);
      }

      if (response.leaveReasons != null && response.leaveReasons!.isNotEmpty) {
        isUserReasonRequired = false;
        for (var reason in response.leaveReasons!) {
          leaveReasonLeaveFilterItems.add(
            RadioFilterItemList('0', reason.reasonName ?? ''),
          );
        }
      } else {
        isUserReasonRequired = true;
      }
      totalApplicableLeaveVisibility = true;
      totalApplicablePaidLeaves = double.parse(
        response.leave?.availablePaidLeave ?? '0',
      );
      totalApplicablePaidLeavesMain = double.parse(
        response.leave?.availablePaidLeave ?? '0',
      );

      applicablePaidLeaveFilterItems.clear();
      if (totalApplicablePaidLeaves > 0) {
        applicablePaidLeaveFilterItems.add(
          RadioFilterItemList('0', 'How Many Paid Leaves?'),
        );

        double step = leaveApplyType == 0
            ? 0.5
            : leaveApplyType == 1
            ? 1.0
            : 0.25;
        String format = step == 1.0
            ? '%.0f'
            : step == 0.5
            ? '%.1f'
            : '%.2f';

        double maxApplicableLeaves =
            (totalApplicablePaidLeaves / step).floor() * step;
        for (double i = step; i <= maxApplicableLeaves; i += step) {
          applicablePaidLeaveFilterItems.add(
            RadioFilterItemList('0', i.toStringAsFixed(step == 0.25 ? 2 : 1)),
          );
        }

        if (totalApplicablePaidLeaves > maxApplicableLeaves) {
          applicablePaidLeaveFilterItems.add(
            RadioFilterItemList(
              '0',
              totalApplicablePaidLeaves.toStringAsFixed(2),
            ),
          );
        }
      }

      if (specialLeave == '1' &&
          totalApplicablePaidLeavesMain == 0 &&
          !(response.isSalaryGenerated ?? false)) {
        // Show salary generated message
      } else {
        // Show other data
      }

      if (totalApplicablePaidLeavesMain == 0) {
        // Hide paid leave selector
      }
      setLeaveDayType();

      setState(() {});
    } catch (e) {
      debugPrint('Error in setDataCall: $e');
    }
  }

  Widget paidLeaveSelector() => Column(
    children: [
      NewTextField(
        label: 'apply_paid_leave',
        focusNode: FocusNode(),
        validator: (value) => value == null || value.isEmpty
            ? 'Please select paid leave amount'
            : null,
        controller: TextEditingController(
          text: _selectedPaidLeaveValue != null
              ? _selectedPaidLeaveValue!.toStringAsFixed(2)
              : '',
        ),
        hintText: 'How Many Paid Leaves?',
        onTap: () {
          // Convert RadioFilterItemList to display strings
          List<String> displayItems = applicablePaidLeaveFilterItems
              .map((item) => item.title)
              .toList();

          showLeaveFilterBottomSheet(
            context,
            _selectedPaidLeaveValue != null
                ? _selectedPaidLeaveValue!.toStringAsFixed(2)
                : '',
                (selectedValue) {
              if (!mounted) return;
              setState(() {
                if (selectedValue != 'How Many Paid Leaves?') {
                  // Find the corresponding RadioFilterItemList
                  var selectedItem = applicablePaidLeaveFilterItems.firstWhere(
                        (item) => item.title == selectedValue,
                    orElse: () =>
                        RadioFilterItemList('0', 'How Many Paid Leaves?'),
                  );

                  _selectedPaidLeaveValue =
                      double.tryParse(selectedItem.title) ?? 0.0;
                  selectedFilterPositionPaidLeave =
                      applicablePaidLeaveFilterItems.indexWhere(
                            (item) => item.title == selectedItem.title,
                      );
                  setPaid(_selectedPaidLeaveValue!);
                } else {
                  _selectedPaidLeaveValue = null;
                  setPaid(0.0);
                }
              });
            },
            displayItems, // Pass the string list
          );
        },
        suffix: Icon(
          Icons.keyboard_arrow_down_sharp,
          color: AppTheme.getColor(context).primary,
          size: 30 * Responsive.getResponsive(context),
        ),
      ),
      SizedBox(height: 10),
      leaveReasonSelector(),
      SizedBox(height: 10),
      NewTextField(
        controller: _reasonController,
        label: 'add_reason',
        isRequired: true,
        maxLines: 5,
        minLines: 5,
        hintText: 'Add Reason',
        prefixIconPath: AppAssets.note_favorite,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a reason';
          }
          return null;
        },
      ),
      SizedBox(height: 10),

      //Mobile Number
      CustomText(
        'Alternate Mobile Number',
        color: AppTheme.getColor(context).onSurfaceVariant,
        fontSize: 16 * Responsive.getResponsiveText(context),
        fontWeight: FontWeight.bold,
      ),
      SizedBox(height: 0.01 * Responsive.getHeight(context)),
      PhoneNumberField(
        selectedCountry: selectedCountry,
        countries: countryMap.keys.toList(),
        onCountryChanged: (value, index) {
          if (value != null) {
            setState(() {
              selectedCountry = value;
            });
          }
        },
        countryDialCodes: countryMap,
        phoneController: phoneController,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            15 * Responsive.getResponsive(context),
          ),
          border: Border.all(color: AppTheme.getColor(context).outline),
          color: AppTheme.getColor(context).onPrimary,
        ),
      ),
      SizedBox(height: 0.015 * Responsive.getHeight(context)),

      //Task Dependency
      CustomText(
        'Task Dependency On You?',
        color: AppTheme.getColor(context).onSurfaceVariant,
        fontSize: 16 * Responsive.getResponsiveText(context),
        fontWeight: FontWeight.bold,
      ),
      SizedBox(height: 0.005 * Responsive.getHeight(context)),
      Row(
        children: [
          CustomTextRadioButton(
            gender: 'Yes',
            selectedGender: taskDependencyValue,
            onSelect: (val) {
              setState(() {
                taskDependencyValue = val;
                showDependencyHandleContainer = true;
              });
            },
            height: 0.063 * Responsive.getHeight(context),
            width: 0.43 * Responsive.getWidth(context),
          ),
          Spacer(),
          CustomTextRadioButton(
            gender: 'No',
            selectedGender: taskDependencyValue,
            onSelect: (val) {
              setState(() {
                taskDependencyValue = val;
                showDependencyHandleContainer = false;
              });
            },
            height: 0.063 * Responsive.getHeight(context),
            width: 0.43 * Responsive.getWidth(context),
          ),
        ],
      ),
      SizedBox(height: 0.02 * Responsive.getHeight(context)),

      //Dependency Handle
      if (showDependencyHandleContainer) ...[
        RequiredTextLabel(
          text: 'Dependency Handle',
          style: TextStyle(
            fontSize: 15 * Responsive.getResponsiveText(context),
            fontWeight: FontWeight.w700,
            color: AppTheme.getColor(context).onSurfaceVariant,
          ),
        ),
        SizedBox(height: 0.01 * Responsive.getHeight(context)),
        MyCoTextfield(
          isReadOnly: false,
          validator: (value) => value == null || value.isEmpty
              ? 'Please enter a reason for leave'
              : null,
          controller: _reasonController,
          hintText: 'Write here',
          hintTextStyle: TextStyle(
            fontSize: 18 * Responsive.getResponsiveText(context),
            color: AppTheme.getColor(context).outline,
          ),
          preFixImage: 'assets/images/message-question.png',
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Color(0xFF98A2B3)),
          ),
          textAlignment: TextAlign.start,
          maxLines: 5,
        ),
        SizedBox(height: 0.02 * Responsive.getHeight(context)),
      ],
      Padding(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: 0.08 * Responsive.getWidth(context),
        ),
        child: CustomLinePieChart(
          isValueOnChart: true,
          dynamicCenterText: 'Leaves\nOverview',
          totalLeaves: 12.0,
          totalPaidLeave: 4.0,
          height: 0.35 * Responsive.getHeight(context),
          innerRadius:
          80 * Responsive.getResponsive(context),
          segments: [
            LineChartSegment(
              label: 'Week-Offs',
              value: 2,
              color: const Color(0xFF08A4BB),
            ),
            LineChartSegment(
              label: 'Holidays',
              value: 2,
              color: const Color(0xFFFF9FEC),
            ),
            LineChartSegment(
              label: 'Unpaid Leaves',
              value: 2,
              showShadow: false,
              color: const Color(0xFF2F648E),
            ),
            LineChartSegment(
              label: 'Paid Leaves',
              showShadow: false,
              value: 2,
              color: const Color(0xFF2FBBA4),
            ),
            LineChartSegment(
              label: 'Presents',
              value: 2,
              color: const Color(0xFF9FBE00),
            ),
            LineChartSegment(
              label: 'Applied Leaves',
              value: 2,
              color: const Color(0xFFFDB913),
            ),
          ],
        ),
      ),
      MyCoButton(
        onTap: () => '',
        title: 'Submit',
        isShadowBottomLeft: true,
        boarderRadius: 50,
        fontFamily: 'Gilroy-Bold',
        fontWeight: FontWeight.w500,
      ),
      SizedBox(
        height:
        VariableBag.formContentSpacingVertical *
            Responsive.getResponsive(context),
      ),
    ],
  );
  Widget leaveReasonSelector() => Column(
    children: [
      NewTextField(
        label: 'leave_reason',
        focusNode: FocusNode(),
        validator: (value) => value == null || value.isEmpty
            ? 'Please select  leave reason'
            : null,
        controller: TextEditingController(
          text: _selectedLeaveReasonValue != null
              ? _selectedLeaveReasonValue!.toString()
              : '',
        ),
        hintText: 'Reason For Leaves?',
        onTap: () {
          // Convert RadioFilterItemList to display strings
          List<String> displayItems = leaveReasonLeaveFilterItems
              .map((item) => item.title)
              .toList();

          showLeaveFilterBottomSheet(
            context,
            _selectedLeaveReasonValue != null
                ? _selectedLeaveReasonValue.toString()
                : '',
                (selectedValue) {
              if (!mounted) return;
              setState(() {
                if (selectedValue != 'How Many Paid Leaves?') {
                  // Find the corresponding RadioFilterItemList
                  var selectedItem = leaveReasonLeaveFilterItems.firstWhere(
                        (item) => item.title == selectedValue,
                    orElse: () =>
                        RadioFilterItemList('0', 'How Many Paid Leaves?'),
                  );
                  _selectedLeaveReasonValue = selectedItem.title.toString();
                }
              });
            },
            displayItems, // Pass the string list
          );
        },
        suffix: Icon(
          Icons.keyboard_arrow_down_sharp,
          color: AppTheme.getColor(context).primary,
          size: 30 * Responsive.getResponsive(context),
        ),
      ),
    ],
  );

  void onDayTypeChangeClick() {
    if (applicablePaidLeaveFilterItems.isNotEmpty &&
        selectedFilterPositionPaidLeave > 0) {
      setPaid(
        double.parse(
          applicablePaidLeaveFilterItems[selectedFilterPositionPaidLeave].title,
        ),
      );
    } else {
      setPaid(0.0);
    }
  }

  void setPaid(double totalSelectedApplicableLeave) {
    try {
      totalApplicablePaidLeaves = totalSelectedApplicableLeave;

      if (totalApplicablePaidLeaves > 0) {
        applyPaidLeaveLogic();
      } else {
        markAllAsUnpaid();
      }

      if ('0'.compareTo(unpaidLeaveAvailable ?? '') == 0) {
        applyUnpaidRestrictionLogic();
      }
    } catch (e) {
      debugPrint('Error : $e');
    }
  }

  void applyPaidLeaveLogic() {
    for (var model in _calendarData.leaveDateModelList) {
      model.isUnpaidRestrictionON = false;
      if (!model.isSelected) {
        model.leavePercentage = 100;
        model.isPaidLeave = false;
        continue;
      }

      double required = getLeaveFraction(model.leaveDayTypeTemp);

      if (totalApplicablePaidLeaves > 0 &&
          totalApplicablePaidLeaves >= required) {
        totalApplicablePaidLeaves -= required;
        model.isPaidLeave = true;
        model.leavePercentage = (required * 100);
      } else if (totalApplicablePaidLeaves > 0 &&
          applyLeaveWithActualDecimalLeaveBalance &&
          '0'.compareTo(unpaidLeaveAvailable ?? '') == 0) {
        model.leavePercentage = (roundToTwoDecimalPlaces(
          totalApplicablePaidLeaves * 100,
        ));
        model.isPaidLeave = true;
        totalApplicablePaidLeaves = 0.0;
      } else {
        model.leavePercentage = (100);
        model.isPaidLeave = false;
      }
    }
  }

  double getLeaveFraction(String type) {
    switch (type) {
      case '0':
        return 1.0;
      case '1':
        return 0.5;
      case '2':
        return 0.25;
      case '3':
        return 0.75;
      default:
        return 0.0;
    }
  }

  double roundToTwoDecimalPlaces(double value) =>
      double.parse(value.toStringAsFixed(2));

  void markAllAsUnpaid() {
    for (var model in _calendarData.leaveDateModelList) {
      model.leavePercentage = 100;
      model.isPaidLeave = false;
    }
  }

  void applyUnpaidRestrictionLogic() {
    double usedUnpaidLeaveInMonthTemp = usedUnpaidLeaveInMonth;

    for (var model in _calendarData.leaveDateModelList) {
      model.isUnpaidRestrictionON = (false);
    }

    for (var model in _calendarData.leaveDateModelList) {
      if (!model.isSelected ||
          model.isPaidLeave ||
          model.isPastDateConditionTrue ||
          !model.isPastDateAllowed) {
        _setOtherTypeData(model.selectedDate, model);
        continue;
      }

      bool restrict = false;
      bool unpaidLimitReached = false;
      String message = '';

      if ('0'.compareTo(unpaidLeaveAvailable ?? '') == 0 &&
          unpaidLeaveAllowed == 0) {
        restrict = true;
        message = totalApplicablePaidLeavesMain == 0
            ? 'For this type of leave' // Replace with your localization
            : 'Unpaid leave is not applicable on selected leave type';
      } else if ('0'.compareTo(unpaidLeaveAvailable ?? '') == 0 &&
          (usedUnpaidLeaveInMonthTemp >= unpaidLeaveAllowed ||
              totalApplicablePaidLeavesMain == 0) &&
          !model.isPaidLeave &&
          checkUnpaidCondition) {
        restrict = true;
        unpaidLimitReached = true;

        message = totalApplicablePaidLeavesMain == 0
            ? 'For this type of leave' // Replace with your localization
            : 'Unpaid leave is not applicable. Max allowed unpaid leaves this month: $unpaidLeaveAllowed. Previously Applied Unpaid Leaves: $usedUnpaidLeaveInMonth';
      } else if ('0'.compareTo(unpaidLeaveAvailable ?? '') == 0 &&
          checkUnpaidCondition) {
        _setOtherTypeData(model.selectedDate, model);
        usedUnpaidLeaveInMonthTemp += getLeaveFraction(model.leaveDayTypeTemp);
      }

      if (restrict) {
        model.isUnpaidRestrictionON = (true);
        model.unpaidLimitReached = (unpaidLimitReached);
        model.extraDataInfo = (message);
      }
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
    final holidayIndex = _calendarData.holidayList.indexOf(dateStr);
    _setHolidayData(holidayIndex, leaveDateModel);

    final isWeekOff = _calendarData.weekOffList.contains(dateStr);
    _setWeekOffData(isWeekOff, holidayIndex, leaveDateModel);

    final hasAttendance = _calendarData.hasAttendanceList.any(
          (d) => DateFormat('yyyy-MM-dd').format(d) == dateStr,
    );
    setLeaveData(dateStr, leaveDateModel);

    _setAttendanceData(isWeekOff, dateStr, leaveDateModel);
  }

  void setLeaveData(String rangeDate, LeaveDateModel leaveDateModel) {
    // Find index of the date in leaveAppliedList
    int indexLeave = -1;
    for (int k = 0; k < _calendarData.leaveAppliedList.length; k++) {
      if (_calendarData.leaveAppliedList[k] == rangeDate) {
        indexLeave = k;
        break;
      }
    }

    if (indexLeave != -1) {
      bool l = _calendarData.leaveAppliedList.contains(rangeDate);
      if (l) {
        leaveDateModel.extraDataInfo =
        'Leave already added'; // Replace with localization if needed
        leaveDateModel.isSelected = false;
        leaveDateModel.weekOffHoliday = '4';

        if (usedLeaveBalanceWithMultipleLeave.isNotEmpty &&
            indexLeave < usedLeaveBalanceWithMultipleLeave.length) {
          double totalLeave = usedLeaveBalanceWithMultipleLeave[indexLeave];
          leaveDateModel.totalAlreadyLeaveApplied = totalLeave;

          if (totalLeave < 1) {
            leaveDateModel.isSelected = true;
          }
        }
      }
    }
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

  void _setWeekOffData(
      bool isWeekOff,
      int holidayIndex,
      LeaveDateModel leaveDateModel,
      ) {
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

  void _setAttendanceData(
      bool isWeekOff,
      String dateStr,
      LeaveDateModel leaveDateModel,
      ) {
    final hasAttendance = _calendarData.hasAttendanceList.any(
          (d) => DateFormat('yyyy-MM-dd').format(d) == dateStr,
    );

    if (hasAttendance) {
      leaveDateModel.extraDataInfo = 'You were already present';
      leaveDateModel.weekOffHoliday = '3';

      if (isWeekOff) {
        leaveDateModel.isSelected = true;
      }
    }
  }

  void _setAttendanceLeave(DateTime attendanceDate) {
    setState(() {
      _currentlySelectedDays = [attendanceDate];
      _selectedStartDay = attendanceDate;
      _selectedEndDay = null;

      final monthYear = DateFormat('MM-yyyy').format(attendanceDate);
      final isSalary = _calendarData.salaryGeneratedMY.contains(monthYear);

      if (!isSalary) {
        _setDateData(_currentlySelectedDays);
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Salary Generated'),
            content: Text('Leave month salary has already been generated'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
            ],
          ),
        );
      }
    });
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

      if (_leaveTypeController.text.isNotEmpty && leaveTypeIds.isNotEmpty) {
        final selectedIndex = leaveTypeNames.indexOf(_leaveTypeController.text);
        if (selectedIndex > 0) {
          final leaveId = leaveTypeIds[selectedIndex];
          final leaveName = leaveTypeNames[selectedIndex];

          for (final model in _calendarData.leaveDateModelList) {
            model.leaveTypeId = leaveId;
            model.leaveTypeName = leaveName;
          }
        }
      }
    }
    setState(() {});

    _checkSelectedLeaveDate();
  }

  void _checkSelectedLeaveDate() {
    if (_calendarData.leaveDateModelList.length == 1) {
      final dateParts = _calendarData.leaveDateModelList[0].selectedDate.split(
        '-',
      );
      final selectedMonth = dateParts[1];
      final selectedDay = dateParts[2];
      final finalSelectedDate = '$selectedDay-$selectedMonth';

      final birthdayDate = '';
      final anniversaryDate = '';

      String myFinalSelectedBirthDate = '';
      String myFinalSelectedAnniversaryDate = '';

      if (birthdayDate.isNotEmpty) {
        final dateMyBirthDay = birthdayDate.split('-');
        final selectedMyBirthDayMonth = dateMyBirthDay[1];
        final selectedMyBirthDayDay = dateMyBirthDay[2];
        myFinalSelectedBirthDate =
        '$selectedMyBirthDayDay-$selectedMyBirthDayMonth';
      }

      if (anniversaryDate.isNotEmpty) {
        final dateMyAnniversary = anniversaryDate.split('-');
        final selectedAnniversaryMonth = dateMyAnniversary[1];
        final selectedAnniversaryDay = dateMyAnniversary[2];
        myFinalSelectedAnniversaryDate =
        '$selectedAnniversaryDay-$selectedAnniversaryMonth';
      }

      if (myFinalSelectedBirthDate.isNotEmpty ||
          myFinalSelectedAnniversaryDate.isNotEmpty) {
        if (myFinalSelectedBirthDate == finalSelectedDate ||
            myFinalSelectedAnniversaryDate == finalSelectedDate) {
          if (_leaveTypeController.text.isNotEmpty &&
              leaveTypeNames.indexOf(_leaveTypeController.text) > 0) {
            _getLeaveBalanceForAutoLeave(specialLeave);
          }
        }
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

String _formattedHeaderDate(DateTime date) =>
    DateFormat('MMMM yyyy').format(date);

class RadioFilterItemList {
  final String id;
  final String title;

  RadioFilterItemList(this.id, this.title);

}