import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/colors.dart';

class HorizontalProgressBar extends StatelessWidget {
  final double height;
  final int totalValue;
  final List<(int start, int end, Color color)> colorRanges;
  final Color backgroundColor;
  final BorderRadiusGeometry? borderRadius;

  const HorizontalProgressBar({
    required this.height,
    required this.totalValue,
    required this.colorRanges,
    super.key,
    this.backgroundColor = AppColors.gray,
    this.borderRadius,
  });

  /// Determines the color of a segment based on the provided ranges.
  Color _getColorForSegment(int segmentIndex) {
    for (final (start, end, color) in colorRanges) {
      if (segmentIndex >= start && segmentIndex < end) {
        return color;
      }
    }
    // If the segment is not in any specified range, it's part of the background.
    return backgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    // Avoid division by zero if totalValue is not positive.
    if (totalValue <= 0) {
      return SizedBox(height: height);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final double segmentWidth = constraints.maxWidth / totalValue;

        return SizedBox(
          height: height,
          child: Stack(
            children: [
              // Base progress bar built from colored segments
              ClipRRect(
                borderRadius: borderRadius ?? BorderRadius.zero,
                child: Row(
                  children: List.generate(totalValue, (i) => Container(
                      width: segmentWidth,
                      height: height,
                      color: _getColorForSegment(i),
                    )),
                ),
              ),

              // Decorative inner shadow overlays (unchanged)
              IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: borderRadius ?? BorderRadius.zero,
                    gradient: const LinearGradient(
                      colors: [
                        Colors.white10,
                        Colors.transparent,
                        Colors.transparent,
                        Colors.white10,
                      ],
                      stops: [0.0, 0.1, 0.95, 1.0],
                    ),
                  ),
                ),
              ),
              IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: borderRadius ?? BorderRadius.zero,
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white30, Colors.transparent],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}