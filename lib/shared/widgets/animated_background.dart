import 'dart:math';
import 'package:clear_due/core/app_colors.dart';
import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  AnimatedBackgroundState createState() =>
      AnimatedBackgroundState();
}

// Make the State class public (remove the underscore)
class AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();

  late List<Offset> _dots;
  late List<double> _dotRadii;
  final int _numDots = 30;

  @override
  void initState() {
    super.initState();

    _dots = List.generate(
      _numDots,
      (index) => Offset(_random.nextDouble(), _random.nextDouble()),
    );
    _dotRadii = List.generate(
      _numDots,
      (index) => 2 + _random.nextDouble() * 4,
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return CustomPaint(
          painter: FinanceBackgroundPainter(
            progress: _controller.value,
            dots: _dots,
            dotRadii: _dotRadii,
          ),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

class FinanceBackgroundPainter extends CustomPainter {
  final double progress;
  final List<Offset> dots;
  final List<double> dotRadii;

  FinanceBackgroundPainter({
    required this.progress,
    required this.dots,
    required this.dotRadii,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint dotPaint = Paint()
      ..color = AppColors.backgroundDot.withValues(alpha: 0.15);

    for (int i = 0; i < dots.length; i++) {
      final Offset baseOffset = Offset(
        size.width * dots[i].dx,
        size.height * dots[i].dy,
      );

      final double dx = baseOffset.dx + sin((progress * 2 * pi) + i) * 10;
      final double dy = baseOffset.dy + cos((progress * 2 * pi) + i) * 8;

      canvas.drawCircle(Offset(dx, dy), dotRadii[i], dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant FinanceBackgroundPainter oldDelegate) => true;
}
