import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/idea_box/presentation/widgets/common_container.dart';
import 'package:myco_flutter/features/work_allocation/data/models/request/task_approval_request.dart';
import 'package:myco_flutter/features/work_allocation/domain/entities/get_assignee_entity.dart';
import 'package:myco_flutter/features/work_allocation/presentation/bloc/assign_work_bloc.dart';
import 'package:myco_flutter/features/work_allocation/presentation/bloc/assign_work_event.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';

class ApprovalConfirmationSheet extends StatelessWidget {
  final GetAssigneeResponseEntity assignee;

  const ApprovalConfirmationSheet({
    required this.assignee,
    super.key,
  });

  /// Now returns Future<T?> so you can use `.then()` on it.
  static Future<T?> show<T>(
      BuildContext context,
      GetAssigneeResponseEntity assignee,
      ) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      builder: (_) => ApprovalConfirmationSheet(
        assignee: assignee,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => CommonCard(
    title: 'Are you sure you want to approve this task?',
    headerColor: AppTheme.getColor(context).secondary,
    bottomWidget: Column(
      children: [
        SvgPicture.asset(
          'assets/icons/approve_task.svg',
          height: 80 * Responsive.getResponsive(context),
        ),
        SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16 * Responsive.getResponsive(context),
            vertical: 12 * Responsive.getResponsive(context),
          ),
          child: Row(
            children: [
              Expanded(
                child: MyCoButton(
                  title: 'No',
                  height: 45 * Responsive.getResponsive(context),
                  onTap: () {
                    // Return false when user taps No
                    Navigator.pop(context, false);
                  },
                  backgroundColor: AppTheme.getColor(context).onPrimary,
                  textStyle: TextStyle(
                    color: AppTheme.getColor(context).primary,
                    fontWeight: FontWeight.w600,
                  ),
                  borderColor: AppTheme.getColor(context).primary,
                  boarderRadius: 20 * Responsive.getResponsive(context),
                ),
              ),
              SizedBox(width: 16 * Responsive.getResponsive(context)),
              Expanded(
                child: MyCoButton(
                  title: LanguageManager().get('yes'),
                  height: 45 * Responsive.getResponsive(context),
                  onTap: () async {
                    final companyId = await PreferenceManager().getCompanyId();
                    final request = TaskApprovalRequest(
                      taskApproval: 'taskApproval',
                      companyId: companyId,
                      assignedEngineerId: assignee.assignedEngineerId,
                      workAllocationId: assignee.workAllocationId,
                      engineerStatus: '1',
                      engineerRemark: '',
                      hodId: assignee.hodId,
                      projectName: assignee.projectName,
                      workCategoryName: assignee.workCategoryName,
                      assignedEngineerName: assignee.userFullName,
                      workAllocationAddAccess: '',
                      hodName: assignee.userFullName,
                    );

                    context.read<AssignWorkBloc>().add(
                      ApproveTaskEvent(request),
                    );

                    if (context.mounted) {
                      // Return true when user taps Yes
                      Navigator.pop(context, true);
                    }
                  },
                  backgroundColor: AppTheme.getColor(context).primary,
                  textStyle: TextStyle(
                    color: AppTheme.getColor(context).onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  boarderRadius: 20 * Responsive.getResponsive(context),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
