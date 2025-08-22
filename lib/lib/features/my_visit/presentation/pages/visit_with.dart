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
import 'package:myco_flutter/features/my_visit/presentation/bloc/bloc_ui/visit_bloc.dart';
import 'package:myco_flutter/features/work_from_home/presentation/widgets/label_row.dart';
import 'package:myco_flutter/features/my_visit/presentation/widgets/tag_input_shimmer_widget.dart';
import 'package:myco_flutter/features/my_visit/presentation/widgets/tag_input_widget.dart';
import 'package:myco_flutter/widgets/cached_image_holder.dart';
import 'package:myco_flutter/widgets/circle_image_employee_card.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_searchfield.dart';
import 'package:myco_flutter/widgets/custom_simple_bottom_sheet.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class VisitWith extends StatelessWidget {
  VisitWith({super.key});

  final TextEditingController _searchController = TextEditingController();

  final Color blendedColor = Color.lerp(
    const Color(0xFF2F648E),
    const Color(0xFFFFFFFF),
    0.5,
  )!;

  @override
  Widget build(BuildContext context) {
    context.read<VisitApiBloc>().add(const FetchBranchData());
    Responsive.init(context);
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal:
              VariableBag.screenHorizontalPadding *
              Responsive.getResponsive(context),
          vertical: 5 * Responsive.getResponsive(context),
        ),
        height: Responsive.getHeight(context) * 0.95,
        width: Responsive.getWidth(context),
        child: Column(
          spacing:
              VariableBag.formContentSpacingVertical *
              Responsive.getResponsive(context),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  'visit_with',
                  fontSize: Responsive.getDashboardResponsiveText(context) * 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.getColor(context).onSurface,
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: SvgPicture.asset(AppAssets.DoubleDown_Arrow),
                ),
              ],
            ),
            CustomSearchField(
              hintText: 'search',
              controller: _searchController,
              onChanged: (q) {},
              onSubmitted: (_) => FocusScope.of(context).unfocus(),
            ),

            // Branch Section
            BlocBuilder<VisitBloc, VisitState>(
              builder: (context, visitState) {
                if (visitState is! VisitLoaded) {
                  return const SizedBox.shrink();
                }

                final branchTags = visitState.branchTags;

                return BlocBuilder<VisitApiBloc, VisitApiState>(
                  builder: (context, apiState) {
                    if (apiState is! VisitApiLoaded) {
                      return const SizedBox.shrink();
                    }

                    final assignedBranches = apiState.VisitWithBranches;

                    return Column(
                      children: [
                        LabelRow(
                          title: 'blocks',
                          actionLabel: 'select_branch',
                          isSelectBtn: branchTags.isNotEmpty,
                          onTap: () async {
                            final List<Map<String, String>>? result =
                                await showCustomSimpleBottomSheet(
                                  context: context,
                                  heading: 'select_branch',
                                  dataList: assignedBranches,
                                  btnTitle: 'add',
                                  isMultipleSelection: true,
                                );

                            if (!context.mounted) return;

                            if (result != null && result.isNotEmpty) {
                              for (final item in result) {
                                final id = item['id'] ?? '';
                                final name = item['name'] ?? '';

                                final alreadyExists = branchTags.any(
                                  (tag) => tag['id'] == id,
                                );

                                if (id.isNotEmpty &&
                                    name.isNotEmpty &&
                                    !alreadyExists) {
                                  context.read<VisitBloc>().add(
                                    AddBranchTagFromSheet(name, id),
                                  );
                                }
                              }
                            }
                          },
                        ),

                        CustomTagInputWidget(
                          tags: branchTags.map((e) => e['name'] ?? '').toList(),
                          hint: 'block',
                          onAdd: (value) {
                            final cleanValue = value.replaceAll(',', '').trim();
                            final alreadyExists = branchTags.any(
                              (tag) => tag['name'] == cleanValue,
                            );

                            if (cleanValue.isNotEmpty && !alreadyExists) {
                              context.read<VisitBloc>().add(
                                AddBranchTagFromSheet(
                                  cleanValue,
                                  DateTime.now().millisecondsSinceEpoch
                                      .toString(),
                                ),
                              );
                            }
                          },
                          onRemove: (tagName) {
                            final tag = branchTags.firstWhere(
                              (t) => t['name'] == tagName,
                              orElse: () => {},
                            );

                            if (tag.containsKey('name')) {
                              context.read<VisitBloc>().add(
                                RemoveBranchTag(tag['name'] ?? ''),
                              );
                            }
                          },
                          onArrowTap: () async {
                            final List<Map<String, String>>? result =
                                await showCustomSimpleBottomSheet(
                                  context: context,
                                  heading: 'select_branch',
                                  dataList: assignedBranches,
                                  btnTitle: 'add',
                                  isMultipleSelection: true,
                                );

                            if (!context.mounted) return;

                            if (result != null && result.isNotEmpty) {
                              for (final item in result) {
                                final id = item['id'] ?? '';
                                final name = item['name'] ?? '';
                                final alreadyExists = branchTags.any(
                                  (tag) => tag['id'] == id,
                                );

                                if (id.isNotEmpty &&
                                    name.isNotEmpty &&
                                    !alreadyExists) {
                                  context.read<VisitBloc>().add(
                                    AddBranchTagFromSheet(name, id),
                                  );
                                }
                              }
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),

            // Department Section - SHOWN ONLY IF branch selected
            BlocBuilder<VisitBloc, VisitState>(
              builder: (context, visitState) {
                if (visitState is! VisitLoaded ||
                    visitState.branchTags.isEmpty) {
                  return const SizedBox.shrink();
                }

                // Trigger FetchDepartmentData only if the branch tags change
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.read<VisitApiBloc>().add(
                    FetchDepartmentData(
                      SelectedBranchId: visitState.branchTags
                          .map((e) => int.parse(e['id']!))
                          .toList(),
                    ),
                  );
                });

                final departmentTags = visitState.departmentTags;
                return BlocBuilder<VisitApiBloc, VisitApiState>(
                  builder: (context, apiState) {
                    if (apiState is! VisitApiLoaded) {
                      return const Column(
                        children: [
                          LabelRow(
                            title: 'department',
                            actionLabel: 'select_department',
                          ),
                          ShimmerWidget.rectangular(height: 50),
                        ],
                      );
                    }

                    return Column(
                      children: [
                        LabelRow(
                          title: 'department',
                          actionLabel: 'select_department',
                          isSelectBtn: visitState.departmentTags.isNotEmpty,
                          onTap: () async {
                            final List<Map<String, String>>? result =
                                await showCustomSimpleBottomSheet(
                                  context: context,
                                  heading: 'select_department',
                                  dataList: apiState.VisitWithDepartments,
                                  btnTitle: 'add',
                                  isMultipleSelection: true,
                                );
                            if (!context.mounted) return;

                            if (result != null && result.isNotEmpty) {
                              final existingTags = visitState.departmentTags;

                              for (final item in result) {
                                final name = item['name'] ?? '';
                                final id = item['id'] ?? '';
                                if (name.isNotEmpty &&
                                    !existingTags.contains(name)) {
                                  context.read<VisitBloc>().add(
                                    AddDepartmentTagFromSheet(name, id),
                                  );
                                }
                              }
                            }
                          },
                        ),
                        CustomTagInputWidget(
                          onArrowTap: () async {
                            final List<Map<String, String>>? result =
                                await showCustomSimpleBottomSheet(
                                  context: context,
                                  heading: 'select_department',
                                  dataList: apiState.VisitWithDepartments,
                                  btnTitle: 'add',
                                  isMultipleSelection: true,
                                );
                            if (!context.mounted) return;
                            if (result != null && result.isNotEmpty) {
                              final existingTags = visitState.departmentTags;

                              for (final item in result) {
                                final name = item['name'] ?? '';
                                final id = item['id'] ?? '';
                                if (name.isNotEmpty &&
                                    !existingTags.contains(name)) {
                                  context.read<VisitBloc>().add(
                                    AddDepartmentTagFromSheet(name, id),
                                  );
                                }
                              }
                            }
                          },
                          tags: departmentTags
                              .map((e) => e['name'] ?? '')
                              .toList(),
                          hint: 'department',
                          onAdd: (value) {
                            final cleanValue = value.replaceAll(',', '').trim();
                            final alreadyExists = departmentTags.any(
                              (tag) => tag['name'] == cleanValue,
                            );
                            if (cleanValue.isNotEmpty && !alreadyExists) {
                              context.read<VisitBloc>().add(
                                AddDepartmentTagFromSheet(
                                  cleanValue,
                                  DateTime.now().millisecondsSinceEpoch
                                      .toString(),
                                ),
                              );
                            }
                          },
                          onRemove: (tag) {
                            context.read<VisitBloc>().add(
                              RemoveDepartmentTag(tag),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),

            /// Employee card
            BlocBuilder<VisitBloc, VisitState>(
              builder: (context, uiState) {
                if (uiState is! VisitLoaded ||
                    uiState.branchTags.isEmpty ||
                    uiState.departmentTags.isEmpty) {
                  return const SizedBox.shrink();
                }

                // Trigger FetchEmployeeData only if the department tags change
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.read<VisitApiBloc>().add(
                    FetchEmployeeData(
                      SelectedDepartmentId: uiState.departmentTags
                          .map((e) => int.parse(e['id']!))
                          .toList(),
                    ),
                  );
                });
                return Expanded(
                  child: BlocBuilder<VisitApiBloc, VisitApiState>(
                    builder: (context, apiState) {
                      // Show shimmer if employee data is not loaded
                      if (apiState is! VisitApiLoaded) {
                        return LayoutBuilder(
                          builder: (context, constraints) {
                            final config = Responsive.getGridConfig(
                              context,
                              screenWide: constraints.maxWidth,
                            );
                            return GridView.builder(
                              padding: const EdgeInsets.all(5),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: config.itemCount,
                                    mainAxisSpacing: config.spacing,
                                    crossAxisSpacing: config.spacing,
                                    childAspectRatio: config.childAspectRatio,
                                  ),
                              itemCount: 6, // Number of shimmer items to show
                              itemBuilder: (context, index) =>
                                  ShimmerWidget.circular(width: 80, height: 80),
                            );
                          },
                        );
                      }

                      final employeeList = apiState.VisitWithEmployee;
                      final selectedIndexes = uiState.selectedEmployeeIndexes;

                      return LayoutBuilder(
                        builder: (context, constraints) {
                          final config = Responsive.getGridConfig(
                            context,
                            screenWide: constraints.maxWidth,
                          );

                          return GridView.builder(
                            padding: const EdgeInsets.all(5),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: config.itemCount,
                                  mainAxisSpacing: config.spacing,
                                  crossAxisSpacing: config.spacing,
                                  childAspectRatio: config.childAspectRatio,
                                ),
                            itemCount: employeeList.length,
                            itemBuilder: (context, index) {
                              final emp = employeeList[index];
                              final isSelected = selectedIndexes.contains(
                                index,
                              );

                              return CircleImageEmployeeCard(
                                selectedColor: blendedColor,
                                name: emp['name'] ?? '',
                                department: emp['designation'] ?? '',
                                imageWidget: CachedImage(
                                  imageProvider: NetworkImage(
                                    emp['photo'] ?? '',
                                  ),
                                ),
                                showDelete: false,
                                isSelected: isSelected,
                                onSelected: (_) {
                                  context.read<VisitBloc>().add(
                                    ToggleEmployeeSelection(index),
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),

            // Add Button
            Align(
              alignment: Alignment.bottomCenter,
              child: BlocBuilder<VisitBloc, VisitState>(
                builder: (context, state) => MyCoButton(
                  title: 'add',
                  boarderRadius: VariableBag.buttonBorderRadius,
                  height: 0.05 * Responsive.getHeight(context),
                  isShadowBottomLeft: true,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  onTap: () {
                    if (state is VisitLoaded &&
                        state.selectedEmployeeIndexes.isNotEmpty) {
                      context.read<VisitBloc>().add(
                        UpdateVisitTypeAndTapEvent(
                          selectedVisitType: 'Add visit for other employee',
                          index: 2,
                          isTapped: true,
                          actionType: 'assign_to',
                        ),
                      );

                      Navigator.pop(context);
                    } else {
                      context.read<VisitBloc>().add(
                        UpdateVisitTypeAndTapEvent(
                          selectedVisitType: 'Self Visit',
                          index: 1,
                          isTapped: false,
                          actionType: 'Self Visit',
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
