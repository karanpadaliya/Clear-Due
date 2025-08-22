import 'package:flutter/material.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/my_visit/presentation/widgets/card_bottom_content.dart';
import 'package:myco_flutter/widgets/common_card.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class CustomerCard extends StatelessWidget {
  final String title;
  final String buttonName;
  final Color headerColor;
  final bool isOnlyVisit;
  final bool isOrderTaken;
  final VoidCallback? onTap;

  const CustomerCard({
    required this.title,
    required this.buttonName,
    required this.headerColor,
    super.key,
    this.isOnlyVisit = false,
    this.isOrderTaken = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double responsiveText = Responsive.getResponsiveText(context);
    final double responsive = Responsive.getResponsive(context);
    final double borderWidth = Responsive.getWidth(context);

    return CommonCard(
      title: title,
      onTap: onTap,
      titleFontSize: 14 * responsiveText,
      borderRadius: VariableBag.commonCardBorderRadius * responsive,
      headerColor: headerColor,
      borderColor: AppTheme.getColor(context).outline,
      suffixIcon: Container(
        height: 35 * responsive,
        width: 100 * responsive,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: headerColor,
          borderRadius: BorderRadius.circular(
            VariableBag.buttonBorderRadius * responsive,
          ),
          border: Border.all(
            color: AppTheme.getColor(context).onPrimary,
            width: 0.003 * borderWidth,
          ),
        ),
        child: CustomText(
          buttonName,
          color: AppTheme.getColor(context).onSecondary,
          fontSize: 12 * responsiveText,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottomWidget: CardBottomContent(
        isOnlyVisit: isOnlyVisit,
        isOrderTaken: isOrderTaken,
      ),
    );
  }
}
