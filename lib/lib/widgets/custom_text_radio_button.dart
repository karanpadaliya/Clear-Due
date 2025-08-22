import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class CustomTextRadioButton extends StatelessWidget {
  final String gender;
  final String selectedGender;
  final void Function(String) onSelect;

  // Responsive helpers
  final double height;
  final double width;

  // Optional customization
  final BoxDecoration? customDecoration;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final TextStyle? textStyle;
  final Widget? leading;
  final Widget? trailing;

  final double? fontSize;

  const CustomTextRadioButton({
    super.key,
    required this.gender,
    required this.selectedGender,
    required this.onSelect,
    required this.height,
    required this.width,
    this.customDecoration,
    this.padding,
    this.margin,
    this.textStyle,
    this.leading,
    this.trailing,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = gender == selectedGender;

    return GestureDetector(
      onTap: () {
        if (isSelected) {
          onSelect('');
        } else {
          onSelect(gender);
        }
      },
      child: Container(
        height: height,
        width: width,
        padding: padding ??
            EdgeInsets.symmetric(
              vertical: 12 * Responsive.getResponsive(context),
              horizontal: 8 * Responsive.getResponsive(context),
            ),
        margin: margin ??
            EdgeInsets.symmetric(
              horizontal: 2 * Responsive.getResponsive(context),
            ),
        decoration: customDecoration ??
            BoxDecoration(
              border: Border.all(color: AppColors.gray, width: 1),
              borderRadius:
              BorderRadius.circular(10 * Responsive.getResponsive(context)),
              color: isSelected
                  ? AppTheme.getColor(context).inversePrimary
                  : AppTheme.getColor(context).onSurface,
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            leading ??
                Radio<String>(
                  value: gender,
                  groupValue: selectedGender,
                  activeColor: AppColors.primary,
                  onChanged: (value) {
                    if (value == selectedGender) {
                      onSelect('');
                    } else {
                      onSelect(value!);
                    }
                  },
                ),
            Expanded(
              child: CustomText(
                gender,
                fontSize: (fontSize ?? 14) *
                    Responsive.getResponsiveText(context),
                fontWeight: FontWeight.w700,
                color: isSelected
                    ? AppTheme.getColor(context).primary
                    : AppTheme.getColor(context).outline,
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
