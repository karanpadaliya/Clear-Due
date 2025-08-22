import 'package:flutter/material.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class DashboardWarningWithMessage extends StatelessWidget {
  /// A widget that displays a warning message in the dashboard.
  ///
  final String message;
  final Color backgroundColor;
  final Color textColor;
  const DashboardWarningWithMessage({
    required this.message,
    required this.backgroundColor,
    required this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.symmetric(
      vertical: 6 * Responsive.getDashboardResponsive(context),
    ),
    padding: EdgeInsets.symmetric(
      vertical: 4 * Responsive.getDashboardResponsive(context),
    ),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(
        9 * Responsive.getDashboardResponsive(context),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          message,
          fontSize: 14 * Responsive.getDashboardResponsiveText(context),
          fontWeight: FontWeight.w600,
          color: textColor,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
