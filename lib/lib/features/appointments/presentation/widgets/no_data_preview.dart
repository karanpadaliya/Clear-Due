import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class NoDataPreview extends StatelessWidget {
  final String? iconKey;
  final String icon;
  final String message;

  const NoDataPreview({
    required this.icon,
    required this.message,
    this.iconKey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Widget finalIcon = iconKey != null
        ? SvgPicture.asset(
            icon,
            height: 0.072 * Responsive.getHeight(context),
            width: 0.072 * Responsive.getWidth(context),
          ) // Value if TRUE
        : SvgPicture.asset(
            AppAssets.noDataImage,
            height: 0.072 * Responsive.getHeight(context),
            width: 0.072 * Responsive.getWidth(context),
          ); // Value if FALSE

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20 * Responsive.getResponsive(context),
      children: [
        finalIcon,
        CustomText(
          message,
          fontWeight: FontWeight.w500,
          color: AppColors.textGray,
        ),
      ],
    );
  }
}

// usage :
// NoDataPreview(
// /**
//  * This widget displays an icon and a message.
//  * * @param {String} message - The text to display below the icon. This is always required.
//  * * @param {String} icon - The asset path for the icon you want to show.
//  * This is required, but it will only be used if `iconKey` is NOT null.
//  *
//  * @param {String?} iconKey - An optional key. If you provide any value for `iconKey`, the `icon`
//  * parameter will be used. If you leave `iconKey` null, a default
//  * `noDataImage` will be shown instead, and the `icon` parameter will be ignored.
//  */
// icon: AppAssets.noDataImage,
// message: 'data_not_available',
// );
