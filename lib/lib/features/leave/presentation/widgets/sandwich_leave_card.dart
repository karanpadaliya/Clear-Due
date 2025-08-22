import 'package:flutter/material.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/leave/domain/entities'
    '/leave_history_response_entity.dart';
import 'package:myco_flutter/widgets/common_card.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class SandwichLeaveEntry {
  final String date;
  final String subType;
  final String reason;
  final String status;
  final bool isSalaryGenerated;
  final String? nextLeaveDate;
  final String? prevLeaveDate;
  final LeaveHistoryEntity leaveEntity;

  SandwichLeaveEntry({
    required this.date,
    required this.subType,
    required this.reason,
    required this.status,
    required this.isSalaryGenerated,
    required this.leaveEntity,
    this.nextLeaveDate,
    this.prevLeaveDate,
  });
}

class SandwichLeaveCard extends StatelessWidget {
  final SandwichLeaveEntry leave;
  final Function({required LeaveHistoryEntity leave})? onEdit;

  const SandwichLeaveCard({required this.leave, this.onEdit, super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.getResponsive(context);
    final textResponsive = Responsive.getResponsiveText(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8 * responsive),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10 * responsive),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonCard(
            showHeaderPrefixIcon: true,
            headerPrefixIcon: AppAssets.calendarIcon,
            suffixIcon: !leave.isSalaryGenerated
                ? IconButton(
                    onPressed: () {
                      onEdit!(leave: leave.leaveEntity);
                    },
                    icon: Image.asset(
                      AppAssets.editLeave,
                      height: 0.03 * Responsive.getHeight(context),
                      color: AppTheme.getColor(context).surface,
                    ),
                  )
                : null,
            title: leave.prevLeaveDate ?? leave.date,
            // Show prevLeaveDate if available
            headerColor: AppColors.secondary,
            bottomWidget: Padding(
              padding: EdgeInsets.all(10 * responsive),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildBadge(leave.subType, Colors.blue),
                      if (leave.nextLeaveDate != null &&
                          leave.nextLeaveDate!.isNotEmpty)
                        CustomText(
                          ' - ${leave.nextLeaveDate}',
                          fontSize: 12 * textResponsive,
                          color: Colors.grey.shade600,
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Reason
                  CustomText(
                    leave.reason,
                    fontSize: 14 * textResponsive,
                    color: Colors.black,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  // Status
                  CustomText(
                    leave.status,
                    color: AppColors.secondary,
                    fontSize: 13 * textResponsive,
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
