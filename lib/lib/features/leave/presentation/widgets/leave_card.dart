import 'package:flutter/material.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/leave/domain/entities'
    '/leave_history_response_entity.dart';
import 'package:myco_flutter/widgets/common_card.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class LeaveEntry {
  final String date;
  final String leaveType;
  final String subType;
  final String leaveTime;
  final String reason;
  final String approvedBy;
  final String status;
  final String payStatus;
  final Widget onViewDetailWidget;
  final LeaveHistoryEntity leaveEntity;
  final String headerColor;
  final bool isAutoLeave;

  LeaveEntry({
    required this.date,
    required this.leaveType,
    required this.subType,
    required this.leaveTime,
    required this.reason,
    required this.approvedBy,
    required this.status,
    required this.payStatus,
    required this.onViewDetailWidget,
    required this.leaveEntity,
    required this.headerColor,
    required this.isAutoLeave,
  });
}

class LeaveCard extends StatelessWidget {
  final LeaveEntry leave;
  final Function({required LeaveHistoryEntity leave})? onEdit;
  final Function({required String? leaveId})? onDelete;

  const LeaveCard({required this.leave, this.onEdit, this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.getResponsive(context);
    final textResponsive = Responsive.getResponsiveText(context);

    // Determine if delete icon should be visible
    final showDeleteIcon =
        leave.status == 'Pending' &&
        (leave.leaveEntity.convertedFromAutoLeave == null ||
            leave.leaveEntity.convertedFromAutoLeave!.trim().isEmpty ||
            leave.leaveEntity.convertedFromAutoLeave!.trim() != '1');
    // Determine if edit icon should be visible based on Java conditions
    final showEditIcon =
        (leave.status == 'Pending') ||
        ((leave.leaveEntity.autoLeave ?? false) &&
            !(leave.leaveEntity.isSalaryGenerated ?? false));

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8 * responsive),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.getColor(context).onSecondaryContainer,
        ),
        borderRadius: BorderRadius.circular(10 * responsive),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonCard(
            showHeaderPrefixIcon: true,
            headerPrefixIcon: AppAssets.calendarIcon,
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showEditIcon)
                  IconButton(
                    onPressed: () {
                      onEdit!(leave: leave.leaveEntity);
                    },
                    icon: Image.asset(
                      AppAssets.editLeave,
                      height: 0.03 * Responsive.getHeight(context),
                      color: AppTheme.getColor(context).surface,
                    ),
                    // Adding some padding to make it easier to tap
                    padding: EdgeInsets.all(8.0 * responsive),
                  ),
                if (showDeleteIcon)
                  IconButton(
                    onPressed: () {
                      onDelete!(leaveId: leave.leaveEntity.leaveId);
                    },
                    icon: Image.asset(
                      AppAssets.deleteLeave,
                      height: 0.03 * Responsive.getHeight(context),
                      color: AppTheme.getColor(context).surface,
                    ),
                    // Adding some padding to make it easier to tap
                    padding: EdgeInsets.all(8.0 * responsive),
                  ),
              ],
            ),
            title: leave.date,
            headerColor: leave.headerColor == '1'
                ? AppTheme.getColor(context).secondary
                : leave.headerColor == '2'
                ? AppTheme.getColor(context).onErrorContainer
                : AppTheme.getColor(context).onTertiaryContainer,
            bottomWidget: Padding(
              padding: EdgeInsets.all(10 * responsive),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Leave type and time
                  Row(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildBadge(
                        leave.isAutoLeave ? leave.subType : leave.leaveType,
                        AppTheme.getColor(context).primary,
                      ),
                      const SizedBox(width: 4),
                      CustomText(
                        leave.payStatus,
                        fontWeight: FontWeight.bold,
                        fontSize: 16 * textResponsive,
                        color: AppTheme.getColor(context).tertiaryContainer,
                      ),
                    ],
                  ),

                  CustomText(
                    leave.leaveTime,
                    fontSize: 12 * textResponsive,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(height: 4),
                  // Reason
                  CustomText(
                    '${leave.leaveEntity.leaveDayView}${leave.leaveEntity.halfDaySession!.isNotEmpty ? ': ${leave.leaveEntity.halfDaySession}' : ''}',
                    fontSize: 12 * textResponsive,
                    color: Colors.black,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  // Pay Status & View Details
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        leave.status,
                        fontWeight: FontWeight.bold,
                        fontSize: 16 * textResponsive,
                        color: leave.headerColor == '1'
                            ? AppTheme.getColor(context).secondary
                            : leave.headerColor == '2'
                            ? AppTheme.getColor(context).onErrorContainer
                            : AppTheme.getColor(context).onTertiaryContainer,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          MyCoButton(
                            height: 0.035 * Responsive.getHeight(context),
                            width: 0.2 * Responsive.getWidth(context),
                            isShadowBottomLeft: true,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12 * textResponsive,
                              color: AppTheme.getColor(context).surface,
                            ),
                            boarderRadius: 50,
                            onTap: () async {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                builder: (_) => Padding(
                                  padding: EdgeInsets.all(20 * responsive),
                                  child: leave.onViewDetailWidget,
                                ),
                              );
                            },
                            title: 'View Details',
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String label, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      border: Border.all(color: color),
      borderRadius: BorderRadius.circular(6),
    ),
    child: CustomText(label, color: color, fontSize: 12),
  );
}
