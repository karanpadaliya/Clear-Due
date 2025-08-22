import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/core/utils/util.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class ColorRange {
  final double startMinutes;
  final double endMinutes;
  final Color color;

  ColorRange(this.startMinutes, this.endMinutes, this.color);
}

class CustomTimer extends StatefulWidget {
  final double maxMinutes;
  final double minutesPerSegment;
  final double strokeWidth;
  final double sectionGap;
  final Color backgroundColor;
  final List<Color> primaryColor;
  final List<ColorRange> colorRanges;
  final VoidCallback? onCompleted;

  final double timerWidth;
  final double timerHeight;
  final double initialMinutes; // To set the starting value of the timer

  const CustomTimer({
    super.key,
    this.maxMinutes = 10,
    this.minutesPerSegment = 2,
    this.strokeWidth = 20,
    this.sectionGap = 2,
    this.backgroundColor = Colors.grey,
    this.primaryColor = const [Colors.teal],
    this.colorRanges = const [],
    this.onCompleted,
    this.timerWidth = 250,
    this.timerHeight = 250,
    this.initialMinutes = 0,
  });

  @override
  State<CustomTimer> createState() => _CustomTimerState();
}

class _CustomTimerState extends State<CustomTimer> {
  late Timer _timer;
  late double currentMinutes;

  @override
  void initState() {
    super.initState();
    currentMinutes = widget.initialMinutes;
    _startTimer();
  }

  @override
  void didUpdateWidget(covariant CustomTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialMinutes != widget.initialMinutes) {
      _timer.cancel();
      currentMinutes = widget.initialMinutes;
      _startTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        currentMinutes += 1 / 60.0;
        if (currentMinutes >= widget.maxMinutes) {
          currentMinutes = widget.maxMinutes;
          _timer.cancel();
          widget.onCompleted?.call();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalSeconds = (currentMinutes * 60).toInt();
    final displayHours = (totalSeconds ~/ 3600).toString().padLeft(2, '0');
    final displayMinutes = ((totalSeconds % 3600) ~/ 60).toString().padLeft(
      2,
      '0',
    );
    final displaySeconds = (totalSeconds % 60).toString().padLeft(2, '0');
    final timeText = '$displayHours:$displayMinutes:$displaySeconds';

    final safeStrokeWidth = min(widget.strokeWidth, widget.timerWidth * 0.2);

    return SizedBox(
      width: widget.timerWidth,
      height: widget.timerHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer shadow circle
          Container(
            width: widget.timerWidth,
            height: widget.timerHeight,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Util.applyOpacity(const Color(0xFF2FBBA4), 0.70),
                  blurRadius: 10,
                ),
              ],
            ),
          ),

          // Inner white circle
          Container(
            width: widget.timerWidth * 0.47,
            height: widget.timerHeight * 0.47,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.getColor(context).surface,
                  spreadRadius: widget.timerWidth * 0.12,
                  blurRadius: widget.timerWidth * 0.15,
                ),
              ],
            ),
          ),

          // Timer arc and inner shadow
          CustomPaint(
            size: Size(widget.timerWidth, widget.timerHeight),
            painter: _CustomTimerPainter(
              maxMinutes: widget.maxMinutes,
              currentMinutes: currentMinutes,
              minutesPerSegment: widget.minutesPerSegment,
              strokeWidth: safeStrokeWidth,
              sectionGap: widget.sectionGap,
              backgroundColor: widget.backgroundColor,
              primaryColor: widget.primaryColor,
              colorRanges: widget.colorRanges,
            ),
            foregroundPainter: InnerShadowPainter(
              strokeWidth: 5,
              blurRadius: 20,
              shadowColor: Colors.black26,
            ),
          ),

          // Time text
          CustomText(
            timeText,
            fontSize: 18 * Responsive.getDashboardResponsiveText(context),
            fontWeight: FontWeight.w600,
            color: AppTheme.getColor(context).onSurface,
          ),
        ],
      ),
    );
  }
}

class _CustomTimerPainter extends CustomPainter {
  final double maxMinutes;
  final double currentMinutes;
  final double minutesPerSegment;
  final double strokeWidth;
  final double sectionGap;
  final Color backgroundColor;
  final List<Color> primaryColor;
  final List<ColorRange> colorRanges;

  _CustomTimerPainter({
    required this.maxMinutes,
    required this.currentMinutes,
    required this.minutesPerSegment,
    required this.strokeWidth,
    required this.sectionGap,
    required this.backgroundColor,
    required this.primaryColor,
    required this.colorRanges,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (min(size.width, size.height) / 2) - strokeWidth / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    if (maxMinutes <= 0) return;

    final totalSegments = (maxMinutes / minutesPerSegment).ceil();
    final totalGapAngle =
        (totalSegments > 0 ? totalSegments - 1 : 0) * sectionGap;
    final totalAvailableAngle = 360.0 - totalGapAngle;
    final anglePerMinute = totalAvailableAngle / maxMinutes;
    const startAngle = -90.0;

    final backgroundPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = backgroundColor;

    final primaryPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    if (primaryColor.length > 1) {
      primaryPaint.shader = SweepGradient(
        colors: primaryColor,
        startAngle: _degToRad(startAngle),
        endAngle: _degToRad(startAngle + 360),
        transform: GradientRotation(_degToRad(startAngle)),
      ).createShader(rect);
    } else {
      primaryPaint.color = primaryColor.first;
    }

    // --- Drawing Logic ---
    // 1. Draw Background Segments
    double currentDrawingAngle = startAngle;
    for (int i = 0; i < totalSegments; i++) {
      final segmentMinutes = min(
        minutesPerSegment,
        maxMinutes - (i * minutesPerSegment),
      );
      final segmentAngle = segmentMinutes * anglePerMinute;
      canvas.drawArc(
        rect,
        _degToRad(currentDrawingAngle),
        _degToRad(segmentAngle),
        false,
        backgroundPaint,
      );
      currentDrawingAngle += segmentAngle + sectionGap;
    }

    // 2. Draw Primary Color Progress Segments
    currentDrawingAngle = startAngle;
    final filledMinutes = min(currentMinutes, maxMinutes);
    for (int i = 0; i < totalSegments; i++) {
      final segmentStartMinute = i * minutesPerSegment;
      if (filledMinutes <= segmentStartMinute) break;

      final segmentMinutes = min(
        minutesPerSegment,
        maxMinutes - segmentStartMinute,
      );
      final drawableMinutesInSegment = min(
        filledMinutes - segmentStartMinute,
        segmentMinutes,
      );
      final sweepAngle = drawableMinutesInSegment * anglePerMinute;

      canvas.drawArc(
        rect,
        _degToRad(currentDrawingAngle),
        _degToRad(sweepAngle),
        false,
        primaryPaint,
      );
      currentDrawingAngle += (segmentMinutes * anglePerMinute) + sectionGap;
    }

    // 3. Overlay the colored break ranges on top
    final breakPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    for (final range in colorRanges) {
      if (range.startMinutes >= filledMinutes) continue;

      final effectiveEndMinutes = min(range.endMinutes, filledMinutes);
      if (effectiveEndMinutes <= range.startMinutes) continue;

      final rangeStartAngle = _mapMinutesToAngle(
        range.startMinutes,
        minutesPerSegment,
        anglePerMinute,
        sectionGap,
      );
      final rangeEndAngle = _mapMinutesToAngle(
        effectiveEndMinutes,
        minutesPerSegment,
        anglePerMinute,
        sectionGap,
      );
      final sweepAngle = rangeEndAngle - rangeStartAngle;

      if (sweepAngle > 0) {
        breakPaint.color = range.color;
        canvas.drawArc(
          rect,
          _degToRad(startAngle + rangeStartAngle),
          _degToRad(sweepAngle),
          false,
          breakPaint,
        );
      }
    }
  }

  /// Helper to convert a minute value to its corresponding angle, accounting for gaps.
  double _mapMinutesToAngle(
    double minutes,
    double minutesPerSegment,
    double anglePerMinute,
    double sectionGap,
  ) {
    if (minutes <= 0) return 0.0;
    final numFullSegments = (minutes / minutesPerSegment).floor();
    final angleForGaps = numFullSegments * sectionGap;
    final angleForMinutes = minutes * anglePerMinute;
    return angleForMinutes + angleForGaps;
  }

  double _degToRad(double degrees) => degrees * pi / 180;

  @override
  bool shouldRepaint(covariant _CustomTimerPainter oldDelegate) =>
      oldDelegate.currentMinutes != currentMinutes ||
      oldDelegate.maxMinutes != maxMinutes ||
      oldDelegate.backgroundColor != backgroundColor ||
      oldDelegate.primaryColor != primaryColor ||
      oldDelegate.colorRanges != colorRanges ||
      oldDelegate.minutesPerSegment != minutesPerSegment ||
      oldDelegate.sectionGap != sectionGap ||
      oldDelegate.strokeWidth != strokeWidth;
}

class InnerShadowPainter extends CustomPainter {
  final double strokeWidth;
  final double blurRadius;
  final Color shadowColor;

  InnerShadowPainter({
    required this.strokeWidth,
    this.blurRadius = 10.0,
    this.shadowColor = Colors.black12,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // final outerRadius = (min(size.width, size.height) / 2);
    // final innerRadius = outerRadius - strokeWidth;
    // final center = size.center(Offset.zero);

    // final outerPath = Path()
    //   ..addOval(Rect.fromCircle(center: center, radius: outerRadius));
    // final innerPath = Path()
    // ..addOval(Rect.fromCircle(center: center, radius: innerRadius));
    // final ringPath = Path.combine(
    //   PathOperation.difference,
    //   outerPath,
    //   innerPath,
    // );

    canvas.saveLayer(Offset.zero & size, Paint());

    // canvas.drawPath(
    //   ringPath,
    //   Paint()
    //     ..color = shadowColor
    //     ..maskFilter = MaskFilter.blur(BlurStyle.inner, blurRadius),
    // );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
