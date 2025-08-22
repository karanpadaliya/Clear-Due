import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/take_order/presentation/widgets/add_order_bottomsheet.dart';
import 'package:myco_flutter/features/take_order/presentation/widgets/bottomsheet_config.dart';
import 'package:myco_flutter/widgets/custom_cached_network_image.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class FrequentBuyCard extends StatelessWidget {
  final String? productName;
  final String? productVariantName;
  final String? unitMeasurementType;
  final String? productId;
  final String? variantImage;
  const FrequentBuyCard({
    super.key,
    this.productName,
    this.unitMeasurementType,
    this.productId,
    this.productVariantName,
    this.variantImage,
  });

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      border: Border.all(color: AppTheme.getColor(context).outline),
      borderRadius: BorderRadius.circular(
        12 * Responsive.getResponsive(context),
      ),
    ),
    child: ListTile(
      contentPadding: EdgeInsets.only(
        left: 12.0 * Responsive.getResponsive(context),
        right: 12.0 * Responsive.getResponsive(context),
        top: 6.0 * Responsive.getResponsive(context),
      ),
      // isThreeLine: true,
      leading: CustomCachedNetworkImage(
        imageUrl: variantImage ?? '',
        width: 0.12 * Responsive.getWidth(context),
        height: 0.05 * Responsive.getHeight(context),
        // errorWidget: Image.asset(
        //   'assets/take_order/apple_image.png',
        //   width: 0.12 * Responsive.getWidth(context),
        // ),
      ),

      title: CustomText(
        '${productName ?? ''} (${productVariantName ?? ''} )',
        fontWeight: FontWeight.w500,
        fontSize: 13 * Responsive.getResponsiveText(context),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            unitMeasurementType ?? '',
            fontSize: 12 * Responsive.getResponsiveText(context),
          ),
          CustomText(
            productId ?? '',
            fontSize: 10 * Responsive.getResponsiveText(context),
          ),
        ],
      ),
      trailing: Column(
        children: [
          MyCoButton(
            onTap: () {
              getBottomSheet(context, const AddOrderBottomsheet());
            },
            title: LanguageManager().get('add'),
            textStyle: TextStyle(
              fontSize: 14 * Responsive.getResponsiveText(context),
              fontWeight: FontWeight.w600,
              color: AppTheme.getColor(context).onPrimary,
            ),
            boarderRadius: 30 * Responsive.getResponsive(context),
            width: 0.17 * Responsive.getWidth(context),
            height: 0.028 * Responsive.getHeight(context),
          ),
        ],
      ),
    ),
  );
}
