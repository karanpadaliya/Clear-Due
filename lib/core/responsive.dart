import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// You can add this class to the same file or a separate file if you prefer.
class GridConfig {
  final int itemCount;
  final double spacing;
  final double itemWidth;
  final double itemHeight;
  final double childAspectRatio;

  GridConfig({
    required this.itemCount,
    required this.spacing,
    required this.itemWidth,
    required this.itemHeight,
    required this.childAspectRatio,
  });
}

class Responsive {
  // Existing static properties from the new code
  static late double _screenWidth;
  static late double _screenHeight;

  // New init method to initialize screen dimensions
  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _screenWidth = size.width;
    _screenHeight = size.height;
  }

  // Merged methods from both versions
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // Corrected method to use `textScaler` instead of `textScaleFactor`
  static double textScale(BuildContext context, double size) {
    return MediaQuery.of(context).textScaler.scale(size);
  }

  static bool isMobile(BuildContext context) {
    return screenWidth(context) < 650;
  }

  // New methods from the second code snippet
  static double screenWidthInitialized() => _screenWidth;

  static double screenHeightInitialized() => _screenHeight;

  static double scaleHeight(double height) => (_screenHeight / 812) * height;

  static double scaleWidth(double width) => (_screenWidth / 375) * width;

  static double scaleText(double size) {
    double factor = _screenWidth / 375;
    factor = factor.clamp(0.85, 1.2);
    // You'll need to pass a context to this function if you want to use textScaler
    // For now, this old implementation is kept for backwards compatibility but is not recommended.
    return size * factor;
  }

  static bool isTablet(BuildContext context) => getWidth(context) >= 600;

  static double responsivePadding(context) => isTablet(context) ? 24 : 16;

  static double getHeight(context) => MediaQuery.of(context).size.height;

  static double getWidth(context) => MediaQuery.of(context).size.width;

  static double getResponsive(context) =>
      MediaQuery.of(context).size.height * 0.001;

  static double getResponsiveOnWidth(context) =>
      MediaQuery.of(context).size.width * 0.001;

  static double getResponsiveText(context) {
    final double width = MediaQuery.of(context).size.width;
    if (kIsWeb) return width > 600 ? 1.5 : 1.0;
    if (Platform.isAndroid) return getWidth(context) > 600 ? 1.5 : 1.0;
    return getWidth(context) > 600 ? 1.5 : 1.0;
  }

  static double getDashboardResponsive(BuildContext context) =>
      getWidth(context) > 600 ? 1 : 0.9;

  static double getDashboardResponsiveText(BuildContext context) =>
      getWidth(context) > 600 ? 1.1 : 1;

  static GridConfig getGridConfig(BuildContext context, {double? screenWide}) {
    final screenWidth = screenWide ?? getWidth(context);
    final spacing = 15.0 * getResponsive(context);
    final itemCount = screenWidth > 1200
        ? 10
        : screenWidth > 1000
        ? 7
        : screenWidth > 600
        ? 5
        : 3;

    final itemWidth = (screenWidth - (spacing * (itemCount - 1))) / itemCount;
    final itemHeight = screenWidth > 600
        ? 180.0
        : screenWidth > 500
        ? 160.0
        : 155.0;
    final childAspectRatio = itemWidth / itemHeight;

    return GridConfig(
      itemCount: itemCount,
      spacing: spacing,
      itemWidth: itemWidth,
      itemHeight: itemHeight,
      childAspectRatio: childAspectRatio,
    );
  }
}
