import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/responsive.dart';
import '../../../shared/widgets/animated_background.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return Scaffold(
      body: Stack(
        children: [
          // Finance-themed animated background
          const AnimatedBackground(),

          // Gradient overlay for depth and legibility
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.9),
                  AppColors.primary.withValues(alpha: 0.7),
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Centered content with elegant fade and scale animations
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 1100),
                  curve: Curves.easeOutBack,
                  builder: (context, scale, child) =>
                      Transform.scale(scale: scale, child: child),
                  child: const _FinanceLogo(0.3),
                ),
                const SizedBox(height: 40),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.easeIn,
                  builder: (context, opacity, child) =>
                      Opacity(opacity: opacity, child: child),
                  child: Text(
                    "Clear Due",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: Responsive.textScale(context, 44),
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                      shadows: const [
                        Shadow(
                          color: Colors.black38,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 1400),
                  curve: Curves.easeIn,
                  builder: (context, opacity, child) =>
                      Opacity(opacity: opacity, child: child),
                  child: Text(
                    "Your Smart Bill Companion",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.white.withValues(alpha: 0.85),
                      fontSize: Responsive.textScale(context, 18),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.7,
                      shadows: const [
                        Shadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//// Custom logo widget built with Flutter shapes, themed for finance app
class _FinanceLogo extends StatelessWidget {
  final double sizeFactor;

  const _FinanceLogo(this.sizeFactor);

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
