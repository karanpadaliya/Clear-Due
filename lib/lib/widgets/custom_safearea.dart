import 'package:flutter/material.dart';

class CustomSafeArea extends StatelessWidget {
  final Widget child;

  final bool top, left, right, bottom, maintainBottomViewPadding;

  final EdgeInsets minimum;

  const CustomSafeArea({
    required this.child,
    super.key,
    this.top = true,
    this.left = true,
    this.right = true,
    this.bottom = true,
    this.maintainBottomViewPadding = false,
    this.minimum = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) => SafeArea(
    key: key,
    top: top,
    left: left,
    right: right,
    bottom: bottom,
    maintainBottomViewPadding: maintainBottomViewPadding,
    minimum: minimum,
    child: child,
  );
}
 