import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/core/utils/util.dart';
import 'package:myco_flutter/features/common_api/presentation/bloc/common_api_bloc.dart';
import 'package:myco_flutter/features/work_allocation/presentation/bloc/assign_work_bloc.dart';
import 'package:myco_flutter/features/work_allocation/presentation/bloc/assign_work_event.dart';
import 'package:myco_flutter/features/work_allocation/presentation/widgets/employee_card.dart';
import 'package:myco_flutter/widgets/custom_cached_network_image.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class Employee {
  final String id;
  final String name;
  final String designation;
  final String imageUrl;

  const Employee({
    required this.id,
    required this.name,
    required this.designation,
    required this.imageUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Employee &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          designation == other.designation &&
          imageUrl == other.imageUrl;

  @override
  int get hashCode => name.hashCode ^ designation.hashCode ^ imageUrl.hashCode;
}

class AssignEngineerField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final List<Employee> allEmployees;

  const AssignEngineerField({
    required this.controller,
    required this.focusNode,
    required this.allEmployees,
    super.key,
  });

  @override
  State<AssignEngineerField> createState() => _AssignEngineerFieldState();
}

class _AssignEngineerFieldState extends State<AssignEngineerField> {
  List<Employee> allEmployees = [];
  List<Employee> filteredEmployees = [];
  Employee? selectedEmployee;

  @override
  void initState() {
    super.initState();
    widget.controller.clear();
    selectedEmployee = null;
  }

  /// search filter
  void _filterEmployees(String query) {
    setState(() {
      filteredEmployees = allEmployees
          .where(
            (emp) =>
                emp.name.toLowerCase().contains(query.toLowerCase()) ||
                emp.designation.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<CommonApiBloc, CommonApiState>(
    builder: (context, state) {
      if (state is EmployeeApiSuccess) {
        allEmployees =
            state.response.employees
                ?.map(
                  /// selected emp list
                  (e) => Employee(
                    id: e.userId ?? '',
                    name: e.userFullNameView ?? '',
                    designation: e.userDesignation ?? '',
                    imageUrl: e.userProfilePic ?? '',
                  ),
                )
                .toList() ??
            [];
      }

      if (widget.controller.text.isEmpty) {
        filteredEmployees = allEmployees;
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// assign work engineer
              CustomText(
                'assign_work_engineer',
                fontSize: 14 * Responsive.getResponsiveText(context),
                fontWeight: FontWeight.w700,
                color: AppTheme.getColor(context).onSurfaceVariant,
              ),
              CustomText(
                ' *',
                fontSize: 14 * Responsive.getResponsiveText(context),
                fontWeight: FontWeight.w700,
                color: AppTheme.getColor(context).error,
              ),
            ],
          ),
          SizedBox(height: 0.003 * Responsive.getHeight(context)),
          Container(
            padding: EdgeInsets.only(
              left: 10 * Responsive.getResponsive(context),
              right: 10 * Responsive.getResponsive(context),
              bottom: 15 * Responsive.getResponsive(context),
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppTheme.getColor(context).outline,
                width: 1.2,
              ),
              borderRadius: BorderRadius.circular(
                12 * Responsive.getResponsive(context),
              ),
              color: AppTheme.getColor(context).surfaceBright,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 0.060 * Responsive.getHeight(context),
                  child: Focus(
                    onFocusChange: (hasFocus) {
                      if (!hasFocus) {
                        setState(() => filteredEmployees = allEmployees);
                      }
                    },

                    /// search bar
                    child: TextField(
                      controller: widget.controller,
                      focusNode: widget.focusNode,
                      onChanged: _filterEmployees,
                      decoration: InputDecoration(
                        hintText: 'Mention Here',
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10 * Responsive.getResponsive(context),
                        ),
                        border: const UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppTheme.getColor(context).outline,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppTheme.getColor(context).outline,
                          ),
                        ),
                        hintStyle: TextStyle(
                          fontSize: 12 * Responsive.getResponsiveText(context),
                          fontWeight: FontWeight.w600,
                          color: AppTheme.getColor(context).outline,
                        ),
                        suffixIcon: widget.controller.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  widget.controller.clear();
                                  setState(() {
                                    filteredEmployees = allEmployees;
                                    selectedEmployee = null;
                                  });
                                },
                              )
                            : null,
                      ),
                    ),
                  ),
                ),

                /// search result
                if (filteredEmployees.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        color: AppTheme.getColor(context).surfaceBright,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 220),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: filteredEmployees.length,
                            itemBuilder: (context, index) {
                              final emp = filteredEmployees[index];
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedEmployee = emp;
                                    widget.controller.text = emp.name;
                                    filteredEmployees = [];
                                  });
                                  context.read<AssignWorkBloc>().add(
                                    SelectEmployeeEvent(emp),
                                  );
                                },
                                child: Container(
                                  height: 0.07 * Responsive.getHeight(context),
                                  margin: EdgeInsets.symmetric(
                                    vertical:
                                        4 * Responsive.getResponsive(context),
                                    horizontal:
                                        8 * Responsive.getResponsive(context),
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppTheme.getColor(
                                      context,
                                    ).surfaceBright,
                                    border: Border.all(
                                      color: Util.applyOpacity(
                                        AppTheme.getColor(context).outline,
                                        0.4,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              10 *
                                              Responsive.getResponsive(context),
                                        ),
                                        child: CustomCachedNetworkImage(
                                          imageUrl: emp.imageUrl,
                                          isCircular: true,
                                          height:
                                              50 *
                                              Responsive.getResponsive(context),
                                          width:
                                              50 *
                                              Responsive.getResponsive(context),
                                          errorWidget: Container(
                                            width:
                                                50 *
                                                Responsive.getResponsive(
                                                  context,
                                                ),
                                            height:
                                                50 *
                                                Responsive.getResponsive(
                                                  context,
                                                ),
                                            color: Colors.grey.shade300,
                                            child: Center(
                                              child: CustomText(
                                                Util.getInitials(
                                                  emp.name?.trim().isNotEmpty ==
                                                          true
                                                      ? emp.name
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
                                        // child: CircleAvatar(
                                        //   radius: 18,
                                        //   backgroundImage: NetworkImage(
                                        //     emp.imageUrl,
                                        //   ),
                                        // ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              emp.name,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  14 *
                                                  Responsive.getResponsiveText(
                                                    context,
                                                  ),
                                              color: AppTheme.getColor(
                                                context,
                                              ).onSurface,
                                            ),
                                            CustomText(
                                              emp.designation,
                                              fontSize:
                                                  12 *
                                                  Responsive.getResponsiveText(
                                                    context,
                                                  ),
                                              color: AppTheme.getColor(
                                                context,
                                              ).outline,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            0.008 *
                                            Responsive.getWidth(context),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                /// selected emp
                if (selectedEmployee != null)
                  SizedBox(
                    height: 0.190 * Responsive.getHeight(context),
                    width: 0.400 * Responsive.getWidth(context),
                    child: Padding(
                      padding: EdgeInsets.all(
                        8 * Responsive.getResponsive(context),
                      ),
                      child: EmployeeSelectionCard(
                        name: selectedEmployee!.name,
                        department: selectedEmployee!.designation,
                        image: const Icon(Icons.person),
                        isSelected: true,
                        showDelete: true,
                        onDeleteTap: () {
                          setState(() {
                            selectedEmployee = null;
                            widget.controller.clear();
                          });
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
