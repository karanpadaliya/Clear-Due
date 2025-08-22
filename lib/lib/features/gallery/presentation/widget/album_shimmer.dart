import 'package:flutter/material.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:shimmer/shimmer.dart';

class AlbumShimmer extends StatelessWidget {
  const AlbumShimmer({super.key});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
    // The base and highlight colors of the shimmer effect.
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: GridView.builder(
      // IMPORTANT: Use the exact same gridDelegate as your real GridView
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150.0 * Responsive.getResponsive(context),
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      // Display a fixed number of shimmer items to fill the screen
      itemCount: 50,
      itemBuilder: (context, index) =>
          // The placeholder for each grid item
          Container(
            color: Colors
                .white, // The shimmer effect is drawn on top of this color
          ),
    ),
  );
}
