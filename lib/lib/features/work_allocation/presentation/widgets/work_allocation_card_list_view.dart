import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/core/utils/util.dart';
import 'package:myco_flutter/features/work_allocation/data/models/request/work_allocation_request.dart';
import 'package:myco_flutter/features/work_allocation/presentation/bloc/work_allocation/work_allocation_bloc.dart';
import 'package:myco_flutter/features/work_allocation/presentation/bloc/work_allocation/work_allocation_event.dart';
import 'package:myco_flutter/features/work_allocation/presentation/bloc/work_allocation/work_allocation_state.dart';
import 'package:myco_flutter/widgets/common_card.dart';
import 'package:myco_flutter/widgets/custom_cached_network_image.dart';
import 'package:myco_flutter/widgets/custom_common_row.dart';
import 'package:myco_flutter/widgets/custom_horizontal_stepper.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_no_data_widget.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:shimmer/shimmer.dart';

class WorkAllocationCardListView extends StatefulWidget {
  final String searchText;
  final int? selectedMonth;
  final int? selectedYear;

  const WorkAllocationCardListView({
    required this.searchText,
    this.selectedMonth,
    this.selectedYear,
    super.key,
  });

  @override
  State<WorkAllocationCardListView> createState() =>
      _WorkAllocationCardListViewState();
}

class _WorkAllocationCardListViewState
    extends State<WorkAllocationCardListView> {
  String? userId;
  String? companyId;
  final String _noData = 'no_data_found_web';

  @override
  void initState() {
    super.initState();
    if (widget.selectedYear != null) {
      _fetchWorkAllocationData(widget.selectedYear.toString());
    }
  }

  @override
  void didUpdateWidget(covariant WorkAllocationCardListView oldWidget) {
    super.didUpdateWidget(oldWidget);

    final yearChanged = widget.selectedYear != oldWidget.selectedYear;
    final monthChanged = widget.selectedMonth != oldWidget.selectedMonth;
    final searchChanged = widget.searchText != oldWidget.searchText;

    if (yearChanged || monthChanged || searchChanged) {
      if (widget.selectedYear != null) {
        _fetchWorkAllocationData(widget.selectedYear.toString());
      }
    }
  }

  //api calling ::- get work allocation
  Future<void> _fetchWorkAllocationData(String filterYear) async {
    final preferenceManager = GetIt.I<PreferenceManager>();
    companyId = await preferenceManager.getCompanyId();
    userId = await preferenceManager.getUserId();

    if (userId != null && companyId != null) {
      final request = WorkAllocationRequest(
        tag: 'getWorkAllocation',
        companyId: companyId,
        userId: userId,
        workAllocationAddAccess: '',
        filterMonth: false,
        filterYear: filterYear,
      );

      context.read<WorkAllocationBloc>().add(
        FetchWorkAllocationListEvent(request),
      );
    } else {
      debugPrint('Unable to load data.');
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<WorkAllocationBloc, WorkAllocationState>(
    builder: (context, state) {
      if (state is WorkAllocationInitial || state is WorkAllocationLoading) {
        // Shimmer effect
        return ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: CommonCard(
                title: '',
                headerColor: AppTheme.getColor(context).primary,
                headerPrefixIcon: AppAssets.calendarIcon,
                headerPrefixIconWidth: 20 * Responsive.getResponsive(context),
                showHeaderPrefixIcon: true,
                bottomWidget: Padding(
                  padding: EdgeInsets.all(
                    10 * Responsive.getResponsive(context),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50 * Responsive.getResponsive(context),
                            height: 50 * Responsive.getResponsive(context),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 12,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  width: 150,
                                  height: 10,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  width: 200,
                                  height: 10,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(color: AppTheme.getColor(context).secondary),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          itemCount: 4,

                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(color: AppTheme.getColor(context).secondary),
                      SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 80,
                              height: 10,
                              color: Colors.white,
                            ),
                            Container(
                              width: 80,
                              height: 10,
                              color: Colors.white,
                            ),
                            Container(
                              width: 80,
                              height: 10,
                              color: Colors.white,
                            ),
                            Container(
                              width: 80,
                              height: 10,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }

      if (state is WorkAllocationError) {
        return Center(child: CustomText(state.error));
      }

      if (state is WorkAllocationList) {
        final fullList = state.workAllocationList?.workAllocation ?? [];

        ///search filter
        final filteredList = fullList.where((item) {
          final query = widget.searchText.toLowerCase();
          final userName = item.userFullName?.toLowerCase() ?? _noData;
          final category = item.workCategoryName?.toLowerCase() ?? _noData;
          final project = item.projectName?.toLowerCase() ?? _noData;

          final matchesSearch =
              userName.contains(query) ||
              category.contains(query) ||
              project.contains(query);

          final parsedDate = DateTime.tryParse(item.startDate ?? _noData);
          final matchesMonth =
              widget.selectedMonth == null ||
              widget.selectedMonth == 0 ||
              (parsedDate?.month == widget.selectedMonth);
          final matchesYear =
              widget.selectedYear == null ||
              (parsedDate?.year == widget.selectedYear);

          return matchesSearch && matchesMonth && matchesYear;
        }).toList();

        if (filteredList.isEmpty) {
          return const Center(
            child: CustomNoDataWidget(
              // assetPath: 'assets/icons/search.svg',
              assetWidth: 60,
              assetHeight: 60,
              spacing: 8,
              message: 'No data found',
              messageColor: Colors.grey,
              messageFontSize: 16,
              messageFontWeight: FontWeight.w600,
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => _fetchWorkAllocationData(
            widget.selectedYear?.toString() ?? DateTime.now().year.toString(),
          ),
          child: ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final workAllocation = filteredList[index];

              final responsive = Responsive.getResponsive(context);

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonCard(
                  title: Util.formatDate(
                    originalDateTime: workAllocation.createdDate,
                    dateTimeOutputFormat: 'dd MMM yyyy, hh:mm a',
                  ),
                  headerColor: AppTheme.getColor(context).primary,
                  headerPrefixIcon: AppAssets.calendarIcon,
                  // headerPrefixIconHeight: 10,
                  headerPrefixIconWidth: 20 * Responsive.getResponsive(context),
                  showHeaderPrefixIcon: true,
                  bottomWidget: Padding(
                    padding: EdgeInsets.all(
                      10 * Responsive.getResponsive(context),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// assign to and view detail button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// assign to
                            CustomText(
                              LanguageManager().get('assign_to'),
                              fontSize: 12 * Responsive.getResponsive(context),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.getColor(context).primary,
                            ),

                            /// view details
                            MyCoButton(
                              onTap: () {
                                context.pushNamed(
                                  'detailPage',
                                  extra:
                                      workAllocation.workAllocationId ??
                                      _noData,
                                );
                              },
                              title: LanguageManager().get('view_details'),
                              textStyle: TextStyle(
                                fontSize:
                                    12 * Responsive.getResponsiveText(context),
                                fontWeight: FontWeight.w600,
                                color: AppTheme.getColor(context).onPrimary,
                              ),
                              height: 0.03 * Responsive.getHeight(context),
                              width: 0.25 * Responsive.getWidth(context),
                              backgroundColor: AppTheme.getColor(
                                context,
                              ).secondary,
                              borderColor: AppTheme.getColor(context).secondary,
                              boarderRadius: 23,
                              isShadowBottomLeft: true,
                            ),
                          ],
                        ),

                        /// personal details
                        Row(
                          spacing: 16 * Responsive.getResponsive(context),
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                35 * Responsive.getResponsive(context),
                              ),

                              ///person image
                              child: CustomCachedNetworkImage(
                                imageUrl:
                                    workAllocation.userProfilePic ?? _noData,
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
                                        workAllocation.userFullName
                                                    ?.trim()
                                                    .isNotEmpty ==
                                                true
                                            ? workAllocation.userFullName!
                                            : 'NA',
                                      ),
                                      fontSize:
                                          20 *
                                          Responsive.getResponsiveText(context),
                                      fontWeight: FontWeight.w700,
                                      color: AppTheme.getColor(context).primary,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              child: Column(
                                spacing: 2 * Responsive.getResponsive(context),
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ///person name
                                  CustomText(
                                    workAllocation.userFullName ?? _noData,
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                        12 *
                                        Responsive.getResponsiveText(context),
                                    color: AppTheme.getColor(
                                      context,
                                    ).onSurfaceVariant,
                                  ),

                                  ///designation
                                  CustomText(
                                    workAllocation.userDesignation ?? _noData,
                                    color: AppColors.gray,
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                        10 *
                                        Responsive.getResponsiveText(context),
                                  ),

                                  ///DepartmentName - BranchName
                                  CustomText(
                                    '${workAllocation.departmentName ?? _noData} - ${workAllocation.branchName ?? _noData}',
                                    color: AppColors.gray,
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                        10 *
                                        Responsive.getResponsiveText(context),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(color: AppTheme.getColor(context).secondary),

                        /// work category, project, start date, target date of completion
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              CommonRow(
                                title: 'work_category',
                                value:
                                    workAllocation.workCategoryName ?? _noData,

                                titleFontSize:
                                    14 * Responsive.getResponsiveText(context),
                                // fontWeight: FontWeight.w600,
                                textColor: AppTheme.getColor(
                                  context,
                                ).onSurfaceVariant,
                              ),
                              CommonRow(
                                title: 'project',
                                value: workAllocation.projectName ?? _noData,
                              ),
                              CommonRow(
                                title: 'work_start_date',
                                value: workAllocation.startDate ?? _noData,
                              ),
                              CommonRow(
                                title: 'target_date_of_completion',
                                value: workAllocation.endDate ?? _noData,
                              ),
                            ],
                          ),
                        ),

                        Divider(color: AppTheme.getColor(context).secondary),

                        /// timeline
                        StatusTimeline(
                          steps: getTimelineStepsFromModel(
                            context: context,
                            engineerStatus:
                                workAllocation.engineerStatus ?? _noData,
                            completionDateByEng:
                                workAllocation.completionDateByEngg,
                            authorizedDateByHod:
                                workAllocation.authorizedDateByHod,
                          ),
                          textSlotWidthMultiplier: 3.5,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }

      return const SizedBox.shrink();
    },
  );

  ///timeline filter
  List<CustomHorizontalStepper> getTimelineStepsFromModel({
    required BuildContext context,
    required String engineerStatus,
    required String? completionDateByEng,
    required String? authorizedDateByHod,
  }) {
    final steps = <CustomHorizontalStepper>[];

    final status = engineerStatus.trim().toLowerCase();
    final isCompleted = (completionDateByEng?.trim().isNotEmpty ?? false);
    final isAuthorized = (authorizedDateByHod?.trim().isNotEmpty ?? false);

    if (status == '2') {
      return [
        ///pending for deny
        CustomHorizontalStepper(
          label: LanguageManager().get('peding'),
          color: AppTheme.getColor(context).error,
          isActive: true,
        ),

        ///denied for deny
        CustomHorizontalStepper(
          label: LanguageManager().get('denied'),
          color: AppTheme.getColor(context).error,
          imagePath: AppAssets.cancelCross,
          isActive: true,
        ),
      ];
    }

    bool pendingActive = false;
    bool approvedActive = false;
    bool completedActive = false;
    bool authorizedActive = false;

    if (status == '0') {
      pendingActive = true;
    } else if (status == '1' && !isCompleted) {
      pendingActive = true;
      approvedActive = true;
    } else if (status == '2') {
      pendingActive = true;
      approvedActive = true;
    }

    if (isCompleted && !isAuthorized) {
      pendingActive = true;
      approvedActive = true;
      completedActive = true;
    }

    if (isCompleted && isAuthorized) {
      pendingActive = true;
      approvedActive = true;
      completedActive = true;
      authorizedActive = true;
    }

    String? getIcon(active) => active ? AppAssets.checkMark : null;

    ///pending
    steps.add(
      CustomHorizontalStepper(
        label: LanguageManager().get('peding'),
        color: AppColors.spanishYellow,
        isActive: pendingActive,
      ),
    );

    ///approved
    steps.add(
      CustomHorizontalStepper(
        label: LanguageManager().get('approved'),
        color: AppTheme.getColor(context).secondary,
        isActive: approvedActive,
        imagePath: getIcon(approvedActive),
      ),
    );

    /// completed
    steps.add(
      CustomHorizontalStepper(
        label: LanguageManager().get('completed_meeting'),
        color: AppTheme.getColor(context).secondary,
        isActive: completedActive,
        imagePath: getIcon(completedActive),
      ),
    );

    /// authorized
    steps.add(
      CustomHorizontalStepper(
        label: LanguageManager().get('authorized'),
        color: AppTheme.getColor(context).secondary,
        isActive: authorizedActive,
        imagePath: getIcon(authorizedActive),
      ),
    );

    return steps;
  }
}
