import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:shimmer/shimmer.dart';

class FullImageEmployeeCardModel {
  final Widget image;
  final String name, department;

  FullImageEmployeeCardModel({
    required this.image,
    required this.name,
    required this.department,
  });
}

class FullImageEmployeeCard extends StatelessWidget {
  final Widget image;
  final String name, department;
  final bool isSelected;
  final TextStyle? nameTextStyle, departmentTextStyle;
  final EdgeInsetsGeometry? boxPadding;
  final Color? borderColor, selectedColor;
  final double? boxHeight,
      boxWidth,
      borderRadius,
      imageWidth,
      imageHeight,
      spaceBetweenImageText;
  final ValueChanged<FullImageEmployeeCardModel>? onSelected;

  const FullImageEmployeeCard({
    required this.image,
    required this.name,
    required this.department,
    required this.isSelected,
    super.key,
    this.boxHeight,
    this.boxWidth,
    this.imageWidth,
    this.imageHeight,
    this.spaceBetweenImageText,
    this.onSelected,
    this.borderRadius,
    this.borderColor,
    this.nameTextStyle,
    this.departmentTextStyle,
    this.boxPadding,
    this.selectedColor,
  });

  void _handleTap() {
    if (onSelected != null) {
      onSelected!(
        FullImageEmployeeCardModel(
          name: name,
          department: department,
          image: image,
        ),
      );
    }
  }

  bool get _shouldShowShimmer =>
      name.trim().isEmpty && department.trim().isEmpty;

  @override
  Widget build(BuildContext context) {
    final double height = boxHeight ?? 150 * Responsive.getHeight(context);
    final double width = boxWidth ?? 102 * Responsive.getWidth(context);
    final double radius =
        borderRadius ?? 15 * Responsive.getResponsive(context);

    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppTheme.getColor(context).surface,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: _shouldShowShimmer
                ? Colors.transparent
                : (selectedColor ?? AppTheme.getColor(context).primary),
            width: 0.5,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: _shouldShowShimmer
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(color: Colors.white),
                      )
                    : image,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 0.015 * Responsive.getWidth(context),
                  vertical: 0.01 * Responsive.getHeight(context),
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black12,
                      Colors.black12,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _shouldShowShimmer
                      ? [
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              height:
                                  12 * Responsive.getResponsiveText(context),
                              width: 60,
                              margin: const EdgeInsets.only(bottom: 4),
                              color: Colors.white,
                            ),
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              height:
                                  12 * Responsive.getResponsiveText(context),
                              width: 40,
                              color: Colors.white,
                            ),
                          ),
                        ]
                      : [
                          CustomText(
                            name,
                            fontSize:
                                12 * Responsive.getResponsiveText(context),
                            fontWeight: FontWeight.w600,
                            color: AppTheme.getColor(context).onPrimary,
                            overflow: TextOverflow.ellipsis,
                            textShadows: [
                              Shadow(
                                color: Colors.black.withValues(alpha: 0.85),
                                offset: const Offset(0.5, 1.5),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          CustomText(
                            department,
                            fontSize:
                                11 * Responsive.getResponsiveText(context),
                            fontWeight: FontWeight.w600,
                            color: AppTheme.getColor(context).onPrimary,
                            overflow: TextOverflow.ellipsis,
                            textShadows: [
                              Shadow(
                                color: Colors.black.withValues(alpha: 0.85),
                                offset: const Offset(0.5, 1.5),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
