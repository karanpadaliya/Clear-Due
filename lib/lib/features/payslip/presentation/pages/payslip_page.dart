import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/custom_bloc/tab-bar/bloc/tabbar_bloc.dart';
import 'package:myco_flutter/features/payslip/domain/entities/salary_entity.dart';
import 'package:myco_flutter/features/payslip/presentation/bloc/payslip_bloc.dart';
import 'package:myco_flutter/features/payslip/presentation/pages/other_earnings.dart';
import 'package:myco_flutter/features/payslip/presentation/widgets/error_widget.dart';
import 'package:myco_flutter/features/payslip/presentation/widgets/ios_calendar_time_picker.dart';
import 'package:myco_flutter/features/payslip/presentation/widgets/no_data_available_widget.dart';
import 'package:myco_flutter/features/payslip/presentation/widgets/payslip_card.dart';
import 'package:myco_flutter/features/payslip/presentation/widgets/payslip_webview.dart';
import 'package:myco_flutter/features/payslip/presentation/widgets/shimmer_salary_loading.dart';
import 'package:myco_flutter/features/payslip/presentation/widgets/summary_bottomsheet.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_myco_tabbar.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

// ignore: must_be_immutable
class PayslipPage extends StatefulWidget {
  const PayslipPage({super.key});

  @override
  State<PayslipPage> createState() => _PayslipPageState();
}

class _PayslipPageState extends State<PayslipPage> {
  List<Widget> screens = [const PaySlip(), const OtherEarnings()];
  @override
  void initState() {
    super.initState();
    Future.microtask(loadData);
  }

  // Taking Current Year and passing it in the api request body
  final currentYear = DateTime.now().year.toString();
  void loadData({String? year}) {
    context.read<PayslipBloc>().add(
      GetSalaryEvent(salaryYear: year ?? DateTime.now().year.toString()),
    );
    context.read<OtherEarningsBloc>().add(
      GetOtherEarningsEvent(
        leavePayoutYear: year ?? DateTime.now().year.toString(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: CustomAppbar(
      title: LanguageManager().get('payslip'),
      actions: [
        MyCoButton(
          onTap: () {
            context.pushNamed(RoutePaths.salaryBreakUp);
          },
          backgroundColor: AppTheme.getColor(context).secondary,
          borderColor: AppTheme.getColor(context).secondary,
          boarderRadius: 30 * Responsive.getResponsive(context),
          title: LanguageManager().get('view_ctc'),
          textStyle: TextStyle(
            fontSize: 14 * Responsive.getResponsiveText(context),
            color: AppTheme.getColor(context).onSecondary,
          ),
          width: 0.2 * Responsive.getWidth(context),
          height: 0.03 * Responsive.getHeight(context),
          isShadowBottomLeft: true,
        ),
        SizedBox(width: 0.06 * Responsive.getWidth(context)),
      ],
    ),
    body: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 0.08 * Responsive.getWidth(context),
          ),
          child: BlocBuilder<PayslipBloc, PayslipState>(
            builder: (context, state) {
              var currentYear = state.year;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Decrease year button
                  InkWell(
                    onTap: () {
                      context.read<PayslipBloc>().add(
                        ChangeYearEvent(
                          tagEvent: 'decrease',
                          year: currentYear,
                        ),
                      );

                      // Reload both APIs
                      loadData(year: (int.parse(currentYear) - 1).toString());
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 8 * Responsive.getResponsive(context),
                        top: 2 * Responsive.getResponsive(context),
                        bottom: 2 * Responsive.getResponsive(context),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          6 * Responsive.getResponsive(context),
                        ),

                        color: AppTheme.getColor(context).primary.withAlpha(40),
                      ),
                      child: const Center(
                        child: Icon(Icons.arrow_back_ios, size: 16),
                      ),
                    ),
                  ),
                  // Year display
                  InkWell(
                    onTap: () async {
                      final selectedDate = await showPicker(
                        context,
                        minDate: DateTime(2020),
                        maxDate: DateTime(2030),
                        pickDay: false,
                        timePicker: false,
                      );
                      if (selectedDate != null) {
                        // Extracting the year from whole date
                        final year = selectedDate.split(' ')[1];
                        // Sending the year to the bloc
                        context.read<PayslipBloc>().add(
                          ChangeYearEvent(year: year, tagEvent: ''),
                        );
                        // Reload both APIs
                        loadData(year: year);
                      }
                    },
                    child: Row(
                      children: [
                        CustomText(
                          '${int.parse(currentYear) - 1}-$currentYear',
                          fontSize: 16 * Responsive.getResponsiveText(context),
                          fontWeight: FontWeight.w700,
                        ),

                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 25 * Responsive.getResponsive(context),
                        ),
                      ],
                    ),
                  ),
                  // Increase year button
                  InkWell(
                    onTap: () {
                      // Year should not be greater than current year
                      if (int.parse(currentYear) < DateTime.now().year) {
                        context.read<PayslipBloc>().add(
                          ChangeYearEvent(
                            tagEvent: 'increase',
                            year: currentYear,
                          ),
                        );
                        // Reload both APIs
                        loadData(year: (int.parse(currentYear) + 1).toString());
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3 * Responsive.getResponsive(context),
                        vertical: 2 * Responsive.getResponsive(context),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          6 * Responsive.getResponsive(context),
                        ),
                        color: AppTheme.getColor(context).primary.withAlpha(40),
                      ),
                      child: const Center(
                        child: Icon(Icons.arrow_forward_ios, size: 16),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),

        SizedBox(height: 0.02 * Responsive.getHeight(context)),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 0.08 * Responsive.getWidth(context),
          ),
          child: BlocBuilder<TabbarBloc, TabbarState>(
            builder: (context, state) {
              final selectedIndex = state is TabChangeState
                  ? state.selectedIndex
                  : 0;
              return MyCustomTabBar(
                tabs: [
                  LanguageManager().get('payslip'),
                  LanguageManager().get('other_earnings'),
                ],
                selectedBgColors: [
                  AppTheme.getColor(context).secondary,
                  AppTheme.getColor(context).primary,
                ],
                unselectedBorderAndTextColor: AppTheme.getColor(
                  context,
                ).primary,
                tabBarBorderColor: selectedIndex == 0
                    ? AppTheme.getColor(context).secondary
                    : AppTheme.getColor(context).primary,
                selectedIndex: selectedIndex,
                isShadowBottomLeft: true,
                onTabChange: (index) {
                  context.read<TabbarBloc>().add(TabChangeEvent(index: index));
                },
              );
            },
          ),
        ),
        SizedBox(height: 0.02 * Responsive.getHeight(context)),

        BlocBuilder<TabbarBloc, TabbarState>(
          builder: (context, state) {
            final selectedIndex = state is TabChangeState
                ? state.selectedIndex
                : 0;
            return screens[selectedIndex];
          },
        ),
      ],
    ),
  );
}

class PaySlip extends StatelessWidget {
  const PaySlip({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<PayslipBloc, PayslipState>(
    builder: (context, state) {
      // Loading State
      if (state.isLoading) {
        return const ShimmerSalaryLoadingWidget(loadingFor: 'payslip');
      }

      // Error State
      if (state.error.isNotEmpty) {
        return PayslipErrorWidget(error: state.error);
      }

      final salary = state.salaryEntity;

      // To handle if any card's list is coming as empty then we can handle it in ui accordingly
      final List<EarningsTotalEntity> earningsTotal =
          salary.earningsTotal ?? [];
      final List<DeductionsTotalEntity> deductionsTotal =
          salary.deductionsTotal ?? [];
      final List<EmployerContributionTotalEntity> employerContributionTotal =
          salary.employerContributionTotal ?? [];

      // No Data State
      if (salary.salaryItem == null) {
        return const NoDataAvailableWidget();
      }
      // Success State
      return Column(
        children: [
          Container(
            height: 0.65 * Responsive.getHeight(context),
            padding: EdgeInsets.symmetric(
              horizontal: 0.08 * Responsive.getWidth(context),
            ),
            // Main Listview of Payslips
            child: ListView.separated(
              itemCount: salary.salaryItem?.length ?? 0,
              itemBuilder: (context, index) => PayslipCard(
                month: salary.salaryItem?[index].monthName ?? '',
                year: salary.salaryItem?[index].year ?? '',
                netPay: salary.salaryItem?[index].totalNetSalary ?? '',
                grossSalary: salary.salaryItem?[index].totalEarningSalary ?? '',
                totalDeduction:
                    salary.salaryItem?[index].totalDeductionSalary ?? '',
                onView: () {
                  context.pushNamed(
                    RoutePaths.payslipDetail,
                    extra: salary.salaryItem?[index].salarySlipId ?? '',
                  );
                },
                onDownload: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PayslipWebViewScreen(
                        url: salary.salaryItem?[index].payslipDownloadUrl ?? '',
                      ),
                    ),
                  );
                },
              ),
              separatorBuilder: (context, index) =>
                  SizedBox(height: 0.01 * Responsive.getHeight(context)),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 0.08 * Responsive.getWidth(context),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // View Summary
                MyCoButton(
                  onTap: () {
                    // View Summary Bottomsheet
                    showModalBottomSheet(
                      constraints: BoxConstraints(
                        maxHeight: 0.7 * Responsive.getHeight(context),
                      ),
                      useSafeArea: true,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(
                          8 * Responsive.getResponsive(context),
                        ),
                      ),
                      clipBehavior: Clip.hardEdge,
                      context: context,
                      builder: (context) => SummaryBottomsheet(
                        basic: earningsTotal.isEmpty
                            ? 'N/A'
                            : earningsTotal[0].earningAmount ?? '',
                        basicName: earningsTotal.isEmpty
                            ? 'N/A'
                            : earningsTotal[0].earningType ?? '',
                        hra: earningsTotal.isEmpty
                            ? 'N/A'
                            : earningsTotal[1].earningAmount ?? '',
                        hraName: earningsTotal.isEmpty
                            ? 'N/A'
                            : earningsTotal[1].earningType ?? '',
                        conveyance: earningsTotal.isEmpty
                            ? 'N/A'
                            : earningsTotal[2].earningAmount ?? '',
                        conveyanceName: earningsTotal.isEmpty
                            ? 'N/A'
                            : earningsTotal[2].earningType ?? '',

                        grossDeductions: deductionsTotal.isEmpty
                            ? 'N/A'
                            : deductionsTotal[0].deductionAmount ?? '',
                        grossDeductionsName: deductionsTotal.isEmpty
                            ? 'N/A'
                            : deductionsTotal[0].deductionType ?? '',
                        professionalTax: deductionsTotal.isEmpty
                            ? 'N/A'
                            : deductionsTotal[1].deductionAmount ?? '',
                        professionalTaxName: deductionsTotal.isEmpty
                            ? 'N/A'
                            : deductionsTotal[1].deductionType ?? '',

                        totalEarnings: salary.totalEarning ?? '',
                        leaveEncashment: '',
                        paidLeaveAllowance: '',
                        totalEmplotersContributions:
                            employerContributionTotal.isEmpty
                            ? 'N/A'
                            : employerContributionTotal[0]
                                      .employerContributionAmount ??
                                  '',
                      ),
                    );
                  },
                  title: LanguageManager().get('view_summary'),
                  width: 0.4 * Responsive.getWidth(context),
                  height: 0.04 * Responsive.getHeight(context),
                  boarderRadius: 30 * Responsive.getResponsive(context),
                  textStyle: TextStyle(
                    fontSize: 14 * Responsive.getResponsiveText(context),
                    fontWeight: FontWeight.w600,
                    color: AppTheme.getColor(context).onPrimary,
                  ),
                  isShadowBottomLeft: true,
                ),
                // Download All Payslip
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PayslipWebViewScreen(
                          url: salary.payslipDownloadUrl ?? '',
                        ),
                      ),
                    );
                  },
                  child: CustomText(
                    'download_all_payslip',
                    fontSize: 14 * Responsive.getResponsiveText(context),
                    color: AppTheme.getColor(context).primary,
                    decoration: TextDecoration.underline,
                    decorationColor: AppTheme.getColor(context).primary,
                    fontWeight: FontWeight.w700,
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
