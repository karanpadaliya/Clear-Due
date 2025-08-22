import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/payslip/presentation/bloc/payslip_bloc.dart';
import 'package:myco_flutter/features/payslip/presentation/widgets/error_widget.dart';
import 'package:myco_flutter/features/payslip/presentation/widgets/no_data_available_widget.dart';
import 'package:myco_flutter/features/payslip/presentation/widgets/shimmer_salary_loading.dart';
import 'package:myco_flutter/widgets/common_card.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class OtherEarnings extends StatelessWidget {
  const OtherEarnings({super.key});

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<OtherEarningsBloc, PayslipState>(
    builder: (context, state) {
      if (state.getOtherEarningsLoading) {
        return const ShimmerSalaryLoadingWidget(loadingFor: 'payslip');
      }

      if (state.getOtherEarningsError.isNotEmpty) {
        return PayslipErrorWidget(error: state.error);
      }

      if (state.otherEarningsEntity.otherEarnings == null) {
        return const NoDataAvailableWidget();
      }

      final otherEarnings = state.otherEarningsEntity.otherEarnings ?? [];
      // If Api gets called Successfully and no data found
      if (otherEarnings.isEmpty) {
        return Column(
          children: [
            SizedBox(height: 0.3 * Responsive.getHeight(context)),
            const CustomText('no_data_available'),
          ],
        );
      }
      return Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 0.08 * Responsive.getWidth(context),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Other Earnings card list view
              Expanded(
                child: ListView.separated(
                  itemCount: otherEarnings.length,
                  itemBuilder: (context, index) => CommonCard(
                    title: otherEarnings[index].leavePayoutDate ?? '',
                    showHeaderPrefixIcon: true,
                    headerPrefixIcon: 'assets/payslip/calendar.png',
                    headerPrefixIconHeight:
                        0.025 * Responsive.getHeight(context),
                    headerColor: AppTheme.getColor(context).primary,
                    bottomWidget: getCommonCardBottomWidget(
                      context,
                      leaveTypeName: otherEarnings[index].leaveTypeName ?? '',
                      numberOfPayoutLeaves:
                          otherEarnings[index].noOfPayoutLeaves ?? '',
                      leavePayoutAmount:
                          otherEarnings[index].leavePayoutAmount ?? '',
                    ),
                  ),
                  separatorBuilder: (context, index) =>
                      SizedBox(height: 0.02 * Responsive.getHeight(context)),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  Container getCommonCardBottomWidget(
    BuildContext context, {
    required String leaveTypeName,
    required String numberOfPayoutLeaves,
    required String leavePayoutAmount,
  }) => Container(
    padding: EdgeInsets.symmetric(
      horizontal: 0.04 * Responsive.getWidth(context),
      vertical: 0.01 * Responsive.getHeight(context),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              leaveTypeName,
              fontSize: 15 * Responsive.getResponsiveText(context),
              fontWeight: FontWeight.w700,
            ),
            CustomText(
              'net_pay',
              fontSize: 15 * Responsive.getResponsiveText(context),
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        SizedBox(height: 0.005 * Responsive.getHeight(context)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              'total_leave_days'
              ': $numberOfPayoutLeaves',
              fontSize: 15 * Responsive.getResponsiveText(context),
              fontWeight: FontWeight.w500,
            ),
            CustomText(
              leavePayoutAmount,
              fontSize: 15 * Responsive.getResponsiveText(context),
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ],
    ),
  );
}
