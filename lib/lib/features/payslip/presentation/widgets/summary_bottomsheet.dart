import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/payslip/presentation/widgets/payslip_card.dart';
import 'package:myco_flutter/widgets/common_card.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class SummaryBottomsheet extends StatelessWidget {
  const SummaryBottomsheet({
    required this.basic,
    required this.basicName,
    required this.hra,
    required this.hraName,
    required this.conveyance,
    required this.conveyanceName,
    required this.paidLeaveAllowance,
    required this.leaveEncashment,
    required this.totalEarnings,
    required this.professionalTax,
    required this.professionalTaxName,
    required this.grossDeductions,
    required this.grossDeductionsName,
    required this.totalEmplotersContributions,
    super.key,
  });
  final String basic;
  final String basicName;
  final String hra;
  final String hraName;
  final String conveyance;
  final String conveyanceName;
  final String paidLeaveAllowance;
  final String leaveEncashment;
  final String totalEarnings;

  final String professionalTax;
  final String professionalTaxName;
  final String grossDeductions;
  final String grossDeductionsName;

  final String totalEmplotersContributions;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(
      horizontal: 0.06 * Responsive.getWidth(context),
    ),
    child: Column(
      children: [
        Row(
          children: [
            const BackButton(),
            CustomText(
              'summary',
              color: AppTheme.getColor(context).onSurface,
              fontSize: 18 * Responsive.getResponsiveText(context),
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(16.0 * Responsive.getResponsive(context)),
          child: Column(
            children: [
              //  'Earnings Card',
              CommonCard(
                title: 'earnings',
                bottomWidget: Padding(
                  padding: EdgeInsets.all(
                    10.0 * Responsive.getResponsive(context),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            basicName,
                            color: AppTheme.getColor(context).onSurface,
                            fontSize:
                                15 * Responsive.getResponsiveText(context),
                            fontWeight: FontWeight.w500,
                          ),
                          CustomText(
                            basic,
                            color: AppTheme.getColor(context).onSurface,
                            fontSize:
                                15 * Responsive.getResponsiveText(context),
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            hraName,
                            color: AppTheme.getColor(context).onSurface,
                            fontSize:
                                15 * Responsive.getResponsiveText(context),
                            fontWeight: FontWeight.w500,
                          ),
                          CustomText(
                            hra,
                            color: AppTheme.getColor(context).onSurface,
                            fontSize:
                                15 * Responsive.getResponsiveText(context),
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            conveyanceName,
                            color: AppTheme.getColor(context).onSurface,
                            fontSize:
                                15 * Responsive.getResponsiveText(context),
                            fontWeight: FontWeight.w500,
                          ),
                          CustomText(
                            conveyance,
                            color: AppTheme.getColor(context).onSurface,
                            fontSize:
                                15 * Responsive.getResponsiveText(context),
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            'paid_leave_allowance',
                            color: AppTheme.getColor(context).onSurface,
                            fontSize:
                                15 * Responsive.getResponsiveText(context),
                            fontWeight: FontWeight.w500,
                          ),
                          CustomText(
                            paidLeaveAllowance,
                            color: AppTheme.getColor(context).onSurface,
                            fontSize:
                                15 * Responsive.getResponsiveText(context),
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            'leave_inCaseMent',
                            color: AppTheme.getColor(context).onSurface,
                            fontSize:
                                15 * Responsive.getResponsiveText(context),
                            fontWeight: FontWeight.w500,
                          ),
                          CustomText(
                            leaveEncashment,
                            color: AppTheme.getColor(context).onSurface,
                            fontSize:
                                15 * Responsive.getResponsiveText(context),
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
                            'total_earnings',
                            color: AppTheme.getColor(context).onSurface,
                            fontWeight: FontWeight.w700,
                            fontSize:
                                15 * Responsive.getResponsiveText(context),
                          ),
                          CustomText(
                            totalEarnings,
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
              SizedBox(height: .025 * Responsive.getHeight(context)),
              //  'Deductions Card',
              CommonCard(
                title: 'deductions',
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
                            professionalTaxName,
                            color: AppTheme.getColor(context).onSurface,
                            fontSize:
                                16 * Responsive.getResponsiveText(context),
                            fontWeight: FontWeight.w500,
                          ),
                          CustomText(
                            professionalTax,
                            color: AppTheme.getColor(context).onSurface,
                            fontSize:
                                16 * Responsive.getResponsiveText(context),
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
                            grossDeductionsName,
                            color: AppTheme.getColor(context).onSurface,
                            fontWeight: FontWeight.w700,
                            fontSize:
                                16 * Responsive.getResponsiveText(context),
                          ),
                          CustomText(
                            grossDeductions,
                            color: AppTheme.getColor(context).onSurface,
                            fontWeight: FontWeight.w700,
                            fontSize:
                                16 * Responsive.getResponsiveText(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: .03 * Responsive.getHeight(context)),
              // 'Employer Contribution Card',
              CommonCard(
                title: 'employer_contribution',
                headerColor: AppTheme.getColor(context).primary,
                bottomWidget: Padding(
                  padding: EdgeInsets.all(
                    10.0 * Responsive.getResponsive(context),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            'total_employers_contribution',
                            color: AppTheme.getColor(context).onSurface,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                15 * Responsive.getResponsiveText(context),
                          ),
                          CustomText(
                            totalEmplotersContributions,
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
          ),
        ),
      ],
    ),
  );
}
