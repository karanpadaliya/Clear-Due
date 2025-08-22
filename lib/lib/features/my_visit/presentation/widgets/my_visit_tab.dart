import 'package:flutter/material.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/visit_entity.dart';
import 'package:myco_flutter/features/my_visit/presentation/widgets/date_selection_row.dart';
import 'package:myco_flutter/features/my_visit/presentation/widgets/shimmer_myvisit_tab.dart';
import 'package:myco_flutter/widgets/custom_no_data_widget.dart';
import 'package:myco_flutter/widgets/custom_searchfield.dart';

class MyVisitTab extends StatelessWidget {
  final TextEditingController searchController;
  final FocusNode searchFocus;
  final String formattedDate;
  final VoidCallback goToPreviousDate;
  final VoidCallback goToNextDate;
  final VoidCallback selectDateFromPicker;
  final List<MyVisitEntity> visitList;
  final Widget Function(BuildContext, MyVisitEntity, int, int) buildVisitCard;
  final Widget buildAutoExpenseCard;
  final bool isLoadingVisits;

  const MyVisitTab({
    required this.searchController, required this.searchFocus, required this.formattedDate, required this.goToPreviousDate, required this.goToNextDate, required this.selectDateFromPicker, required this.visitList, required this.buildVisitCard, required this.buildAutoExpenseCard, super.key,
    this.isLoadingVisits = false,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: Responsive.getResponsive(context) * VariableBag.screenHorizontalPadding,
      vertical: Responsive.getResponsive(context) * VariableBag.tabBarAfterSpace,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // DateSelectionRow
        DateSelectionRow(
          formattedDate: formattedDate,
          goToPreviousDate: goToPreviousDate,
          goToNextDate: goToNextDate,
          selectDateFromPicker: selectDateFromPicker,
        ),
        SizedBox(height: Responsive.getHeight(context) * 0.010),

        // Search Field
        CustomSearchField(
          controller: searchController,
          hintText: 'Search with Customer',
        ),
        SizedBox(height: Responsive.getHeight(context) * 0.010),

        // Auto Expense Card
        buildAutoExpenseCard,
        SizedBox(height: Responsive.getHeight(context) * 0.010),

        // Visit List - Only this is scrollable and needs shimmer
        Expanded(
          child: isLoadingVisits
              ? ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) => const ShimmerVisitCard(),
          )
              : visitList.isEmpty
              ? const Center(child: CustomNoDataWidget(assetPath: '' ,message: 'There is no Data found',))
              : ListView.builder(
            itemCount: visitList.length,
            itemBuilder: (context, index) => buildVisitCard(
              context,
              visitList[index],
              index,
              visitList.length,
            ),
          ),
        ),
      ],
    ),
  );
}