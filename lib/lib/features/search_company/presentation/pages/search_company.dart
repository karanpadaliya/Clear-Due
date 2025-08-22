import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/company_selector/presentation/bloc/company/company_bloc.dart';
import 'package:myco_flutter/features/company_selector/presentation/bloc/login/login_bloc.dart';
import 'package:myco_flutter/features/company_selector/presentation/bloc/select_company_step/select_company_step_bloc.dart';
import 'package:myco_flutter/features/company_selector/presentation/pages/select_company_page.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';

class SearchCompanyScreen extends StatelessWidget {
  const SearchCompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Function to show the bottom sheet, reusable for both widgets.
    void showCompanySearchSheet() {
      showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            12 * Responsive.getResponsive(context),
          ),
        ),
        clipBehavior: Clip.none,
        useSafeArea: true,
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        requestFocus: false,
        context: context,

        builder: (bottomSheetContext) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => SelectCompanyStepBloc()),
            BlocProvider(create: (_) => GetIt.I<CompanyBloc>()),
            BlocProvider(create: (_) => GetIt.I<LoginBloc>()),
          ],
          child: BlocBuilder<SelectCompanyStepBloc, SelectCompanyStepState>(
            builder: (context, stepState) {
              // if the keyboard is visible
              final bool isKeyboardOpen =
                  MediaQuery.of(context).viewInsets.bottom > 0;

              // default height
              double heightFactor = 0.9;

              // sign in height
              if (stepState is SelectCompanyStepLogin) {
                heightFactor = isKeyboardOpen ? 0.85 : 0.8;
              }

              // otp height
              if (stepState is SelectCompanyStepOtp) {
                heightFactor = isKeyboardOpen ? 0.8 : 0.55;
              }

              return AnimatedContainer(
                duration: const Duration(milliseconds: 500), // Animation speed
                curve: Curves.easeInOut, // Animation style
                constraints: BoxConstraints(
                  maxHeight: heightFactor * Responsive.getHeight(context),
                ),
                child: const SelectCompanyPage(),
              );
            },
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [
              AppTheme.getColor(context).primary,
              AppTheme.getColor(context).surface,
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 20 * Responsive.getResponsive(context),
            right: 20 * Responsive.getResponsive(context),
            bottom: 30 * Responsive.getResponsive(context),
          ),
          child: Column(
            children: [
              const Spacer(),
              Image.asset(
                AppAssets.searchCompanyIllustration,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 0.044 * Responsive.getHeight(context)),
              CustomText(
                'select_your_company',
                fontSize: 20 * Responsive.getResponsiveText(context),
                fontWeight: FontWeight.w600,
                color: AppTheme.getColor(context).onSurface,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 0.005 * Responsive.getHeight(context)),
              CustomText(
                'select_your_company_desc',
                fontSize: 13 * Responsive.getResponsiveText(context),
                color: AppTheme.getColor(context).onSurface,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 0.03 * Responsive.getHeight(context)),
              InkWell(
                onTap: showCompanySearchSheet,
                child: const AbsorbPointer(
                  // Prevents the text field from gaining focus
                  child: NewTextField(
                    label: 'company_name',
                    hintText: 'search_your_company',
                    prefixIconPath: AppAssets.search_company_icon,
                  ),
                ),
              ),
              SizedBox(height: 0.025 * Responsive.getHeight(context)),
              MyCoButton(
                onTap: showCompanySearchSheet,
                // Use the same function
                title: 'search',
                width: Responsive.getWidth(context),
                height: 0.062 * Responsive.getHeight(context),
                boarderRadius: 30,
                textStyle: TextStyle(
                  fontSize: 16 * Responsive.getResponsiveText(context),
                  fontWeight: FontWeight.w600,
                  color: AppTheme.getColor(context).onPrimary,
                ),
                backgroundColor: AppTheme.getColor(context).primary,
                isShadowBottomLeft: true,
              ),
              SizedBox(height: 0.015 * Responsive.getHeight(context)),
            ],
          ),
        ),
      ),
    );
  }
}
