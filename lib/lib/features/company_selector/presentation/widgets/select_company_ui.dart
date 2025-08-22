import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/di/modules/network_module.dart';
import 'package:myco_flutter/features/company_selector/domain/entites/company_response_entity.dart';
import 'package:myco_flutter/features/company_selector/presentation/bloc/company/company_bloc.dart';
import 'package:myco_flutter/features/company_selector/presentation/bloc/company/company_event.dart';
import 'package:myco_flutter/features/company_selector/presentation/bloc/company/company_state.dart';
import 'package:myco_flutter/features/company_selector/presentation/bloc/select_company_step/select_company_step_bloc.dart';
import 'package:myco_flutter/features/company_selector/presentation/pages/sales_inquiry_dialog_page.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';
import 'package:shimmer/shimmer.dart';

class SelectCompanyUi extends StatefulWidget {
  const SelectCompanyUi({super.key});

  @override
  State<SelectCompanyUi> createState() => _SelectCompanyUiState();
}

class _SelectCompanyUiState extends State<SelectCompanyUi> {
  // The controller is managed locally within this stateless widget.
  // It doesn't need to be part of a State object as its lifecycle
  // is contained within this build method.
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!focusNode.hasFocus) {
        focusNode.requestFocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 30 * Responsive.getResponsive(context),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 0.02 * Responsive.getHeight(context)),
        NewTextField(
          controller: controller,
          focusNode: focusNode,
          onChange: (value) {
            if (value.length >= 3) {
              context.read<CompanyBloc>().add(SearchCompany(value));
            } else {
              context.read<CompanyBloc>().add(InitialView());
            }
          },
          label: 'company_name',
          hintText: 'enter_company_name',
          prefixIconPath: AppAssets.search_company_icon,
        ),
        SizedBox(height: 0.025 * Responsive.getHeight(context)),
        Expanded(
          child: BlocBuilder<CompanyBloc, CompanyState>(
            builder: (blocContext, state) {
              if (state is CompanyLoading) {
                return ListView.builder(
                  itemCount: 8, // Display 8 shimmer items to represent a list
                  itemBuilder: (_, __) => const _CompanyListItemShimmer(),
                );
              } else if (state is CompanyLoaded) {
                final companies = state.companies.society ?? [] ?? [];
                final selectedIndex = state.selectedIndex ?? -1;

                if (state.companies.society == null ||
                    state.companies.society!.isEmpty) {
                  return const _NoCompanyFoundWidget();
                }
                return Column(
                  children: [
                    Expanded(
                      child: _CompanyList(
                        companies: state.companies.society!,
                        selectedIndex: state.selectedIndex,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10.0 * Responsive.getResponsive(context),
                        bottom: 25.0 * Responsive.getResponsive(context),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: MyCoButton(
                              title: 'Close',
                              height: 0.054 * Responsive.getHeight(context),
                              onTap: () => Navigator.pop(context),
                              backgroundColor: Colors.white,
                              boarderRadius:
                                  30 * Responsive.getResponsive(context),
                              border: Border.all(
                                color: AppTheme.getColor(context).primary,
                              ),
                              textStyle: TextStyle(
                                color: AppTheme.getColor(context).primary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: MyCoButton(
                              title: 'Submit',
                              height: 0.055 * Responsive.getHeight(context),
                              isShadowBottomLeft: true,
                              boarderRadius:
                                  30 * Responsive.getResponsive(context),
                              onTap: () {
                                if (selectedIndex >= 0 &&
                                    companies.isNotEmpty) {
                                  final company = companies[selectedIndex];
                                  final preference =
                                      GetIt.I<PreferenceManager>();

                                  preference.setCompanyId(
                                    company.companyId.toString(),
                                  );
                                  preference.setCompanyName(
                                    company.companyName.toString(),
                                  );
                                  preference.setCompanyAddress(
                                    company.companyAddress.toString(),
                                  );
                                  preference.setBaseUrl(
                                    company.subDomain.toString(),
                                  );
                                  preference.setLoginSession(false);
                                  refreshApiServiceCompany(GetIt.instance);

                                  dev.log(
                                    'Company details saved for ${company.companyName}',
                                    name: 'CompanyPref',
                                  );

                                  context.read<SelectCompanyStepBloc>().add(
                                    GoToLoginStep(company),
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                    msg: LanguageManager().get(
                                      'please_select_company',
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (state is CompanyError) {
                return Center(child: CustomText(state.message));
              }
              // Initial "Search Your Society" view
              return const _InitialSearchWidget();
            },
          ),
        ),
        // --- Always Visible Buttons ---
      ],
    ),
  );
}

// --- Extracted Widgets for Clarity and Reusability ---

class _CompanyList extends StatelessWidget {
  final List<SocietyEntity> companies;
  final int selectedIndex;

  const _CompanyList({required this.companies, required this.selectedIndex});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Expanded(
        child: ListView.builder(
          itemCount: companies.length,
          itemBuilder: (_, index) {
            final company = companies[index];
            final isSelected = selectedIndex == index;
            return GestureDetector(
              onTap: () => context.read<CompanyBloc>().add(CompanyIndex(index)),
              child: _CompanyListItem(company: company, isSelected: isSelected),
            );
          },
        ),
      ),
    ],
  );
}

class _CompanyListItem extends StatelessWidget {
  const _CompanyListItem({required this.company, required this.isSelected});

  final SocietyEntity company;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = AppTheme.getColor(context);
    return Container(
      width: Responsive.getWidth(context),
      padding: EdgeInsets.all(12.0 * Responsive.getResponsive(context)),
      margin: EdgeInsets.only(bottom: 12 * Responsive.getResponsive(context)),
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outline),
        borderRadius: BorderRadius.circular(
          14 * Responsive.getResponsive(context),
        ),
        color: isSelected ? colorScheme.primary : colorScheme.surface,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: colorScheme.primary,
            radius: 18 * Responsive.getResponsive(context),
            child: CircleAvatar(
              backgroundColor: colorScheme.onPrimary,
              radius: 15 * Responsive.getResponsive(context),
              child: Center(
                child: CustomText(
                  company.companyName!.substring(0, 1),
                  fontWeight: FontWeight.w600,
                  color: colorScheme.primary,
                  fontSize: 18 * Responsive.getResponsiveText(context),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(width: 0.02 * Responsive.getWidth(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  company.companyName!,
                  fontWeight: FontWeight.w600,
                  fontSize: 14 * Responsive.getResponsiveText(context),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  color: isSelected
                      ? colorScheme.onPrimary
                      : colorScheme.onSurface,
                ),
                CustomText(
                  company.companyAddress!,
                  fontSize: 12 * Responsive.getResponsiveText(context),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  color: isSelected
                      ? colorScheme.onPrimary
                      : colorScheme.onSurface,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CompanyListItemShimmer extends StatelessWidget {
  const _CompanyListItemShimmer();

  @override
  Widget build(BuildContext context) {
    final colorScheme = AppTheme.getColor(context);

    // The Shimmer.fromColors provides the sweeping animation effect.
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: Responsive.getWidth(context),
        padding: EdgeInsets.all(12.0 * Responsive.getResponsive(context)),
        margin: EdgeInsets.only(bottom: 12 * Responsive.getResponsive(context)),
        decoration: BoxDecoration(
          border: Border.all(color: colorScheme.outline),
          borderRadius: BorderRadius.circular(
            14 * Responsive.getResponsive(context),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Shimmer for the CircleAvatar ---
            CircleAvatar(
              backgroundColor: Colors.white, // Color is overridden by shimmer
              radius: 18 * Responsive.getResponsive(context),
            ),
            SizedBox(width: 0.02 * Responsive.getWidth(context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Shimmer for the company name (1 line) ---
                  Container(
                    height: 14 * Responsive.getResponsiveText(context),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(height: 4 * Responsive.getResponsive(context)),

                  // --- Shimmer for the address (2 lines for realism) ---
                  Container(
                    height: 12 * Responsive.getResponsiveText(context),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(height: 4 * Responsive.getResponsive(context)),
                  Container(
                    height: 12 * Responsive.getResponsiveText(context),
                    width: MediaQuery.of(context).size.width * 0.4,
                    // Shorter line
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InitialSearchWidget extends StatelessWidget {
  const _InitialSearchWidget();

  @override
  Widget build(BuildContext context) => Center(
    child: SingleChildScrollView(
      child: Image.asset(
        AppAssets.searchCompanyIllustration,
        fit: BoxFit.contain,
      ),
    ),
  );
}

class _NoCompanyFoundWidget extends StatelessWidget {
  const _NoCompanyFoundWidget();

  @override
  Widget build(BuildContext context) => Center(
    child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16 * Responsive.getResponsive(context)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              AppAssets.noCompanyListed,
              height: 0.25 * Responsive.getHeight(context),
            ),
            // const SizedBox(height: 20),
            CustomText(
              'Your company is not listed?',
              fontSize: 20 * Responsive.getResponsiveText(context),
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
            CustomText(
              'If your company does not appear in the list,\nplease submit a request for it to be added',
              fontSize: 12 * Responsive.getResponsiveText(context),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            MyCoButton(
              title: 'request_your_society',
              isShadowBottomLeft: true,
              boarderRadius: 30 * Responsive.getResponsive(context),
              onTap: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => const SalesInquiryForm(),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
