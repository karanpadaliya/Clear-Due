import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCircularDialog extends StatelessWidget {
  const ShimmerCircularDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final r = Responsive.getResponsive(context);

    // Main dialog frame
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * r).copyWith(top: 10 * r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // The Shimmer content, wrapped in Flexible to ensure it fits
          Flexible(
            child: buildShimmerLayout(r),
          ),
        ],
      ),
    );
  }

  // This method builds the actual shimmer placeholder layout
  Widget buildShimmerLayout(double r) {
    // Helper widget for a single shimmer line/box
    Widget shimmerBox(
        {required double width,
          required double height,
          double borderRadius = 4}) =>
        Container(
          height: height * r,
          width: width * r,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius * r),
          ),
        );

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- First Card Placeholder (Notice Card) ---
            Container(
              decoration: BoxDecoration(
                // This border will be covered by the shimmer color,
                // but it helps define the card shape.
                border: Border.all(color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(12 * r),
              ),
              child: Column(
                children: [
                  // Header section of the first card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12 * r),
                    decoration: BoxDecoration(
                      color: Colors.white, // Placeholder color
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(11 * r)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        shimmerBox(width: 150, height: 16), // Title placeholder
                        SizedBox(height: 8 * r),
                        shimmerBox(width: 100, height: 12), // Subtitle placeholder
                      ],
                    ),
                  ),

                  // Body content of the first card
                  Padding(
                    padding: EdgeInsets.all(12 * r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        shimmerBox(width: 250, height: 14),
                        SizedBox(height: 10 * r),
                        shimmerBox(width: 200, height: 14),
                        SizedBox(height: 10 * r),
                        shimmerBox(width: 220, height: 14),
                        SizedBox(height: 10 * r),
                        shimmerBox(width: 180, height: 14),
                        SizedBox(height: 10 * r),
                        shimmerBox(width: 150, height: 14),
                        SizedBox(height: 10 * r),
                        shimmerBox(width: 180, height: 14),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16 * r),

            // --- Second Card Placeholder (Attachment Card) ---
            Container(
              decoration: BoxDecoration(
                // This border will be covered by the shimmer color,
                // but it helps define the card shape.
                border: Border.all(color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(12 * r),
              ),
              child: Column(
                children: [
                  // Header section of the first card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12 * r),
                    decoration: BoxDecoration(
                      color: Colors.white, // Placeholder color
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(11 * r)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        shimmerBox(width: 150, height: 16), // Title placeholder
                        SizedBox(height: 8 * r),
                      ],
                    ),
                  ),

                  // Body content of the first card
                  Padding(
                    padding: EdgeInsets.all(12 * r),
                    child: Row(
                      children: [
                        shimmerBox(width: 70, height: 70),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}