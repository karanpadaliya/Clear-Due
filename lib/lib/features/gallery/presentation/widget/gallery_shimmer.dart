import 'package:flutter/material.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:shimmer/shimmer.dart';

class GalleryShimmer extends StatelessWidget {
  const GalleryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final side = 130 * Responsive.getResponsive(context);

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Responsive.isTablet(context) ? 5 : 3,
        crossAxisSpacing: 16 * Responsive.getResponsive(context),
        mainAxisSpacing: 6 * Responsive.getResponsive(context),
        childAspectRatio: 0.65,
      ),
      itemCount: 9, // you can adjust this as needed
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 2x2 image grid shimmer
            SizedBox(
              height: side,
              width: side,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                ),
                itemCount: 4,
                itemBuilder: (context, i) => Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      4 * Responsive.getResponsive(context),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8 * Responsive.getResponsive(context)),

            // album title shimmer line
            Container(
              height: 14 * Responsive.getResponsive(context),
              width: side * 0.8,
              color: Colors.white,
            ),
            SizedBox(height: 4 * Responsive.getResponsive(context)),

            // album date shimmer line
            Container(
              height: 12 * Responsive.getResponsive(context),
              width: side * 0.5,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
