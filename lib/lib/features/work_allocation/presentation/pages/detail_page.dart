import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/core/utils/util.dart';
import 'package:myco_flutter/features/work_allocation/data/models/request/get_assignee_details_request.dart';
import 'package:myco_flutter/features/work_allocation/data/models/request/hod_approval_request.dart';
import 'package:myco_flutter/features/work_allocation/data/models/request/task_completion_request.dart';
import 'package:myco_flutter/features/work_allocation/domain/entities/get_assignee_entity.dart';
import 'package:myco_flutter/features/work_allocation/presentation/bloc/assign_work_bloc.dart';
import 'package:myco_flutter/features/work_allocation/presentation/bloc/assign_work_event.dart';
import 'package:myco_flutter/features/work_allocation/presentation/bloc/assign_work_state.dart';
import 'package:myco_flutter/features/work_allocation/presentation/bloc/work_allocation/work_allocation_bloc.dart';
import 'package:myco_flutter/features/work_allocation/presentation/bloc/work_allocation/work_allocation_event.dart';
import 'package:myco_flutter/features/work_allocation/presentation/bloc/work_allocation/work_allocation_state.dart';
import 'package:myco_flutter/features/work_allocation/presentation/bottom_sheet/approval_confirmation_sheet.dart';
import 'package:myco_flutter/features/work_allocation/presentation/bottom_sheet/completion_bottom_sheet.dart';
import 'package:myco_flutter/features/work_allocation/presentation/bottom_sheet/completion_remark_bottom_sheet.dart';
import 'package:myco_flutter/features/work_allocation/presentation/bottom_sheet/deny_reason_bottom_sheet.dart';
import 'package:myco_flutter/features/work_allocation/presentation/bottom_sheet/reassign_bottom_sheet.dart';
import 'package:myco_flutter/features/work_allocation/presentation/pages/detail_page_shimmer.dart';
import 'package:myco_flutter/features/work_allocation/presentation/widgets/work_detail_card.dart';
import 'package:myco_flutter/widgets/common_card.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_cached_network_image.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_vertical_stepper.dart';

class DetailPage extends StatefulWidget {
  final String workAllocationId;

  const DetailPage({required this.workAllocationId, super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String? currentUserId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Responsive.init(context);
  }

  @override
  void initState() {
    super.initState();
    _fetchAssigneeDetails();
  }

  Future<void> _fetchAssigneeDetails() async {
    final prefs = PreferenceManager();
    final companyId = await prefs.getCompanyId();
    currentUserId = await prefs.getUserId();

    if (companyId != null) {
      final request = GetAssigneeDetailsRequest(
        getAssigneeDetails: 'getAssigneeDetails',
        companyId: companyId,
        workAllocationAddAccess: '',
        workAllocationId: widget.workAllocationId,
      );
      context.read<WorkAllocationBloc>().add(
        FetchAssigneeDetailsEvent(request),
      );
    }
  }

  List<StepData> getTimelineStepsFromModel(GetAssigneeResponseEntity assignee) {
    final List<StepData> steps = [];
    final engineerStatus = (assignee.engineerStatus ?? '').toLowerCase();
    final isPending = engineerStatus == '0';
    final isApproved = engineerStatus == '1';
    final isDenied = engineerStatus == '2';

    if (isDenied) {
      steps.add(
        StepData(
          title: 'PENDING',
          status: StepStatus.denied,
          isStepIconShow: false,
        ),
      );
      steps.add(
        StepData(
          title: 'DENIED',
          status: StepStatus.denied,
          details: [
            StepDetail(
              title: 'Remark',
              description: assignee.engineerRemark ?? '-',
            ),
          ],
        ),
      );
      return steps;
    }

    final isCompleted =
        (assignee.completionDateByEngg?.trim().isNotEmpty ?? false) ||
        (assignee.engineerCompletionRemark?.trim().isNotEmpty ?? false);

    final isAuthorized =
        (assignee.authorizedDateByHodView?.trim().isNotEmpty ?? false) &&
        (assignee.completionRemark?.trim().isNotEmpty ?? false) &&
        (assignee.hodCompletionRemark?.trim().isNotEmpty ?? false);

    steps.add(
      StepData(
        title: 'PENDING',
        status: isPending ? StepStatus.pending : StepStatus.completed,
        isStepIconShow: false,
      ),
    );
    steps.add(
      StepData(
        title: 'APPROVED',
        status: isApproved ? StepStatus.approved : StepStatus.inActive,
      ),
    );
    steps.add(
      StepData(
        title: 'COMPLETED',
        status: isCompleted ? StepStatus.completed : StepStatus.inActive,
        details:
            (assignee.completionDateByEnggView?.trim().isNotEmpty ?? false) ||
                (assignee.completionRemark?.trim().isNotEmpty ?? false)
            ? [
                if ((assignee.completionDateByEnggView?.trim().isNotEmpty ??
                    false))
                  StepDetail(
                    title: LanguageManager().get('date'),
                    description: assignee.completionDateByEnggView ?? '',
                  ),
                if ((assignee.completionRemark?.trim().isNotEmpty ?? false))
                  StepDetail(
                    title: LanguageManager().get('remark'),
                    description: assignee.completionRemark ?? '',
                  ),
              ]
            : [],
      ),
    );
    steps.add(
      StepData(
        title: 'AUTHORIZED',
        status: isAuthorized ? StepStatus.completed : StepStatus.inActive,
        details: isAuthorized
            ? [
                StepDetail(
                  title: LanguageManager().get('date'),
                  description: assignee.authorizedDateByHodView ?? '',
                ),
                StepDetail(
                  title: 'completion_remark',
                  description: assignee.completionRemark ?? '',
                ),
                StepDetail(
                  title: LanguageManager().get('remark'),
                  description: assignee.hodCompletionRemark ?? '',
                ),
              ]
            : [],
      ),
    );
    return steps;
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.getResponsive(context);
    return Scaffold(
      appBar: const CustomAppbar(title: 'work_allocation', isKey: true),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AssignWorkBloc, AssignWorkState>(
            listener: (context, state) {
              if (state is TaskApprovalSuccess ||
                  state is TaskDenySuccess ||
                  state is TaskCompletionSuccess) {
                _fetchAssigneeDetails();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Status updated successfully!')),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<WorkAllocationBloc, WorkAllocationState>(
          builder: (context, state) {
            if (state is WorkAllocationLoading) {
              return const DetailPageShimmer(); // full end-to-end shimmer
            }

            if (state is WorkAllocationError) {
              return Center(child: Text(state.error));
            }

            if (state is AssigneeDetailsLoaded) {
              final assignee = state.assignee;

              final isAssignedByMe =
                  assignee.assignedEngineerId != currentUserId;
              final titleText = isAssignedByMe
                  ? LanguageManager().get('assign_by')
                  : LanguageManager().get('assign_to');
              final isCurrentUserHOD =
                  (assignee.hodId ?? '') == (currentUserId ?? '');
              final engineerStatus = (assignee.engineerStatus ?? '')
                  .toLowerCase();
              final isReassigned =
                  (assignee.isReassigned ?? '').toLowerCase() == '0';
              final showReassign =
                  isCurrentUserHOD && engineerStatus == '2' && isReassigned;
              final completionDateByEngg = assignee.completionDateByEngg
                  ?.trim();
              final authorizedDateByHod = assignee.authorizedDateByHod?.trim();
              final showMarkComplete =
                  !isCurrentUserHOD && engineerStatus == '0';
              final showAuthorize =
                  isCurrentUserHOD &&
                  completionDateByEngg?.isNotEmpty == true &&
                  (authorizedDateByHod?.isEmpty ?? true);

              final shouldHideAll =
                  engineerStatus == '2' ||
                  ((completionDateByEngg?.isNotEmpty == true) &&
                      !showAuthorize &&
                      !showReassign &&
                      !showMarkComplete);
              final steps = getTimelineStepsFromModel(assignee);
              final isEngineerApproved = engineerStatus == '1';
              final isEngineerAlreadyCompleted =
                  completionDateByEngg?.isNotEmpty == true;
              final showEngineerButtons =
                  !isCurrentUserHOD && engineerStatus == '0';

              return RefreshIndicator(
                onRefresh: _fetchAssigneeDetails,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          VariableBag.screenHorizontalPadding * responsive,
                      vertical:
                          VariableBag.formContentSpacingVertical * responsive,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Profile Card
                        CommonCard(
                          headerPadding: EdgeInsets.only(
                            top: 13 * responsive,
                            bottom: 13 * responsive,
                            left: 20 * responsive,
                          ),
                          title: titleText,
                          bottomWidget: Padding(
                            padding: EdgeInsets.only(
                              top: 17 * responsive,
                              bottom: 14 * responsive,
                              left: 16 * responsive,
                            ),
                            child: Row(
                              children: [
                                CustomCachedNetworkImage(
                                  imageUrl: assignee.userProfilePic ?? '',
                                  isCircular: true,
                                  height: 50 * responsive,
                                  width: 50 * responsive,
                                  errorWidget: Container(
                                    width: 50 * responsive,
                                    height: 50 * responsive,
                                    color: Colors.grey.shade300,
                                    child: Center(
                                      child: CustomText(
                                        Util.getInitials(
                                          assignee.userFullName
                                                      ?.trim()
                                                      .isNotEmpty ==
                                                  true
                                              ? assignee.userFullName!
                                              : 'NA',
                                        ),
                                        fontSize:
                                            20 *
                                            Responsive.getResponsiveText(
                                              context,
                                            ),
                                        fontWeight: FontWeight.w700,
                                        color: AppTheme.getColor(
                                          context,
                                        ).primary,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 0.03 * Responsive.getWidth(context),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      assignee.userFullName ?? 'No_UserName',
                                      fontSize: 14 * responsive,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.getColor(
                                        context,
                                      ).onSurfaceVariant,
                                    ),
                                    CustomText(
                                      assignee.userDesignation ??
                                          'No_Designation',
                                      fontSize: 12 * responsive,
                                      color: AppTheme.getColor(context).outline,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    CustomText(
                                      '${assignee.departmentName ?? ''} - ${assignee.branchName ?? ''}',
                                      fontSize: 12 * responsive,
                                      fontWeight: FontWeight.w500,
                                      color: AppTheme.getColor(context).outline,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 16 * responsive),

                        /// Work Detail Card
                        WorkDetailCard(workDetail: assignee),

                        SizedBox(height: 25 * responsive),

                        /// Stepper
                        CustomVerticalStepper(steps: steps),

                        SizedBox(height: 24 * responsive),

                        if (!shouldHideAll)
                          Column(
                            children: [
                              if (showReassign)
                                MyCoButton(
                                  title: LanguageManager().get(
                                    're_assign_work',
                                  ),
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      builder: (context) => ReassignBottomSheet(
                                        onSubmit: (_, __) {},
                                      ),
                                    );
                                  },
                                ),

                              if (showEngineerButtons)
                                Row(
                                  children: [
                                    Expanded(
                                      child: MyCoButton(
                                        title: LanguageManager().get('deny'),
                                        onTap: () {
                                          DenyReasonBottomSheet.show(
                                            context,
                                            assignee,
                                            onDenied: () {},
                                          );
                                        },
                                        boarderRadius:
                                            VariableBag.buttonBorderRadius,
                                        borderColor: AppTheme.getColor(
                                          context,
                                        ).error,
                                        backgroundColor: Util.applyOpacity(
                                          AppTheme.getColor(
                                            context,
                                          ).surfaceBright,
                                          0.1,
                                        ),
                                        textStyle: TextStyle(
                                          color: AppTheme.getColor(
                                            context,
                                          ).error,
                                          fontSize:
                                              13.5 *
                                              Responsive.getResponsiveText(
                                                context,
                                              ),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        isShadowBottomLeft: true,
                                        height:
                                            0.050 *
                                            Responsive.getHeight(context),
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          VariableBag.buttonRowSpacing *
                                          responsive,
                                    ),
                                    Expanded(
                                      child: MyCoButton(
                                        title: LanguageManager().get('approve'),
                                        onTap: () {
                                          ApprovalConfirmationSheet.show(
                                            context,
                                            assignee,
                                          ).then((_) {
                                            _fetchAssigneeDetails();
                                          });
                                        },
                                        backgroundColor: AppTheme.getColor(
                                          context,
                                        ).secondary,
                                        boarderRadius:
                                            VariableBag.buttonBorderRadius,
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        isShadowBottomLeft: true,
                                        height:
                                            0.050 *
                                            Responsive.getHeight(context),
                                      ),
                                    ),
                                  ],
                                ),

                              if (!isCurrentUserHOD &&
                                  isEngineerApproved &&
                                  !isEngineerAlreadyCompleted)
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: MyCoButton(
                                    title: LanguageManager().get(
                                      'mark_as_completed',
                                    ),
                                    onTap: () async {
                                      CompletionBottomSheet.show(
                                        context,
                                        onComplete: (date, remark) async {
                                          final companyId =
                                              await PreferenceManager()
                                                  .getCompanyId();
                                          if (companyId == null ||
                                              companyId.isEmpty)
                                            return;
                                          final request = TaskCompletionRequest(
                                            taskCompletion: 'taskCompletion',
                                            companyId: companyId,
                                            workAllocationId:
                                                assignee.workAllocationId ?? '',
                                            workAllocationAddAccess: '1',
                                            assignedEngineerId:
                                                assignee.assignedEngineerId ??
                                                '',
                                            hodId: assignee.hodId ?? '',
                                            assignedEngineerName:
                                                assignee.userFullName ?? '',
                                            completionDateByEng: date,
                                            engineerCompletionRemark: remark,
                                          );
                                          context.read<AssignWorkBloc>().add(
                                            CompleteTaskEvent(request: request),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),

                              if (showAuthorize)
                                MyCoButton(
                                  title: LanguageManager().get(
                                    'authorize_work',
                                  ),
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      builder: (context) =>
                                          CompletionRemarkBottomSheet(
                                            onSubmit: (remark) async {
                                              final companyId =
                                                  await PreferenceManager()
                                                      .getCompanyId();
                                              if (companyId == null ||
                                                  companyId.isEmpty)
                                                return;
                                              final request = HodApprovalRequest(
                                                hodApproval: 'Approved',
                                                companyId: companyId,
                                                assignedEngineerId:
                                                    assignee.assignedEngineerId,
                                                workAllocationId:
                                                    assignee.workAllocationId,
                                                hodId: assignee.hodId,
                                                hodCompletionRemark: remark,
                                                hodName: '',
                                                completionRemark: assignee
                                                    .engineerCompletionRemark,
                                                assignedEngineerName:
                                                    assignee.userFullName,
                                                workAllocationAddAccess: '1',
                                              );
                                              context
                                                  .read<AssignWorkBloc>()
                                                  .add(
                                                    ApproveByHodEvent(
                                                      request: request,
                                                    ),
                                                  );
                                            },
                                          ),
                                    );
                                  },
                                ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
