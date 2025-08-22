import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/cached_image_holder.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class CustomNoDataWidget extends StatelessWidget {
  final String? assetPath;
  final String? message;
  final double? assetWidth;
  final double? assetHeight;
  final BoxFit? assetFit;
  final double? messageFontSize;
  final double? spacing;
  final Color? messageColor;
  final FontWeight? messageFontWeight;

  const CustomNoDataWidget({
    super.key,
    this.assetPath,
    this.message,
    this.assetWidth,
    this.assetHeight,
    this.messageFontSize,
    this.spacing,
    this.messageColor,
    this.messageFontWeight,
    this.assetFit,
  });

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      if (assetPath != null)
        assetPath!.startsWith('http') || assetPath!.startsWith('https')
            ? CachedImage(
                imageUrl: assetPath,
                width: assetWidth,
                height: assetHeight,
                fit: assetFit ?? BoxFit.cover,
              )
            : SvgPicture.asset(
                assetPath!,
                width: assetWidth,
                height: assetHeight,
                fit: assetFit ?? BoxFit.cover,
              ),
      if (assetPath != null)
        SizedBox(height: spacing ?? 0.01 * Responsive.getHeight(context)),
      if (message != null)
        CustomText(
          message!,
          color: messageColor,
          fontSize:
              messageFontSize ??
              16 * Responsive.getDashboardResponsiveText(context),
          fontWeight: messageFontWeight ?? FontWeight.w600,
        ),
    ],
  );
}
