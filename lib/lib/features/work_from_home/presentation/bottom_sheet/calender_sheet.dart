import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/work_from_home/presentation/widgets/selected_date_row.dart';
import 'package:myco_flutter/widgets/custom_calender.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarSheet extends StatefulWidget {
  final Map<DateTime, String> initialDates;
  final DateTime focusedDay;
  const CalendarSheet({
    required this.initialDates,
    required this.focusedDay,
    super.key,
  });

  @override
  State<CalendarSheet> createState() => _CalendarSheetState();
}

class _CalendarSheetState extends State<CalendarSheet> {
  late Map<DateTime, String> _tempPickedDates;
  late DateTime _tempFocusedDay;

  @override
  void initState() {
    super.initState();
    _tempPickedDates = Map.from(widget.initialDates);
    _tempFocusedDay = widget.focusedDay;
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Padding(
      padding: EdgeInsets.only(
        right:
            VariableBag.bottomSheetRightPadding *
            Responsive.getResponsive(context),
        left:
            VariableBag.bottomSheetLeftPadding *
            Responsive.getResponsive(context),
        top:
            VariableBag.bottomSheetTopPadding *
            Responsive.getResponsive(context),
        bottom:
            VariableBag.bottomSheetBottomPadding *
            Responsive.getResponsive(context),
      ),
      child: Column(
        children: [
          CustomCalendar(
            calendarFormat: CalendarFormat.month,
            focusedDay: _tempFocusedDay,
            selectedDays: _tempPickedDates.keys.toList(),
            onPageChanged: (focusedDay) {
              setState(() {
                _tempFocusedDay = focusedDay;
              });
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _tempFocusedDay = focusedDay;
                final isSelected = _tempPickedDates.containsKey(selectedDay);
                if (isSelected) {
                  _tempPickedDates.remove(selectedDay);
                } else {
                  _tempPickedDates[selectedDay] = 'fullDay';
                }
              });
            },
          ),
          if (_tempPickedDates.isNotEmpty)
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(
                  top: 16 * Responsive.getResponsive(context),
                ),
                children: [
                  const Divider(),
                  const SelectedDateRowHeader(),
                  ..._buildSelectedDateRows(),
                ],
              ),
            ),
          SizedBox(height: 0.023 * Responsive.getHeight(context)),
          MyCoButton(
            title: 'Submit',
            boarderRadius:
                VariableBag.buttonBorderRadius *
                Responsive.getResponsive(context),
            onTap: () {
              Navigator.pop(context, _tempPickedDates);
            },
          ),
        ],
      ),
    ),
  );

  List<Widget> _buildSelectedDateRows() {
    final sortedDates = _tempPickedDates.keys.toList()..sort();
    return sortedDates
        .map(
          (date) => SelectedDateRow(
            date: date,
            dayPart: _tempPickedDates[date]!,
            onDayPartChanged: (newPart) {
              setState(() {
                _tempPickedDates[date] = newPart;
              });
            },
            onDelete: () {
              setState(() {
                _tempPickedDates.remove(date);
              });
            },
          ),
        )
        .toList();
  }
}

class SelectedDateRowHeader extends StatelessWidget {
  const SelectedDateRowHeader({super.key});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      SizedBox(
        width: 117 * Responsive.getResponsive(context),
        child: Center(
          child: SvgPicture.asset(
            AppAssets.calendar,
            colorFilter: ColorFilter.mode(
              AppTheme.getColor(context).primary,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),

      Expanded(
        child: Center(
          child: CustomText(
            'Full Day',
            fontWeight: FontWeight.bold,
            fontSize: 11 * Responsive.getResponsiveText(context),
          ),
        ),
      ),

      Expanded(
        child: Center(
          child: CustomText(
            '1st Half',
            fontWeight: FontWeight.bold,
            fontSize: 11 * Responsive.getResponsiveText(context),
          ),
        ),
      ),

      Expanded(
        child: Center(
          child: CustomText(
            '2nd Half',
            fontWeight: FontWeight.bold,
            fontSize: 11 * Responsive.getResponsiveText(context),
          ),
        ),
      ),

      SizedBox(width: 48 * Responsive.getResponsive(context)),
    ],
  );
}
