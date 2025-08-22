import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class BulletTextRow extends StatelessWidget {
  final String leadingText;
  final String trailingText;
  final double? fontSize;
  final FontWeight? fontWeight;

  const BulletTextRow({
    required this.leadingText,
    required this.trailingText,
    super.key,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    if (leadingText.trim().isEmpty || trailingText.trim().isEmpty) {
      return const SizedBox.shrink();
    }
    final responsiveFontSize =
        (fontSize ?? 12) * Responsive.getResponsiveText(context);

    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(
            right: 10.0 * Responsive.getResponsive(context),
          ),
          child: CustomText(
            '•',
            fontSize: 20 * Responsive.getResponsiveText(context),
            fontWeight: fontWeight ?? FontWeight.w500,
          ),
        ),
        CustomText(trailingText, fontSize: responsiveFontSize),
        SizedBox(width: 6 * Responsive.getResponsive(context)),
        Expanded(
          child: CustomText(
            '------------------------------------------------------------',
            maxLines: 1,
            fontWeight: FontWeight.w500,
            overflow: TextOverflow.clip,
            fontSize: responsiveFontSize,
            color: AppTheme.getColor(context).outline,
          ),
        ),
        SizedBox(width: 6 * Responsive.getResponsive(context)),
        CustomText(
          leadingText,
          fontSize: responsiveFontSize,
          color: AppTheme.getColor(context).onTertiary,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
