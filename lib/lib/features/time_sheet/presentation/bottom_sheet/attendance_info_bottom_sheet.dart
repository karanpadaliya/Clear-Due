import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/idea_box/presentation/widgets/common_container.dart';
import 'package:myco_flutter/features/time_sheet/domain/entities/attendence_month_entity.dart';
import 'package:myco_flutter/features/time_sheet/presentation/widgets/odometer_time_sheet.dart';
import 'package:myco_flutter/features/time_sheet/presentation/widgets/progress_bar_card.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_vertical_stepper.dart';
import 'package:myco_flutter/widgets/media_picker/widgets/design_border_container.dart';

class AttendanceInfoBottomSheet extends StatelessWidget {
  final MonthlyHistoryEntity history;
  final bool isSalaryGenerated;

  const AttendanceInfoBottomSheet({
    required this.history,
    required this.isSalaryGenerated,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    // Wrapping with Material and Scaffold to provide a proper context for a full-screen-like view
    return Material(
      child: Scaffold(
        body: SafeArea(
          child: AttendanceInfoView(
            history: history,
            isSalaryGenerated: isSalaryGenerated,
          ),
        ),
      ),
    );
  }
}

enum TravelMode { car, bike }

class AttendanceInfoView extends StatefulWidget {
  final MonthlyHistoryEntity history;
  final bool isSalaryGenerated;

  const AttendanceInfoView({
    required this.history,
    required this.isSalaryGenerated,
    super.key,
  });

  @override
  State<AttendanceInfoView> createState() => _AttendanceInfoViewState();
}

class _AttendanceInfoViewState extends State<AttendanceInfoView> {
  TravelMode selectedMode = TravelMode.bike;
  bool _isPunchInSubmitted = false;
  bool _isPunchOutSubmitted = false;

  // State for Odometer Readings
  File? _punchInImage, _punchOutImage;
  String? _punchInKm, _punchInMeter, _punchOutKm, _punchOutMeter;

  @override
  void initState() {
    super.initState();
    // Pre-fill state based on history
    _isPunchInSubmitted =
        widget.history.punchInOdometer != null &&
        widget.history.punchInOdometer!.isNotEmpty;
    _isPunchOutSubmitted =
        widget.history.punchOutOdometer != null &&
        widget.history.punchOutOdometer!.isNotEmpty;
  }

  void _handlePunchInSubmit(File? image, String km, String meter) {
    // In a real app, you would call the API here.
    // For this migration, we'll just update the state to reflect submission.
    setState(() {
      _punchInImage = image;
      _punchInKm = km;
      _punchInMeter = meter;
      _isPunchInSubmitted = true;
    });
  }

  void _handlePunchOutSubmit(File? image, String km, String meter) {
    setState(() {
      _punchOutImage = image;
      _punchOutKm = km;
      _punchOutMeter = meter;
      _isPunchOutSubmitted = true;
    });
  }

  String _getOtRequestStatus(String? status) {
    switch (status) {
      case '1':
        return 'OT Request Pending';
      case '2':
        return 'OT Request Rejected';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine visibility of Odometer widgets
    final bool showOdometerIn =
        widget.history.isToday == true && !_isPunchInSubmitted;
    final bool showOdometerOut =
        widget.history.isToday == true &&
        _isPunchInSubmitted &&
        !_isPunchOutSubmitted;

    return Column(
      children: [
        _buildHeaderCard(context),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal:
                    VariableBag.bottomSheetLeftPadding *
                    Responsive.getResponsive(context),
                vertical:
                    VariableBag.bottomSheetTopPadding *
                    Responsive.getResponsive(context),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing:
                    VariableBag.formContentSpacingVertical *
                    Responsive.getResponsive(context),
                children: [
                  if (widget.history.attendancePunchOutMissingStatus == '0')
                    _buildStatusContainer(
                      'punch_out_missing_request_sent',
                      isKey: true,
                    ),
                  if (widget.history.attendancePunchOutMissingStatus == '2')
                    _buildStatusContainer(
                      'you_punch_out_missing_request_was_rejected',
                      isKey: true,
                      isError: true,
                    ),
                  if (widget.history.isShortLeave == true)
                    _buildStatusContainer('short_leaves', isKey: true),
                  if (widget.history.attendanceDeclined == true)
                    _buildRejectedContainer(context),
                  _buildProgressBar(context),
                  if (widget.history.shiftName != null &&
                      widget.history.shiftName!.isNotEmpty)
                    _buildStatusContainer(
                      widget.history.shiftName!,
                      isKey: false,
                    ),

                  _buildPunchStepper(context),

                  if (widget.history.leaveList != null &&
                      widget.history.leaveList!.isNotEmpty)
                    _buildLeaveDetails(context),

                  if (showOdometerIn || showOdometerOut) ...[
                    CustomText(
                      'Travel Mode:',
                      fontSize: 14 * Responsive.getResponsiveText(context),
                    ),
                    Row(
                      children: [
                        _buildTravelModeCard(
                          icon: Icons.pedal_bike,
                          label: 'Bike',
                          isSelected: selectedMode == TravelMode.bike,
                          onTap: () =>
                              setState(() => selectedMode = TravelMode.bike),
                        ),
                        const SizedBox(width: 10),
                        _buildTravelModeCard(
                          icon: Icons.directions_car,
                          label: 'Car',
                          isSelected: selectedMode == TravelMode.car,
                          onTap: () =>
                              setState(() => selectedMode = TravelMode.car),
                        ),
                      ],
                    ),
                  ],

                  if (showOdometerIn)
                    OdometerTimeSheet(
                      title: 'Add Odometer Reading For Punch In',
                      onSubmit: _handlePunchInSubmit,
                    ),

                  if (showOdometerOut)
                    OdometerTimeSheet(
                      title: 'Add Odometer Reading For Punch Out',
                      onSubmit: _handlePunchOutSubmit,
                    ),

                  if (widget.history.isPunchOutMissing == true &&
                      widget.history.attendancePunchOutMissingId == null)
                    MyCoButton(
                      onTap: () {
                        /* Handle Raise Request */
                      },
                      title: 'Raise a Request',
                      boarderRadius: 25 * Responsive.getResponsive(context),
                      isShadowBottomLeft: true,
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    final history = widget.history;
    String attendanceStatusText = '';
    if (history.attendnacePending == true) {
      attendanceStatusText = ' (Pending)';
    }

    final String extraDayStatus = history.extraDay == true ? '(Extra Day)' : '';
    String otStatus = _getOtRequestStatus(history.otRequestStatus);
    if (otStatus.isNotEmpty) {
      otStatus = '($otStatus)';
    }

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          const BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
          BoxShadow(color: AppTheme.getColor(context).secondary.withAlpha(180)),
          BoxShadow(
            color: AppTheme.getColor(context).secondary,
            offset: const Offset(1, 4),
            spreadRadius: -6.0,
            blurRadius: 6.0,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        vertical:
        VariableBag.commonContainerPadding *
            Responsive.getResponsive(context),
        horizontal:
        VariableBag.bottomSheetRightPadding *
            Responsive.getResponsive(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomText(
                '${history.dayName ?? ''}$attendanceStatusText',
                color: AppTheme.getColor(context).onPrimary,
                fontSize: 14 * Responsive.getResponsiveText(context),
                fontWeight: FontWeight.w700,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: SvgPicture.asset(
                  AppAssets.downArrowBottomSheet,
                  width: Responsive.isTablet(context)
                      ? 0.03 * Responsive.getWidth(context)
                      : 0.06 * Responsive.getWidth(context),
                  fit: BoxFit.scaleDown,
                  colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                ),
              ),
            ],
          ),
          CustomText(
            history.dateName ?? 'N/A',
            color: AppTheme.getColor(context).onPrimary,
            fontSize: 16 * Responsive.getResponsiveText(context),
            fontWeight: FontWeight.w700,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (extraDayStatus.isNotEmpty)
                CustomText(
                  extraDayStatus,
                  color: AppTheme.getColor(context).onPrimary,
                  fontSize: 14 * Responsive.getResponsiveText(context),
                  fontWeight: FontWeight.w500,
                ),
              if (otStatus.isNotEmpty)
                CustomText(
                  otStatus,
                  color: AppColors.spanishYellow,
                  fontSize: 14 * Responsive.getResponsiveText(context),
                  fontWeight: FontWeight.w500,
                ),
              CustomText(
                '(Shift Hours: ${history.shiftPerDayHoursView ?? 'N/A'})',
                color: AppTheme.getColor(context).onPrimary,
                fontSize: 14 * Responsive.getResponsiveText(context),
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusContainer(
    String text, {
    bool isKey = false,
    bool isError = false,
  }) => DesignBorderContainer(
    backgroundColor: isError ? AppColors.absentDays : const Color(0xFFD8EEFF),
    borderRadius: 10 * Responsive.getResponsive(context),
    child: Center(
      child: CustomText(
        text,
        isKey: isKey,
        color: isError
            ? AppTheme.getColor(context).error
            : AppTheme.getColor(context).primary,
        fontSize: 14 * Responsive.getResponsiveText(context),
      ),
    ),
  );

  Widget _buildRejectedContainer(BuildContext context) => DesignBorderContainer(
    backgroundColor: const Color(0xFFFFEBEB),
    width: double.infinity,
    borderRadius: 10 * Responsive.getResponsive(context),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          'Attendance Rejected',
          color: AppTheme.getColor(context).error,
          fontSize: 14 * Responsive.getResponsiveText(context),
          fontWeight: FontWeight.w700,
        ),
        CustomText(
          widget.history.attendanceDeclinedMessage ?? 'No reason provided.',
          color: AppTheme.getColor(context).error,
          fontSize: 14 * Responsive.getDashboardResponsiveText(context),
        ),
      ],
    ),
  );

  Widget _buildProgressBar(BuildContext context) {
    final double percentage =
        double.tryParse(
          widget.history.newUiDataView?.workingHourInPer ?? '0.0',
        ) ??
        0.0;
    return ProgressBarCard(
      style: ProgressBarCardStyle.attendanceInfo,
      history: widget.history,
      progressPercentage: percentage,
    );
  }

  Widget _buildPunchStepper(BuildContext context) {
    final punchData = widget.history.newUiDataView?.multiPunchDataView;
    if (punchData == null || punchData.isEmpty) {
      return const SizedBox.shrink();
    }

    final List<StepData> steps = punchData.map((punch) {
      String title = '';
      String subTitle = '';
      final String trailingTitle = punch.workingHour ?? '';

      if (punch.punchInTime != null &&
          punch.punchInTime!.isNotEmpty &&
          punch.punchOutTime != null &&
          punch.punchOutTime!.isNotEmpty) {
        title = 'PUNCH IN & OUT';
        subTitle = '${punch.punchInTime} - ${punch.punchOutTime}';
      } else if (punch.punchInTime != null && punch.punchInTime!.isNotEmpty) {
        title = 'PUNCH IN';
        subTitle = punch.punchInTime!;
      } else if (punch.punchOutTime != null && punch.punchOutTime!.isNotEmpty) {
        title = 'PUNCH OUT';
        subTitle = punch.punchOutTime!;
      }

      final List<SubStepData> subSteps = (punch.breaks ?? [])
          .map(
            (breakData) => SubStepData(
              subStepTitle: breakData.breakName,
              subStepSubTitle:
                  breakData.breakInTime != null &&
                      breakData.breakOutTime != null
                  ? '${breakData.breakInTime} - ${breakData.breakOutTime}'
                  : breakData.breakInTime,
              subStepTrailingTitle: breakData.totalBreakHoursSpend,
              subStepStatus: StepStatus.completed,
              isSubStepIconShow: false,
            ),
          )
          .toList();

      return StepData(
        title: title,
        subTitle: subTitle,
        trillingTitle: trailingTitle,
        status: StepStatus.completed,
        subSteps: subSteps,
        titleColor: AppColors.black,
        subTitleColor: AppColors.textSecondary,
      );
    }).toList();

    return CustomVerticalStepper(steps: steps);
  }

  Widget _buildLeaveDetails(BuildContext context) => CommonCard(
    title: 'Leave Details',
    bottomWidget: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15 * Responsive.getResponsive(context),
        vertical: 10 * Responsive.getResponsive(context),
      ),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.history.leaveList!.length,
        separatorBuilder: (context, index) =>
            Divider(height: 20, color: Colors.grey.shade300),
        itemBuilder: (context, index) {
          final leave = widget.history.leaveList![index];
          final reason =
              (leave.leaveReason != null && leave.leaveReason!.isNotEmpty)
              ? leave.leaveReason
              : leave.autoLeaveReason;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                '${leave.leaveTypeName ?? 'Leave'} :',
                fontSize: 16 * Responsive.getResponsiveText(context),
                fontWeight: FontWeight.w700,
                color: AppTheme.getColor(context).primary,
              ),
              const SizedBox(height: 4),
              CustomText(
                '${leave.leaveDayType ?? ''} - ${leave.leavePaidUnpaid ?? ''}',
                fontSize: 12 * Responsive.getResponsiveText(context),
                color: AppTheme.getColor(context).onSurface,
              ),
              if (reason != null && reason.isNotEmpty) ...[
                const SizedBox(height: 4),
                CustomText(
                  'Reason : $reason',
                  fontSize: 12 * Responsive.getResponsiveText(context),
                  color: AppTheme.getColor(context).onSurface,
                ),
              ],
            ],
          );
        },
      ),
    ),
  );

  Widget _buildTravelModeCard({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 0.4 * Responsive.getWidth(context),
      padding: EdgeInsets.symmetric(
        vertical: 12 * Responsive.getResponsive(context),
      ),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFD8EEFF) : Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? Colors.blue : Colors.grey, size: 28),
          SizedBox(width: 0.02 * Responsive.getWidth(context)),
          CustomText(
            label,
            fontSize: 14 * Responsive.getResponsiveText(context),
            color: isSelected ? Colors.blue : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    ),
  );
}
