import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class DetailsCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget? prefixIcon;
  final double? titleFontSize;
  final double? subTitleFontSize;
  final Color? titleColor;
  final Color? subTitleColor;
  final EdgeInsetsGeometry? padding;

  const DetailsCard({
    Key? key,
    required this.title,
    required this.subTitle,
    this.prefixIcon,
    this.titleFontSize,
    this.subTitleFontSize,
    this.titleColor,
    this.subTitleColor,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ??
          EdgeInsets.symmetric(
            horizontal: 26 * Responsive.getResponsive(context),
            vertical: 6 * Responsive.getResponsive(context),
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (prefixIcon != null)
                Padding(
                  padding: EdgeInsets.only(
                    right: 20 * Responsive.getResponsive(context),
                  ),
                  child: prefixIcon!,
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title,
                      fontSize:
                          (titleFontSize ?? 12) *
                          Responsive.getResponsiveText(context),
                      fontWeight: FontWeight.w500,
                      color: titleColor ?? AppColors.textGray,
                    ),
                    CustomText(
                      subTitle.trim().isEmpty ? 'No data available!' : subTitle,
                      fontSize:
                          (subTitleFontSize ?? 13) *
                          Responsive.getResponsiveText(context),
                      fontWeight: FontWeight.w500,
                      color:
                          subTitleColor ?? AppTheme.getColor(context).onSurface,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 0.006 * Responsive.getHeight(context)),
          Padding(
            padding: EdgeInsets.only(
              left: 18 * Responsive.getResponsive(context),
            ),
            child: Divider(height: 1, color:AppColors.gray10)),
        ],
      ),
    );
  }
}
