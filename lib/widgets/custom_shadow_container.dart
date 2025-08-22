import 'package:flutter/material.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class CustomShadowContainer extends StatelessWidget {
  final Widget image;
  final String? title;
  final bool? isRect;
  final double? height, width, boxPadding, imagePadding, imgTitleSpacing;

  const CustomShadowContainer({
    required this.image,
    super.key,
    this.title,
    this.isRect,
    this.height,
    this.width,
    this.boxPadding,
    this.imagePadding,
    this.imgTitleSpacing,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
    width: width ?? 0.02 * Responsive.getWidth(context),
    height: height,
    child: Column(
      mainAxisAlignment: imgTitleSpacing != null
          ? MainAxisAlignment.center
          : MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      spacing: imgTitleSpacing ?? 0,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: boxPadding ?? 14,
            right: boxPadding ?? 14,
            left: boxPadding ?? 14,
          ),
          child: Container(
            padding: EdgeInsets.all(imagePadding ?? 15),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AppTheme.isAppThemeDarkMode(context)
                      ? isRect == true
                            ? AppAssets.rechangle_shadow_container_dark
                            : AppAssets.square_shadow_container_dark
                      : isRect == true
                      ? AppAssets.rechangle_shadow_container
                      : AppAssets.square_shadow_container,
                ),
              ),
            ),
            child: Center(child: image),
          ),
        ),

        CustomText(
          title ?? '',
          textAlign: TextAlign.center,
          fontSize: 12 * Responsive.getDashboardResponsiveText(context),
          fontWeight: FontWeight.w600,
        ),
      ],
    ),
  );
}
