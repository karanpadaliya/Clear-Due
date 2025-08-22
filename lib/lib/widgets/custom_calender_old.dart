import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
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
  });

  @override
  State<CustomCalendar> createState() => _CustomCalendar();
}

class _CustomCalendar extends State<CustomCalendar> {
  // Internal state for _focusedDay and _selectedDay is removed
  // The widget now relies on properties passed from the parent

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
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              todayDecoration: BoxDecoration(
                color: AppTheme.getColor(context).secondary,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: AppTheme.getColor(context).primary,
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
                            // ADDED LOG
                            print(
                                '🚀🚀🚀: API call triggered by changing month/year from picker in weekly view.');
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
                    SizedBox(height: 14 * r),
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
                              // ADDED LOG
                              print(
                                '🚀🚀🚀: API call triggered by changing week/month with Left Arrow.',
                              );
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
                                // ADDED LOG
                                print(
                                    '🚀🚀🚀: API call triggered by changing month/year from picker in monthly view.');
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
                              // ADDED LOG
                              print(
                                '🚀🚀🚀: API call triggered by changing week/month with Right Arrow.',
                              );
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
              defaultBuilder: (context, day, focusedDay) {
                final now = DateTime.now();
                final isPast = day.isBefore(
                  DateTime(now.year, now.month, now.day),
                );
                final isSelected = widget.selectedDays.any(
                      (d) => isSameDay(d, day),
                );

                if (isSelected) {
                  return Container(
                    margin: EdgeInsets.all(
                      7 * Responsive.getResponsive(context),
                    ),
                    decoration: BoxDecoration(
                      color: widget.rangeSelectedDayColor ?? AppColors.primary,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black45,
                          offset: Offset(3, 3),
                          blurRadius: 2,
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

                if (day.weekday == DateTime.saturday ||
                    day.weekday == DateTime.sunday) {
                  return Container(
                    margin: EdgeInsets.all(
                      7 * Responsive.getResponsive(context),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        const BoxShadow(color: Colors.black26),
                        BoxShadow(
                          color: AppTheme.getColor(
                            context,
                          ).onPrimary.withAlpha(210),
                          blurRadius: 3,
                          offset: const Offset(1, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: CustomText(
                      '${day.day}',
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }

                if (isPast) {
                  return Container(
                    margin: EdgeInsets.all(
                      7 * Responsive.getResponsive(context),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.isAppThemeDarkMode(context)
                              ? AppColors.gray
                              : Colors.black26,
                        ),
                        const BoxShadow(
                          color: Color(0xFFCECECE),
                          blurRadius: 2,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: CustomText(
                      '${day.day}',
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }
                return Container(
                  margin: EdgeInsets.all(7 * Responsive.getResponsive(context)),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.isAppThemeDarkMode(context)
                            ? AppColors.gray
                            : Colors.black26,
                      ),
                      BoxShadow(
                        color: AppTheme.getColor(context).onPrimary,
                        blurRadius: 3,
                        offset: const Offset(1.5, 2),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: CustomText(
                    '${day.day}',
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
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
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}
