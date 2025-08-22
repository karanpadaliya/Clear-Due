import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/payslip/presentation/widgets/ios_calendar_time_picker.dart';
import 'package:myco_flutter/features/time_sheet/data/models/ui/punch_entry_model.dart';
import 'package:myco_flutter/features/time_sheet/domain/entities/attendence_month_entity.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class AttendanceRequestPage extends StatefulWidget {
  final MonthlyHistoryEntity history;

  const AttendanceRequestPage({required this.history, super.key});

  @override
  State<AttendanceRequestPage> createState() => _AttendanceRequestPageState();
}

class _AttendanceRequestPageState extends State<AttendanceRequestPage> {
  final _reasonController = TextEditingController();
  final _reasonFocusNode = FocusNode(); // Add FocusNode for reason field
  List<PunchEntryModel> _punchList = [];

  // Simulated API dates; in a real app, this would be fetched.
  final List<String> apiDates = ['2025-07-25', '2025-07-26', '2025-07-27'];

  @override
  void initState() {
    super.initState();
    // Use the date from the history to initialize the first entry
    _addPunchEntry(isInitial: true, initialDate: widget.history.date);
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _reasonFocusNode.dispose(); // Dispose focus node
    super.dispose();
  }

  // Helper method to unfocus all text fields
  void _unfocusAll() {
    _reasonFocusNode.unfocus();
    FocusScope.of(context).unfocus();
  }

  /// Adds a new punch entry to the list.
  /// Before adding, it validates the current entries.
  void _addPunchEntry({bool isInitial = false, String? initialDate}) {
    if (!isInitial && !_validateEntries()) {
      // Don't add a new card if existing ones are invalid.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields in the current punch first.'),
        ),
      );
      return;
    }
    setState(() {
      _punchList.add(
        PunchEntryModel(
          // Use initialDate if provided, otherwise default to the first API date
          punchInDate: initialDate ?? apiDates.first,
          punchOutDate: initialDate ?? apiDates.first,
        ),
      );
    });
  }

  /// Removes a punch entry from the list at a given index.
  void _removePunchEntry(int index) {
    if (index >= 0 && index < _punchList.length) {
      setState(() {
        _punchList.removeAt(index);
        // Re-validate after removal
        _validateEntries();
      });
    }
  }

  /// Updates the punch-in date for a specific entry.
  void _updatePunchInDate(int index, String date) {
    setState(() {
      _punchList[index] = _punchList[index].copyWith(
        punchInDate: date,
        punchInTime: '--:--:--',
        punchOutTime: '--:--:--',
      );
      _validateEntries();
    });
  }

  /// Updates the punch-out date for a specific entry.
  void _updatePunchOutDate(int index, String date) {
    setState(() {
      _punchList[index] = _punchList[index].copyWith(
        punchOutDate: date,
        punchInTime: '--:--:--',
        punchOutTime: '--:--:--',
      );
      _validateEntries();
    });
  }

  /// Updates the punch-in time for a specific entry.
  void _updatePunchInTime(int index, String time) {
    setState(() {
      _punchList[index] = _punchList[index].copyWith(punchInTime: time);
      _validateEntries();
    });
  }

  /// Updates the punch-out time for a specific entry.
  void _updatePunchOutTime(int index, String time) {
    setState(() {
      _punchList[index] = _punchList[index].copyWith(punchOutTime: time);
      _validateEntries();
    });
  }

  /// A comprehensive validation method that checks all entries for errors.
  bool _validateEntries({bool isSubmitting = false}) {
    bool allValid = true;
    final updatedList = List<PunchEntryModel>.from(_punchList);

    // 1. Reset all previous errors
    for (int i = 0; i < updatedList.length; i++) {
      updatedList[i] = updatedList[i].copyWith(
        errorMessage: () => null,
        errorFields: {},
      );
    }

    // 2. Perform validation for each entry (empty fields, date/time logic)
    for (int i = 0; i < updatedList.length; i++) {
      final entry = updatedList[i];
      final currentErrors = <ErrorField>{};
      String? errorMessage;

      // Check for empty fields
      if (entry.punchInTime == '--:--:--') {
        currentErrors.add(ErrorField.punchInTime);
      }
      if (entry.punchOutTime == '--:--:--') {
        currentErrors.add(ErrorField.punchOutTime);
      }
      if (entry.punchInDate.isEmpty) currentErrors.add(ErrorField.punchInDate);
      if (entry.punchOutDate.isEmpty) {
        currentErrors.add(ErrorField.punchOutDate);
      }

      if (currentErrors.isNotEmpty) {
        errorMessage = 'All fields are required.';
        allValid = false;
      }

      // Check date and time validity if all fields are filled
      if (currentErrors.isEmpty) {
        final dateFormat = DateFormat('yyyy-MM-dd h:mm a');
        try {
          final inDateTime = dateFormat.parse(
            '${entry.punchInDate} ${entry.punchInTime}',
          );
          final outDateTime = dateFormat.parse(
            '${entry.punchOutDate} ${entry.punchOutTime}',
          );

          if (inDateTime.isAfter(outDateTime) ||
              inDateTime.isAtSameMomentAs(outDateTime)) {
            errorMessage = 'Punch-in time must be before punch-out time.';
            currentErrors.addAll({
              ErrorField.punchInTime,
              ErrorField.punchOutTime,
              ErrorField.punchInDate,
              ErrorField.punchOutDate,
            });
            allValid = false;
          }
        } on FormatException {
          errorMessage = 'Invalid date or time format.';
          currentErrors.addAll({
            ErrorField.punchInTime,
            ErrorField.punchOutTime,
          });
          allValid = false;
        }
      }

      updatedList[i] = entry.copyWith(
        errorMessage: () => errorMessage,
        errorFields: currentErrors,
      );
    }

    // 3. Check for overlaps between entries
    if (allValid) {
      // Only check for overlaps if individual entries are valid
      for (int i = 0; i < updatedList.length; i++) {
        for (int j = i + 1; j < updatedList.length; j++) {
          final entry1 = updatedList[i];
          final entry2 = updatedList[j];

          final dateFormat = DateFormat('yyyy-MM-dd h:mm a');
          final start1 = dateFormat.parse(
            '${entry1.punchInDate} ${entry1.punchInTime}',
          );
          final end1 = dateFormat.parse(
            '${entry1.punchOutDate} ${entry1.punchOutTime}',
          );
          final start2 = dateFormat.parse(
            '${entry2.punchInDate} ${entry2.punchInTime}',
          );
          final end2 = dateFormat.parse(
            '${entry2.punchOutDate} ${entry2.punchOutTime}',
          );

          if (start1.isBefore(end2) && start2.isBefore(end1)) {
            allValid = false;
            const message = 'Entries have overlapping times.';
            updatedList[i] = updatedList[i].copyWith(
              errorMessage: () => message,
              errorFields: {
                ...updatedList[i].errorFields,
                ErrorField.punchInTime,
                ErrorField.punchOutTime,
              },
            );
            updatedList[j] = updatedList[j].copyWith(
              errorMessage: () => message,
              errorFields: {
                ...updatedList[j].errorFields,
                ErrorField.punchInTime,
                ErrorField.punchOutTime,
              },
            );
          }
        }
      }
    }

    // 4. On final submission, check for the reason
    if (isSubmitting && allValid && _reasonController.text.trim().isEmpty) {
      allValid = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Reason for attendance request is required.'),
        ),
      );
    }

    setState(() {
      _punchList = updatedList;
    });

    return allValid;
  }

  void _validateAndSubmit() {
    if (_validateEntries(isSubmitting: true)) {
      // All data is valid, proceed with submission

      for (final entry in _punchList) {
        debugPrint(
          'Punch: ${entry.punchInDate} ${entry.punchInTime} -> ${entry.punchOutDate} ${entry.punchOutTime}',
        );
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Attendance request submitted successfully!'),
        ),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fix the errors before submitting.'),
        ),
      );
    }
  }

  String getPunchLabel(int index) {
    final keys = [
      'first',
      'second',
      'third',
      'fourth',
      'fifth',
      'sixth',
      'seventh',
      'eighth',
      'ninth',
      'tenth',
    ];
    if (index < keys.length) {
      return '${LanguageManager().get(keys[index])} Punch';
    }
    return 'Punch ${index + 1}';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const CustomAppbar(title: 'Attendance Request', elevation: 1),
    body: GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _unfocusAll, // Use the helper method
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              VariableBag.screenHorizontalPadding *
              Responsive.getResponsive(context),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: .010 * Responsive.getHeight(context)),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _punchList.length,
                separatorBuilder: (_, __) =>
                    SizedBox(height: .016 * Responsive.getHeight(context)),
                itemBuilder: (context, index) =>
                    _punchContainer(context, index, _punchList[index]),
              ),
              SizedBox(height: .010 * Responsive.getHeight(context)),
              MyCoButton(
                onTap: () {
                  _unfocusAll(); // Unfocus before adding
                  _addPunchEntry();
                },
                height: .030 * Responsive.getHeight(context),
                width: .50 * Responsive.getWidth(context),
                borderWidth: 1.5 * Responsive.getResponsive(context),
                backgroundColor: AppColors.transparent,
                title: 'add_another_punch',
                textStyle: TextStyle(
                  color: AppTheme.getColor(context).primary,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Gilroy-Bold',
                ),
              ),
              SizedBox(height: .020 * Responsive.getHeight(context)),
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.getColor(context).surface,
                  borderRadius: BorderRadius.circular(
                    12 * Responsive.getResponsive(context),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.getColor(context).outline,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _reasonController,
                  focusNode: _reasonFocusNode,
                  // Add focus node to TextField
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: LanguageManager().get('reason_of_att_req'),
                    hintStyle: const TextStyle(
                      fontFamily: 'Gilroy-Regular',
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: .030 * Responsive.getWidth(context),
                      vertical: .010 * Responsive.getHeight(context),
                    ),
                  ),
                ),
              ),
              SizedBox(height: .020 * Responsive.getHeight(context)),
              Row(
                children: [
                  Expanded(
                    child: MyCoButton(
                      onTap: () {
                        _unfocusAll(); // Unfocus before closing
                        Navigator.of(context).pop();
                      },
                      backgroundColor: AppColors.transparent,
                      title: 'close',
                      textStyle: TextStyle(
                        color: AppTheme.getColor(context).primary,
                        fontWeight: FontWeight.w600,
                      ),
                      boarderRadius: 50 * Responsive.getResponsive(context),
                      height: .045 * Responsive.getHeight(context),
                    ),
                  ),
                  SizedBox(width: .020 * Responsive.getWidth(context)),
                  Expanded(
                    child: MyCoButton(
                      onTap: () {
                        _unfocusAll(); // Unfocus before submitting
                        _validateAndSubmit();
                      },
                      isShadowBottomLeft: true,
                      title: 'crm_submit',
                      boarderRadius: 50 * Responsive.getResponsive(context),
                      height: .045 * Responsive.getHeight(context),
                    ),
                  ),
                ],
              ),
              SizedBox(height: .020 * Responsive.getHeight(context)),
            ],
          ),
        ),
      ),
    ),
  );

  Widget _punchContainer(
    BuildContext context,
    int index,
    PunchEntryModel entry,
  ) => GestureDetector(
    onTap: _unfocusAll, // Add unfocus to punch container tap
    behavior: HitTestBehavior.translucent,
    child: Container(
      height: .23 * Responsive.getHeight(context),
      // Increased height for error message
      decoration: BoxDecoration(
        color: AppTheme.getColor(context).surface,
        borderRadius: BorderRadius.circular(
          8 * Responsive.getResponsive(context),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.getColor(context).outline,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              .020 * Responsive.getWidth(context),
              .010 * Responsive.getHeight(context),
              .010 * Responsive.getWidth(context),
              0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  getPunchLabel(index),
                  fontWeight: FontWeight.w500,
                  color: AppTheme.getColor(context).primary,
                ),
                if (index != 0)
                  GestureDetector(
                    onTap: () {
                      _unfocusAll(); // Unfocus before removing
                      _removePunchEntry(index);
                    },
                    child: CustomText(
                      'Remove',
                      color: AppTheme.getColor(context).error,
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: .010 * Responsive.getWidth(context),
                    ),
                    child: Row(
                      children: [
                        _punchDateWidget(
                          context,
                          'punch_in_date',
                          entry.punchInDate,
                          (pickedDate) => _updatePunchInDate(index, pickedDate),
                          apiDates,
                          entry.errorFields.contains(ErrorField.punchInDate),
                        ),
                        _punchDateWidget(
                          context,
                          'punch_out_date',
                          entry.punchOutDate,
                          (pickedDate) =>
                              _updatePunchOutDate(index, pickedDate),
                          apiDates,
                          entry.errorFields.contains(ErrorField.punchOutDate),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: .010 * Responsive.getWidth(context),
                    ),
                    child: Row(
                      children: [
                        _punchTimeWidget(
                          context,
                          index,
                          entry.punchInTime,
                          'punch_in_time',
                          AppTheme.getColor(context).secondary,
                          Icons.arrow_downward_outlined,
                          true,
                          entry.errorFields.contains(ErrorField.punchInTime),
                        ),
                        _punchTimeWidget(
                          context,
                          index,
                          entry.punchOutTime,
                          'punch_out_time',
                          AppTheme.getColor(context).onTertiaryContainer,
                          Icons.arrow_upward,
                          false,
                          entry.errorFields.contains(ErrorField.punchOutTime),
                        ),
                      ],
                    ),
                  ),
                ),
                if (entry.errorMessage != null)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: .015 * Responsive.getWidth(context),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning_amber,
                          color: AppTheme.getColor(context).error,
                          size: 20 * Responsive.getResponsive(context),
                        ),
                        SizedBox(width: 0.005 * Responsive.getWidth(context)),
                        Expanded(
                          child: CustomText(
                            entry.errorMessage!,
                            isKey: false,
                            color: AppTheme.getColor(context).error,
                            fontWeight: FontWeight.w600,
                            fontSize:
                                13 * Responsive.getResponsiveText(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: .005 * Responsive.getHeight(context)),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _punchDateWidget(
    BuildContext context,
    String label,
    String selectedDate,
    Function(String) onDateSelected,
    List<String> dateList,
    bool hasError,
  ) {
    final GlobalKey key = GlobalKey();

    return GestureDetector(
      key: key,
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        _unfocusAll(); // Use the helper method instead

        final currentContext = key.currentContext;
        if (currentContext == null) {
          return;
        }

        final renderBox = currentContext.findRenderObject() as RenderBox;
        final size = renderBox.size;
        final offset = renderBox.localToGlobal(Offset.zero);
        final double menuWidth = 88;
        final double menuHeight = 10.0 * dateList.length;
        final double left = offset.dx + (size.width / 2) - (menuWidth / 3);
        final double top = offset.dy + size.height - 35;
        final double screenWidth = MediaQuery.of(context).size.width;
        final double fixedLeft = left.clamp(2, screenWidth - menuWidth - 2);

        final pickedDate = await showMenu<String>(
          context: context,
          position: RelativeRect.fromLTRB(
            fixedLeft,
            top,
            fixedLeft + menuWidth,
            top + menuHeight,
          ),
          items: dateList
              .map(
                (date) => PopupMenuItem<String>(
                  value: date,
                  child: Container(
                    alignment: Alignment.center,
                    width: menuWidth,
                    child: CustomText(
                      date,
                      isKey: false, // Assuming dates are not localization keys
                      fontSize: 15 * Responsive.getResponsiveText(context),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
              .toList(),
          elevation: 4,
        );

        if (pickedDate != null && pickedDate != selectedDate) {
          onDateSelected(pickedDate);
        }
      },
      child: SizedBox(
        height: .10 * Responsive.getHeight(context),
        width: .43 * Responsive.getWidth(context),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: .008 * Responsive.getWidth(context),
            vertical: .004 * Responsive.getHeight(context),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: .010 * Responsive.getWidth(context),
              vertical: .005 * Responsive.getHeight(context),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                12 * Responsive.getResponsive(context),
              ),
              border: Border.all(
                color: hasError
                    ? AppTheme.getColor(context).error
                    : AppTheme.getColor(context).outline,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  label.contains('in')
                      ? Icons.arrow_downward
                      : Icons.arrow_upward,
                  size: 20 * Responsive.getResponsive(context),
                  color: label.contains('in')
                      ? AppTheme.getColor(context).secondary
                      : AppTheme.getColor(context).onTertiaryContainer,
                ),
                const Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          ' $selectedDate',
                          fontSize: 12 * Responsive.getResponsiveText(context),
                          fontWeight: FontWeight.w500,
                          color: AppTheme.getColor(context).primary,
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: AppTheme.getColor(context).primary,
                        ),
                      ],
                    ),
                    CustomText(
                      label,
                      fontSize: 12 * Responsive.getResponsiveText(context),
                      color: AppTheme.getColor(context).onSurfaceVariant,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _punchTimeWidget(
    BuildContext context,
    int index,
    String time,
    String label,
    Color iconColor,
    IconData icon,
    bool isPunchIn,
    bool hasError,
  ) => GestureDetector(
    onTap: () async {
      _unfocusAll(); // Use the helper method instead

      final data = await showPicker(context, pickDay: false, timePicker: true);
      if (data != null) {
        if (isPunchIn) {
          _updatePunchInTime(index, data);
        } else {
          _updatePunchOutTime(index, data);
        }
      }
    },
    child: SizedBox(
      height: .10 * Responsive.getHeight(context),
      width: .43 * Responsive.getWidth(context),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: .008 * Responsive.getWidth(context),
          vertical: .004 * Responsive.getHeight(context),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: .010 * Responsive.getWidth(context),
            vertical: .005 * Responsive.getHeight(context),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              12 * Responsive.getResponsive(context),
            ),
            border: Border.all(
              color: hasError
                  ? AppTheme.getColor(context).error
                  : AppTheme.getColor(context).outline,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20 * Responsive.getResponsive(context),
                color: iconColor,
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CustomText(
                        time,
                        fontSize: 12 * Responsive.getResponsiveText(context),
                        color: AppTheme.getColor(context).primary,
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: AppTheme.getColor(context).primary,
                      ),
                    ],
                  ),
                  CustomText(
                    label,
                    fontSize: 12 * Responsive.getResponsiveText(context),
                    color: AppTheme.getColor(context).onSurfaceVariant,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
