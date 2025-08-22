import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

// Model for each step in the horizontal stepper
class CustomHorizontalStepper {
  final String label;
  final String? imagePath;
  final Color color;
  final bool isActive;

  const CustomHorizontalStepper({
    required this.label,
    required this.color,
    this.imagePath,
    this.isActive = false,
  });
}

class StatusTimeline extends StatelessWidget {
  final List<CustomHorizontalStepper> steps;
  final double circleSize;
  final double lineWidth;
  final double textSlotWidthMultiplier;

  const StatusTimeline({
    required this.steps,
    super.key,
    this.circleSize = 19,
    this.lineWidth = 0.15,
    this.textSlotWidthMultiplier = 2,
  });

  @override
  Widget build(BuildContext context) {
    final lastActiveIndex = steps.lastIndexWhere((step) => step.isActive);
    final activeColor = lastActiveIndex >= 0
        ? steps[lastActiveIndex].color
        : Colors.grey;

    final double effectiveCircleAreaWidth = circleSize * 1.5;

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(10 * Responsive.getResponsive(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 10 * Responsive.getResponsive(context),
              ),
              child: _buildStepCirclesRow(
                context,
                lastActiveIndex,
                activeColor,
                effectiveCircleAreaWidth,
              ),
            ),
            SizedBox(height: 0.01 * Responsive.getHeight(context)),
            _buildLabelsRow(
              context,
              lastActiveIndex,
              activeColor,
              effectiveCircleAreaWidth,
            ),
          ],
        ),
      ),
    );
  }

  // Row containing all step circles and connecting lines
  Widget _buildStepCirclesRow(
    BuildContext context,
    int lastActiveIndex,
    Color activeColor,
    double width,
  ) => Row(
    children: List.generate(steps.length * 2 - 1, (index) {
      if (index.isOdd) {
        // Line between two steps
        return Container(
          width: lineWidth * Responsive.getWidth(context),
          height: circleSize,
          alignment: Alignment.center,
          child: Container(
            height: 0.003 * Responsive.getHeight(context),
            color: isLineActive(index, lastActiveIndex)
                ? activeColor
                : AppTheme.getColor(context).outline,
          ),
        );
      } else {
        // Step circle
        final stepIndex = index ~/ 2;
        final isStepActive = steps[stepIndex].isActive;
        final displayColor = isStepActive
            ? activeColor
            : AppTheme.getColor(context).outline;

        return SizedBox(
          width: width * Responsive.getResponsive(context),
          child: Column(
            children: [
              Container(
                width: width,
                height: width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    const BoxShadow(color: Colors.black38),
                    BoxShadow(
                      color: AppTheme.getColor(context).surface,
                      blurRadius: 5,
                      offset: const Offset(3, 3),
                    ),
                  ],
                ),
                child: Container(
                  width: circleSize,
                  height: circleSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: displayColor,
                    border: Border.all(color: displayColor, width: 2),
                  ),
                  child: Center(
                    child: steps[stepIndex].imagePath != null
                        ? Image.asset(
                            steps[stepIndex].imagePath!,
                            width: circleSize * 0.5,
                            height: circleSize * 0.4,
                            fit: BoxFit.contain,
                          )
                        : const SizedBox(),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }),
  );

  double dynamicSpacingWidth(
    String label,
    double lineWidth,
    BuildContext context,
  ) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          fontSize: 10 * Responsive.getResponsiveText(context),
          // fontWeight: FontWeight.w500,
        ),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();

    final double textWidth = textPainter.size.width;
    double adjustedWidth = lineWidth - (textWidth / 3);

    double minWidth = 0.6 * Responsive.getWidth(context);
    double maxWidth = 0.12 * Responsive.getWidth(context);

    if (adjustedWidth < minWidth) adjustedWidth = minWidth;
    if (adjustedWidth > maxWidth) adjustedWidth = maxWidth;

    return adjustedWidth;
  }

  Widget _buildLabelsRow(
    BuildContext context,
    int lastActiveIndex,
    Color activeColor,
    double width,
  ) => Row(
    children: List.generate(steps.length * 2 - 1, (index) {
      if (index.isOdd) {
        final prevStepIndex = (index - 1) ~/ 2;
        return SizedBox(
          width: dynamicSpacingWidth(
            steps[prevStepIndex].label,
            lineWidth - 1,
            context,
          ),
        );
      } else {
        final stepIndex = index ~/ 2;
        final isLabelActive = stepIndex <= lastActiveIndex;
        final labelColor = isLabelActive
            ? activeColor
            : const Color(0xff929292);

        return CustomText(
          steps[stepIndex].label,
          textAlign: TextAlign.center,
          fontSize: 10 * Responsive.getResponsiveText(context),
          color: labelColor,
          fontWeight: FontWeight.w600,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        );
      }
    }),
  );

  // Determines if a connecting line should be active
  bool isLineActive(int index, int lastActiveIndex) {
    final stepIndex = (index - 1) ~/ 2;
    return stepIndex < lastActiveIndex;
  }
}
