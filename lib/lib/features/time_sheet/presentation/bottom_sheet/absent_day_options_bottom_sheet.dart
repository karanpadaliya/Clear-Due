import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/time_sheet/domain/entities/attendence_month_entity.dart';
import 'package:myco_flutter/widgets/common_card.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class AbsentDayOptionsBottomSheet extends StatelessWidget {
  final MonthlyHistoryEntity history;
  final void Function()? requestForAttendance;
  final void Function()? requestForLeave;
  final void Function()? overTimeRequest;
  final bool isOption1isEnable;
  final bool isOption2isEnable;

  const AbsentDayOptionsBottomSheet({
    required this.history,
    required this.requestForAttendance,
    required this.requestForLeave,
    this.overTimeRequest,
    this.isOption1isEnable = true,
    this.isOption2isEnable = true,
    super.key,
  });

  // Helper to determine the main title for the dialog header
  String _getHeaderTitle() {
    if (history.weekOff == true) {
      return 'Week Off';
    } else if (history.holiday == true) {
      return history.holidayName ?? 'Holiday';
    }
    return 'Absent Day';
  }

  Widget _buildRequestButton({
    required BuildContext context,
    required String title,
    required bool isEnabled,
    required void Function()? onTap,
  }) => GestureDetector(
    onTap: isEnabled ? onTap : null,
    child: Opacity(
      opacity: isEnabled ? 1.0 : 0.5,
      child: Container(
        height: 0.06 * Responsive.getHeight(context),
        width: 0.43 * Responsive.getWidth(context),
        decoration: BoxDecoration(
          color: AppColors.primaryAlpha,
          borderRadius: BorderRadius.circular(
            8 * Responsive.getResponsive(context),
          ),
        ),
        alignment: Alignment.center,
        child: CustomText(
          title,
          fontSize: 14 * Responsive.getResponsiveText(context),
          color: AppTheme.getColor(context).primary,
          fontWeight: FontWeight.w600,
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: history.penaltyName!.isNotEmpty
            ? constraints.maxHeight * 0.6
            : constraints.maxHeight * 0.5, // still gives breathing room
      ),
      child: CommonCard(
        title: '${_getHeaderTitle()} (${history.dateName ?? ''})',
        headerColor: AppTheme.getColor(context).primary,
        headerPadding: const EdgeInsets.symmetric(
          horizontal: VariableBag.commonCardHorizontalPadding + 4,
          vertical: VariableBag.commonCardVerticalPadding,
        ),
        titleFontSize: 16 * Responsive.getResponsiveText(context),
        bottomWidget: Padding(
          padding: EdgeInsets.all(12.0 * Responsive.getResponsive(context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // Important for BottomSheet
            children: [
              Padding(
                padding: EdgeInsetsGeometry.only(
                  top: 18 * Responsive.getResponsive(context),
                ),
                child: SvgPicture.asset(
                  AppAssets.timeSheetAttendanceRequest,
                  height: 0.16 * Responsive.getHeight(context),
                ),
              ),

              // This corresponds to the `penaltyName` field in Android
              if (history.penaltyName != null &&
                  history.penaltyName!.isNotEmpty)
                Padding(
                  padding: EdgeInsetsGeometry.only(
                    top: 24 * Responsive.getResponsive(context),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    width: Responsive.getWidth(context),
                    decoration: BoxDecoration(
                      color: AppColors.primaryAlpha,
                      borderRadius: BorderRadius.circular(
                        8 * Responsive.getResponsive(context),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: CustomText(
                      history.penaltyName!,
                      isKey: false,
                      fontSize: 14 * Responsive.getResponsiveText(context),
                      color: AppTheme.getColor(context).primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              SizedBox(height: 12 * Responsive.getResponsive(context)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildRequestButton(
                    context: context,
                    title: 'Request for Attendance',
                    isEnabled: isOption1isEnable,
                    onTap: requestForAttendance,
                  ),
                  _buildRequestButton(
                    context: context,
                    title: 'Request for Leave',
                    isEnabled: isOption2isEnable,
                    onTap: requestForLeave,
                  ),
                ],
              ),
              if (overTimeRequest != null)
                Padding(
                  padding: EdgeInsetsGeometry.only(
                    top: 14 * Responsive.getResponsive(context),
                  ),
                  child: MyCoButton(
                    onTap: overTimeRequest,
                    title: 'Overtime request',
                    isShadowBottomLeft: true,
                    boarderRadius: 30 * Responsive.getResponsive(context),
                    backgroundColor: AppTheme.getColor(context).secondary,
                    borderColor: AppTheme.getColor(context).secondary,
                  ),
                ),
              Padding(
                padding: EdgeInsetsGeometry.only(
                  top: 10 * Responsive.getResponsive(context),
                ),
                child: MyCoButton(
                  onTap: () => context.pop(),
                  title: 'Close',
                  backgroundColor: Colors.white,
                  boarderRadius: 30 * Responsive.getResponsive(context),
                  border: Border.all(color: AppTheme.getColor(context).primary),
                  textStyle: TextStyle(
                    color: AppTheme.getColor(context).primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
