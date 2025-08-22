import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/core/utils/util.dart';

import 'package:myco_flutter/features/chat/presentation/bloc/bloc/select_emp_bloc.dart';
import 'package:myco_flutter/features/chat/presentation/bloc/bloc/select_emp_state.dart';
import 'package:myco_flutter/features/chat/presentation/widgets/creat_group_bottomsheet.dart';

import 'package:myco_flutter/features/chat/presentation/widgets/employee_avatar.dart';
import 'package:myco_flutter/features/chat/presentation/widgets/shimmers/skeleton_employee_card.dart';
import 'package:myco_flutter/widgets/circle_image_employee_card.dart';

import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_multiselect_field.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_searchfield.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class NewGroupScreen extends StatefulWidget {
  NewGroupScreen({super.key});

  @override
  State<NewGroupScreen> createState() => _NewGroupScreenState();
}

class _NewGroupScreenState extends State<NewGroupScreen> {
  final TextEditingController branchController = TextEditingController();

  Map<String, String> selectedDepartments = {};
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () { context.read<SelectEmpBloc>().add(LoadEmployeesEvent());
    context.read<SelectEmpBloc>().add(LoadDepartmentsEvent());},
    );
    
    // ;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppTheme.getColor(context).background,

    appBar: CustomAppbar(title: LanguageManager().get('select_group_members')),
    body: Padding(
      padding: EdgeInsets.symmetric(
        horizontal:
            VariableBag.screenHorizontalPadding *
            Responsive.getResponsive(context),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomSearchField(
            hintText: LanguageManager().get('search'),

            onChanged: (value) => {
              context.read<SelectEmpBloc>().add(SearchEmployeesEvent(value)),
            },
          ),
          SizedBox(height: 0.001 * Responsive.getHeight(context)),
          BlocBuilder<SelectEmpBloc, SelectEmpState>(
            builder: (context, state) {
              List<Map<String, String>> departmentsList = [];

              if (state.departments.isNotEmpty) {
                departmentsList = state.departments
                    .map(
                      (e) => {
                        // 'id': '${e.blockId}_${e.floorId}', // unique ID
                        'name': e.name.toString(),
                        'id': e.id.toString(),
                        'blockId': e.blockId.toString(),
                      },
                    )
                    .toList();
              }

              return CustomMultiSelectField(
                items: departmentsList,
                labelText: 'floors',
                hintText: 'select_department',
                addButtonText: 'select_department',
                onSelectionChanged: (selectedIds) {
                  log(
                    selectedIds.toString(),
                    name: 'selectedId in group employee',
                  );
                  final selectedDepartments = selectedIds
                      .map((dept) => dept['id'].toString())
                      .toList();
                  log(
                    selectedDepartments.toString(),
                    name: 'selectedDepartments in amit',
                  );
                  context.read<SelectEmpBloc>().add(
                    FilterEmployeesByDepartmentEvent(selectedDepartments),
                  );
                },
              );
            },
          ),
          SizedBox(height: 0.015 * Responsive.getHeight(context)),
          BlocBuilder<SelectEmpBloc, SelectEmpState>(
            builder: (context, state) => SelectedEmployeesList(
              selectedEmployees: state.selectedEmployees,
              onRemove: (employee) {
                context.read<SelectEmpBloc>().add(
                  RemoveSelectedEmployeeEvent(employee),
                );
              },
            ),
          ),

          SizedBox(height: 0.012 * Responsive.getHeight(context)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyCoButton(
                onTap: () {
                  context.read<SelectEmpBloc>().add(
                    UnselectAllEmployeesEvent(),
                  );
                },
                title: LanguageManager().get('unselect_all'),
                textStyle: AppTheme.getTextStyle(context).labelMedium!.copyWith(
                  color: AppTheme.getColor(context).onPrimary,
                  fontSize: 12 * Responsive.getResponsiveText(context),
                ),
                width: 0.25 * Responsive.getWidth(context),
                height: 0.028 * Responsive.getHeight(context),
                boarderRadius: 20 * Responsive.getResponsive(context),
                isShadowBottomLeft: true,
              ),
              SizedBox(width: 0.01 * Responsive.getWidth(context)),
              MyCoButton(
                backgroundColor: AppTheme.getColor(context).secondary,
                borderColor: AppTheme.getColor(context).secondary,
                onTap: () {
                  context.read<SelectEmpBloc>().add(
                    SelectAllVisibleEmployeesEvent(),
                  );
                },
                title: LanguageManager().get('select_all'),
                textStyle: AppTheme.getTextStyle(context).labelMedium!.copyWith(
                  fontSize: 12 * Responsive.getResponsiveText(context),
                  color: AppTheme.getColor(context).onPrimary,
                ),
                width: 0.25 * Responsive.getWidth(context),
                height: 0.028 * Responsive.getHeight(context),
                boarderRadius: 20 * Responsive.getResponsive(context),
                isShadowBottomLeft: true,
              ),
            ],
          ),
          SizedBox(height: 0.008 * Responsive.getHeight(context)),
          BlocBuilder<SelectEmpBloc, SelectEmpState>(
            builder: (context, state) {
              if (state.isLoadingEmployees) {
                return const Expanded(
                  child: Center(child: SkeletonEmployeeGrid()),
                );
              }

              if (state.employeeError != null) {
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('Error: ${state.departmentError}')],
                    ),
                  ),
                );
              }
              return Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(
                    10 * Responsive.getResponsive(context),
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                    childAspectRatio: 0.77,
                  ),
                  itemCount: state.filteredEmployees.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final emp = state.filteredEmployees[index];
                    final isSelected = state.isEmployeeSelected(emp);

                    return CircleImageEmployeeCard(
                      imageWidget: CachedNetworkImage(
                        imageUrl: emp.imageUrl,
                        errorWidget: (context, url, error) => Center(
                          child: CustomText(
                            Util.getInitials(
                              emp.name.trim().isNotEmpty == true
                                  ? emp.name
                                  : 'NA',
                            ),
                            fontSize:
                                20 * Responsive.getResponsiveText(context),
                            fontWeight: FontWeight.w700,
                            color: AppTheme.getColor(context).primary,
                          ),
                        ),
                      ),
                      name: emp.name,
                      department: emp.department,
                      spaceBetweenImageText:
                          0.004 * Responsive.getHeight(context),
                      isSelected: isSelected,
                      onSelected: (selected) {
                        context.read<SelectEmpBloc>().add(
                          ToggleEmployeeSelectionEvent(emp),
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),

          SizedBox(height: 0.01 * Responsive.getHeight(context)),

          Align(
            alignment: Alignment.bottomCenter,
            child: BlocBuilder<SelectEmpBloc, SelectEmpState>(
              builder: (context, state) => MyCoButton(
                  onTap: () {
                    log(state.selectedEmployees.toString(), name: 'selectedEmployees & create group');
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      builder: (_) => CreatGroupBottomsheet(
                        headerHeight: 0.06 * Responsive.getHeight(context),
                      ),
                    );
                  },
                  title: state.selectedEmployees.length ==0 ? 'add' : 'add (${state.selectedEmployees.length})',

                  height: 0.055 * Responsive.getHeight(context),
                  boarderRadius: 30,
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.getColor(context).onPrimary,
                  ),
                  backgroundColor: AppTheme.getColor(context).primary,
                  isShadowBottomLeft: true,
                ),
            ),
          ),

          SizedBox(height: 20 * Responsive.getResponsive(context)),

          // SizedBox(height: 20 * Responsive.getResponsive(context)),
        ],
      ),
    ),
  );
}
