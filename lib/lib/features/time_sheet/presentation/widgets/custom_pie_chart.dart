import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:myco_flutter/core/utils/responsive.dart';

/// Data model for a single segment in the pie chart.
class PieSegment {
  final int id;
  final double value;
  final Color color;
  final String label;
  final dynamic data;

  PieSegment({
    required this.id,
    required this.value,
    required this.color,
    required this.label,
    this.data,
  });
}

/// A customizable, interactive donut pie chart widget.
class CustomPieChart extends StatefulWidget {
  final List<PieSegment> segments;
  final ValueChanged<PieSegment?>? onSegmentSelected;
  final int? initialSelectedSegmentId;

  const CustomPieChart({
    required this.segments,
    super.key,
    this.onSegmentSelected,
    this.initialSelectedSegmentId,
  });

  @override
  State<CustomPieChart> createState() => _CustomPieChartState();
}

class _CustomPieChartState extends State<CustomPieChart> {
  int? selectedSegmentIndex;

  @override
  void initState() {
    super.initState();
    if (widget.initialSelectedSegmentId != null) {
      final index = widget.segments.indexWhere(
        (s) => s.id == widget.initialSelectedSegmentId,
      );
      if (index != -1) {
        selectedSegmentIndex = index;
      }
    }
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTapUp: (details) {
      final RenderBox box = context.findRenderObject() as RenderBox;
      final localPosition = box.globalToLocal(details.globalPosition);
      final center = Offset(box.size.width / 2, box.size.height / 2);
      final dx = localPosition.dx - center.dx;
      final dy = localPosition.dy - center.dy;
      final distance = math.sqrt(dx * dx + dy * dy);
      final radius = box.size.width / 2;
      const innerRadiusFactor = 0.5;
      final innerRadius = radius * innerRadiusFactor;

      if (distance >= innerRadius && distance <= radius) {
        var angle = math.atan2(dy, dx);
        if (angle < -math.pi / 2) angle += 2 * math.pi;
        angle += math.pi / 2;

        double startAngle = 0;
        final totalValue = widget.segments.fold(0.0, (sum, s) => sum + s.value);

        for (int i = 0; i < widget.segments.length; i++) {
          final sweep = (widget.segments[i].value / totalValue) * 2 * math.pi;
          if (angle >= startAngle && angle < startAngle + sweep) {
            final wasSelected = selectedSegmentIndex == i;
            setState(() {
              selectedSegmentIndex = wasSelected ? null : i;
            });

            widget.onSegmentSelected?.call(
              wasSelected ? null : widget.segments[i],
            );
            return;
          }
          startAngle += sweep;
        }
      } else {
        setState(() {
          selectedSegmentIndex = null;
        });
        widget.onSegmentSelected?.call(null);
      }
    },
    child: SizedBox(
      width: 250 * Responsive.getResponsive(context),
      height: 250 * Responsive.getResponsive(context),
      child: CustomPaint(
        painter: DonutChartPainter(
          segments: widget.segments,
          selectedSegmentIndex: selectedSegmentIndex,
          innerCircleColor: Colors.transparent,
        ),
      ),
    ),
  );
}

/// CustomPainter for drawing the donut chart.
class DonutChartPainter extends CustomPainter {
  final List<PieSegment> segments;
  final int? selectedSegmentIndex;
  final Color innerCircleColor;

  DonutChartPainter({
    required this.segments,
    required this.innerCircleColor,
    this.selectedSegmentIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const innerRadiusFactor = 0.5;
    final innerRadius = radius * innerRadiusFactor;
    const liftOffset = 30.0;
    final totalValue = segments.fold(0.0, (sum, s) => sum + s.value);
    double startAngle = -math.pi / 2;

    // Outer shadow paint
    final outerShadowPaint = Paint()
      ..color = Colors.black.withAlpha((255 * 0.4).round())
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5.0);

    // Inner shadow paint
    final innerShadowPaint = Paint()
      ..color = Colors.black.withAlpha((255 * 0.15).round())
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < segments.length; i++) {
      final s = segments[i];
      final sweep = (s.value / totalValue) * 2 * math.pi;
      final segmentPaint = Paint()..color = s.color;

      Offset segmentCenter = center;

      if (selectedSegmentIndex == i) {
        final mid = startAngle + sweep / 2;
        segmentCenter = Offset(
          center.dx + liftOffset * math.cos(mid),
          center.dy + liftOffset * math.sin(mid),
        );
      }

      final segmentPath = Path()
        ..moveTo(
          center.dx + radius * math.cos(startAngle),
          center.dy + radius * math.sin(startAngle),
        )
        ..arcTo(
          Rect.fromCircle(center: center, radius: radius),
          startAngle,
          sweep,
          false,
        )
        ..lineTo(
          center.dx + innerRadius * math.cos(startAngle + sweep),
          center.dy + innerRadius * math.sin(startAngle + sweep),
        )
        ..arcTo(
          Rect.fromCircle(center: center, radius: innerRadius),
          startAngle + sweep,
          -sweep,
          false,
        )
        ..close();

      // Apply the outer shadow
      canvas.drawPath(
        segmentPath.shift(segmentCenter - center),
        outerShadowPaint,
      );
      canvas.drawPath(segmentPath.shift(segmentCenter - center), segmentPaint);

      // Draw the "inner" shadow with variable thickness lines
      _drawInnerShadow(
        canvas,
        segmentCenter,
        innerRadius,
        startAngle,
        sweep,
        innerShadowPaint,
      );

      canvas.drawCircle(
        segmentCenter,
        innerRadius,
        Paint()..color = innerCircleColor,
      );

      final labelRadius = radius * 0.75;

      // Calculate the start and end angles for the label text arc
      final textArcStartAngle = startAngle + 0.1; // Small margin
      final textArcSweepAngle = sweep - 0.2; // Small margin

      _drawCurvedText(
        canvas,
        segmentCenter,
        s.label,
        labelRadius,
        textArcStartAngle,
        textArcSweepAngle,
      );

      startAngle += sweep;
    }
  }

  void _drawCurvedText(
    Canvas canvas,
    Offset center,
    String text,
    double radius,
    double startAngle,
    double sweepAngle,
  ) {
    if (text.isEmpty) {
      return;
    }

    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final textWidth = textPainter.width;
    final arcLength = radius * sweepAngle;

    // Only draw the text if it fits within the arc
    if (textWidth > arcLength) {
      return;
    }

    final startPositionAngle =
        startAngle + (sweepAngle - textWidth / radius) / 2;
    double currentAngle = startPositionAngle;

    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      final charPainter = TextPainter(
        text: TextSpan(text: char, style: textPainter.text!.style),
        textDirection: TextDirection.ltr,
      )..layout();

      final charWidth = charPainter.width;
      final charAngle = charWidth / 2 / radius;

      canvas.save();
      canvas.translate(
        center.dx + radius * math.cos(currentAngle + charAngle),
        center.dy + radius * math.sin(currentAngle + charAngle),
      );

      // Flip the text if it's on the bottom half of the circle
      var rotationAngle = currentAngle + charAngle + math.pi / 2;
      if (rotationAngle > math.pi / 1 && rotationAngle < 2 * math.pi / 2) {
        rotationAngle += math.pi;
      }
      canvas.rotate(rotationAngle);

      charPainter.paint(
        canvas,
        Offset(-charWidth / 2, -charPainter.height / 2),
      );
      canvas.restore();

      currentAngle += charWidth / radius;
    }
  }

  void _drawInnerShadow(
    Canvas canvas,
    Offset center,
    double innerRadius,
    double startAngle,
    double sweepAngle,
    Paint paint,
  ) {
    const shadowMargin = 0.005;
    final shadowStartAngle = startAngle + shadowMargin;
    final shadowSweepAngle = sweepAngle - (2 * shadowMargin);

    if (shadowSweepAngle <= 0) {
      return;
    }

    final numLines = (100 * (shadowSweepAngle / sweepAngle)).toInt().clamp(
      10,
      100,
    );
    final angleStep = shadowSweepAngle / numLines;

    for (int j = 0; j <= numLines; j++) {
      final angleRad = shadowStartAngle + j * angleStep;
      final thicknessFactor = (-math.sin(angleRad) + 1) / 2;
      final strokeW = (35.0 * thicknessFactor + 10.0) * 0.1;
      paint.strokeWidth = strokeW;

      final x1 = center.dx + math.cos(angleRad) * (innerRadius - strokeW / 2);
      final y1 = center.dy + math.sin(angleRad) * (innerRadius - strokeW / 2);
      final x2 = center.dx + math.cos(angleRad) * (innerRadius + strokeW / 2);
      final y2 = center.dy + math.sin(angleRad) * (innerRadius + strokeW / 2);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
