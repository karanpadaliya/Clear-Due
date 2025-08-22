import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/idea_box/presentation/widgets/common_container.dart';
import 'package:myco_flutter/features/payslip/presentation/bloc/payslip_bloc.dart';
import 'package:myco_flutter/features/payslip/presentation/widgets/custom_piechart.dart';
import 'package:myco_flutter/features/payslip/presentation/widgets/error_widget.dart';
import 'package:myco_flutter/features/payslip/presentation/widgets/header_custom_painter.dart';
import 'package:myco_flutter/features/payslip/presentation/widgets/payslip_card.dart';
import 'package:myco_flutter/features/payslip/presentation/widgets/payslip_webview.dart';
import 'package:myco_flutter/features/payslip/presentation/widgets/shimmer_salary_loading.dart';
import 'package:myco_flutter/features/take_order/presentation/widgets/bottomsheet_config.dart';
import 'package:myco_flutter/features/take_order/presentation/widgets/side_by_side_buttons.dart';
import 'package:myco_flutter/widgets/big_textfield.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class PayslipDetail extends StatefulWidget {
  final String salarySlipId;
  const PayslipDetail({required this.salarySlipId, super.key});

  @override
  State<PayslipDetail> createState() => _PayslipDetailState();
}

class _PayslipDetailState extends State<PayslipDetail> {
  TextEditingController raiseIssueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PayslipBloc>().add(
      GetSalaryDetailsEvent(salarySlipId: widget.salarySlipId),
    );
  }

  void openPayslipInWebView(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PayslipWebViewScreen(url: url)),
    );
  }

  Future<void> printPayslipFromUrl(String url) async {
    openPayslipInWebView(url);
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      body: BlocConsumer<PayslipBloc, PayslipState>(
        listener: (context, state) {
          if (state.issueResponse.isNotEmpty) {
            // Need to clear the issue details in order to not go into infinite loop of this if block
            context.read<PayslipBloc>().add(ClearIssueDetailsEvent());

            raiseIssueController.clear();

            // Closing the bottomsheet
            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: CustomText(
                  state.issueResponse,
                  color: AppTheme.getColor(context).onSecondary,
                ),
                backgroundColor: AppTheme.getColor(context).secondary,
                duration: const Duration(seconds: 2),
              ),
            );
            return;
          }

          if (state.error.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: CustomText(
                  state.error,
                  color: AppTheme.getColor(context).onError,
                ),
                backgroundColor: AppTheme.getColor(context).error,
                duration: const Duration(seconds: 2),
              ),
            );
            // Need to clear the issue details in order to not go into infinite loop of this if block
            context.read<PayslipBloc>().add(ClearIssueDetailsEvent());
            // return;
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const ShimmerSalaryLoadingWidget(
              loadingFor: 'payslipDetails',
            );
          }

          if (state.error.isNotEmpty) {
            return PayslipErrorWidget(error: state.error);
          }

          if (state.salaryDetailsEntity.status != '200') {
            return Center(
              child: Text(
                state.salaryDetailsEntity.message ?? 'Something Went Wrong',
              ),
            );
          }

          final salaryDetails = state.salaryDetailsEntity;

          // salaryDetails.
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    CustomPaint(
                      size: Size(
                        Responsive.getWidth(context),
                        0.55 * Responsive.getHeight(context),
                      ),
                      painter: HeaderCustomPainter(),
                    ),
                    Column(
                      children: [
                        AppBar(
                          backgroundColor: AppTheme.getColor(context).primary,
                          centerTitle: false,
                          leading: BackButton(
                            color: AppTheme.getColor(context).onPrimary,
                          ),
                          title: CustomText(
                            '${LanguageManager().get('payslip')} ${salaryDetails.salaryMonthYear}',
                            color: AppTheme.getColor(context).onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        SizedBox(height: 0.02 * Responsive.getHeight(context)),
                        SizedBox(height: 0.02 * Responsive.getHeight(context)),

                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 0.08 * Responsive.getWidth(context),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 0.04 * Responsive.getWidth(context),
                              vertical: 0.01 * Responsive.getHeight(context),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                8 * Responsive.getResponsive(context),
                              ),
                              border: Border.all(
                                color: AppTheme.getColor(context).outline,
                              ),
                              color: AppTheme.getColor(context).surface,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      'net_pay',
                                      fontWeight: FontWeight.w600,
                                    ),
                                    CustomText(
                                      'salary_mode',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 0.005 * Responsive.getHeight(context),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      salaryDetails.totalNetSalary ?? '',
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          28 *
                                          Responsive.getResponsiveText(context),
                                      color: AppTheme.getColor(context).primary,
                                    ),
                                    CustomText(
                                      salaryDetails.salaryMode ?? '',
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          16 *
                                          Responsive.getResponsiveText(context),
                                      color: AppTheme.getColor(context).outline,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 0.01 * Responsive.getHeight(context),
                                ),
                                Divider(
                                  thickness: 0.4,
                                  color: AppTheme.getColor(context).onSurface,
                                ),
                                SizedBox(
                                  height: 0.005 * Responsive.getHeight(context),
                                ),
                                CustomText(
                                  '${LanguageManager().get('net_pay')} (In Words)',
                                  fontWeight: FontWeight.w600,
                                  textAlign: TextAlign.start,
                                ),
                                CustomText(
                                  salaryDetails.amountInWords ?? '',
                                  fontSize:
                                      14 *
                                      Responsive.getResponsiveText(context),
                                  color: AppTheme.getColor(context).primary,
                                ),
                              ],
                            ),
                          ),
                        ),
                        // CustomLinePieChart
                        Padding(
                          padding: EdgeInsetsGeometry.symmetric(
                            horizontal: 0.08 * Responsive.getWidth(context),
                          ),
                          child: CustomLinePieChart(
                            isValueOnChart: true,
                            dynamicCenterText: LanguageManager().get('payslip'),
                            totalLeaves: 12.0,
                            totalPaidLeave: 4.0,
                            height: 0.35 * Responsive.getHeight(context),
                            innerRadius: 80 * Responsive.getResponsive(context),
                            segments: [
                              LineChartSegment(
                                label: LanguageManager().get('leave_days'),
                                value: double.parse(
                                  salaryDetails.leaveDays ?? '0',
                                ),
                                color: const Color(0xFF08A4BB),
                              ),
                              LineChartSegment(
                                label: LanguageManager().get('extra_days'),
                                value: double.parse(
                                  salaryDetails.extraDays ?? '0',
                                ),
                                color: const Color(0xFFFF9FEC),
                              ),
                              LineChartSegment(
                                label: LanguageManager().get('paid_week_off'),
                                value: double.parse(
                                  salaryDetails.paidWeekOff ?? '0',
                                ),
                                showShadow: false,
                                color: const Color(0xFF2F648E),
                              ),
                              LineChartSegment(
                                label: LanguageManager().get(
                                  'total_working_days_web',
                                ),
                                value: double.parse(
                                  salaryDetails.totalWorkingDays ?? '0',
                                ),
                                color: const Color(0xFF9FBE00),
                              ),
                              LineChartSegment(
                                label: LanguageManager().get('paid_holidays'),
                                value: double.parse(
                                  salaryDetails.paidHolidays ?? '0',
                                ),
                                color: const Color(0xFF2FBBA4),
                              ),
                              LineChartSegment(
                                label: LanguageManager().get(
                                  'total_special_allowance_c',
                                ),
                                value: double.parse(
                                  salaryDetails.totalSpecialAllowance ?? '0',
                                ),
                                color: const Color(0xFFFDB913),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Earnings Card
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.08 * Responsive.getWidth(context),
                  ),
                  child: CommonCard(
                    title: 'earnings',
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
                                salaryDetails.earningData?[0]?.title ?? 'Basic',
                                color: AppTheme.getColor(context).onSurface,
                                fontSize:
                                    15 * Responsive.getResponsiveText(context),
                                fontWeight: FontWeight.w500,
                              ),
                              CustomText(
                                salaryDetails.earningData?[0]?.value ?? '',
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
                                salaryDetails.earningData?[1]?.title ?? 'HRA',
                                color: AppTheme.getColor(context).onSurface,
                                fontSize:
                                    15 * Responsive.getResponsiveText(context),
                                fontWeight: FontWeight.w500,
                              ),
                              CustomText(
                                salaryDetails.earningData?[1]?.value ?? '',
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
                                salaryDetails.earningData?[2]?.title ??
                                    'conveyance',
                                color: AppTheme.getColor(context).onSurface,
                                fontSize:
                                    15 * Responsive.getResponsiveText(context),
                                fontWeight: FontWeight.w500,
                              ),
                              CustomText(
                                salaryDetails.earningData?[2]?.value ?? '',
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
                                '${LanguageManager().get('gross_pay')} (A)',
                                color: AppTheme.getColor(context).onSurface,
                                fontWeight: FontWeight.w800,
                                fontSize:
                                    15 * Responsive.getResponsiveText(context),
                              ),
                              CustomText(
                                salaryDetails.grossSalary ?? '',
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
                ),
                SizedBox(height: 0.01 * Responsive.getHeight(context)),
                // Deductions Card
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.08 * Responsive.getWidth(context),
                  ),
                  child: CommonCard(
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
                                salaryDetails.deductionData?[1]?.title ??
                                    'professional_tex',
                                color: AppTheme.getColor(context).onSurface,
                                fontSize:
                                    14 * Responsive.getResponsiveText(context),
                                fontWeight: FontWeight.w500,
                              ),
                              CustomText(
                                salaryDetails.deductionData?[1]?.value ?? '',
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
                                'total_deductions',
                                color: AppTheme.getColor(context).onSurface,
                                fontWeight: FontWeight.w700,
                                fontSize:
                                    15 * Responsive.getResponsiveText(context),
                              ),
                              CustomText(
                                salaryDetails.totalDeductionSalary ?? '',
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
                ),
                SizedBox(height: .01 * Responsive.getHeight(context)),
                // Net Pay Card
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.08 * Responsive.getWidth(context),
                  ),
                  child: CommonCard(
                    title: 'net_pay',
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
                                'net_salary_a_b',
                                color: AppTheme.getColor(context).onSurface,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    15 * Responsive.getResponsiveText(context),
                              ),
                              CustomText(
                                salaryDetails.aB ?? '',
                                color: AppTheme.getColor(context).onSurface,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    15 * Responsive.getResponsiveText(context),
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
                                'net_pay',
                                color: AppTheme.getColor(context).primary,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    18 * Responsive.getResponsiveText(context),
                              ),
                              CustomText(
                                salaryDetails.totalNetSalary ?? '',
                                color: AppTheme.getColor(context).primary,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    18 * Responsive.getResponsiveText(context),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 0.01 * Responsive.getHeight(context)),
                // Total CTC Card
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.08 * Responsive.getWidth(context),
                  ),
                  child: CommonCard(
                    title: 'total_ctc',
                    headerColor: AppColors.myCoCyan,
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
                                'total_employers_contribution',
                                color: AppTheme.getColor(context).onSurface,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    15 * Responsive.getResponsiveText(context),
                              ),
                              CustomText(
                                salaryDetails.totalContri ?? '',
                                color: AppTheme.getColor(context).onSurface,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    15 * Responsive.getResponsiveText(context),
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
                                'total_ctc',
                                color: AppColors.myCoCyan,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    18 * Responsive.getResponsiveText(context),
                              ),
                              CustomText(
                                salaryDetails.totalCtcCost ?? '',
                                color: AppColors.myCoCyan,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    18 * Responsive.getResponsiveText(context),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 0.02 * Responsive.getHeight(context)),
                // Button Container
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.08 * Responsive.getWidth(context),
                  ),
                  child: Row(
                    spacing: 14,
                    children: [
                      // Download Button
                      Expanded(
                        child: MyCoButton(
                          onTap: () async {
                            await printPayslipFromUrl(
                              salaryDetails.payslipDownloadUrl ?? '',
                            );
                          },
                          title: 'download',
                          height: 0.045 * Responsive.getHeight(context),
                          boarderRadius: 30 * Responsive.getResponsive(context),
                        ),
                      ),
                      // Raise Issue Button
                      Expanded(
                        child: MyCoButton(
                          onTap: () {
                            getRaiseIssueBottomSheet(context, state);
                          },
                          title: 'raise_issue',
                          height: 0.045 * Responsive.getHeight(context),
                          boarderRadius: 30 * Responsive.getResponsive(context),
                          backgroundColor: AppTheme.getColor(context).surface,
                          textStyle: TextStyle(
                            color: AppTheme.getColor(context).primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 0.05 * Responsive.getHeight(context)),
              ],
            ),
          );
        },
      ),
    ),
  );

  void getRaiseIssueBottomSheet(BuildContext context, PayslipState state) {
    getBottomSheet(
      context,
      Container(
        color: AppTheme.getColor(context).surface,
        padding: EdgeInsets.symmetric(
          horizontal: 0.08 * Responsive.getWidth(context),
          vertical: 0.02 * Responsive.getHeight(context),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              'raise_issue',
              fontSize: 14 * Responsive.getResponsiveText(context),
            ),
            BigMyCoTextField(
              controller: raiseIssueController,
              prefixImage: SvgPicture.asset(AppAssets.warning),
              hintText: LanguageManager().get('type_here'),
              decoration: BoxDecoration(
                color: AppTheme.getColor(context).surface,
                border: Border.all(color: AppTheme.getColor(context).outline),
                borderRadius: BorderRadius.circular(
                  12 * Responsive.getResponsive(context),
                ),
              ),
            ),
            SizedBox(height: 0.02 * Responsive.getHeight(context)),
            SideBySideButtons(
              button1Name: LanguageManager().get('close'),
              button2Name: LanguageManager().get('crm_submit'),
              onTap1: () => Navigator.pop(context),
              onTap2: () {
                context.read<PayslipBloc>().add(
                  AddSalaryIssueEvent(
                    issueMessage: raiseIssueController.text,
                    salarySlipId: state.salaryDetailsEntity.salarySlipId ?? '',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
