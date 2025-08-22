import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class DistributorCard extends StatelessWidget {
  final String title;
  final bool isButton;
  final String buttonText;
  final Widget bottomWidget;
  final void Function()? onTap;
  final double? headerHeight;
  final bool? isHeaderIconEnabled;
  const DistributorCard({
    required this.title,
    required this.bottomWidget,
    this.isButton = false,
    this.buttonText = '',
    this.onTap,
    this.headerHeight,
    super.key,
    this.isHeaderIconEnabled = false,
  });

  @override
  Widget build(BuildContext context) => Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        12 * Responsive.getResponsive(context),
      ),
      side: BorderSide(color: AppTheme.getColor(context).outline),
    ),
    // color: AppTheme.getColor(context).onPrimary,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Stack(
          children: [
            Material(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  12 * Responsive.getResponsive(context),
                ),
                topRight: Radius.circular(
                  12 * Responsive.getResponsive(context),
                ),
              ),
              elevation: 3.0,
              child: Container(
                height: headerHeight ?? 0.06 * Responsive.getHeight(context),
                padding: EdgeInsets.all(10 * Responsive.getResponsive(context)),
                decoration: BoxDecoration(
                  color: AppTheme.getColor(context).secondary,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(
                      12 * Responsive.getResponsive(context),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: isButton
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.start,
                  children: [
                    if (isHeaderIconEnabled!)
                      Image.asset(
                        'assets/take_order/profile-circle.png',
                        height: 0.1 * Responsive.getHeight(context),
                        width: 0.06 * Responsive.getWidth(context),
                      ),
                    if (isHeaderIconEnabled!)
                      SizedBox(width: 0.02 * Responsive.getWidth(context)),
                    CustomText(
                      title,
                      color: AppTheme.getColor(context).onPrimary,
                      fontSize: 17 * Responsive.getResponsiveText(context),
                      fontWeight: FontWeight.bold,
                    ),
                    isButton
                        ? MyCoButton(
                            onTap: onTap,
                            title: buttonText,
                            textStyle: TextStyle(
                              fontSize:
                                  13 * Responsive.getResponsiveText(context),
                              color: AppTheme.getColor(context).onPrimary,
                            ),
                            width: 0.16 * Responsive.getWidth(context),
                            boarderRadius:
                                30 * Responsive.getResponsive(context),
                            height: 0.03 * Responsive.getHeight(context),
                            isShadowBottomLeft: true,
                            enabled: true,
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),

            // Inner shadow simulation using a white gradient
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.white.withValues(alpha: 0.3), // top white fade
                        Colors.transparent, // fade to transparent
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomWidget,
      ],
    ),
  );
}
