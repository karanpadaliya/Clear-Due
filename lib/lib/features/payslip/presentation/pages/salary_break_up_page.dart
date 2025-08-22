import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/payslip/domain/entities/ctc_details_entity.dart';
import 'package:myco_flutter/features/payslip/presentation/bloc/payslip_bloc.dart';
import 'package:myco_flutter/features/payslip/presentation/widgets/error_widget.dart';
import 'package:myco_flutter/features/payslip/presentation/widgets/no_data_available_widget.dart';
import 'package:myco_flutter/features/payslip/presentation/widgets/payslip_card.dart';
import 'package:myco_flutter/features/payslip/presentation/widgets/shimmer_salary_loading.dart';
import 'package:myco_flutter/widgets/common_card.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_myco_tabbar.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class SalaryBreakUpPage extends StatefulWidget {
  const SalaryBreakUpPage({super.key});

  @override
  State<SalaryBreakUpPage> createState() => _SalaryBreakUpPageState();
}

class _SalaryBreakUpPageState extends State<SalaryBreakUpPage> {
  @override
  void initState() {
    super.initState();
    context.read<PayslipBloc>().add(GetCtcDetailsEvent());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const CustomAppbar(title: 'salary_break_up'),

    body: Container(
      padding: EdgeInsets.symmetric(
        horizontal: 0.08 * Responsive.getWidth(context),
      ),
      child: Column(
        children: [
          MyCustomTabBar(
            tabs: [
              LanguageManager().get('monthly'),
              LanguageManager().get('annually'),
            ],
            selectedBgColors: [
              AppTheme.getColor(context).secondary,
              AppTheme.getColor(context).primary,
            ],
            unselectedBorderAndTextColor: AppTheme.getColor(context).primary,
            tabBarBorderColor: AppColors.black,
            selectedIndex: 0,
            isShadowBottomLeft: true,
          ),
          SizedBox(height: 0.02 * Responsive.getHeight(context)),
          // Monthly CTC details screen
          BlocBuilder<PayslipBloc, PayslipState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const ShimmerSalaryLoadingWidget(loadingFor: 'ctc');
              }

              if (state.error.isNotEmpty) {
                return PayslipErrorWidget(error: state.error);
              }

              if (state.ctcDetailsEntity.ctcHeads == null &&
                  state.ctcDetailsEntity.earningHeads == null &&
                  state.ctcDetailsEntity.deductionHeads == null) {
                return const NoDataAvailableWidget();
              }

              final ctcDetails = state.ctcDetailsEntity;

              final List<DeductionHeadEntity> deductionHeads =
                  ctcDetails.deductionHeads ?? [];

              final List<EarningHeadEntity> earningHeads =
                  ctcDetails.earningHeads ?? [];

              final List<CtcHeadEntity> ctcHeads = ctcDetails.ctcHeads ?? [];
              return Column(
                children: [
                  // Earning Card
                  CommonCard(
                    title: 'earnings',
                    bottomWidget: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 0.04 * Responsive.getWidth(context),
                        vertical: 0.01 * Responsive.getHeight(context),
                      ),
                      child: Column(
                        children: [
                          Table(
                            border: TableBorder(
                              verticalInside: BorderSide(
                                color: AppTheme.getColor(context).outline,
                              ),
                            ),
                            children: [
                              TableRow(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: AppTheme.getColor(context).outline,
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                      right: 0.1 * Responsive.getWidth(context),
                                      top:
                                          0.005 * Responsive.getHeight(context),
                                      bottom:
                                          0.005 * Responsive.getHeight(context),
                                    ),
                                    child: CustomText(
                                      'salary_head',
                                      fontWeight: FontWeight.w700,
                                      fontSize:
                                          14 *
                                          Responsive.getResponsiveText(context),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: 0.2 * Responsive.getWidth(context),
                                      top:
                                          0.005 * Responsive.getHeight(context),
                                      bottom:
                                          0.005 * Responsive.getHeight(context),
                                    ),
                                    child: CustomText(
                                      'amount'
                                      '(₹)',
                                      fontWeight: FontWeight.w700,
                                      fontSize:
                                          13 *
                                          Responsive.getResponsiveText(context),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                      top:
                                          0.005 * Responsive.getHeight(context),
                                    ),
                                    child: CustomText(
                                      earningHeads.isEmpty
                                          ? 'N/A'
                                          : earningHeads[0].headName ?? 'Basic',
                                      fontSize:
                                          12 *
                                          Responsive.getResponsiveText(context),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: 0.23 * Responsive.getWidth(context),
                                      top:
                                          0.005 * Responsive.getHeight(context),
                                      bottom:
                                          0.005 * Responsive.getHeight(context),
                                    ),
                                    child: CustomText(
                                      // '19,500.00',
                                      earningHeads.isEmpty
                                          ? 'N/A'
                                          : earningHeads[0].salaryPerMonth ??
                                                '',
                                      fontSize:
                                          12 *
                                          Responsive.getResponsiveText(context),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                      top:
                                          0.005 * Responsive.getHeight(context),
                                    ),
                                    child: CustomText(
                                      earningHeads.isEmpty
                                          ? 'N/A'
                                          : earningHeads[1].headName ?? 'HRA',
                                      fontSize:
                                          12 *
                                          Responsive.getResponsiveText(context),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: 0.23 * Responsive.getWidth(context),
                                      top:
                                          0.005 * Responsive.getHeight(context),
                                      bottom:
                                          0.005 * Responsive.getHeight(context),
                                    ),
                                    child: CustomText(
                                      // '7,800.00',
                                      earningHeads.isEmpty
                                          ? 'N/A'
                                          : earningHeads[1].salaryPerMonth ??
                                                '',
                                      fontSize:
                                          12 *
                                          Responsive.getResponsiveText(context),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                      top:
                                          0.005 * Responsive.getHeight(context),
                                    ),
                                    child: CustomText(
                                      earningHeads.isEmpty
                                          ? 'N/A'
                                          : earningHeads[2].headName ??
                                                'conveyance',
                                      // 'Conveyance',
                                      fontSize:
                                          12 *
                                          Responsive.getResponsiveText(context),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: 0.23 * Responsive.getWidth(context),
                                      top:
                                          0.005 * Responsive.getHeight(context),
                                      bottom:
                                          0.005 * Responsive.getHeight(context),
                                    ),
                                    child: CustomText(
                                      // '11,700.00',
                                      earningHeads.isEmpty
                                          ? 'N/A'
                                          : earningHeads[2].salaryPerMonth ??
                                                '',
                                      fontSize:
                                          12 *
                                          Responsive.getResponsiveText(context),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                      top:
                                          0.005 * Responsive.getHeight(context),
                                    ),
                                    child: CustomText(
                                      'gross_salary_per_month',
                                      // 'Gross Salary /\nper Month',
                                      fontSize:
                                          12 *
                                          Responsive.getResponsiveText(context),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: 0.23 * Responsive.getWidth(context),
                                      top:
                                          0.005 * Responsive.getHeight(context),
                                      bottom:
                                          0.005 * Responsive.getHeight(context),
                                    ),
                                    child: CustomText(
                                      // '39,000.00',
                                      ctcHeads.isEmpty
                                          ? 'N/A'
                                          : ctcHeads[0].ctcPerMonth ?? '',
                                      fontSize:
                                          12 *
                                          Responsive.getResponsiveText(context),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                      top: 0.01 * Responsive.getHeight(context),
                                    ),
                                    child: CustomText(
                                      'Salary (CTC) /\nper Month',
                                      fontSize:
                                          12 *
                                          Responsive.getResponsiveText(context),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: 0.23 * Responsive.getWidth(context),
                                      top:
                                          0.005 * Responsive.getHeight(context),
                                      bottom:
                                          0.005 * Responsive.getHeight(context),
                                    ),
                                    child: CustomText(
                                      // '39,000.00',
                                      ctcHeads.isEmpty
                                          ? 'N/A'
                                          : ctcHeads[0].ctcPerAnnum ?? '',
                                      fontSize:
                                          12 *
                                          Responsive.getResponsiveText(context),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: .02 * Responsive.getHeight(context)),
                  // Deductions Card
                  CommonCard(
                    title: 'deductions',
                    // 'Deductions',
                    headerColor: AppTheme.getColor(context).error,
                    bottomWidget: Container(
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
                                // If list comes as empty then show N/A
                                deductionHeads.isEmpty
                                    ? 'N/A'
                                    : deductionHeads[1].headName ??
                                          'professional_tex',
                                // 'Professional Tax',
                                color: AppTheme.getColor(context).onSurface,
                                fontSize:
                                    14 * Responsive.getResponsiveText(context),
                                fontWeight: FontWeight.w500,
                              ),
                              CustomText(
                                // '₹2,222.00',
                                // If list comes as empty then show N/A
                                deductionHeads.isEmpty
                                    ? 'N/A'
                                    : deductionHeads[0].perMonth ?? '',
                                color: AppTheme.getColor(context).onSurface,
                                fontSize:
                                    14 * Responsive.getResponsiveText(context),
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                          DottedLineWidget(
                            color: AppTheme.getColor(context).onSurface,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                'gross_deduction',
                                // 'Total Deduction',
                                color: AppTheme.getColor(context).onSurface,
                                fontWeight: FontWeight.w700,
                                fontSize:
                                    15 * Responsive.getResponsiveText(context),
                              ),
                              CustomText(
                                // '₹2,222.00',
                                // If list comes as empty then show N/A
                                deductionHeads.isEmpty
                                    ? 'N/A'
                                    : deductionHeads[1].perMonth ?? '',
                                color: AppTheme.getColor(context).onSurface,
                                fontWeight: FontWeight.w700,
                                fontSize:
                                    15 * Responsive.getResponsiveText(context),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: .02 * Responsive.getHeight(context)),
                  // Net Pay Card
                  CommonCard(
                    title: 'net_pay',
                    // 'Net Pay',
                    headerColor: AppTheme.getColor(context).primary,
                    bottomWidget: Container(
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
                                'salary_in_hand_per_month',
                                // 'Salary in Hand (Per Month)',
                                color: AppTheme.getColor(context).onSurface,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    15 * Responsive.getResponsiveText(context),
                              ),
                              CustomText(
                                // '₹38,800.00',
                                ctcDetails.netSalaryPerMonthInHand ?? '',
                                color: AppTheme.getColor(context).onSurface,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    15 * Responsive.getResponsiveText(context),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 0.005 * Responsive.getHeight(context),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                'Salary (CTC) / (Per Year)',
                                color: AppTheme.getColor(context).onSurface,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    15 * Responsive.getResponsiveText(context),
                              ),
                              CustomText(
                                // '₹468,000.00',
                                ctcDetails.netSalaryPerAnnumInHand ?? '',
                                color: AppTheme.getColor(context).onSurface,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    15 * Responsive.getResponsiveText(context),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    ),
  );
}
