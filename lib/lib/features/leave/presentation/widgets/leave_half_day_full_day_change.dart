import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/leave/presentation/widgets/leave_date_model.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class LeaveDatesHalfDayChangeWidget extends StatefulWidget {
  final List<LeaveDateModel> leaveDateModelList;
  final int leaveApplyType;
  final bool isUnpaidRestrictionON;
  final int isQuarterTriggersFullDay;
  final Function(int, LeaveDateModel) onAppliedLeaveClick;
  final Function() onDayTypeChangeClick;

  const LeaveDatesHalfDayChangeWidget({
    super.key,
    required this.leaveDateModelList,
    required this.leaveApplyType,
    required this.isUnpaidRestrictionON,
    required this.isQuarterTriggersFullDay,
    required this.onAppliedLeaveClick,
    required this.onDayTypeChangeClick,
  });

  @override
  _LeaveDatesHalfDayChangeWidgetState createState() =>
      _LeaveDatesHalfDayChangeWidgetState();
}

class _LeaveDatesHalfDayChangeWidgetState
    extends State<LeaveDatesHalfDayChangeWidget> {
  @override
  Widget build(BuildContext context) => ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: widget.leaveDateModelList.length,
    itemBuilder: (context, index) {
      final leaveDateModel = widget.leaveDateModelList[index];
      return _buildLeaveDateItem(index, leaveDateModel);
    },
  );

  Widget _buildLeaveDateItem(int position, LeaveDateModel leaveDateModel) {
    DateTime? parsedDate;
    try {
      parsedDate = DateTime.parse(leaveDateModel.selectedDate);
    } catch (e) {
      debugPrint('Error parsing date: $e');
      return const SizedBox();
    }

    final formattedDate = DateFormat('dd MMM, yyyy').format(parsedDate);
    final double totalAppliedLeave = leaveDateModel.totalAlreadyLeaveApplied;
    final bool alreadyLeaveApplied =
        totalAppliedLeave != 0 && totalAppliedLeave < 1;

    final bool showSelectedLayout =
        leaveDateModel.isSelected &&
        !(leaveDateModel.isPastDateConditionTrue &&
            !leaveDateModel.isPastDateAllowed) &&
        leaveDateModel.weekOffHoliday != '3';

    final bool showUnselectedLayout =
        !leaveDateModel.isSelected && leaveDateModel.weekOffHoliday != '3';
    final bool showWeekOffHolidayLayout = leaveDateModel.weekOffHoliday == '3';

    final bool quarterRestriction = _shouldShowQuarterRestriction(
      leaveDateModel,
      alreadyLeaveApplied,
    );
    final String errorMessageQuarter = _getQuarterErrorMessage(
      leaveDateModel,
      alreadyLeaveApplied,
      totalAppliedLeave,
    );

    return Column(
      children: [
        if (showSelectedLayout)
          _buildSelectedLayout(
            position,
            leaveDateModel,
            formattedDate,
            alreadyLeaveApplied,
            totalAppliedLeave,
          ),
        if (showUnselectedLayout)
          _buildUnselectedLayout(leaveDateModel, formattedDate),
        if (showWeekOffHolidayLayout)
          _buildWeekOffHolidayLayout(leaveDateModel, formattedDate),
        const SizedBox(height: 8),
        if (quarterRestriction)
          CustomText(
            '$errorMessageQuarter',
            color: AppTheme.getColor(context).onSurfaceVariant,
            fontSize: 13 * Responsive.getResponsiveText(context),
            fontWeight: FontWeight.bold,
          ),
        SizedBox(height: 0.02 * Responsive.getHeight(context)),
      ],
    );
  }

  Widget _buildSelectedLayout(
    int position,
    LeaveDateModel leaveDateModel,
    String formattedDate,
    bool alreadyLeaveApplied,
    double totalAppliedLeave,
  ) => Row(
    children: [
      Container(
        width: 120,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              formattedDate,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              _getPaidUnpaidText(leaveDateModel),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (widget.leaveApplyType == 0 || widget.leaveApplyType == 2)
              _buildRadioOption(
                leaveDateModel,
                '0',
                Icons.radio_button_checked,
                alreadyLeaveApplied &&
                    (totalAppliedLeave == 0.25 ||
                        totalAppliedLeave == 0.5 ||
                        totalAppliedLeave == 0.75),
                'Full',
              ),
            if (widget.leaveApplyType == 0 || widget.leaveApplyType == 2)
              _buildRadioOption(
                leaveDateModel,
                '1',
                Icons.radio_button_checked,
                alreadyLeaveApplied &&
                    (totalAppliedLeave == 0.5 || totalAppliedLeave == 0.75),
                '1st',
              ),
            if (widget.leaveApplyType == 0 || widget.leaveApplyType == 2)
              _buildRadioOption(
                leaveDateModel,
                '1',
                Icons.radio_button_checked,
                alreadyLeaveApplied &&
                    (totalAppliedLeave == 0.5 || totalAppliedLeave == 0.75),
                '2nd',
              ),
            if (widget.leaveApplyType == 2)
              _buildRadioOption(
                leaveDateModel,
                '2',
                Icons.radio_button_checked,
                alreadyLeaveApplied && totalAppliedLeave == 0.75,
                'Q',
              ),
            if (widget.leaveApplyType == 2)
              _buildRadioOption(
                leaveDateModel,
                '3',
                Icons.radio_button_checked,
                alreadyLeaveApplied && totalAppliedLeave == 0.75,
                '3Q',
              ),
          ],
        ),
      ),
    ],
  );


  Widget _buildRadioOption(
    LeaveDateModel leaveDateModel,
    String value,
    IconData icon,
    bool disabled,
    String label,
  ) {
    final isSelected =
        leaveDateModel.leaveDayTypeTemp == value &&
        (value != '1' ||
            (value == '1' &&
                leaveDateModel.halfDaySession == (label == '1st' ? '1' : '2')));

    return GestureDetector(
      onTap: disabled
          ? null
          : () {
              setState(() {
                widget.leaveDateModelList[widget.leaveDateModelList.indexOf(
                  leaveDateModel,
                )] = leaveDateModel.copyWith(
                  leaveDayTypeTemp: value,
                  halfDaySession: value == '1'
                      ? (label == '1st' ? '1' : '2')
                      : '0',
                  isFullDay: value == '0',
                  takeQuarterLeave: true,
                  changedSelection: true,
                );
                _validateQuarterLeaveLogic();
                widget.onDayTypeChangeClick();
              });
            },
      child: Column(
        children: [
          Icon(
            isSelected
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
            color: disabled
                ? Colors.grey
                : isSelected
                ? Colors.blue
                : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              color: disabled ? Colors.grey : Colors.black,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnselectedLayout(
    LeaveDateModel leaveDateModel,
    String formattedDate,
  ) => Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Container(
          width: 120,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.cyan,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                formattedDate,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                leaveDateModel.isPaidLeave ? 'Paid' : 'Unpaid',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              leaveDateModel.extraDataInfo.isNotEmpty
                  ? leaveDateModel.extraDataInfo
                  : 'Not selectable',
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildWeekOffHolidayLayout(
    LeaveDateModel leaveDateModel,
    String formattedDate,
  ) => Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Container(
              width: 120,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    formattedDate,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    leaveDateModel.isPaidLeave ? 'Paid' : 'Unpaid',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    leaveDateModel.extraDataInfo,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  String _getPaidUnpaidText(LeaveDateModel leaveDateModel) {
    if (leaveDateModel.isPaidLeave) {
      double percentageValue = leaveDateModel.leavePercentage;
      bool hasPercentage = false;

      if (leaveDateModel.leaveDayTypeTemp == '0' &&
          percentageValue != 100 &&
          percentageValue != 0) {
        hasPercentage = true;
      } else if (leaveDateModel.leaveDayTypeTemp == '1' &&
          percentageValue != 50 &&
          percentageValue != 0) {
        hasPercentage = true;
      } else if (leaveDateModel.leaveDayTypeTemp == '2' &&
          percentageValue != 25 &&
          percentageValue != 0) {
        hasPercentage = true;
      } else if (leaveDateModel.leaveDayTypeTemp == '3' &&
          percentageValue != 75 &&
          percentageValue != 0) {
        hasPercentage = true;
      }

      if (hasPercentage && leaveDateModel.isPaidLeave) {
        return 'Paid (${percentageValue.toStringAsFixed(0)}%)';
      } else if (leaveDateModel.isPaidLeave) {
        return 'Paid';
      }
    }
    return 'Unpaid';
  }

  void _validateQuarterLeaveLogic() {
    if (widget.isQuarterTriggersFullDay == 1) {
      for (var item in widget.leaveDateModelList) {
        if (item.isSelected && item.leaveDayTypeTemp == '2') {
          item.takeQuarterLeave = true;
        }
      }

      for (int i = 0; i < widget.leaveDateModelList.length; i++) {
        LeaveDateModel current = widget.leaveDateModelList[i];

        if (current.isSelected && current.leaveDayTypeTemp == '2') {
          bool hasFullNeighbor = false;

          // Check downward
          for (int j = i + 1; j < widget.leaveDateModelList.length; j++) {
            LeaveDateModel next = widget.leaveDateModelList[j];
            if (next.isSelected) {
              if (next.leaveDayTypeTemp == '0') {
                hasFullNeighbor = true;
              }
              break;
            }
          }

          // Check upward
          if (!hasFullNeighbor) {
            for (int j = i - 1; j >= 0; j--) {
              LeaveDateModel prev = widget.leaveDateModelList[j];
              if (prev.isSelected) {
                if (prev.leaveDayTypeTemp == '0') {
                  hasFullNeighbor = true;
                }
                break;
              }
            }
          }

          if (!hasFullNeighbor) {
            current.takeQuarterLeave = false;
          }
        }
      }
    }
  }

  bool _shouldShowQuarterRestriction(
      LeaveDateModel leaveDateModel,
      bool alreadyLeaveApplied,
      ) {
    if (leaveDateModel.weekOffHoliday == '3') return true;
    if (alreadyLeaveApplied) return true;
    if (leaveDateModel.isSelected &&
        !leaveDateModel.isPastDateConditionTrue &&
        leaveDateModel.isPastDateAllowed &&
        leaveDateModel.isUnpaidRestrictionON) {
      return true;
    }
    if (!leaveDateModel.takeQuarterLeave) return true;
    return false;
  }

  String _getQuarterErrorMessage(
      LeaveDateModel leaveDateModel,
      bool alreadyLeaveApplied,
      double totalAppliedLeave,
      ) {
    if (leaveDateModel.weekOffHoliday == '3') {
      return leaveDateModel.extraDataInfo;
    }
    if (alreadyLeaveApplied) {
      return 'Total Already Applied Leave: $totalAppliedLeave';
    }
    if (leaveDateModel.isSelected &&
        !leaveDateModel.isPastDateConditionTrue &&
        leaveDateModel.isPastDateAllowed &&
        leaveDateModel.isUnpaidRestrictionON) {
      return leaveDateModel.extraDataInfo;
    }
    if (!leaveDateModel.takeQuarterLeave) {
      return 'Quarter leave not allowed for this date';
    }
    return '';
  }
}
