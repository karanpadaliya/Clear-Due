import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/border_container_wraper.dart';
import 'package:myco_flutter/widgets/custom_cached_network_image.dart';

class ProfileCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String department;
  final double? width;
  final double? height;
  final double? imageHeight;
  final double? imageWidth;
  final double? vectorWidth;
  final double? vectorHeight;
  final Offset? vectorOffset;
  final Offset? imageOffset;
  final Decoration? decoration;

  const ProfileCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.department,
    this.width,
    this.height,
    this.imageHeight,
    this.imageWidth,
    this.vectorWidth,
    this.vectorHeight,
    this.vectorOffset,
    this.imageOffset,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 125 * Responsive.getDashboardResponsive(context),
    child: Column(
      children: [
        // Stack image directly on top of vector shape
        BorderContainerWraper(
          padding: EdgeInsets.only(
            bottom: 10 * Responsive.getDashboardResponsive(context),
          ),
          borderRadius: 15 * Responsive.getDashboardResponsive(context),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              CustomPaint(
                size: Size(
                  125 * Responsive.getDashboardResponsive(context),
                  100 * Responsive.getDashboardResponsive(context),
                ),
                painter: DiagonalCornerPainter(blur: 8, borderRadius: 10),
              ),
              // Profile image slightly above vector center
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        15 * Responsive.getDashboardResponsive(context),
                      ),
                      child: CustomCachedNetworkImage(
                        imageUrl: imagePath,
                        userName: name,
                        height: 82 * Responsive.getDashboardResponsive(context),
                        width: 82 * Responsive.getDashboardResponsive(context),
                      ),
                    ),
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize:
                          15 * Responsive.getDashboardResponsiveText(context),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    department,
                    style: TextStyle(
                      fontSize:
                          10 * Responsive.getDashboardResponsiveText(context),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Text(
                  //   name,
                  //   style: const TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 18,
                  //   ),
                  // ),
                  //  Spacer(),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 10),
                  //   child: Text(
                  //     department,
                  //     style: const TextStyle(fontSize: 15),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),

        // ProfileDemo()
      ],
    ),
  );
}

class DiagonalCornerPainter extends CustomPainter {
  final Color fillColor;
  final Color shadowColor;
  final double blur;
  final double borderRadius;
  final Offset shadowOffset;

  DiagonalCornerPainter({
    this.fillColor = AppColors.secondary,
    this.shadowColor = AppColors.black,
    this.blur = 6.0,
    this.borderRadius = 18.0,
    this.shadowOffset = const Offset(8, 0),
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Replaced the path creation with one that uses `arcTo` for perfect circular corners
    final Path shapePath = Path()
      ..moveTo(borderRadius, 0)
      ..lineTo(size.width - borderRadius, 0)
      ..arcTo(
        Rect.fromCircle(
          center: Offset(size.width - borderRadius, borderRadius),
          radius: borderRadius,
        ),
        -pi / 2, // Start angle (top)
        pi / 2, // Sweep angle (90 degrees)
        false,
      )
      ..lineTo(borderRadius, size.height)
      ..arcTo(
        Rect.fromCircle(
          center: Offset(borderRadius, size.height - borderRadius),
          radius: borderRadius,
        ),
        pi / 2, // Start angle (bottom)
        pi / 2, // Sweep angle (90 degrees)
        false,
      )
      ..lineTo(0, borderRadius)
      ..arcTo(
        Rect.fromCircle(
          center: Offset(borderRadius, borderRadius),
          radius: borderRadius,
        ),
        pi, // Start angle (left)
        pi / 2, // Sweep angle (90 degrees)
        false,
      )
      ..close();

    // Step 1: Fill the original shape (Unchanged)
    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    canvas.drawPath(shapePath, fillPaint);

    // Step 2: Shadow path using even-odd fill technique (Unchanged)
    final Path innerShadowPath = Path()
      ..addPath(shapePath.shift(shadowOffset), Offset.zero)
      ..addPath(shapePath, Offset.zero)
      ..fillType = PathFillType.evenOdd;

    // Step 3: Shadow paint (Unchanged)
    final shadowPaint = Paint()
      ..color = shadowColor.withOpacity(0.5)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blur);

    // Step 4: Save layer and clip to original shape (Unchanged)
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());
    canvas.clipPath(shapePath);
    canvas.drawPath(innerShadowPath, shadowPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

// class SvgShapePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     // The original SVG viewBox dimensions.
//     const double svgWidth = 126.0;
//     const double svgHeight = 100.0;

//     // Calculate scaling factors to fit the path into the canvas size.
//     final double scaleX = size.width / svgWidth;
//     final double scaleY = size.height / svgHeight;

//     // Create the path object.
//     final Path path = Path();

//     // Translate the SVG path commands to Flutter Path methods.
//     // Each coordinate is scaled to fit the canvas.
//     path.moveTo(1 * scaleX, 10 * scaleY);
//     path.cubicTo(
//       1 * scaleX,
//       5.58172 * scaleY,
//       4.58172 * scaleX,
//       2 * scaleY,
//       9 * scaleX,
//       2 * scaleY,
//     );
//     path.lineTo(114 * scaleX, 2 * scaleY);
//     path.cubicTo(
//       118.418 * scaleX,
//       2 * scaleY,
//       122 * scaleX,
//       5.58172 * scaleY,
//       122 * scaleX,
//       10 * scaleY,
//     );
//     path.lineTo(122 * scaleX, 11.2551 * scaleY);
//     path.cubicTo(
//       122 * scaleX,
//       13.8355 * scaleY,
//       120.755 * scaleX,
//       16.2575 * scaleY,
//       118.657 * scaleX,
//       17.7597 * scaleY,
//     );
//     path.lineTo(13.6572 * scaleX, 92.9377 * scaleY);
//     path.cubicTo(
//       8.36317 * scaleX,
//       96.7281 * scaleY,
//       1 * scaleX,
//       92.9441 * scaleY,
//       1 * scaleX,
//       86.433 * scaleY,
//     );

//     // Close the path to connect the last point to the first one.
//     path.close();

//     // Define the paint for the fill color.
//     final Paint fillPaint = Paint()
//       ..color = const Color(0xFF2FBBA4)
//       ..style = PaintingStyle.fill;

//     // First, draw the main filled path.
//     canvas.drawPath(path, fillPaint);

//     // --- Inner Shadow Implementation ---
//     // To create a shadow on top, we draw a blurred shape inside the original path.
//     // This technique uses a hollowed-out path and a blur filter, clipped by the original path.

//     // Corrected shadow parameters. Positive offsets cast the shadow inwards from the opposite side.
//     final double shadowOffsetX =
//         6.0 * scaleX; // Positive value casts shadow on the LEFT interior.
//     final double shadowOffsetY =
//         2.5 * scaleY; // Positive value casts shadow on the TOP interior.
//     final double shadowBlurSigma =
//         4.0; // Increased blur for a softer, more prominent shadow

//     // Create a path that is the inverse of our shape within its bounding box.
//     // The even-odd fill type creates a "hole" where the shape is.
//     final Path shadowPath = Path()
//       ..addRect(path.getBounds())
//       ..addPath(path, Offset.zero)
//       ..fillType = PathFillType.evenOdd;

//     // The paint for the shadow, with color and blur.
//     final Paint shadowPaint = Paint()
//       ..color = Colors.black
//           .withOpacity(0.3) // Increased opacity slightly
//       ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadowBlurSigma);

//     // We use a save/restore block to ensure the clipping and translation
//     // for the shadow do not affect subsequent drawing operations.
//     canvas.save();
//     // Clip the canvas to the main shape's path. This prevents the shadow
//     // from spilling outside the shape's boundaries.
//     canvas.clipPath(path);
//     // Translate the canvas by the shadow's offset.
//     canvas.translate(shadowOffsetX, shadowOffsetY);
//     // Draw the hollowed-out path. The blur will bleed inwards from the
//     // edges of the "hole", creating the inner shadow effect.
//     canvas.drawPath(shadowPath, shadowPaint);
//     canvas.restore();
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     // The shape is static, so we don't need to repaint unless the painter changes.
//     return false;
//   }
// }
