// lib/widgets/attendance_info_bottom_sheet.dart (or your preferred path)

import 'package:flutter/material.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/attendance_type_response_entity.dart';
import 'package:myco_flutter/features/dashboard/presentation/widgets/timer_and_slider/custom_timer.dart';
import 'package:myco_flutter/features/payslip/presentation/widgets/payslip_card.dart';
import 'package:myco_flutter/features/time_sheet/presentation/widgets/progress_bar_card.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_vertical_stepper.dart';

class AttendanceInfoBottomSheet extends StatelessWidget {
  final AttendanceTypeResponseEntity? attendanceData;
  final double maxMinutes;
  final double currentMinutes;
  final List<ColorRange> colorRanges;

  const AttendanceInfoBottomSheet({
    required this.attendanceData,
    required this.maxMinutes,
    required this.currentMinutes,
    required this.colorRanges,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (attendanceData == null) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Center(child: Text('Attendance data is not available.')),
      );
    }

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    // --- Data Processing ---
    final shift = attendanceData?.shiftData;
    String shiftDetails = 'Not Available';
    if (shift != null) {
      shiftDetails =
          "${shift.shiftName ?? ''} (${shift.shiftCode ?? ''}) ${shift.shiftStartTimeView ?? ''} - ${shift.shiftEndTimeView ?? ''}";
    }

    final totalSeconds =
        double.tryParse(attendanceData?.timeDiffSeconds ?? '0') ?? 0;
    final workingHours = _formatDuration(
      Duration(seconds: totalSeconds.toInt()),
    );

    final productiveSeconds =
        double.tryParse(attendanceData?.productiveHoursInSec ?? '0') ?? 0;
    final productiveHours = _formatDuration(
      Duration(seconds: productiveSeconds.toInt()),
    );

    // --- UI ---
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          CustomText(
            'attendance_summary',
            color: AppTheme.isAppThemeDarkMode(context)
                ? AppColors.darkprimary
                : AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 16 * Responsive.getResponsiveText(context),
          ),
          const SizedBox(height: 8),
          // ProgressBarCard(
          //   maxMinutes: maxMinutes,
          //   initialCurrentMinutes: currentMinutes,
          // ),
          SizedBox(
            height:
                VariableBag.shadowContainerVerticalPadding *
                Responsive.getResponsive(context),
          ),
          CustomVerticalStepper(
            steps: [
              StepData(
                title: 'PUNCH IN',
                subTitle: 'New Punch In',
                status: StepStatus.approved,
              ),
              StepData(
                title: 'PUNCH IN',
                subTitle: 'New Punch In',
                status: StepStatus.approved,
              ),
            ],
          ),
          // _buildInfoRow('Working Hours:', workingHours, context),
          // _buildInfoRow('Productive Hours:', productiveHours, context),
          // _buildInfoRow("Today's Shift:", shiftDetails, context),
          // if (attendanceData?.multiPunchDataView != null &&
          //     attendanceData!.multiPunchDataView!.isNotEmpty) ...[
          //   const SizedBox(height: 16),
          //   const Divider(),
          //   const LiveClock(isAppBar: true),
          //   const SizedBox(height: 16),
          //   Text(
          //     'Punch Timings',
          //     style: textTheme.titleMedium?.copyWith(
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          //   const SizedBox(height: 8),
          //   ...attendanceData!.multiPunchDataView!.map(
          //     (punch) => _buildInfoRow(
          //       "${punch.punchInTime ?? 'Time'}:",
          //       punch.punchInTime ?? '',
          //       context,
          //     ),
          //   ),
          // ],
        ],
      ),
    );
  }

  // Helper to format duration as HH:mm:ss
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }

  // Helper widget for a consistent row style
  Widget _buildInfoRow(String label, String value, BuildContext context) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(color: AppTheme.getColor(context).outline),
            ),
            const SizedBox(width: 16),
            Flexible(
              child: Text(
                value,
                style: const TextStyle(fontWeight: FontWeight.w600),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      );
}
