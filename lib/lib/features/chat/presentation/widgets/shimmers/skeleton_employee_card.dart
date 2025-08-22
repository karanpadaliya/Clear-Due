import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:shimmer/shimmer.dart';

class EmployeeCardSkeleton extends StatelessWidget {
  final double? boxHeight,
      boxWidth,
      borderRadius,
      imageWidth,
      imageHeight,
      spaceBetweenImageText;
  final EdgeInsetsGeometry? boxPadding;

  const EmployeeCardSkeleton({
    super.key,
    this.boxHeight,
    this.boxWidth,
    this.borderRadius,
    this.imageWidth,
    this.imageHeight,
    this.spaceBetweenImageText,
    this.boxPadding,
  });

  @override
  Widget build(BuildContext context) {
    final double textScale = Responsive.getResponsiveText(context);

    return Container(
      width: boxWidth ?? 100,
      padding: boxPadding ??
          const EdgeInsets.only(top: 12, left: 16, right: 24, bottom: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? 20),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 3,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          // Image shimmer
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: imageWidth ?? 80,
              height: imageHeight ?? 80,
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.grey.shade300,
                    Colors.grey.shade200,
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: spaceBetweenImageText ?? 8),

          // First text line shimmer
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 12 * textScale,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(6),
              ),
              margin: const EdgeInsets.only(top: 6),
            ),
          ),

          // Second text line shimmer
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 12 * textScale,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(6),
              ),
              margin: const EdgeInsets.only(top: 4),
            ),
          ),
        ],
      ),
    );
  }
}


class SkeletonEmployeeGrid extends StatelessWidget {
  const SkeletonEmployeeGrid({super.key});

  @override
  Widget build(BuildContext context) => GridView.builder(
    padding: EdgeInsets.all(
                      10 * Responsive.getResponsive(context),
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 6,
                          crossAxisSpacing: 6,
                          childAspectRatio: 0.77,
                        ),
                    itemCount: 12,
                    shrinkWrap: true,
      itemBuilder: (_, index) => const EmployeeCardSkeleton(),
      );
}
