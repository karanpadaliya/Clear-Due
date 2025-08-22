import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/my_visit/presentation/widgets/new_phone_number_field/bloc/phone_number_field_bloc.dart';
import 'package:myco_flutter/features/my_visit/presentation/widgets/new_phone_number_field/bloc/phone_number_field_event.dart';
import 'package:myco_flutter/features/my_visit/presentation/widgets/new_phone_number_field/bloc/phone_number_field_state.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';

class NewPhoneNumberField extends StatelessWidget {
  final String selectedCountryCode;
  final String selectedCountryId;
  final VoidCallback? onTapCountryPicker;
  final String? hintText;
  final TextEditingController? phoneController;

  const NewPhoneNumberField({
    required this.selectedCountryCode,
    required this.selectedCountryId,
    super.key,
    this.phoneController,
    this.onTapCountryPicker,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) => BlocProvider<PhoneNumberFieldBloc>(
    create: (_) => PhoneNumberFieldBloc(),
    child: BlocBuilder<PhoneNumberFieldBloc, PhoneNumberFieldState>(
      builder: (context, state) {
        bool hasText = false;
        if (state is PhoneNumberFieldLoaded) {
          hasText = state.hasText;
        }
        return NewTextField(
          controller: phoneController,
          hintText: hintText ?? '0000 0000 0000',
          keyboardType: TextInputType.phone,
          onChange: (value) => context.read<PhoneNumberFieldBloc>().add(
            PhoneNumberChanged(value),
          ),
          prefix: InkWell(
            onTap: onTapCountryPicker,
            child: Padding(
              padding: EdgeInsets.only(
                left: 10 * Responsive.getResponsive(context),
                top: 3 * Responsive.getResponsive(context),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    selectedCountryId,
                    fontSize: 14 * Responsive.getResponsiveText(context),
                    fontWeight: FontWeight.w600,
                    color: AppTheme.getColor(context).onSurface,
                  ),
                  SizedBox(width: 0.008 * Responsive.getWidth(context)),
                  SvgPicture.asset(
                    AppAssets.downArrow,
                    height: 0.025 * Responsive.getHeight(context),
                    width: 0.025 * Responsive.getWidth(context),
                    fit: BoxFit.scaleDown,
                  ),
                  CustomText(
                    selectedCountryCode,
                    fontSize: 16 * Responsive.getResponsiveText(context),
                    fontWeight: FontWeight.w600,
                    color: phoneController?.text.isNotEmpty ?? true
                        ? AppTheme.getColor(context).onSurface
                        : AppTheme.getColor(context).outline,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
