import 'package:flutter/material.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class ShiftDetailsTopCard extends StatelessWidget {
  final String shiftName;
  final String shiftCode;
  const ShiftDetailsTopCard({
    required this.shiftName,
    required this.shiftCode,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(12 * Responsive.getResponsive(context)),
    height: 0.075 * Responsive.getHeight(context),
    decoration: BoxDecoration(
      border: Border.all(
        color: AppTheme.getColor(context).primary,
        width: 1.5 * Responsive.getResponsive(context),
      ),
      color: AppTheme.getColor(context).inversePrimary,
      borderRadius: BorderRadius.circular(
        VariableBag.containerBorderRadius * Responsive.getResponsive(context),
      ),
    ),
    child: Column(
      children: [
        Row(
          children: [
            CustomText(
              'shift_name',
              fontSize: 14 * Responsive.getResponsiveText(context),
              color: AppTheme.getColor(context).primary,
              fontWeight: FontWeight.w600,
            ),
            const Spacer(),
            CustomText(
              'shift_code',
              fontSize: 14 * Responsive.getResponsiveText(context),
              color: AppTheme.getColor(context).primary,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        Row(
          children: [
            CustomText(
              shiftName,
              fontSize: 12 * Responsive.getResponsiveText(context),
              fontWeight: FontWeight.w600,
            ),
            const Spacer(),
            CustomText(
              shiftCode,
              fontWeight: FontWeight.w600,
              fontSize: 12 * Responsive.getResponsiveText(context),
            ),
          ],
        ),
      ],
    ),
  );
}
