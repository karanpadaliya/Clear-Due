import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button_theme.dart';
import 'package:myco_flutter/widgets/custom_searchfield.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class CreatGroupBottomsheet extends StatelessWidget {
  final double? headerWidth;
  final double? headerHeight;
  final EdgeInsetsGeometry? headerPadding;
  final Decoration? decoration;
  final TextStyle? optionTextStyle;
  final Color? headerColor;
  final bool? isHeaderRequired;
  final bool? isButtonRequired;

  const CreatGroupBottomsheet({
    super.key,

    this.headerWidth,
    this.headerHeight,
    this.headerPadding,
    this.decoration,
    this.optionTextStyle,
    this.headerColor,
    this.isHeaderRequired = true,
    this.isButtonRequired = true,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.only(bottom: 20 * Responsive.getResponsive(context)),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header
        Container(
          height: headerHeight,
          width: headerWidth ?? double.infinity,
          padding:
              headerPadding ??
              EdgeInsets.symmetric(horizontal: 28, vertical: 12),
          decoration:
              decoration ??
              BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),

                boxShadow: [
                  BoxShadow(
                    color:
                        headerColor?.withAlpha(200) ??
                        AppTheme.getColor(context).primary.withAlpha(200),
                  ),
                  BoxShadow(
                    color: headerColor ?? AppTheme.getColor(context).primary,
                    spreadRadius: -4.0,
                    blurRadius: 8.0,
                  ),
                ],
              ),
          child: CustomText(
            "create_group",
            fontSize: 22 * Responsive.getResponsiveText(context),
            fontWeight: FontWeight.w700,
            color: AppTheme.getColor(context).onPrimary,
          ),
        ),

        // Radio List
        SizedBox(height: 50 * Responsive.getResponsive(context)),
        Container(
          height: 110,
          width: 110,
          child: Stack(
            children: [
              /// Main CircleAvatar with logo inside
              Image.asset(
                'assets/chat/MYCO_Logo_2027.png',
                width: 0.25 * Responsive.getWidth(context),
              ),

              /// Camera icon on bottom-right
              Positioned(
                bottom: 6,
                right: 6,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.spanishYellow,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    // shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(6),
                  child: SvgPicture.asset(
                    'assets/chat/camera.svg',
                    width: 0.05 * Responsive.getWidth(context),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12 * Responsive.getResponsive(context)),

        Padding(
          padding: const EdgeInsets.all(12.0),
          child: CustomSearchField(
            hintText: LanguageManager().get('enter_group_name'),

            onChanged: (value) => {},
          ),
        ),
        const SizedBox(height: 8),

        // Buttons
        isButtonRequired == false
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 12),
                    MyCoButton(
                      textStyle: MyCoButtonTheme.getWhiteBackgroundTextStyle(
                        context,
                      ),
                      backgroundColor: AppTheme.getColor(context).onPrimary,
                      onTap: () => Navigator.pop(context),
                      title: LanguageManager().get('cancel'),
                      boarderRadius: 30,
                      width: 0.4 * Responsive.getWidth(context),
                    ),

                    const SizedBox(width: 16),

                    MyCoButton(
                      boarderRadius: 30,
                      width: 0.4 * Responsive.getWidth(context),

                      onTap: () {
                        // widget.onApply?.call(_selectedIndex);
                        Navigator.pop(context);
                      },
                      title: LanguageManager().get('create'),
                      isShadowBottomLeft: true,
                    ),

                    const SizedBox(width: 12),
                  ],
                ),
              ),
      ],
    ),
  );
}
