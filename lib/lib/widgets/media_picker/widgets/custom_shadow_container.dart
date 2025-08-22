import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/inner_shadow_painter.dart';

class CustomShadowContainer extends StatelessWidget {
  final Widget image;
  final String title;
  final TextStyle? titleStyle;
  final double? height;
  final double? width;
  final double? containerHeight;
  final double? borderRadius;
  final TextAlign? textAlign;
  final String? highlight;
  final bool? isHighlightOn;

  const CustomShadowContainer({
    required this.image,
    required this.title,
    super.key,
    this.titleStyle,
    this.height,
    this.width,
    this.borderRadius,
    this.containerHeight,
    this.textAlign,
    this.highlight,
    this.isHighlightOn,
  });

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Stack(
        children: [
          Container(
            width: width ?? 70,
            height: containerHeight ?? 70,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppTheme.getColor(context).onPrimary,
              borderRadius: BorderRadius.circular(borderRadius ?? 20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(2.5, 2),
                  blurRadius: 1,
                ),
              ],
            ),
            child: Center(child: image),
          ),
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius ?? 20),
              child: CustomPaint(
                painter: InnerShadowPainter(
                  shadowColor: const Color.fromARGB(50, 0, 0, 0),
                  blur: 4,
                  offset: const Offset(3, -3.5),
                  borderRadius: 20,
                  isShadowBottomRight: true,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius ?? 20),
              child: CustomPaint(
                painter: InnerShadowPainter(
                  shadowColor: const Color.fromARGB(50, 0, 0, 0),
                  blur: 4,
                  offset: const Offset(3, -3.5),
                  borderRadius: 20,
                  isShadowBottomLeft: true,
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 0.006 * Responsive.getHeight(context)),
      // const Spacer(),
      CustomText(
        title,
        color: AppTheme.getColor(context).onSurface,
        fontSize: 12 * Responsive.getResponsiveText(context),
        fontWeight: FontWeight.w600,
        textAlign: textAlign,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        highlightText: highlight,
        isHighlight: isHighlightOn ?? false,
      ),
    ],
  );
}
