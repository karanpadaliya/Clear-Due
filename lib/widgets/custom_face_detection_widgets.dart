import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class CustomFaceDetectionWidgets extends StatelessWidget {
  final CameraController controller;
  final String scanningState;
  final Animation<double> topLineAlignment;
  final Animation<double> bottomLineAlignment;
  final VoidCallback? retry;

  const CustomFaceDetectionWidgets({
    required this.controller,
    required this.scanningState,
    required this.topLineAlignment,
    required this.bottomLineAlignment,
    this.retry,
    super.key,
  });

  Color getBorderColor(BuildContext context) {
    if (scanningState == 'success') return AppColors.spanishYellow;
    if (scanningState == 'failure') return AppTheme.getColor(context).error;
    return AppTheme.getColor(context).primary;
  }

  Widget buildOverLay(BuildContext context) {
    if (scanningState == 'failure') {
      return GestureDetector(
        onTap: retry,
        child: Align(
          child: Icon(
            Icons.refresh,
            color: AppColors.white,
            size: 35 * Responsive.getResponsive(context),
          ),
        ),
      );
    }
    return const SizedBox();
  }

  Widget labelMessage(BuildContext context) {
    if (scanningState == 'success') {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(8 * Responsive.getResponsive(context)),
        color: AppColors.spanishYellow,
        child: CustomText(
          'Face Scan',
          color: AppTheme.getColor(context).onPrimary,
          fontWeight: FontWeight.w700,
          textAlign: TextAlign.center,
        ),
      );
    } else if (scanningState == 'failure') {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(8 * Responsive.getResponsive(context)),
        color: AppTheme.getColor(context).error,
        child: CustomText(
          'failed_to_match_current_face',
          isKey: true,
          fontSize: 14 * Responsive.getResponsiveText(context),
          color: AppTheme.getColor(context).onPrimary,
          fontWeight: FontWeight.w700,
          textAlign: TextAlign.center,
        ),
      );
    }

    return const SizedBox();
  }

  Widget scanningLines(BuildContext context) {
    if (scanningState == 'scanning') {
      return AnimatedBuilder(
        animation: topLineAlignment,
        builder: (context, child) => Stack(
          children: [
            Positioned(
              top: topLineAlignment.value,
              left: 0,
              right: 0,
              child: Container(
                height: 0.003 * Responsive.getHeight(context),
                margin: EdgeInsets.symmetric(
                  horizontal: 40 * Responsive.getResponsive(context),
                ),
                color: AppTheme.getColor(context).primary,
              ),
            ),
            Positioned(
              top: bottomLineAlignment.value,
              left: 0,
              right: 0,
              child: Container(
                height: 0.003 * Responsive.getHeight(context),
                margin: EdgeInsets.symmetric(
                  horizontal: 40 * Responsive.getResponsive(context),
                ),
                color: AppTheme.getColor(context).primary,
              ),
            ),
          ],
        ),
      );
    }

    return Stack(
      children: [
        Positioned(
          top: 40 * Responsive.getResponsive(context),
          left: 0,
          right: 0,
          child: Container(
            height: 0.003 * Responsive.getHeight(context),
            margin: EdgeInsets.symmetric(
              horizontal: 40 * Responsive.getResponsive(context),
            ),
            color: AppTheme.getColor(context).primary,
          ),
        ),
        Positioned(
          top: 230 * Responsive.getResponsive(context),
          left: 0,
          right: 0,
          child: Container(
            height: 0.003 * Responsive.getHeight(context),
            margin: EdgeInsets.symmetric(
              horizontal: 40 * Responsive.getResponsive(context),
            ),
            color: AppTheme.getColor(context).primary,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => Container(
    height: 0.32 * Responsive.getHeight(context),
    width: double.infinity * Responsive.getResponsiveOnWidth(context),
    decoration: BoxDecoration(
      border: Border.all(
        color: getBorderColor(context),
        width: 13 * Responsive.getResponsiveOnWidth(context),
      ),
      borderRadius: BorderRadius.circular(
        27 * Responsive.getResponsive(context),
      ),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(
        19 * Responsive.getResponsive(context),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (controller.value.isInitialized)
            ClipRect(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: controller.value.previewSize!.height,
                  height: controller.value.previewSize!.width,
                  child: CameraPreview(controller),
                ),
              ),
            )
          else
            const Center(child: CircularProgressIndicator()),
          scanningLines(context),
          buildOverLay(context),
          Align(
            alignment: Alignment.bottomCenter,
            child: labelMessage(context),
          ),
        ],
      ),
    ),
  );
}
