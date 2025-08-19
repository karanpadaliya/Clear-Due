import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/responsive.dart';

class ClearDueLogo extends StatelessWidget {
  final double sizeFactor;

  const ClearDueLogo(this.sizeFactor, {super.key});

  @override
  Widget build(BuildContext context) {
    double size = Responsive.screenWidth(context) * sizeFactor;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circle with gradient
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primary.withValues(alpha: 0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
          ),
          // Stacked Bars - symbolizing financial charts
          Positioned(
            bottom: size * 0.2,
            left: size * 0.22,
            child: Container(
              width: size * 0.12,
              height: size * 0.36,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Positioned(
            bottom: size * 0.2,
            left: size * 0.44,
            child: Container(
              width: size * 0.14,
              height: size * 0.50,
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Positioned(
            bottom: size * 0.2,
            right: size * 0.22,
            child: Container(
              width: size * 0.10,
              height: size * 0.28,
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          // Checkmark shape for bill paid/ approved concept
          Positioned(
            top: size * 0.18,
            right: size * 0.12,
            child: Transform.rotate(
              angle: 0.1,
              child: Icon(
                Icons.check_circle,
                size: size * 0.28,
                color: AppColors.white.withValues(alpha: 0.9),
                shadows: const [
                  Shadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
