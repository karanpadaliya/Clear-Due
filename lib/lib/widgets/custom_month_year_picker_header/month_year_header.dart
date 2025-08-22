import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_month_year_picker_header/month_year_picker_bottom_sheet.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class MonthYearHeader extends StatefulWidget {
  final int startYear;
  final int endYear;
  final Function(int month, int year) onChanged;

  final Color? arrowColor;
  final Color? arrowIconColor;
  final Color? disableColor;
  final Color? disableIconColor;
  final Color? headerTextColor;
  final double? headerFontSize;
  final FontWeight? headerFontWeight;
  final double? iconSize;
  final double? arrowCornerRadius;
  final double? horizontalSpacing;

  final bool showMonth;
  final bool showYear;
  final bool allowAll;

  const MonthYearHeader({
    required this.onChanged,
    super.key,
    this.startYear = 2000,
    this.endYear = 2030,
    this.arrowColor = AppColors.lightBlue,
    this.arrowIconColor = Colors.black,
    this.headerTextColor,
    this.headerFontSize = 16,
    this.headerFontWeight = FontWeight.bold,
    this.iconSize = 24,
    this.arrowCornerRadius = 8,
    this.horizontalSpacing = 8,
    this.disableColor = const Color(0xFFE0E0E0),
    this.disableIconColor = Colors.grey,
    this.showMonth = true,
    this.showYear = true,
    this.allowAll = true,
  });

  @override
  State<MonthYearHeader> createState() => _MonthYearHeaderState();
}

class _MonthYearHeaderState extends State<MonthYearHeader> {
  late int selectedMonth;
  late int selectedYear;
  bool manuallyChanged = false;

  @override
  void initState() {
    super.initState();
    selectedMonth = widget.allowAll ? 0 : DateTime.now().month;
    selectedYear = DateTime.now().year;
    manuallyChanged = false;

    // Initial trigger
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   widget.onChanged(selectedMonth, selectedYear);
    // });
  }

  void _changeMonth(int direction) {
    setState(() {
      manuallyChanged = true;

      if (!widget.showMonth && widget.showYear) {
        final newYear = selectedYear + direction;

        if (newYear >= widget.startYear && newYear <= widget.endYear) {
          widget.onChanged(selectedMonth, newYear);
          selectedYear = newYear;
        }
        return;
      }

      if (!widget.showYear && widget.showMonth) {
        int newMonth = selectedMonth + direction;
        if (newMonth < (widget.allowAll ? 0 : 1)) {
          // Adjust for allowAll when month is 0
          newMonth = 12;
        }
        if (newMonth > 12) {
          newMonth = widget.allowAll
              ? 0
              : 1; // Adjust for allowAll when month is 0
        }
        widget.onChanged(newMonth, selectedYear);
        selectedMonth = newMonth;
        return;
      }

      // Condition to directly jump to the next/previous year if selectedMonth is 0 (All)
      if (widget.allowAll && selectedMonth == 0) {
        final newYear = selectedYear + direction;
        if (newYear >= widget.startYear && newYear <= widget.endYear) {
          selectedYear = newYear;
          // Keep selectedMonth as 0 (All)
          widget.onChanged(selectedMonth, selectedYear);
        }
        return; // Return here to prevent further month logic when "All" is selected
      } else {
        int newMonth = selectedMonth + direction;
        int newYear = selectedYear;
        // If allowAll is true, the smallest month is 0, otherwise it's 1.
        final int minMonth = widget.allowAll ? 0 : 1;
        if (newMonth < minMonth) {
          newMonth = 12;
          newYear--;
        } else {
          if (newMonth > 12) {
            newMonth = minMonth; // Reset to the smallest possible month
            newYear++;
          }
        }
        if (newYear >= widget.startYear && newYear <= widget.endYear) {
          widget.onChanged(newMonth, newYear);
          selectedMonth = newMonth;
          selectedYear = newYear;
        }
      }
    });
  }

  void _clearMonthSelection() {
    if (!widget.allowAll) return;
    setState(() {
      selectedMonth = 0;
      selectedYear = DateTime.now().year;
      manuallyChanged = false;
      widget.onChanged(selectedMonth, selectedYear);
    });
  }

  void _openMonthYearPicker() {
    final allMonths = LanguageManager().getList('month_arry');
    final monthsToUse = widget.allowAll ? allMonths : allMonths.sublist(1);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => MonthYearPickerBottomSheet(
        initialMonth: selectedMonth,
        initialYear: selectedYear,
        endYear: widget.endYear,
        showMonth: widget.showMonth,
        showYear: widget.showYear,
        startYear: widget.startYear,
        customMonths: monthsToUse,
        allowAll: widget.allowAll,
        // ignore: avoid_types_on_closure_parameters
        onSubmit: (month, year) {
          if (!widget.allowAll && month == 0) return;
          setState(() {
            selectedMonth = month;
            selectedYear = year;
            manuallyChanged = true;
            widget.onChanged(month, year);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.showMonth && !widget.showYear) return const SizedBox.shrink();

    final allMonths = LanguageManager().getList('month_arry');
    final double spacing =
        widget.horizontalSpacing ?? 0.1 * Responsive.getWidth(context);

    if (allMonths.isEmpty) {
      // Return a placeholder while the language list is loading.
      // This prevents the crash.
      return const SizedBox(
        height: 40, // Give it a consistent height to prevent UI jumps
        child: Center(child: CircularProgressIndicator(strokeWidth: 2.0)),
      );
    }
    String labelText = '';

    if (widget.showMonth && widget.showYear) {
      labelText = widget.allowAll && selectedMonth == 0
          ? '${allMonths[0]}, $selectedYear'
          : '${allMonths[widget.allowAll ? selectedMonth : selectedMonth].substring(0, 3)}, $selectedYear';
    } else if (widget.showMonth) {
      labelText = widget.allowAll && selectedMonth == 0
          ? allMonths[0]
          : allMonths[widget.allowAll ? selectedMonth : selectedMonth]
                .substring(0, 3);
    } else if (widget.showYear) {
      labelText = '$selectedYear';
    }

    bool isLeftDisabled = false;
    bool isRightDisabled = false;

    if (!widget.showMonth && widget.showYear) {
      isLeftDisabled = selectedYear <= widget.startYear;
      isRightDisabled = selectedYear >= widget.endYear;
    } else if (!widget.showYear && widget.showMonth) {
      isLeftDisabled = false;
      isRightDisabled = false;
    } else {
      if (widget.allowAll && selectedMonth == 0) {
        isLeftDisabled = selectedYear <= widget.startYear;
        isRightDisabled = selectedYear >= widget.endYear;
      } else {
        isLeftDisabled = selectedYear <= widget.startYear && selectedMonth == 1;
        isRightDisabled = selectedYear >= widget.endYear && selectedMonth == 12;
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ArrowButton(
          icon: Icons.chevron_left,
          onTap: () => _changeMonth(-1),
          isDisabled: isLeftDisabled,
          backgroundColor: widget.arrowColor,
          iconColor: widget.arrowIconColor,
          disableColor: widget.disableColor,
          disableIconColor: widget.disableIconColor,
          cornerRadius: widget.arrowCornerRadius,
        ),
        InkWell(
          onTap: _openMonthYearPicker,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                labelText,
                fontSize:
                    widget.headerFontSize ??
                    16 * Responsive.getResponsiveText(context),
                fontWeight: widget.headerFontWeight ?? FontWeight.w600,
                color:
                    widget.headerTextColor ??
                    AppTheme.getColor(context).onSurface,
              ),
              SizedBox(width: 5 * Responsive.getResponsive(context)),
              if (widget.allowAll && selectedMonth != 0 && manuallyChanged)
                InkWell(
                  onTap: _clearMonthSelection,
                  child: const Icon(CupertinoIcons.clear_thick, size: 15),
                )
              else
                InkWell(
                  onTap: _openMonthYearPicker,
                  child: const Icon(Icons.keyboard_arrow_down),
                ),
            ],
          ),
        ),
        ArrowButton(
          icon: Icons.chevron_right,
          onTap: () => _changeMonth(1),
          isDisabled: isRightDisabled,
          backgroundColor: widget.arrowColor,
          iconColor: widget.arrowIconColor,
          disableColor: widget.disableColor,
          disableIconColor: widget.disableIconColor,
          cornerRadius: widget.arrowCornerRadius,
        ),
      ],
    );
  }
}

class ArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isDisabled;
  final Color? backgroundColor;
  final Color? disableColor;
  final Color? disableIconColor;
  final Color? iconColor;
  final double? cornerRadius;

  const ArrowButton({
    required this.icon,
    required this.onTap,
    this.isDisabled = false,
    this.backgroundColor,
    this.iconColor,
    this.cornerRadius,
    super.key,
    this.disableColor,
    this.disableIconColor,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = Responsive.getWidth(context);
    final screenHeight = Responsive.getHeight(context);

    return Container(
      height: 0.03 * screenHeight,
      width: 0.07 * screenWidth,
      margin: EdgeInsets.all(4.0 * Responsive.getResponsive(context)),
      decoration: BoxDecoration(
        color: isDisabled
            ? disableColor
            : backgroundColor ?? AppColors.lightBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: isDisabled ? null : onTap,
        borderRadius: BorderRadius.circular(10),
        child: Icon(
          icon,
          size: screenWidth * 0.05,
          color: isDisabled ? disableIconColor : iconColor ?? Colors.black,
        ),
      ),
    );
  }
}
