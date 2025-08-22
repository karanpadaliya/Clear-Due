import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/leave/domain/entities/leave_history_response_entity.dart';
import 'package:myco_flutter/features/leave/domain/use_case/leave_use_case.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/leave_bloc.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/leave_event.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/leave_screen_bloc/leave_screen_bloc.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/leave_screen_bloc/leave_screen_event.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/leave_screen_bloc/leave_screen_state.dart';
import 'package:myco_flutter/features/leave/presentation/leave_utils/leave_skeloton/short_leave_card_skeleton.dart';
import 'package:myco_flutter/features/leave/presentation/widgets/auto_leave_change.dart';
import 'package:myco_flutter/features/leave/presentation/widgets/custom_fab_menu.dart';
import 'package:myco_flutter/features/leave/presentation/widgets/leave_action_button.dart';
import 'package:myco_flutter/features/leave/presentation/widgets/leave_card.dart';
import 'package:myco_flutter/features/leave/presentation/widgets/leave_detail_bottom_sheet.dart';
import 'package:myco_flutter/features/leave/presentation/widgets/leave_filter_bottom_sheet.dart';
import 'package:myco_flutter/features/leave/presentation/widgets/sandwich_leave_card.dart';
import 'package:myco_flutter/features/leave/presentation/widgets/short_leave_card.dart';
import 'package:myco_flutter/widgets/custom_alert_dialog.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_month_year_picker_header/month_year_header.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button_theme.dart';

class LeaveScreen extends StatelessWidget {
  const LeaveScreen({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider<LeaveBloc>(
        create: (ctx) => LeaveBloc(ctx.read<LeaveUseCase>()),
      ),
      BlocProvider<LeaveScreenBloc>(
        create: (ctx) =>
            LeaveScreenBloc(ctx.read<LeaveBloc>())..add(LoadLeaves()),
      ),
    ],
    child: const LeaveScreenView(),
  );
}

class LeaveScreenView extends StatefulWidget {
  const LeaveScreenView({super.key});

  @override
  State<LeaveScreenView> createState() => _LeaveScreenViewState();
}

class _LeaveScreenViewState extends State<LeaveScreenView> {
  final _fabKey = GlobalKey<ExpandableFabState>();

  // ✅ ADDED: Key for the RefreshIndicator
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  // ✅ ADDED: Function to handle the refresh action
  Future<void> _handleRefresh() async {
    // Dispatch the LoadLeaves event to the BLoC. The BlocBuilder will
    // then manage the UI state, showing the skeleton loader while
    // isLoading is true.
    context.read<LeaveScreenBloc>().add(LoadLeaves());
  }

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<LeaveScreenBloc, LeaveScreenState>(
    builder: (context, uiState) {
      final filteredLeaves = _filterLeaves(uiState.leaves, uiState.filter);

      return Scaffold(
        appBar: CustomAppbar(
          isKey: true,
          title: 'leave_balance',
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyCoButton(
                onTap: () => _showFilterBottomSheet(context, uiState.filter),
                textStyle: TextStyle(
                  fontSize: 12 * Responsive.getResponsiveText(context),
                  color: MyCoButtonTheme.whitemobileBackgroundColor,
                ),
                title: uiState.filter,
                height: 0.035 * Responsive.getHeight(context),
                width: 0.25 * Responsive.getWidth(context),
                imagePosition: AxisDirection.right,
                image: const Icon(
                  Icons.keyboard_arrow_down,
                  color: MyCoButtonTheme.whitemobileBackgroundColor,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
              child: Column(
                children: [
                  MonthYearHeader(
                    startYear: 2025,
                    endYear: 2026,
                    iconSize: 0.02 * Responsive.getHeight(context),
                    onChanged: (month, year) {
                      context.read<LeaveScreenBloc>().add(
                        ChangeMonthYear(month, year),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 5,
                        child: LeaveActionButton(
                          title: LanguageManager().get('leave_balance'),
                          onTap: () => context.push(RoutePaths.leaveBalance),
                        ),
                      ),
                      if (uiState.isTeamLeave)
                        Row(
                          children: [
                            SizedBox(
                              width: 0.01 * Responsive.getWidth(context),
                            ),
                            LeaveActionButton(
                              title: LanguageManager().get('my_team_leaves'),
                              onTap: () =>
                                  context.push(RoutePaths.teamLeaveBalance),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              // ✅ MODIFIED: Wrapped the list view area with RefreshIndicator
              child: RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: _handleRefresh,
                color: AppTheme.getColor(context).primary,

                child: uiState.isLoading
                    ? ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        itemCount: 3,
                        itemBuilder: (_, __) => const ShortLeaveCardSkeleton(),
                      )
                    : filteredLeaves.isEmpty
                    ? _buildEmptyStateWithRetry()
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        itemCount: filteredLeaves.length,
                        itemBuilder: (context, index) {
                          final leave = filteredLeaves[index];

                          if (leave.sandwichLeave == false &&
                              leave.shortLeave == true) {
                            return ShortLeaveCard(
                              leave: _convertToShortLeaveEntry(leave),
                              onDelete:
                                  ({
                                    required fullName,
                                    required sandwichLeaveId,
                                    required userId,
                                    required leaveDate,
                                  }) {
                                    // ✅ Capture bloc before showModalBottomSheet
                                    final leaveBloc = context.read<LeaveBloc>();
                                    final leaveScreenBloc = context
                                        .read<LeaveScreenBloc>();

                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      builder: (modalContext) => MultiBlocProvider(
                                        providers: [
                                          BlocProvider.value(value: leaveBloc),
                                          BlocProvider.value(
                                            value: leaveScreenBloc,
                                          ),
                                        ],
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(
                                              context,
                                            ).viewInsets.bottom,
                                          ),
                                          child: CustomAlertDialog(
                                            alertType: AlertType.delete,
                                            content: LanguageManager().get(
                                              'delete_leave',
                                            ),
                                            confirmText: LanguageManager().get(
                                              'ok',
                                            ),
                                            cancelText: LanguageManager().get(
                                              'cancel',
                                            ),
                                            onCancel: () {
                                              Navigator.of(modalContext).pop();
                                            },
                                            onConfirm: () {
                                              leaveBloc.add(
                                                DeleteShortLeave(
                                                  sandwichLeaveId ?? '',
                                                  leaveDate ?? '',
                                                  userId ?? '',
                                                  fullName ?? '',
                                                ),
                                              );

                                              // Add a small delay before reloading to allow the delete operation to complete
                                              Future.delayed(
                                                const Duration(
                                                  milliseconds: 300,
                                                ),
                                                () {
                                                  leaveScreenBloc.add(
                                                    LoadLeaves(),
                                                  );
                                                },
                                              );

                                              Navigator.of(modalContext).pop();
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                            );
                          } else if (leave.sandwichLeave == true &&
                              leave.shortLeave == false) {
                            return SandwichLeaveCard(
                              leave: _convertToSandwichLeaveEntry(leave),
                              onEdit: ({required leave}) {
                                final leaveBloc = BlocProvider.of<LeaveBloc>(
                                  context,
                                );

                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(24),
                                    ),
                                  ),
                                  builder: (bottomSheetContext) => Padding(
                                    padding: EdgeInsets.only(
                                      top: 16,
                                      bottom: MediaQuery.of(
                                        bottomSheetContext,
                                      ).viewInsets.bottom,
                                    ),
                                    child: BlocProvider.value(
                                      value: leaveBloc,
                                      child: SingleChildScrollView(
                                        child: SafeArea(
                                          child: DialogChangeAutoLeave(
                                            isUser: false,
                                            isUserSandwichLeaveUpdate: true,
                                            updateStatus: true,
                                            leaveBloc: leaveBloc,
                                            leaveHistory: leave,
                                            onSubmit: (editLeaveSandwichData) {
                                              final String paid = '0';
                                              _changeSandwichLeave(
                                                context,
                                                editLeaveSandwichData.userId ??
                                                    '',
                                                paid,
                                                editLeaveSandwichData.leaveId ??
                                                    '',
                                                editLeaveSandwichData
                                                        .leaveName ??
                                                    '',
                                                editLeaveSandwichData
                                                    .sandwichId,
                                                editLeaveSandwichData.userId ??
                                                    '',
                                                editLeaveSandwichData
                                                        .useFullName ??
                                                    '',
                                                editLeaveSandwichData
                                                    .leavePercentage
                                                    .toString(),
                                              );
                                              // Navigator.of(context).pop();
                                            },
                                            onClose: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return LeaveCard(
                              leave: _convertToLeaveEntry(leave),
                              onDelete: ({leaveId}) {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => Padding(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(
                                        context,
                                      ).viewInsets.bottom,
                                    ),
                                    child: CustomAlertDialog(
                                      alertType: AlertType.delete,
                                      content: LanguageManager().get(
                                        'delete_leave',
                                      ),
                                      confirmText: LanguageManager().get('ok'),
                                      cancelText: LanguageManager().get(
                                        'cancel',
                                      ),
                                      onCancel: () {
                                        Navigator.of(context).pop();
                                      },
                                      onConfirm: () {
                                        _deleteLeaveRequest(
                                          context,
                                          leaveId ?? '',
                                        );
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                );
                              },
                              onEdit: ({required leave}) {
                                final isAutoChangeable =
                                    (leave.autoLeave ?? false) &&
                                    !(leave.isSalaryGenerated ?? false);
                                if (isAutoChangeable) {
                                  final leaveBloc = BlocProvider.of<LeaveBloc>(
                                    context,
                                  );

                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(24),
                                      ),
                                    ),
                                    builder: (bottomSheetContext) => Padding(
                                      padding: EdgeInsets.only(
                                        top: 16,
                                        bottom: MediaQuery.of(
                                          bottomSheetContext,
                                        ).viewInsets.bottom,
                                      ),
                                      child: BlocProvider.value(
                                        value: leaveBloc,
                                        child: SingleChildScrollView(
                                          child: SafeArea(
                                            child: DialogChangeAutoLeave(
                                              isUser: (leave.autoLeave == true),
                                              isUserSandwichLeaveUpdate:
                                                  (leave.autoLeave != true),
                                              updateStatus:
                                                  (leave.autoLeave != true),
                                              leaveBloc: leaveBloc,
                                              leaveHistory: leave,
                                              onSubmit: (leaveSubmitData) {
                                                String paid =
                                                    leaveSubmitData.isPaidLeave
                                                    ? '0'
                                                    : '1';
                                                final String attendanceId =
                                                    leave.attendanceId ?? '';
                                                final String extraDay =
                                                    bool.tryParse(
                                                          leave.isExtraDay
                                                              .toString(),
                                                        ) ==
                                                        true
                                                    ? '1'
                                                    : '0';

                                                _changeAutoLeave(
                                                  context,
                                                  leave.userId ?? '',
                                                  paid,
                                                  leaveSubmitData.leaveTypeId,
                                                  leave.leaveDate ?? '',
                                                  leaveSubmitData
                                                      .leaveDayTypeStatus,
                                                  extraDay,
                                                  leaveSubmitData
                                                      .isSpecialLeave,
                                                  attendanceId,
                                                  leave.leaveId ?? '',
                                                  leaveSubmitData
                                                      .leavePercentage
                                                      .toString(),
                                                );
                                                Navigator.of(context).pop();
                                              },
                                              onClose: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  context.push(RoutePaths.editLeaveScreen);
                                }
                              },
                            );
                          }
                        },
                      ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: CustomFabMenu(
          keyFab: _fabKey,
          items: [
            FabMenuItem(
              label: 'apply_leave',
              icon: Icon(
                Icons.event_available_outlined,
                color: AppTheme.getColor(context).primary,
                size: 0.02 * Responsive.getHeight(context),
              ),
              onTap: () => context.push(RoutePaths.addLeaveScreen),
            ),
            FabMenuItem(
              label: 'apply_short_leave',
              icon: Image.asset(
                'assets/images/short_apply_leave.png',
                width: 0.04 * Responsive.getWidth(context),
                height: 0.04 * Responsive.getHeight(context),
                fit: BoxFit.contain,
              ),
              onTap: () async {
                final result = await context.push(
                  RoutePaths.addShortLeaveScreen,
                );
                if (result == true) {
                  context.read<LeaveScreenBloc>().add(LoadLeaves());
                }
              },
            ),
          ],
        ),
      );
    },
  );

  List<LeaveHistoryEntity> _filterLeaves(
    List<LeaveHistoryEntity> leaves,
    String selectedFilter,
  ) {
    if (selectedFilter == 'All Leaves') return leaves;
    return leaves.where((leave) {
      if (selectedFilter == 'Paid Leaves') {
        return leave.paidUnpaidStatus == '0';
      } else if (selectedFilter == 'Unpaid Leaves') {
        return leave.paidUnpaidStatus == '1';
      }
      return true;
    }).toList();
  }

  void _showFilterBottomSheet(BuildContext context, String selectedFilter) {
    showLeaveFilterBottomSheet(context, selectedFilter, (newFilter) {
      context.read<LeaveScreenBloc>().add(ChangeFilter(newFilter));
    }, ['All Leaves', 'Paid Leaves', 'Unpaid Leaves']);
  }

  void _deleteShortLeave(
    BuildContext context,
    String shortLeaveId,
    String shortLeaveDate,
    String otherUserId,
    String otherUserName,
  ) {
    context.read<LeaveBloc>().add(
      DeleteShortLeave(
        shortLeaveId,
        shortLeaveDate,
        otherUserId,
        otherUserName,
      ),
    );
    context.read<LeaveScreenBloc>().add(LoadLeaves());
  }

  void _deleteLeaveRequest(BuildContext context, String leaveId) {
    context.read<LeaveBloc>().add(DeleteLeaveRequest(leaveId));
    context.read<LeaveScreenBloc>().add(LoadLeaves());
  }

  void _changeAutoLeave(
    BuildContext context,
    String userId,
    String paid,
    String leaveTypeId,
    String leaveDate,
    String leaveDay,
    String extraDay,
    String isSpecialDay,
    String attendanceId,
    String leaveId,
    String leavePercentage,
  ) {
    context.read<LeaveBloc>().add(
      ChangeAutoLeave(
        userId,
        paid,
        leaveTypeId,
        leaveDate,
        leaveDay,
        extraDay,
        isSpecialDay,
        attendanceId,
        leaveId,
        leavePercentage,
      ),
    );
    context.read<LeaveScreenBloc>().add(LoadLeaves());
  }

  void _changeSandwichLeave(
    BuildContext context,
    String userId,
    String paid,
    String leaveId,
    String leaveName,
    String sandwichId,
    String unitId,
    String userFullName,
    String leavePercentage,
  ) {
    context.read<LeaveBloc>().add(
      ChangeSandwichLeave(
        userId,
        paid,
        leaveId,
        leaveName,
        sandwichId,
        unitId,
        userFullName,
        leavePercentage,
      ),
    );
    context.read<LeaveScreenBloc>().add(LoadLeaves());
  }

  LeaveEntry _convertToLeaveEntry(LeaveHistoryEntity leave) => LeaveEntry(
    date: leave.leaveDateView ?? '',
    leaveType: leave.leaveTypeName ?? '',
    subType: leave.autoLeave == true ? 'Auto Leave' : 'Manual Leave',
    leaveTime: leave.shortLeaveTime ?? '',
    reason: leave.leaveReason ?? '',
    approvedBy: leave.approvedByName ?? '',
    status: leave.leaveStatusView ?? '',
    payStatus: leave.paidUnpaid ?? '',
    onViewDetailWidget: LeaveDetailBottomSheet(
      requestDate: leave.leaveCreatedDate ?? '',
      leaveDateView: leave.leaveDateView ?? '',
      leaveDayView: leave.leaveDayView ?? '',
      approvedByName: leave.approvedByName ?? '',
      leaveRequestedDate: leave.leaveRequestedDate ?? '',
      approvedDate: leave.leaveApprovedDate ?? '',
      leaveType: leave.leaveTypeName ?? '',
      leaveDuration: leave.halfDaySession ?? '',
      reason: (leave.autoLeave == true)
          ? leave.autoLeaveReason ?? ''
          : leave.leaveReason ?? '',
      altPhone: leave.leaveAlternateNumber ?? '',
      taskDependency: leave.leaveTaskDependency == true ? 'Yes' : 'No',
      status: leave.leaveStatusView ?? '',
      dependencyHandle: leave.leaveHandleDependency ?? '',
      attachments:
          leave.leaveAttachment
              ?.split(',')
              .where((e) => e.trim().isNotEmpty)
              .toList() ??
          [],
      detailColor: _getStatusColor(leave.leaveStatus, leave.autoLeave),
      autoLeave: leave.autoLeave ?? false,
      paidUnpaid: leave.paidUnpaid ?? '',
      isMultiLevelApproval: leave.isMultiLevelApproval ?? false,
      approvalUsers: leave.approvalUsers ?? [],
    ),
    leaveEntity: leave,
    headerColor: leave.leaveStatus ?? '',
    isAutoLeave: leave.autoLeave ?? false,
  );

  ShortLeaveEntry _convertToShortLeaveEntry(LeaveHistoryEntity leave) =>
      ShortLeaveEntry(
        date: leave.shortLeaveDateView ?? '',
        subType: LanguageManager().get('short_leave'),
        leaveTime: leave.shortLeaveTime ?? '',
        reason: leave.shortLeaveApplyReason ?? '',
        approvedBy: leave.shortLeaveStatusChangeName ?? '',
        status: leave.shortLeaveStatusView ?? '',
        rejectReason: leave.shortLeaveStatusChangeReason ?? '',
        detailColor: _getShortLeaveStatusColor(leave.shortLeaveStatus),
        leaveEntity: leave,
      );

  SandwichLeaveEntry _convertToSandwichLeaveEntry(LeaveHistoryEntity leave) =>
      SandwichLeaveEntry(
        date: leave.sandwichLeaveDateView ?? '',
        subType: LanguageManager().get('sandwich_leave'),
        reason: '${leave.prevLeaveDate}-${leave.nextLeaveDate}',
        status: 'Approved',
        isSalaryGenerated: leave.isSalaryGenerated ?? false,
        leaveEntity: leave,
      );

  static Color _getStatusColor(String? status, bool? autoLeave) {
    if (autoLeave == true) {
      return AppColors.primary;
    } else {
      switch (status) {
        case '1':
          return AppColors.secondary;
        case '2':
          return AppColors.red;
        default:
          return AppColors.spanishYellow;
      }
    }
  }

  static Color _getShortLeaveStatusColor(String? status) {
    switch (status) {
      case '1':
        return AppColors.secondary;
      case '2':
        return AppColors.red;
      default:
        return AppColors.spanishYellow;
    }
  }

  Widget _buildEmptyStateWithRetry() =>
      // Use a LayoutBuilder to get the screen height, ensuring the
      // content can be centered properly within a scrollable view.
      LayoutBuilder(
        builder: (context, constraints) => ListView(
          children: [
            Container(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LanguageManager().get('no_leave_history'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
