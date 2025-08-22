// leave_detail_bottom_sheet.dart

import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/leave/domain/entities/leave_history_response_entity.dart';
import 'package:myco_flutter/features/leave/presentation/widgets/leave_image_grid_bottom_sheet.dart';
import 'package:myco_flutter/widgets/common_card.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';

class LeaveDetailBottomSheet extends StatelessWidget {
  final String leaveDateView;
  final String requestDate;
  final String leaveDayView;
  final String approvedByName;
  final String leaveRequestedDate;
  final String approvedDate;
  final String leaveType;
  final String leaveDuration;
  final String reason;
  final String altPhone;
  final String taskDependency;
  final String dependencyHandle;
  final String status;
  final Color detailColor;
  final List<String> attachments;
  final bool autoLeave;
  final String paidUnpaid;
  final bool isMultiLevelApproval;
  final List<ApprovalUserEntity> approvalUsers;

  const LeaveDetailBottomSheet({
    required this.leaveDateView,
    required this.requestDate,
    required this.leaveDayView,
    required this.approvedByName,
    required this.leaveRequestedDate,
    required this.approvedDate,
    required this.leaveType,
    required this.leaveDuration,
    required this.reason,
    required this.altPhone,
    required this.taskDependency,
    required this.dependencyHandle,
    required this.attachments,
    required this.status,
    required this.detailColor,
    required this.autoLeave,
    required this.paidUnpaid,
    required this.isMultiLevelApproval,
    required this.approvalUsers,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    final double textScale = Responsive.getResponsiveText(context);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: CommonCard(
          headerColor: detailColor,
          title: leaveDateView,
          secondTitle: status == 'Approved' && approvedByName.isNotEmpty
              ? 'By, $approvedByName'
              : null,
          headerHeight: 0.1 * Responsive.getHeight(context),
          suffixIcon: StatusBadge(
            status: status,
            backgroundColor: detailColor,
            textColor: AppTheme.getColor(context).surface,
            borderColor: AppTheme.getColor(context).surface,
            isAutoLeave: autoLeave,
          ),
          bottomWidget: Column(
            children: [
              _buildDateRow(
                context,
                Icons.calendar_month,
                'Leave Request Date',
                requestDate,
              ),
              if (status == 'APPROVED' && approvedDate.isNotEmpty)
                _buildDateRow(
                  context,
                  Icons.verified,
                  'Leave Approved Date',
                  approvedDate,
                ),

              _buildTabHeader(context),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabelValueColumn(
                      context,
                      autoLeave ? 'Auto Leave Reason :' : 'Leave Reason :',
                      reason,
                    ),
                    const Divider(
                      thickness: 1,
                      height: 1,
                      color: AppColors.gray10,
                    ),
                    if (!autoLeave && altPhone.isNotEmpty)
                      _buildLabelValueRow(
                        context,
                        'Alt. phone Number:',
                        altPhone,
                      ),
                    if (!autoLeave && altPhone.isNotEmpty)
                      const Divider(
                        thickness: 1,
                        height: 1,
                        color: AppColors.gray10,
                      ),
                    _buildLabelValueRow(
                      context,
                      'Task Dependency :',
                      taskDependency,
                    ),
                    const Divider(
                      thickness: 1,
                      height: 1,
                      color: AppColors.gray10,
                    ),
                    if (dependencyHandle.isNotEmpty)
                      _buildLabelValueColumn(
                        context,
                        'Dependency Handle:',
                        dependencyHandle,
                      ),
                    if (dependencyHandle.isNotEmpty)
                      const Divider(
                        thickness: 1,
                        height: 1,
                        color: AppColors.gray10,
                      ),

                    if (isMultiLevelApproval && approvalUsers.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Approval Users:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12 * textScale,
                              ),
                            ),
                            SizedBox(height: Responsive.scaleHeight(6)),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: approvalUsers
                                  .map(
                                    (user) => ApprovalChip(
                                      name: user.name ?? '',
                                      status: user.status ?? '',
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    if (!isMultiLevelApproval && approvalUsers.isNotEmpty)
                      const Divider(
                        thickness: 1,
                        height: 1,
                        color: AppColors.gray10,
                      ),
                    const Divider(
                      thickness: 1,
                      height: 1,
                      color: AppColors.gray10,
                    ),
                  ],
                ),
              ),
              if (status == 'Pending' && attachments.isNotEmpty)
                LeaveImageGridBottomSheet(
                  imageUrls: attachments,
                  buttonText: LanguageManager().get('view_attachments'),
                ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 12),
              //   child: Center(
              //     child: GestureDetector(
              //       onTap: () {
              //         showModalBottomSheet(
              //           context: context,
              //           builder: (context) => Container(),
              //         );
              //       },
              //       child: Text(
              //         'View Attachments',
              //         style: TextStyle(
              //           fontSize: 14 * textScale,
              //           // decoration: TextDecoration.underline,
              //           color: AppColors.primary,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(height: Responsive.scaleHeight(20)),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 38.0,
                  vertical: 10,
                ),
                child: MyCoButton(
                  onTap: () => Navigator.pop(context),
                  title: 'CLOSE',
                  isShadowBottomLeft: true,
                  boarderRadius: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    if (value.trim().isEmpty) return const SizedBox.shrink();
    final double textScale = Responsive.getResponsiveText(context);
    return Padding(
      padding: EdgeInsets.all(Responsive.scaleHeight(8)),
      child: Row(
        children: [
          Icon(icon, size: Responsive.scaleWidth(18), color: Colors.grey[700]),
          SizedBox(width: Responsive.scaleWidth(8)),
          Text('$label :', style: TextStyle(fontSize: 13 * textScale)),
          SizedBox(width: Responsive.scaleWidth(4)),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13 * textScale,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabHeader(BuildContext context) {
    final double textScale = Responsive.getResponsiveText(context);
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: Responsive.scaleHeight(12)),
            decoration: BoxDecoration(
              color: detailColor.withValues(alpha: 0.1),
              border: const Border.symmetric(
                horizontal: BorderSide(color: AppColors.gray10, width: 2),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '$leaveType - $paidUnpaid',
              style: TextStyle(
                fontSize: 14 * textScale,
                fontWeight: FontWeight.w600,
                color: detailColor,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 0.052 * Responsive.getHeight(context),
          child: const VerticalDivider(
            color: AppColors.gray10,
            width: 1,
            thickness: 2,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: Responsive.scaleHeight(12)),
            decoration: BoxDecoration(
              color: detailColor.withValues(alpha: 0.1),
              border: const Border.symmetric(
                horizontal: BorderSide(color: AppColors.gray10, width: 2),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              leaveDayView.isNotEmpty && leaveDuration.isNotEmpty
                  ? '$leaveDayView ($leaveDuration)'
                  : leaveDayView,
              style: TextStyle(
                fontSize: 14 * textScale,
                fontWeight: FontWeight.w600,
                color: detailColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabelValueRow(BuildContext context, String label, String value) {
    if (value.trim().isEmpty) return const SizedBox.shrink();
    final double textScale = Responsive.getResponsiveText(context);
    return Padding(
      padding: EdgeInsets.all(Responsive.scaleHeight(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12 * textScale,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(value, style: TextStyle(fontSize: 13 * textScale)),
          ),
        ],
      ),
    );
  }

  Widget _buildLabelValueColumn(
    BuildContext context,
    String label,
    String value,
  ) {
    if (value.trim().isEmpty) return const SizedBox.shrink();
    final double textScale = Responsive.getResponsiveText(context);
    return Padding(
      padding: EdgeInsets.all(Responsive.scaleHeight(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12 * textScale,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Responsive.scaleHeight(4)),
          Text(value, style: TextStyle(fontSize: 13 * textScale)),
        ],
      ),
    );
  }

  Color getStatusColor(String status, {required bool isAutoLeave}) {
    if (isAutoLeave) return Colors.blue;
    switch (status.toUpperCase()) {
      case 'APPROVED':
        return Colors.green;
      case 'REJECTED':
        return Colors.red;
      case 'PENDING':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}

class StatusBadge extends StatelessWidget {
  final String status;
  final Color borderColor;
  final Color textColor;
  final Color backgroundColor;
  final double? fontSize;
  final bool? isAutoLeave;

  const StatusBadge({
    required this.status,
    required this.borderColor,
    required this.textColor,
    this.backgroundColor = Colors.transparent,
    this.fontSize,
    this.isAutoLeave,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double scale = Responsive.getResponsiveText(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.scaleWidth(12),
        vertical: Responsive.scaleHeight(6),
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Text(
        (isAutoLeave ?? false) ? 'Auto Leave' : status,
        style: TextStyle(
          color: textColor,
          fontSize: (fontSize ?? 12) * scale,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ApprovalChip extends StatelessWidget {
  final String name;
  final String status;

  const ApprovalChip({required this.name, required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    String statusText;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    switch (status) {
      case '1':
        backgroundColor = colorScheme.secondary.withValues(alpha: 0.2);
        textColor = colorScheme.secondary;
        statusText = name;
        break;
      case '2':
        backgroundColor = colorScheme.error.withValues(alpha: 0.2);
        textColor = colorScheme.error;
        statusText = name;
        break;
      default:
        backgroundColor = colorScheme.outline.withValues(alpha: 0.2);
        textColor = colorScheme.onSurfaceVariant;
        statusText = name;
        break;
    }

    return Chip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(statusText, style: TextStyle(color: textColor)),
          Icon(Icons.check, color: textColor),
        ],
      ),
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: textColor.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
