import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';

class MonthYearPickerBottomSheet extends StatefulWidget {
  final int initialMonth;
  final int initialYear;
  final int startYear;
  final int endYear;
  final List<String>? customMonths;
  final double pickerHeight;
  final Function(int month, int year) onSubmit;

  final bool showMonth;
  final bool showYear;
  final bool allowAll;

  const MonthYearPickerBottomSheet({
    required this.initialMonth,
    required this.initialYear,
    required this.onSubmit,
    required this.startYear,
    required this.endYear,
    this.customMonths,
    this.pickerHeight = 180,
    this.showMonth = true,
    this.showYear = true,
    this.allowAll = true,
    super.key,
  });

  @override
  State<MonthYearPickerBottomSheet> createState() =>
      _MonthYearPickerBottomSheetState();
}

class _MonthYearPickerBottomSheetState
    extends State<MonthYearPickerBottomSheet> {
  late int selectedMonth;
  late int selectedYear;

  late List<String> months;
  late List<int> years;

  @override
  void initState() {
    super.initState();

    selectedYear = widget.initialYear;

    // Correct selectedMonth for 0-based indexing if allowAll is false
    if (widget.allowAll) {
      selectedMonth = widget.initialMonth;
    } else {
      selectedMonth = widget.initialMonth - 1;
    }

    final defaultMonths = const [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];

    // Trim "All" from list if allowAll is false
    months =
        widget.customMonths ??
        (widget.allowAll ? defaultMonths : defaultMonths.sublist(0));

    years = List.generate(
      widget.endYear - widget.startYear + 1,
      (index) => widget.startYear + index,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.showMonth && !widget.showYear) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.showMonth)
                  Expanded(
                    child: SizedBox(
                      height: widget.pickerHeight,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ListWheelScrollView.useDelegate(
                            itemExtent: 40,
                            perspective: 0.003,
                            diameterRatio: 1.2,
                            onSelectedItemChanged: (index) {
                              HapticFeedback.lightImpact();
                              setState(() {
                                selectedMonth = index;
                              });
                            },
                            physics: const FixedExtentScrollPhysics(),
                            controller: FixedExtentScrollController(
                              initialItem: selectedMonth,
                            ),
                            childDelegate: ListWheelChildBuilderDelegate(
                              childCount: months.length,
                              builder: (context, index) {
                                final isSelected = selectedMonth == index;
                                return Center(
                                  child: Text(
                                    months[index],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: isSelected
                                          ? AppTheme.getColor(context).primary
                                          : Colors.grey,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          _buildDivider(context),
                        ],
                      ),
                    ),
                  ),
                if (widget.showMonth && widget.showYear)
                  const SizedBox(width: 24),
                if (widget.showYear)
                  Expanded(
                    child: SizedBox(
                      height: widget.pickerHeight,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ListWheelScrollView.useDelegate(
                            itemExtent: 40,
                            perspective: 0.003,
                            diameterRatio: 1.2,
                            onSelectedItemChanged: (index) {
                              HapticFeedback.lightImpact();
                              setState(() {
                                selectedYear = years[index];
                              });
                            },
                            physics: const FixedExtentScrollPhysics(),
                            controller: FixedExtentScrollController(
                              initialItem: years.indexOf(selectedYear),
                            ),
                            childDelegate: ListWheelChildBuilderDelegate(
                              childCount: years.length,
                              builder: (context, index) {
                                final isSelected = selectedYear == years[index];
                                return Center(
                                  child: Text(
                                    years[index].toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: isSelected
                                          ? AppTheme.getColor(context).primary
                                          : Colors.grey,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          _buildDivider(context),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          MyCoButton(
            width: 0.5 * Responsive.getWidth(context),
            boarderRadius: 50,
            isShadowBottomLeft: true,
            textStyle: TextStyle(
              letterSpacing: 1.2,
              color: AppColors.white,
              fontSize: 14 * Responsive.getResponsiveText(context),
              fontWeight: FontWeight.bold,
            ),
            onTap: () {
              final int submittedMonth = widget.allowAll
                  ? (selectedMonth == 0 ? 0 : selectedMonth)
                  : selectedMonth + 1;

              widget.onSubmit(submittedMonth, selectedYear);
              Navigator.pop(context);
            },
            title: 'SUBMIT',
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    final double lineTop = (widget.pickerHeight - 40) / 2;
    return Stack(
      children: [
        Positioned(
          top: lineTop,
          left: 0,
          right: 0,
          child: Container(
            height: 1.5,
            color: AppTheme.getColor(context).primary,
          ),
        ),
        Positioned(
          bottom: lineTop,
          left: 0,
          right: 0,
          child: Container(
            height: 1.5,
            color: AppTheme.getColor(context).primary,
          ),
        ),
      ],
    );
  }
}
