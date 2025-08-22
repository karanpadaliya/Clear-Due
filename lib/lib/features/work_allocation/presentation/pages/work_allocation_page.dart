import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/di/injector.dart';
import 'package:myco_flutter/features/work_allocation/presentation/bloc/work_allocation/work_allocation_bloc.dart';
import 'package:myco_flutter/features/work_allocation/presentation/widgets/work_allocation_card_list_view.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_month_year_picker_header/month_year_header.dart';
import 'package:myco_flutter/widgets/custom_searchfield.dart';
import 'package:myco_flutter/widgets/floating_action_btn.dart';

class WorkAllocationPage extends StatefulWidget {
  const WorkAllocationPage({super.key});

  @override
  State<WorkAllocationPage> createState() => _WorkAllocationPageState();
}

class _WorkAllocationPageState extends State<WorkAllocationPage> {
  String _searchQuery = '';
  int? selectedMonth;
  int? selectedYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) => BlocProvider<WorkAllocationBloc>(
    create: (context) => sl<WorkAllocationBloc>(),
    child: Scaffold(
      appBar: const CustomAppbar(title: 'work_allocation', isKey: true),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              VariableBag.screenHorizontalPadding *
              Responsive.getResponsive(context),
        ),
        child: Column(
          children: [
            /// search field
            CustomSearchField(
              hintText: LanguageManager().get('search'),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.trim().toLowerCase();
                });
              },
            ),
            SizedBox(height: 0.01 * Responsive.getHeight(context)),

            /// calender
            MonthYearHeader(
              startYear: DateTime.now()
                  .subtract(const Duration(days: 365 * 2))
                  .year,
              endYear: DateTime.now().add(const Duration(days: 365 * 1)).year,
              iconSize: 0.02 * Responsive.getHeight(context),
              onChanged: (month, year) {
                setState(() {
                  selectedMonth = month;
                  selectedYear = year;
                });
              },
            ),
            SizedBox(height: 0.01 * Responsive.getHeight(context)),

            /// work allocation list
            Expanded(
              child: WorkAllocationCardListView(
                searchText: _searchQuery,
                selectedMonth: selectedMonth,
                selectedYear: selectedYear,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ExpandableFab(
        innericonsize: 30 * Responsive.getResponsive(context),
        imageSize: 50 * Responsive.getResponsive(context),
        onTap: () {
          context.pushNamed('assignWork');
        },
        openIcon: Icons.add,
        closeIcon: Icons.close,
        actions: const [],
      ),
    ),
  );
}
