import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/my_visit/presentation/bloc/bloc_api/visit_api_bloc.dart';
import 'package:myco_flutter/features/my_visit/presentation/bloc/bloc_api/visit_api_event.dart';
import 'package:myco_flutter/features/my_visit/presentation/bloc/bloc_api/visit_api_state.dart';
import 'package:myco_flutter/features/my_visit/presentation/bloc/bloc_ui/visit_bloc.dart';
import 'package:myco_flutter/features/my_visit/presentation/widgets/auto_expense_card.dart';
import 'package:myco_flutter/features/my_visit/presentation/widgets/build_other_employee_visit_tab.dart';
import 'package:myco_flutter/features/my_visit/presentation/widgets/custom_visit_calender.dart';
import 'package:myco_flutter/features/my_visit/presentation/widgets/my_visit_tab.dart';
import 'package:myco_flutter/features/my_visit/presentation/widgets/visit_card.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_myco_tabbar.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/floating_action_btn.dart';

class MyVisitPage extends StatelessWidget {
  const MyVisitPage({super.key});

  String formattedDate(DateTime date) => DateFormat('dd MMM yyyy').format(date);

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return BlocConsumer<VisitBloc, VisitState>(
      listener: (context, visitState) {
        if (visitState is VisitLoaded) {
          final selectedDate = visitState.selectedDate;
          final formattedDateForApi = DateFormat(
            'yyyy-MM-dd',
          ).format(selectedDate);

          final visitApiState = context.read<VisitApiBloc>().state;
          final isSameDateLoaded =
              visitApiState is VisitApiLoaded &&
              visitApiState.loadedFilterDate == formattedDateForApi;

          if (!isSameDateLoaded) {
            context.read<VisitApiBloc>().add(
              GetVisitDataEvent(filterDate: formattedDateForApi),
            );
          }
        }
      },
      builder: (context, state) {
        final selectedIndex = state is VisitLoaded ? state.selectedIndex : 0;
        final selectedDate = state is VisitLoaded
            ? state.selectedDate
            : DateTime.now();

        final Color tabBorderColor = selectedIndex == 0
            ? AppColors.primary
            : AppColors.secondary;

        return Scaffold(
          appBar: CustomAppbar(
            title: 'Visit',
            actions: [
              Padding(
                padding: EdgeInsets.only(
                  right: 12 * Responsive.getResponsiveText(context),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      'Latitude: 22.938088',
                      isKey: false,
                      fontSize: 10 * Responsive.getResponsiveText(context),
                      fontWeight: FontWeight.w600,
                      color: AppTheme.getColor(context).primary,
                    ),
                    CustomText(
                      'Longitude: 72.938088',
                      fontSize: 10 * Responsive.getResponsiveText(context),
                      fontWeight: FontWeight.w600,
                      color: AppTheme.getColor(context).primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: BlocBuilder<VisitApiBloc, VisitApiState>(
            builder: (context, state) {
              final data = state is VisitApiLoaded
                  ? state.visitModelEntity
                  : null;
              final expenseCategoryList = data?.expenseCategory ?? [];
              final visitlist = data?.myVisits ?? [];

              final bool isLoadingVisits = state is VisitLoadingState;

              return Column(
                children: [
                  MyCustomTabBar(
                    tabs: const ['My Visit', 'Other Employee Visit'],
                    selectedIndex: selectedIndex,
                    onTabChange: (index) {
                      context.read<VisitBloc>().add(TabChanged(index));
                    },
                    selectedBgColors: [
                      AppTheme.getColor(context).primary,
                      AppTheme.getColor(context).secondary,
                    ],
                    unselectedBorderAndTextColor: tabBorderColor,
                    tabBarBorderColor: tabBorderColor,
                    isShadowBottomLeft: true,
                  ),
                  Expanded(
                    child: selectedIndex == 0
                        ? MyVisitTab(
                            searchController: TextEditingController(),
                            searchFocus: FocusNode(),
                            formattedDate: formattedDate(selectedDate),
                            goToPreviousDate: () =>
                                context.read<VisitBloc>().add(PreviousDate()),
                            goToNextDate: () =>
                                context.read<VisitBloc>().add(NextDate()),
                            selectDateFromPicker: () async {
                              final result =
                                  await showModalBottomSheet<Map<String, int>>(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (_) =>
                                        CustomVisitCupertinoDatePicker(
                                          initialDate: selectedDate,
                                        ),
                                  );
                              if (!context.mounted) return;
                              if (result != null) {
                                final picked = DateTime(
                                  result['year']!,
                                  result['month']!,
                                  result['day']!,
                                );
                                context.read<VisitBloc>().add(
                                  UpdateSelectedDate(picked),
                                );
                              }
                            },
                            visitList: visitlist,
                            isLoadingVisits: isLoadingVisits,
                            buildVisitCard: buildVisitCard,
                            buildAutoExpenseCard: AutoExpenseCard(
                              expenses: expenseCategoryList,
                            ),
                          )
                        : buildOtherEmployeeVisitTab(
                            context,
                            searchController: TextEditingController(),
                            searchFocus: FocusNode(),
                            formattedDate: formattedDate(selectedDate),
                            goToPreviousDate: () =>
                                context.read<VisitBloc>().add(PreviousDate()),
                            goToNextDate: () =>
                                context.read<VisitBloc>().add(NextDate()),
                            selectDateFromPicker: () async {
                              final result =
                                  await showModalBottomSheet<Map<String, int>>(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (_) =>
                                        CustomVisitCupertinoDatePicker(
                                          initialDate: selectedDate,
                                        ),
                                  );
                              if (!context.mounted) return;
                              if (result != null) {
                                final picked = DateTime(
                                  result['year']!,
                                  result['month']!,
                                  result['day']!,
                                );
                                context.read<VisitBloc>().add(
                                  UpdateSelectedDate(picked),
                                );
                              }
                            },
                          ),
                  ),
                ],
              );
            },
          ),

          floatingActionButton: selectedIndex == 0
              ? ExpandableFab(
                  openIcon: Icons.add,
                  closeIcon: Icons.close,
                  actions: [
                    ExpandableFabAction(
                      label: 'Add Visit',
                      icon: Icons.location_on,
                      onTap: () => context.pushNamed('assign-to-visit'),
                    ),
                    ExpandableFabAction(
                      label: 'Add Expense',
                      icon: Icons.money,
                      onTap: () => context.pushNamed('add-expense'),
                    ),
                  ],
                  imageSize: 66 * Responsive.getResponsiveText(context),
                  innericonsize: 20 * Responsive.getResponsiveText(context),
                  circleavataradius: 22 * Responsive.getResponsiveText(context),
                  innericonbgr: AppColors.white,
                  margin: EdgeInsets.only(
                    right: 10 * Responsive.getResponsiveText(context),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 14 * Responsive.getResponsiveText(context),
                    vertical: 8 * Responsive.getResponsiveText(context),
                  ),
                )
              : null,
        );
      },
    );
  }
}
