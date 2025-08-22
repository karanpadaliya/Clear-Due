import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/visit_entity.dart';
import 'package:myco_flutter/features/my_visit/presentation/bloc/bloc_ui/visit_bloc.dart';
import 'package:myco_flutter/widgets/common_card.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:shimmer/shimmer.dart';

class AutoExpenseCard extends StatelessWidget {
  final List<ExpenseCategoryEntity> expenses;

  const AutoExpenseCard({
    required this.expenses, super.key,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.getResponsive(context);
    final color = AppTheme.getColor(context);

    return BlocBuilder<VisitBloc, VisitState>(
      builder: (context, state) => CommonCard(
          borderRadius: 12 * responsive,
          title: 'Auto Expense Category',
          headerColor: color.tertiary,
          borderColor: color.outline,
          showHeaderPrefixIcon: false,
          showBlackShadowInChild: true,
          onHeaderTap: () => context.read<VisitBloc>().add(ToggleAutoExpence()),
          headerBottomBorderRadius: 12 * responsive,
          suffixIcon: Icon(
            state is VisitLoaded && state.ToggleAutoExpence ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: AppColors.white,
            size: Responsive.getDashboardResponsiveText(context) * 30,
          ),
          bottomWidget: state is VisitLoaded && state.ToggleAutoExpence ?

          Padding(
            padding: EdgeInsets.all(12 * responsive),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: expenses.isEmpty
                    ? List.generate(
                  4,
                      (index) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      margin: EdgeInsets.only(right: 8 * responsive),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        vertical: 8 * responsive,
                        horizontal: 12 * responsive,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8 * responsive),
                        color: Colors.white,
                      ),
                      child: SizedBox(
                        width: 80 * responsive,
                        height: 12 * Responsive.getResponsiveText(context),
                      ),
                    ),
                  ),
                )
                    : expenses.map((expense) =>
                    Container(
                      margin: EdgeInsets.only(right: 8 * responsive),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        vertical: 8 * responsive,
                        horizontal: 12 * responsive,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8 * responsive),
                        border: Border.all(color: color.tertiary),
                      ),
                      child: CustomText(
                        expense.expenseCategoryName ?? 'N/A',
                        fontSize: 12 * Responsive.getResponsiveText(context),
                        fontWeight: FontWeight.w700,
                        color: color.onSurface,
                      ),
                    )).toList(),
              ),
            ),
          )
              :
          const SizedBox.shrink(),
        ),
    );
  }
}
