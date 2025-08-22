import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/time_sheet/domain/entities/attendence_month_entity.dart';
import 'package:myco_flutter/widgets/custom_dash_line.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/horizontal_progress_bar.dart';

// Enum to define the style of the card
enum ProgressBarCardStyle { timesheet, attendanceInfo }

class ProgressBarCard extends StatelessWidget {
  final String? totalHours;
  final String? monthlyHoursSpent;
  final double progressPercentage;
  final ProgressBarCardStyle style;
  final MonthlyHistoryEntity? history; // Required for detailed view

  const ProgressBarCard({
    required this.progressPercentage,
    this.totalHours,
    this.monthlyHoursSpent,
    this.style = ProgressBarCardStyle.timesheet,
    this.history,
    super.key,
  }) : assert(
         style == ProgressBarCardStyle.timesheet || history != null,
         'History entity must be provided for attendanceInfo style.',
       );

  @override
  Widget build(BuildContext context) {
    final bool isDetailed = style == ProgressBarCardStyle.attendanceInfo;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.isAppThemeDarkMode(context)
            ? AppColors.containerHighDark
            : AppColors.white,
        borderRadius: BorderRadius.circular(
          VariableBag.containerBorderRadius * Responsive.getResponsive(context),
        ),
        border: Border.all(color: AppTheme.getColor(context).outline),
        boxShadow: [
          BoxShadow(
            color: AppTheme.isAppThemeDarkMode(context)
                ? Colors.black26
                : Colors.grey.shade200,
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppTheme.getColor(context).outline),
              ),
            ),
            child: HorizontalProgressBar(
              height: 0.055 * Responsive.getHeight(context),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              backgroundColor: AppTheme.isAppThemeDarkMode(context)
                        ? AppColors.emptyProgressDark.withAlpha(900)
                        : AppColors.emptyProgressLight,
              colorRanges: [
                (
                  0,
                  progressPercentage.toInt(),
                  AppTheme.getColor(context).primary,
                ),
              ],
              totalValue: 100,
            ),
          ),
          if (isDetailed)
            _buildDetailedContent(context)
          else
            _buildTimesheetContent(context),
        ],
      ),
    );
  }

  /// Builds the content for the Time Sheet page.
  Widget _buildTimesheetContent(BuildContext context) => Padding(
    padding: EdgeInsets.fromLTRB(
      25,
      15,
      25,
      15 * Responsive.getResponsive(context),
    ),
    child: IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildInfoColumn(
            context,
            value: totalHours ?? '---',
            label: 'total_hours',
          ),
          _buildVerticalDivider(context),
          _buildInfoColumn(
            context,
            value: monthlyHoursSpent ?? '---',
            label: 'monthly_hours_spend',
          ),
        ],
      ),
    ),
  );

  /// Builds the detailed content for the Attendance Info Bottom Sheet.
  Widget _buildDetailedContent(BuildContext context) => Padding(
      padding: EdgeInsets.all(15 * Responsive.getResponsive(context)),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildInfoColumn(
                  context,
                  value: history?.totalHoursSpend ?? '00:00',
                  label: 'total_hours',
                ),
                _buildVerticalDivider(context),
                _buildInfoColumn(
                  context,
                  value: history?.productiveWorkingHours ?? '00:00',
                  label: 'productive_hours',
                ),
                _buildVerticalDivider(context),
                if (history?.remainingWorkingHoursMinutes != null &&
                    double.tryParse(history!.remainingWorkingHoursMinutes!)! >
                        0) ...[
                  _buildInfoColumn(
                    context,
                    value: history?.remainingWorkingHours ?? '00:00',
                    label: 'remaining_hours',
                  ),
                ] else ...[
                  // If both are gone, show a default remaining hours
                  if (history?.extraWorkingHoursMinutes == null ||
                      double.tryParse(history!.extraWorkingHoursMinutes!)! <= 0)
                    _buildInfoColumn(
                      context,
                      value: '00:00',
                      label: 'remaining_hours',
                    ),
                ],
                if (history?.extraWorkingHoursMinutes != null &&
                    double.tryParse(history!.extraWorkingHoursMinutes!)! > 0 &&
                    history?.remainingWorkingHoursMinutes != null &&
                    double.tryParse(history!.remainingWorkingHoursMinutes!)! >
                        0)
                  _buildVerticalDivider(context),
                if (history?.extraWorkingHoursMinutes != null &&
                    double.tryParse(history!.extraWorkingHoursMinutes!)! > 0)
                  _buildInfoColumn(
                    context,
                    value: history?.extraWorkingHours ?? '00:00',
                    label: 'extra_working_hours',
                  ),
              ],
            ),
          ),
        ],
      ),
    );

  Widget _buildInfoColumn(
    BuildContext context, {
    required String value,
    required String label,
  }) => Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          value,
          fontSize:
              14 * Responsive.getResponsiveText(context),
          fontWeight: FontWeight.w700,
          color: AppTheme.isAppThemeDarkMode(context)
              ? AppColors.darkprimary
              : AppColors.primary,
        ),
        CustomText(
          label,
          fontSize: 12 * Responsive.getResponsiveText(context),
          color: AppTheme.getColor(context).onSurface,
        ),
      ],
    ),
  );

  Widget _buildVerticalDivider(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 14.0 * Responsive.getResponsive(context),
    ),
    child: CustomDashLine(
      axis: Axis.vertical,
      color: AppTheme.isAppThemeDarkMode(context)
          ? AppColors.darkprimary
          : AppTheme.getColor(context).primary,
      dashLength: 2,
      width: 1,
    ),
  );
}
