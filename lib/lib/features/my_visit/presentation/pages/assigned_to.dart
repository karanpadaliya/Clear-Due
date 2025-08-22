import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/my_visit/presentation/bloc/bloc_api/visit_api_bloc.dart';
import 'package:myco_flutter/features/my_visit/presentation/bloc/bloc_api/visit_api_event.dart';
import 'package:myco_flutter/features/my_visit/presentation/bloc/bloc_api/visit_api_state.dart';
import 'package:myco_flutter/features/work_from_home/presentation/widgets/label_row.dart';
import 'package:myco_flutter/features/my_visit/presentation/widgets/tag_input_widget.dart';
import 'package:myco_flutter/widgets/cached_image_holder.dart';
import 'package:myco_flutter/widgets/circle_image_employee_card.dart';
import 'package:myco_flutter/widgets/custom_searchfield.dart';
import 'package:myco_flutter/widgets/custom_simple_bottom_sheet.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class AssignedTo extends StatelessWidget {
  AssignedTo({super.key});

  final TextEditingController searchController = TextEditingController();

  final Color blendedColor = Color.lerp(
    const Color(0xFF2F648E),
    const Color(0xFFFFFFFF),
    0.5,
  )!;

  @override
  Widget build(BuildContext context) {
    context.read<VisitApiBloc>().add(GetBranchDepartmentData());
    return SafeArea(
      child: BlocBuilder<VisitApiBloc, VisitApiState>(
        builder: (context, apiState) {
          if (apiState is! VisitApiLoaded) {
            return const Center(child: CircularProgressIndicator());
          }
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal:
                  VariableBag.screenHorizontalPadding *
                  Responsive.getResponsive(context),
              vertical: 5 * Responsive.getResponsive(context),
            ),
            height: Responsive.getHeight(context) * 0.95,
            width: Responsive.getWidth(context),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      'assign_to',
                      fontSize:
                          Responsive.getDashboardResponsiveText(context) * 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.getColor(context).onSurface,
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: SvgPicture.asset(AppAssets.DoubleDown_Arrow),
                    ),
                  ],
                ),
                SizedBox(
                  height:
                      VariableBag.formContentSpacingVertical *
                      Responsive.getResponsive(context),
                ),
                CustomSearchField(
                  hintText: 'search',
                  controller: searchController,
                ),
                SizedBox(
                  height:
                      VariableBag.formContentSpacingVertical *
                      Responsive.getResponsive(context),
                ),
                BlocBuilder<VisitApiBloc, VisitApiState>(
                  builder: (context, apiState) {
                    if (apiState is! VisitApiLoaded)
                      return const SizedBox.shrink();

                    final selectedBranches = apiState.selectedBranch;
                    final selectedDepartments = apiState.selectedDepartment;

                    final filteredDepartments = apiState.departments
                        .where(
                          (dept) => selectedBranches.any(
                            (branch) => branch.blockId == dept.blockId,
                          ),
                        )
                        .map(
                          (dept) => {
                            'id': dept.floorId,
                            'name': dept.departmentName,
                          },
                        )
                        .toList();

                    return Column(
                      children: [
                        /// Branch Section
                        LabelRow(
                          title: 'branch',
                          actionLabel: 'select_branch',
                          isSelectBtn: selectedBranches.isNotEmpty,
                          onTap: () async {
                            final result = await showCustomSimpleBottomSheet(
                              context: context,
                              heading: 'select_branch',
                              dataList: apiState.branches
                                  .map(
                                    (branch) => {
                                      'id': branch.blockId,
                                      'name': branch.blockName,
                                    },
                                  )
                                  .toList(),
                              btnTitle: 'add',
                            );

                            if (result != null && result['id'] != null) {
                              final selectedBranch = apiState.branches
                                  .firstWhere(
                                    (b) => b.blockId == result['id'],
                                    orElse: () => apiState.branches.first,
                                  );
                              context.read<VisitApiBloc>().add(
                                AddSelectedBranchTag(selectedBranch),
                              );
                            }
                          },
                        ),
                        CustomTagInputWidget(
                          tags: selectedBranches
                              .map((e) => e.blockName)
                              .toList(),
                          hint: 'branch',
                          onAdd: (value) {},
                          onRemove: (tag) {
                            final branchToRemove = selectedBranches.firstWhere(
                              (b) => b.blockName == tag,
                              orElse: () => selectedBranches.first,
                            );
                            context.read<VisitApiBloc>().add(
                              RemoveSelectedBranchTag(branchToRemove),
                            );
                          },
                          onArrowTap: () async {
                            final result = await showCustomSimpleBottomSheet(
                              context: context,
                              heading: 'select_branch',
                              dataList: apiState.branches
                                  .map(
                                    (branch) => {
                                      'id': branch.blockId,
                                      'name': branch.blockName,
                                    },
                                  )
                                  .toList(),
                              btnTitle: 'add',
                            );

                            if (result != null && result['id'] != null) {
                              final selectedBranch = apiState.branches
                                  .firstWhere(
                                    (b) => b.blockId == result['id'],
                                    orElse: () => apiState.branches.first,
                                  );
                              context.read<VisitApiBloc>().add(
                                AddSelectedBranchTag(selectedBranch),
                              );
                            }
                          },
                        ),

                        /// Department Section
                        LabelRow(
                          title: 'department',
                          actionLabel: 'select_department',
                          isSelectBtn: selectedDepartments.isNotEmpty,
                          onTap: () async {
                            final result = await showCustomSimpleBottomSheet(
                              context: context,
                              heading: 'select_department',
                              dataList: filteredDepartments,
                              btnTitle: 'add',
                            );

                            if (result != null && result['name'] != null) {
                              final selectedDept = apiState.departments
                                  .firstWhere(
                                    (d) =>
                                        d.departmentName == result['name'] &&
                                        d.floorId == result['id'],
                                    orElse: () => apiState.departments.first,
                                  );
                              context.read<VisitApiBloc>().add(
                                AddSelectedDepartmentTag(selectedDept),
                              );
                            }
                          },
                        ),
                        CustomTagInputWidget(
                          tags: selectedDepartments
                              .map((e) => e.departmentName)
                              .toList(),
                          hint: 'department',
                          onAdd: (value) {},
                          onRemove: (tag) {
                            final deptToRemove = selectedDepartments.firstWhere(
                              (d) => d.departmentName == tag,
                              orElse: () => selectedDepartments.first,
                            );
                            context.read<VisitApiBloc>().add(
                              RemoveSelectedDepartmentTag(deptToRemove),
                            );
                          },
                          onArrowTap: () async {
                            final result = await showCustomSimpleBottomSheet(
                              context: context,
                              heading: 'select_department',
                              dataList: filteredDepartments,
                              btnTitle: 'add',
                            );

                            if (result != null && result['name'] != null) {
                              final selectedDept = apiState.departments
                                  .firstWhere(
                                    (d) =>
                                        d.departmentName == result['name'] &&
                                        d.floorId == result['id'],
                                    orElse: () => apiState.departments.first,
                                  );
                              context.read<VisitApiBloc>().add(
                                AddSelectedDepartmentTag(selectedDept),
                              );
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
                if (apiState.selectedDepartment.isNotEmpty)
                  // Employees Grid (sample only - replace with API data when ready)
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) =>
                          BlocBuilder<VisitApiBloc, VisitApiState>(
                            builder: (context, apistate) {
                              if (apistate is! VisitApiLoaded)
                                return const SizedBox.shrink();
                              context.read<VisitApiBloc>().add(
                                GetEmployeeDetailEvent(
                                  apistate.SelectedFloorID,
                                  apistate.SelectedBlockID,
                                ),
                              );
                              return GridView.builder(
                                padding: const EdgeInsets.all(5),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: Responsive.getGridConfig(
                                        context,
                                        screenWide: constraints.maxWidth,
                                      ).itemCount,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      childAspectRatio: 0.75,
                                    ),
                                itemCount: apistate.EmployeeDetails.length,
                                itemBuilder: (context, index) {
                                  final emp = apistate.EmployeeDetails[index];
                                  // final isSelected = state.selectedEmployeeIndexes
                                  //     .contains(index);

                                  return CircleImageEmployeeCard(
                                    selectedColor: blendedColor,
                                    name: emp.userFullName ?? 'Unknown',
                                    department: emp.designation ?? 'Unknown',
                                    imageWidget: CachedImage(
                                      imageProvider: NetworkImage(
                                        emp.userProfilePic ?? 'Unknown',
                                      ),
                                    ),
                                    showDelete: false,
                                    isSelected: false,
                                    onSelected: (_) {
                                      // context.read<VisitApiBloc>().add(
                                      //   AssignedToggleEmployeeSelection(index),
                                      // );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                    ),
                  ),

                // Submit Button
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: BlocBuilder<VisitApiBloc, VisitApiState>(
                //     builder: (context, state) => MyCoButton(
                //       title: 'add',
                //       boarderRadius: VariableBag.buttonBorderRadius,
                //       height: 0.05 * Responsive.getHeight(context),
                //       isShadowBottomLeft: true,
                //       fontFamily: 'Inter',
                //       fontWeight: FontWeight.w500,
                //       onTap: () {
                //         if (state is VisitApiLoaded &&
                //             state.selectedEmployeeIndexes.isNotEmpty) {
                //           context.read<VisitBloc>().add(
                //             UpdateVisitTypeAndTapEvent(
                //               selectedVisitType: 'Add visit for other employee',
                //               index: 2,
                //               isTapped: true,
                //               actionType: 'assign_to',
                //             ),
                //           );
                //         } else {
                //           context.read<VisitBloc>().add(
                //             UpdateVisitTypeAndTapEvent(
                //               selectedVisitType: 'Self Visit',
                //               index: 1,
                //               isTapped: false,
                //               actionType: 'Self Visit',
                //             ),
                //           );
                //         }
                //
                //         Navigator.pop(context);
                //       },
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
