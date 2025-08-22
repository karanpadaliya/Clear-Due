import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/work_allocation/data/models/request/task_approval_request.dart';
import 'package:myco_flutter/features/work_allocation/domain/entities/get_assignee_entity.dart';
import 'package:myco_flutter/features/work_allocation/presentation/bloc/assign_work_bloc.dart';
import 'package:myco_flutter/features/work_allocation/presentation/bloc/assign_work_event.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';

class DenyReasonBottomSheet extends StatefulWidget {
  final GetAssigneeResponseEntity assignee;
  final VoidCallback onDenied;

  const DenyReasonBottomSheet({
    super.key,
    required this.assignee,
    required this.onDenied,
  });

  static void show(
    BuildContext context,
    GetAssigneeResponseEntity assignee, {
    required VoidCallback onDenied,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: DenyReasonBottomSheet(assignee: assignee, onDenied: onDenied),
      ),
    );
  }

  @override
  State<DenyReasonBottomSheet> createState() => _DenyReasonBottomSheetState();
}

class _DenyReasonBottomSheetState extends State<DenyReasonBottomSheet> {
  final TextEditingController reasonController = TextEditingController();
  bool isSubmitting = false;

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: MediaQuery.of(context).viewInsets.add(const EdgeInsets.all(20)),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        NewTextField(
          label: 'reason',
          controller: reasonController,
          maxLines: 3,
          hintText: 'reason_enter',
          isRequired: true,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: MyCoButton(
                title: 'Close',
                onTap: () => Navigator.pop(context),
                borderColor: AppTheme.getColor(context).primary,
                backgroundColor: AppTheme.getColor(context).onPrimary,
                textStyle: TextStyle(
                  color: AppTheme.getColor(context).onSurface,
                ),
                height: 0.045 * Responsive.getHeight(context),
                boarderRadius: 25 * Responsive.getResponsive(context),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: MyCoButton(
                title: isSubmitting ? 'Submitting...' : 'Submit',
                onTap: isSubmitting ? null : _submitDenial,
                backgroundColor: AppTheme.getColor(context).primary,
                textStyle: TextStyle(
                  color: AppTheme.getColor(context).onPrimary,
                ),
                height: 0.045 * Responsive.getHeight(context),
                boarderRadius: 25 * Responsive.getResponsive(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    ),
  );

  Future<void> _submitDenial() async {
    final reason = reasonController.text.trim();

    if (reason.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: CustomText('enter_reason', isKey: true),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => isSubmitting = true);

    final companyId = await PreferenceManager().getCompanyId();

    final request = TaskApprovalRequest(
      taskApproval: 'taskApproval',
      companyId: companyId,
      assignedEngineerId: widget.assignee.assignedEngineerId,
      workAllocationId: widget.assignee.workAllocationId,
      engineerStatus: '2',
      engineerRemark: reason,
      hodId: widget.assignee.hodId,
      projectName: widget.assignee.projectName,
      workCategoryName: widget.assignee.workCategoryName,
      assignedEngineerName: widget.assignee.userFullName,
      workAllocationAddAccess: '0',
      hodName: widget.assignee.userFullName,
    );

    context.read<AssignWorkBloc>().add(DenyTaskEvent(request));

    if (context.mounted) {
      Navigator.pop(context); // close the bottom sheet
      widget.onDenied(); // notify parent
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: CustomText('Task Denied'),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() => isSubmitting = false);
  }
}
