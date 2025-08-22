import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
  static late double _screenWidth;
  static late double _screenHeight;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _screenWidth = size.width;
    _screenHeight = size.height;
  }

  static double screenWidth() => _screenWidth;

  static double screenHeight() => _screenHeight;

  static double scaleHeight(double height) => (_screenHeight / 812) * height;

  static double scaleWidth(double width) => (_screenWidth / 375) * width;

  static double scaleText(double size) {
    double factor = _screenWidth / 375;
    factor = factor.clamp(0.85, 1.2);
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

  /*double getResponsiveText(context) {
  if (Platform.isAndroid) {
    return getWidth(context) > 600 ? 1.5 : 0.8;
  } else {
    return getWidth(context) > 600 ? 1.5 : 0.9;
  }
}*/

  // double getResponsiveText(BuildContext context) {
  //   double width = MediaQuery.of(context).size.width;
  //
  //   if (kIsWeb) {
  //     // Web-specific logic
  //     return width > 600 ? 1.5 : 1.0;
  //   } else {
  //     // Mobile or Desktop
  //     return width > 600 ? 1.5 : 0.9;
  //   }
  // }

  static double getResponsiveText(context) {
    double width = MediaQuery.of(context).size.width;
    if (kIsWeb) return width > 600 ? 1.5 : 1.0;
    if (Platform.isAndroid) return getWidth(context) > 600 ? 1.5 : 1.0;
    return getWidth(context) > 600 ? 1.5 : 1.0;
  }

  static double getDashboardResponsive(BuildContext context) =>
      getWidth(context) > 600 ? 1 : 0.9;
  static double getDashboardResponsiveText(BuildContext context) =>
      getWidth(context) > 600 ? 1.2 : 1;

  static GridConfig getGridConfig(BuildContext context, {double? screenWide}) {
    final screenWidth = screenWide ?? getWidth(context);
    final spacing = 15.0 * getResponsive(context);
    final itemCount = screenWidth > 1200
        ? 10
        : screenWidth > 1000
        ? 7
        : screenWidth > 600
        ? 6
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
