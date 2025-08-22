import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';

class CommonShimmer extends StatelessWidget {
  const CommonShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final r = Responsive.getResponsive(context);

    return Shimmer.fromColors(
      baseColor: AppColors.gray10,
      highlightColor: AppColors.gray5,
      child: ListView.builder(
        padding: EdgeInsets.all(16 * r),
        itemCount: 7,
        itemBuilder: (_, __) => _buildCardShimmer(r),
      ),
    );
  }

  Widget shimmerBox({required double width, required double height, double borderRadius = 4}) =>
      Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      );

  Widget _buildCardShimmer(double r) => Container(

    margin: EdgeInsets.only(bottom: 16 * r),
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
              shimmerBox(width: 110, height: 10), // Title placeholder
              SizedBox(height: 8 * r),
              shimmerBox(width: 80, height: 10), // Subtitle placeholder
            ],
          ),
        ),

        // Body content of the first card
        Padding(
          padding: EdgeInsets.all(12 * r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              shimmerBox(width: 350, height: 12),
              SizedBox(height: 10 * r),
              shimmerBox(width: 150, height: 12),

              SizedBox(height: 10 * r),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  shimmerBox(width: 120, height: 16),
                  _buildButtonShimmer(),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _buildButtonShimmer() => Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      width: 140,
      height: 35,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );

    // Helper widget for a single shimmer line/box

}
