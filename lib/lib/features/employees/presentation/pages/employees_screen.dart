import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/core/utils/util.dart';
import 'package:myco_flutter/features/appointments/presentation/bloc/appointment_bloc.dart';
import 'package:myco_flutter/features/appointments/presentation/bottom_sheet/appointment_details_bottom_sheet.dart';
import 'package:myco_flutter/features/employees/domain/entites/branch_entity.dart';
import 'package:myco_flutter/features/employees/domain/entites/department_entity.dart';
import 'package:myco_flutter/features/employees/presentation/bloc/employee_bloc.dart';
import 'package:myco_flutter/features/employees/presentation/bloc/employee_event.dart';
import 'package:myco_flutter/features/employees/presentation/bloc/employee_state.dart';
import 'package:myco_flutter/features/employees/presentation/widgets/full_image_employee_card.dart';
import 'package:myco_flutter/widgets/cached_image_holder.dart';
import 'package:myco_flutter/widgets/circle_image_employee_card.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_searchfield.dart';
import 'package:myco_flutter/widgets/custom_simple_bottom_sheet.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/media_picker/widgets/custom_media_picker_container.dart';

class EmployeesScreen extends StatelessWidget {
  final bool defaultEmployeeScreen;

  EmployeesScreen({required this.defaultEmployeeScreen, super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return BlocProvider<EmployeeBloc>(
      create: (_) => GetIt.I<EmployeeBloc>()..add(LoadUserData()),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: BlocBuilder<EmployeeBloc, EmployeeState>(
              builder: (context, state) => CustomAppbar(
                title: 'employees',
                isKey: true,
                titleFontSize: 18 * Responsive.getResponsiveText(context),
                titleFontWeight: FontWeight.w700,
                appBarBackgoundColor: AppTheme.getColor(context).surface,
              ),
            ),
          ),
          // body: Expanded(
          //   child: SingleChildScrollView(
          //     child: Padding(
          //       padding: const EdgeInsets.all(10.0),
          //       child: CustomVerticalStepper(
          //         steps: [
          //           StepData(
          //             title: 'PUNCH IN',
          //             // title: '',
          //             subTitle: '10:25:06 AM',
          //             status: StepStatus.inActive,
          //             // isStepIconShow: false,
          //             customStatusIcon: SvgPicture.asset(
          //               AppAssets.assetGalleryExport,
          //             ),
          //             // customStatusIcon: const Icon(
          //             //   Icons.ac_unit,
          //             //   color: Colors.white,
          //             // ),
          //             details: [
          //               StepDetail(title: 'title', description: ''),
          //               StepDetail(title: 'Remark', description: 'description'),
          //               StepDetail(
          //                 title: 'Remark Remark',
          //                 description: 'description',
          //               ),
          //             ],
          //             subSteps: [
          //               SubStepData(
          //                 subStepTitle: 'Lunch Break',
          //                 subStepSubTitle: '01:32:56 PM - 02:01:46 PM',
          //                 subStepTrailingTitle: '28 min 50 sec',
          //                 subStepStatus: StepStatus.pending,
          //                 subStepCustomStatusIcon: Icon(Icons.lunch_dining),
          //                 subStepSubTitleFontSize: 20,
          //                 isSubStepIconShow: false,
          //               ),
          //               SubStepData(
          //                 subStepTitle: 'Tea Break',
          //                 subStepSubTitle: '06:05:02 PM - 06:07:51 PM',
          //                 subStepTrailingTitle: '2 min 49 sec',
          //                 subStepStatus: StepStatus.pending,
          //                 // isSubStepIconShow: false,
          //               ),
          //             ],
          //           ),
          //           StepData(
          //             title: 'PUNCH OUT',
          //             subTitle: '06:08:39 PM',
          //             trillingTitle: '7 hour 43 min 33 sec',
          //             status: StepStatus.pending,
          //             // isStepIconShow: false,
          //           ),
          //           StepData(
          //             title: 'PUNCH IN & OUT',
          //             subTitle: '06:08:39 PM',
          //             trillingTitle: '1 min 18 sec',
          //             status: StepStatus.approved,
          //             // isStepIconShow: true,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          body: BlocBuilder<EmployeeBloc, EmployeeState>(
            builder: (context, state) {
              if (state is EmployeeLoading || state is EmployeeInitial) {
                return _buildLoadedContent(context, null);
              } else if (state is EmployeeError) {
                return Center(child: Text('Error: ${state.message}'));
              } else if (state is EmployeeLoaded) {
                return _buildLoadedContent(context, state);
              }
              return const SizedBox();
            },
          ),
          // body: Padding(
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: VariableBag.screenHorizontalPadding,
          //   ),
          //   child: Column(
          //     children: [
          //       ///Media picker container
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: CustomMediaPickerContainer(
          //           title: 'Assets Image',
          //           titleFontSize: 14 * Responsive.getResponsiveText(context),
          //           imageTitle: 'Capture Image',
          //           // imageTitleSize: 10,
          //           // containerHeight: 0.100 * Responsive.getHeight(context),
          //           multipleImage: 5,
          //           imagePath: AppAssets.assetGalleryExport,
          //           isCameraShow: true,
          //           isGalleryShow: true,
          //           isDocumentShow: true,
          //           isCropImage: true,
          //           onSelectedMedia: (files) {
          //             final paths = files.map((file) => file.path).toList();
          //             log('Selected file paths: $paths');
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }

  Widget _buildLoadedContent(BuildContext context, EmployeeLoaded? st) {
    final bloc = context.read<EmployeeBloc>();

    final bool isShimmer = st == null;

    final filteredEmployees = isShimmer
        ? List.generate(15, (_) => null)
        : st.employees.where((e) {
            final matchesBranch =
                st.selectedBranch == null ||
                e.branchId == st.selectedBranch?.branchId;
            final matchesDepartment =
                st.selectedDepartment == null ||
                e.departmentId == st.selectedDepartment?.departmentId;
            final matchesSearch =
                st.searchQuery.isEmpty ||
                (e.userFullName?.toLowerCase().contains(
                      st.searchQuery.toLowerCase(),
                    ) ??
                    false) ||
                (e.designation?.toLowerCase().contains(
                      st.searchQuery.toLowerCase(),
                    ) ??
                    false);
            return matchesBranch && matchesDepartment && matchesSearch;
          }).toList();

    final double gridPadding = 8 * Responsive.getResponsive(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal:
            VariableBag.screenHorizontalPadding *
            Responsive.getResponsive(context),
      ),
      child: Column(
        children: [
          CustomSearchField(
            hintText: 'search',
            controller: _searchController,
            onChanged: (q) {
              if (!isShimmer) bloc.add(SearchEmployees(q));
            },
            onSubmitted: (_) => FocusScope.of(context).unfocus(),
          ),
          SizedBox(height: 0.012 * Responsive.getHeight(context)),

          Row(
            children: [
              Expanded(child: _dropdownBranch(context, st, bloc)), // Pass bloc
              SizedBox(width: 0.013 * Responsive.getWidth(context)),
              Expanded(
                child: _dropdownDepartment(
                  context,
                  st,
                  st?.filteredDepartments ?? [],
                  bloc, // Pass bloc
                  st?.departments ?? [],
                ),
              ),
            ],
          ),
          SizedBox(height: 0.024 * Responsive.getHeight(context)),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => bloc.add(RefreshEmployeeData()),
              child: filteredEmployees.isEmpty && !isShimmer
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.noEmployeeFound,
                            height: Responsive.isTablet(context)
                                ? 0.200 * Responsive.getHeight(context)
                                : 0.100 * Responsive.getHeight(context),
                          ),
                          const SizedBox(height: 12),
                          CustomText(
                            'No employees found',
                            fontSize:
                                16 * Responsive.getResponsiveText(context),
                            fontWeight: FontWeight.w600,
                            color: AppTheme.getColor(context).onSurface,
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      padding: EdgeInsets.only(
                        top: gridPadding,
                        left: gridPadding,
                        right: gridPadding,
                        bottom: 20 * Responsive.getResponsive(context),
                      ),
                      itemCount: filteredEmployees.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Responsive.getGridConfig(
                          context,
                        ).itemCount,
                        mainAxisSpacing: Responsive.getGridConfig(
                          context,
                        ).spacing,
                        crossAxisSpacing: Responsive.getGridConfig(
                          context,
                        ).spacing,
                        childAspectRatio: 2 / 2.5,
                      ),
                      itemBuilder: (_, index) {
                        final emp = filteredEmployees[index];
                        if (emp == null) {
                          return const FullImageEmployeeCard(
                            name: '',
                            department: '',
                            image: SizedBox(),
                            isSelected: false,
                          );
                        }
                        if (defaultEmployeeScreen) {
                          return FullImageEmployeeCard(
                            name: emp.userFullName ?? '',
                            department: emp.designation ?? '',
                            image: CachedImage(
                              key: ValueKey(emp.userId),
                              errorWidget: Center(
                                child: CustomText(
                                  Util.getInitials(
                                    emp.userFullName?.trim().isNotEmpty == true
                                        ? emp.userFullName!
                                        : 'NA',
                                  ),
                                  fontSize:
                                      20 *
                                      Responsive.getResponsiveText(context),
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.getColor(context).primary,
                                ),
                              ),
                              imageProvider: NetworkImage(
                                emp.userProfilePic ?? '',
                              ),
                            ),
                            isSelected:
                                st?.selectedEmployeeIds.contains(emp.userId) ??
                                false,
                            onSelected: (_) {
                              debugPrint('Navigation to ProfileScreen');
                              debugPrint(emp.userId);
                              debugPrint(emp.userFirstName);
                              debugPrint(emp.designation);
                              debugPrint(emp.userMobile);
                              debugPrint(emp.shortName);
                              bloc.add(
                                ToggleEmployeeSelection(emp.userId ?? ''),
                              );
                            },
                          );
                        } else {
                          return CircleImageEmployeeCard(
                            name: emp.userFullName ?? '',
                            department: emp.designation ?? '',
                            imageWidget: CachedImage(
                              key: ValueKey(emp.userId),
                              errorWidget: Center(
                                child: CustomText(
                                  Util.getInitials(
                                    emp.userFullName?.trim().isNotEmpty == true
                                        ? emp.userFullName!
                                        : 'NA',
                                  ),
                                  fontSize:
                                      20 *
                                      Responsive.getResponsiveText(context),
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.getColor(context).primary,
                                ),
                              ),
                              imageProvider: NetworkImage(
                                emp.userProfilePic ?? '',
                              ),
                            ),
                            isSelected:
                                st?.selectedEmployeeIds.contains(emp.userId) ??
                                false,
                            onSelected: (_) async {
                              final appointmentBloc = context
                                  .read<AppointmentBloc>();

                              final bool? appointmentAdded =
                                  await showModalBottomSheet<bool>(
                                    isScrollControlled: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(
                                            14 *
                                                Responsive.getResponsive(
                                                  context,
                                                ),
                                          ),
                                    ),
                                    context: context,
                                    builder: (bottomSheetContext) =>
                                        BlocProvider.value(
                                          value: appointmentBloc,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(
                                                bottomSheetContext,
                                              ).viewInsets.bottom,
                                            ),
                                            child: SingleChildScrollView(
                                              child:
                                                  AppointmentDetailsBottomSheet(
                                                    appointmentForUserId:
                                                        emp.userId ?? '',
                                                    userFullName:
                                                        emp.userFullName ?? '',
                                                    userMobile:
                                                        emp.userMobile ?? 'N/A',
                                                    userProfilePic:
                                                        emp.userProfilePic ??
                                                        AppAssets.myCoLogo,
                                                  ),
                                            ),
                                          ),
                                        ),
                                  );
                              if (appointmentAdded == true) {
                                Navigator.pop(context, true);
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
    );
  }

  Widget _dropdownBranch(
    BuildContext ctx,
    EmployeeLoaded? st,
    EmployeeBloc bloc,
  ) => GestureDetector(
    onTap: () async {
      if (st == null) return;

      final selectedMap = await showCustomSimpleBottomSheet(
        context: ctx,
        heading: 'branch',
        dataList: st.branches
            .map((b) => {'id': b.branchId ?? '', 'name': b.branchName ?? ''})
            .toList(),
        selectedId: st.selectedBranch?.branchId,
      );

      if (selectedMap == null ||
          selectedMap['id'] == st.selectedBranch?.branchId) {
        return;
      }

      final branch = Branch(
        branchId: selectedMap['id'],
        branchName: selectedMap['name'],
      );

      _searchController.clear();
      FocusScope.of(ctx).unfocus();

      bloc.add(ChangeBranch(branch));
    },
    child: _buildDropdownBox(ctx, st?.selectedBranch?.branchName ?? 'branch'),
  );

  Widget _dropdownDepartment(
    BuildContext ctx,
    EmployeeLoaded? st,
    List<Department> depts,
    EmployeeBloc bloc,
    List<Department> department,
  ) => GestureDetector(
    onTap: () async {
      if (st == null) return;

      final selectedMap = await showCustomSimpleBottomSheet(
        context: ctx,
        heading: 'department',
        dataList: department
            .map(
              (d) => {
                'id': d.departmentId ?? '',
                'name': d.departmentName ?? '',
              },
            )
            .toList(),
        selectedId: st.selectedDepartment?.departmentId,
      );

      if (selectedMap == null ||
          selectedMap['id'] == st.selectedDepartment?.departmentId) {
        return;
      }

      final dept = Department(
        departmentId: selectedMap['id'],
        departmentName: selectedMap['name'],
      );

      _searchController.clear();
      FocusScope.of(ctx).unfocus();

      bloc.add(ChangeDepartment(dept));
    },
    child: _buildDropdownBox(
      ctx,
      st?.selectedDepartment?.departmentName ?? 'department',
    ),
  );

  Widget _buildDropdownBox(BuildContext context, String text) {
    final boxHeight = Responsive.isTablet(context)
        ? 48.0
        : 44 * Responsive.getResponsive(context);
    final horizontalPadding = Responsive.isTablet(context) ? 16.0 : 10.0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      height: boxHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
        border: Border.all(color: AppTheme.getColor(context).outline),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomText(
              LanguageManager().get(text),
              fontSize: 14 * Responsive.getResponsiveText(context),
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              color: AppTheme.getColor(context).primary,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            size: Responsive.isTablet(context)
                ? 0.060 * Responsive.getHeight(context)
                : 0.020 * Responsive.getHeight(context),
            color: AppTheme.getColor(context).primary,
          ),
        ],
      ),
    );
  }
}
