import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/payslip/presentation/widgets/ios_calendar_time_picker.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  final Function(DateTime, String)? onLeaveTypeChanged;
  final Function(DateTime)? onPageChanged;
  final Function(DateTime, DateTime)? onDaySelected;
  final Color? rangeSelectedDayColor;
  final DateTime? totalPreviousYear;
  final DateTime? totalNextYear;
  final bool allowSaturdaySelection;
  final bool allowSundaySelection;
  final CalendarFormat calendarFormat;
  final DateTime focusedDay;
  final List<DateTime> selectedDays;
  final bool allowMultipleSelection;
  final bool applyDecoratorOnTap;
  // Decoration properties for TimeSheet Module
  final List<DateTime>? presentDays;
  final List<DateTime>? pendingDays;
  final List<DateTime>? punchMissingDays;
  final List<DateTime>? halfDays;
  final List<DateTime>? leaveDays;
  final List<DateTime>? holidayDays;
  final List<DateTime>? weekOffDays;
  final List<DateTime>? absentDays;
  final List<DateTime>? rejectedDays;
  final List<DateTime>? extraDays;

  const CustomCalendar({
    required this.calendarFormat,
    required this.focusedDay,
    required this.selectedDays,
    super.key,
    this.onLeaveTypeChanged,
    this.onPageChanged,
    this.onDaySelected,
    this.rangeSelectedDayColor,
    this.totalPreviousYear,
    this.totalNextYear,
    this.allowSaturdaySelection = false,
    this.allowSundaySelection = false,
    this.allowMultipleSelection = true,
    this.applyDecoratorOnTap = true,
    this.presentDays,
    this.pendingDays,
    this.punchMissingDays,
    this.halfDays,
    this.leaveDays,
    this.holidayDays,
    this.weekOffDays,
    this.absentDays,
    this.rejectedDays,
    this.extraDays,
  });

  @override
  State<CustomCalendar> createState() => _CustomCalendar();
}

class _CustomCalendar extends State<CustomCalendar> {
  void _onDaySelectedInternal(DateTime selectedDay, DateTime focusedDay) {
    if (!widget.allowSaturdaySelection &&
        selectedDay.weekday == DateTime.saturday) {
      return;
    }

    if (!widget.allowSundaySelection &&
        selectedDay.weekday == DateTime.sunday) {
      return;
    }
    widget.onDaySelected?.call(selectedDay, focusedDay);
  }

  DateTime _getStartOfWeek(DateTime date) =>
      date.subtract(Duration(days: date.weekday - 1));

  DateTime _getEndOfWeek(DateTime date) {
    final startOfWeek = _getStartOfWeek(date);
    return startOfWeek.add(const Duration(days: 6));
  }

  // Helper to check if a day is in a list of dates, ignoring time
  bool _isDayInList(DateTime day, List<DateTime>? dayList) {
    if (dayList == null) return false;
    return dayList.any((d) => isSameDay(d, day));
  }

  // Returns a styled container for a calendar day, now with shadows.
  /// Builds a calendar day cell by determining its style based on its status.
  Widget _buildDayCell(BuildContext context, DateTime day) {
    final isDarkMode = AppTheme.isAppThemeDarkMode(context);
    final now = DateTime.now();
    final isPast = day.isBefore(DateTime(now.year, now.month, now.day));

    /// A helper to generate the standard shadow effect for most cell types.
    List<BoxShadow> getStandardShadow() => [
      BoxShadow(color: isDarkMode ? AppColors.gray : Colors.black26),
      BoxShadow(
        color: isDarkMode ? AppColors.textGray : Colors.black54,
        blurRadius: 2,
        offset: const Offset(2, 2),
      ),
    ];

    /// A reusable helper to create the final styled container for the cell.
    Widget buildCell({
      required Color color,
      List<BoxShadow>? boxShadow,
      Color textColor = Colors.white,
    }) => Container(
        margin: EdgeInsets.all(7 * Responsive.getResponsive(context)),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: boxShadow ?? getStandardShadow(),
        ),
        alignment: Alignment.center,
        child: CustomText(
          '${day.day}',
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      );

    /// ---- LOGIC FOR CELL STYLING ---- ///

    // Highest priority: Attendance status
    if (_isDayInList(day, widget.absentDays) ||
        _isDayInList(day, widget.rejectedDays)) {
      return buildCell(color: AppColors.absentDays); // Red
    }
    if (_isDayInList(day, widget.punchMissingDays)) {
      return buildCell(color: AppColors.punchMissingDays); // Orange
    }
    if (_isDayInList(day, widget.pendingDays)) {
      return buildCell(color: AppColors.pendingDays); // Yellow
    }
    if (_isDayInList(day, widget.leaveDays) ||
        _isDayInList(day, widget.halfDays)) {
      return buildCell(color: AppColors.leaveDays); // Purple
    }
    if (_isDayInList(day, widget.holidayDays)) {
      return buildCell(color: AppColors.holidayDays); // Cyan
    }
    if (_isDayInList(day, widget.presentDays) ||
        _isDayInList(day, widget.extraDays)) {
      return buildCell(color: AppColors.presentDays); // Green
    }
    if (_isDayInList(day, widget.weekOffDays)) {
      return buildCell(color: AppColors.weekOffDays); // Grey
    }

    // Fallback: Weekends
    if (day.weekday == DateTime.saturday || day.weekday == DateTime.sunday) {
      return buildCell(
        color: AppTheme.getColor(context).onPrimary.withAlpha(210),
        textColor: AppColors.black,
        boxShadow: [
          const BoxShadow(color: Colors.black26),
          BoxShadow(
            color: AppTheme.getColor(context).onPrimary.withAlpha(210),
            blurRadius: 3,
            offset: const Offset(1, 2),
          ),
        ],
      );
    }

    // Fallback: Past days with no other status
    if (isPast) {
      return buildCell(
        color: const Color(0xFFCECECE),
        textColor: AppColors.black,
        boxShadow: [
          BoxShadow(color: isDarkMode ? AppColors.gray : Colors.black26),
          const BoxShadow(
            color: Color(0xFFCECECE),
            blurRadius: 2,
            offset: Offset(1, 2),
          ),
        ],
      );
    }

    // Default: Future days
    return Container(
      margin: EdgeInsets.all(7 * Responsive.getResponsive(context)),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: isDarkMode ? Colors.white54 : Colors.black26),
          BoxShadow(
            color: isDarkMode ? Colors.black : AppColors.white,
            blurRadius: 3,
            offset: const Offset(1.5, 2),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: CustomText(
        '${day.day}',
        color: AppTheme.getColor(context).onSurface,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double r = Responsive.getResponsive(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: VariableBag.screenHorizontalPadding * r,
      ),
      child: Column(
        children: [
          TableCalendar(
            availableGestures: AvailableGestures.none,
            firstDay: widget.totalPreviousYear ?? DateTime.utc(2020),
            lastDay: widget.totalNextYear ?? DateTime.utc(2035, 12, 31),
            focusedDay: widget.focusedDay,
            onPageChanged: (focusedDay) {
              widget.onPageChanged?.call(focusedDay);
            },
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
              CalendarFormat.week: 'Week',
            },
            startingDayOfWeek: StartingDayOfWeek.monday,
            selectedDayPredicate: (day) =>
                widget.selectedDays.any((d) => isSameDay(d, day)),
            onDaySelected: _onDaySelectedInternal,
            calendarFormat: widget.calendarFormat,
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                color: AppTheme.getColor(context).onSurface,
                fontWeight: FontWeight.w400,
                fontSize: 14 * Responsive.getResponsiveText(context),
              ),
              weekendStyle: TextStyle(
                color: AppTheme.getColor(context).onSurfaceVariant,
                fontWeight: FontWeight.w400,
                fontSize: 14 * Responsive.getResponsiveText(context),
              ),
            ),
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              // todayDecoration: BoxDecoration(
              //   color: AppTheme.getColor(
              //     context,
              //   ).secondary.withValues(alpha: 0.5),
              //   shape: BoxShape.circle,
              // ),
              selectedDecoration: BoxDecoration(
                color:
                    widget.rangeSelectedDayColor ??
                    AppTheme.getColor(context).primary,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black45,
                    offset: Offset(3, 3),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              leftChevronVisible: false,
              rightChevronVisible: false,
              titleTextFormatter: (date, _) => _formattedHeaderTitleDate(date),
              titleTextStyle: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w700,
                fontSize: 16 * Responsive.getResponsiveText(context),
              ),
              leftChevronMargin: EdgeInsets.zero,
              rightChevronMargin: EdgeInsets.zero,
            ),
            calendarBuilders: CalendarBuilders(
              headerTitleBuilder: (context, day) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10 * r),
                child: Column(
                  children: [
                    if (widget.calendarFormat == CalendarFormat.week)
                      GestureDetector(
                        onTap: () async {
                          final selectedDate = await showPicker(
                            context,
                            minDate: DateTime(2020),
                            maxDate: DateTime(2030),
                            pickDay: false,
                            timePicker: false,
                          );
                          if (selectedDate != null) {
                            final parts = selectedDate.split(' ');
                            final monthNames = {
                              'Jan': 1,
                              'Feb': 2,
                              'Mar': 3,
                              'Apr': 4,
                              'May': 5,
                              'Jun': 6,
                              'Jul': 7,
                              'Aug': 8,
                              'Sep': 9,
                              'Oct': 10,
                              'Nov': 11,
                              'Dec': 12,
                            };
                            final selectedMonth = monthNames[parts[0]];
                            final selectedYear = int.tryParse(parts[1]);
                            if (selectedMonth != null && selectedYear != null) {
                              widget.onPageChanged?.call(
                                DateTime(selectedYear, selectedMonth),
                              );
                            }
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              _formattedHeaderTitleDate(day),
                              fontSize:
                                  16 * Responsive.getResponsiveText(context),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.getColor(context).onSurface,
                            ),
                            SizedBox(
                              width: 0.005 * Responsive.getWidth(context),
                            ),
                            SvgPicture.asset(
                              AppAssets.calendarDownArrow,
                              fit: BoxFit.scaleDown,
                              colorFilter: ColorFilter.mode(
                                AppTheme.getColor(context).onSurface,
                                BlendMode.srcIn,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Left Arrow
                        Container(
                          height: 0.03 * Responsive.getHeight(context),
                          width: 0.07 * Responsive.getWidth(context),
                          margin: EdgeInsets.all(
                            4.0 * Responsive.getResponsive(context),
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.getColor(
                              context,
                            ).surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: GestureDetector(
                            child: Image.asset(
                              AppAssets.caretLeft,
                              color: AppTheme.getColor(context).onSurface,
                              scale: 2,
                            ),
                            onTap: () {
                              DateTime newFocusedDay;
                              if (widget.calendarFormat ==
                                  CalendarFormat.week) {
                                newFocusedDay = widget.focusedDay.subtract(
                                  const Duration(days: 7),
                                );
                              } else {
                                newFocusedDay = DateTime(
                                  widget.focusedDay.year,
                                  widget.focusedDay.month - 1,
                                );
                              }
                              final firstDay =
                                  widget.totalPreviousYear ??
                                  DateTime.utc(2020);
                              if (!newFocusedDay.isBefore(firstDay)) {
                                widget.onPageChanged?.call(newFocusedDay);
                              }
                            },
                          ),
                        ),

                        /// Center Content (Month or Week Range)
                        const Spacer(),
                        if (widget.calendarFormat == CalendarFormat.month)
                          GestureDetector(
                            onTap: () async {
                              final selectedDate = await showPicker(
                                context,
                                minDate: DateTime(2020),
                                maxDate: DateTime(2030),
                                pickDay: false,
                                timePicker: false,
                              );
                              if (selectedDate != null) {
                                final parts = selectedDate.split(' ');
                                final monthNames = {
                                  'Jan': 1,
                                  'Feb': 2,
                                  'Mar': 3,
                                  'Apr': 4,
                                  'May': 5,
                                  'Jun': 6,
                                  'Jul': 7,
                                  'Aug': 8,
                                  'Sep': 9,
                                  'Oct': 10,
                                  'Nov': 11,
                                  'Dec': 12,
                                };
                                final selectedMonth = monthNames[parts[0]];
                                final selectedYear = int.tryParse(parts[1]);
                                if (selectedMonth != null &&
                                    selectedYear != null) {
                                  widget.onPageChanged?.call(
                                    DateTime(selectedYear, selectedMonth),
                                  );
                                }
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                  _formattedHeaderTitleDate(day),
                                  fontSize:
                                      16 *
                                      Responsive.getResponsiveText(context),
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.getColor(context).onSurface,
                                ),
                                const SizedBox(width: 8),
                                SvgPicture.asset(
                                  AppAssets.calendarDownArrow,
                                  fit: BoxFit.scaleDown,
                                  colorFilter: ColorFilter.mode(
                                    AppTheme.getColor(context).onSurface,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(
                                '${_formattedHeaderSubTitleDate(_getStartOfWeek(widget.focusedDay))} - ${_formattedHeaderSubTitleDate(_getEndOfWeek(widget.focusedDay))}',
                                fontSize:
                                    14 * Responsive.getResponsiveText(context),
                                color: AppTheme.getColor(context).onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(
                                width:
                                    0.008 * Responsive.getResponsive(context),
                              ),
                            ],
                          ),
                        const Spacer(),

                        /// Right Arrow
                        Container(
                          height: 0.03 * Responsive.getHeight(context),
                          width: 0.07 * Responsive.getWidth(context),
                          margin: EdgeInsets.all(
                            4.0 * Responsive.getResponsive(context),
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.getColor(
                              context,
                            ).surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: GestureDetector(
                            child: Image.asset(
                              AppAssets.caretRight,
                              color: AppTheme.getColor(context).onSurface,
                              scale: 2,
                            ),
                            onTap: () {
                              DateTime newFocusedDay;
                              if (widget.calendarFormat ==
                                  CalendarFormat.week) {
                                newFocusedDay = widget.focusedDay.add(
                                  const Duration(days: 7),
                                );
                              } else {
                                newFocusedDay = DateTime(
                                  widget.focusedDay.year,
                                  widget.focusedDay.month + 1,
                                );
                              }
                              final lastDay =
                                  widget.totalNextYear ??
                                  DateTime.utc(2035, 12, 31);
                              if (!newFocusedDay.isAfter(lastDay)) {
                                widget.onPageChanged?.call(newFocusedDay);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              selectedBuilder: (context, day, focusedDay) {
                // If the flag is false, we want to show the day's status color
                // instead of the default blue selection circle.
                if (!widget.applyDecoratorOnTap) {
                  return _buildDayCell(context, day);
                }
                // Otherwise (if flag is true), return null to let the calendar
                // use the default `selectedDecoration` from `CalendarStyle`.
                return null;
              },
              todayBuilder: (context, day, focusedDay) {
                // If today is also selected, let the selected day style take precedence.
                // Returning null falls back to the default or your `selectedBuilder`.
                if (widget.selectedDays.any((d) => isSameDay(d, day))) {
                  return null;
                }

                // For a non-selected 'today', use your centralized styling logic.
                // This will correctly show its status (Present, Absent, Holiday, etc.).
                return _buildDayCell(context, day);
              },
              defaultBuilder: (context, day, focusedDay) => _buildDayCell(context, day),
            ),
          ),
          SizedBox(height: 0.015 * Responsive.getHeight(context)),
        ],
      ),
    );
  }

  String _formattedHeaderTitleDate(DateTime date) =>
      '${_monthName(date.month)}, ${date.year}';

  String _formattedHeaderSubTitleDate(DateTime date) =>
      '${_monthName(date.month)} ${date.day}, ${date.year}';

  String _monthName(int month) {
    final List<String> monthArray = LanguageManager().getList('month_arry');

    monthArray.removeAt(0);

    return monthArray[month - 1];
  }
}
