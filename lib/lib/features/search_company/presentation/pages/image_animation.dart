import 'package:flutter/material.dart';
import 'package:myco_flutter/core/utils/responsive.dart';

class BouncingImage extends StatefulWidget {
  const BouncingImage({super.key});

  @override
  State<BouncingImage> createState() => _BouncingImageState();
}

class _BouncingImageState extends State<BouncingImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: -50.0,
      end: 30.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _animation,
    builder: (context, child) => Transform.translate(
      offset: Offset(0, -_animation.value),
      child: Image.asset(
        'assets/search_society/get-started.png',
        width: Responsive.getWidth(context) * 0.85,
        height: Responsive.getHeight(context) * 0.4,
      ),
    ),
  );
}
