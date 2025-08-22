import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  SliverTabBarDelegate({required this.child, required this.height});

  @override
  double get minExtent => height; // or exact height of your tab bar
  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) => Material(
    color: AppTheme.getColor(context).surface,
    elevation: overlapsContent ? 1 : 0,
    child: SizedBox(height: height, child: child),
  );

  @override
  bool shouldRebuild(covariant SliverTabBarDelegate oldDelegate) =>
      child != oldDelegate.child || height != oldDelegate.height;
}
