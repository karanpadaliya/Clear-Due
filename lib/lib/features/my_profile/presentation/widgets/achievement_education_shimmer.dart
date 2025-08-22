import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:shimmer/shimmer.dart';
// Make sure to import your own project files for Responsive, VariableBag etc.
// import 'package:myco_flutter/core/utils/responsive.dart';
// import 'package:myco_flutter/constants/constants.dart';


/// A shimmer loading placeholder for the Education and Achievements page,
/// designed to match the layout of the CustomVerticalStepper.
class AchievementEducationShimmer extends StatelessWidget {
  const AchievementEducationShimmer({super.key});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          // Use padding consistent with your loaded screen
          padding: EdgeInsets.symmetric(horizontal: 16.0 * Responsive.getResponsive(context)),
          // Or using your variables:
          // padding: EdgeInsets.symmetric(horizontal: VariableBag.screenHorizontalPadding * Responsive.getResponsive(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16* Responsive.getResponsive(context)),
              // Shimmer for "Achievements" title
              _placeholder(width: 0.015 * Responsive.getWidth(context), height: 0.022 * Responsive.getHeight(context),context: context),
              SizedBox(height: 0.008* Responsive.getHeight(context) ),
              _buildItemPlaceholder(context),
              _buildItemPlaceholder(context),
              SizedBox(height: 0.024 * Responsive.getHeight(context)),
              // Shimmer for "Education" title
              _placeholder(width: 120, height: 22,context: context),
              SizedBox(height: 0.008 * Responsive.getHeight(context)),
              _buildItemPlaceholder(context),
            ],
          ),
        ),
      ),
    );

  /// A generic placeholder container.
  Widget _placeholder({double? width, double? height,required BuildContext context}) => Container(
      width: width,
      height: height= 0.016* Responsive.getHeight(context),
      decoration: BoxDecoration(
        color: AppTheme.getColor(context).surface,
        borderRadius: BorderRadius.circular(8 * Responsive.getResponsive(context)),
      ),
    );

  /// Builds a placeholder for a single item in the vertical stepper.
  Widget _buildItemPlaceholder(BuildContext context) => IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side: Stepper line and circle
          Column(
            children: [
              _placeholder(width: 0.024 * Responsive.getWidth(context), height: 0.024 * Responsive.getHeight(context),context: context), // Circle
              Expanded(
                child: _placeholder(width: 2, height: double.infinity,context: context), // Line
              ),
            ],
          ),
          SizedBox(width: 0.012* Responsive.getWidth(context)),
          // Right side: Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 6* Responsive.getResponsive(context), bottom: 16* Responsive.getResponsive(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _placeholder(width: double.infinity, height: 0.0018* Responsive.getHeight(context),context: context), // Main title
                  SizedBox(height: 0.001 * Responsive.getHeight(context)),
                  // Box for details
                  Container(
                    padding: EdgeInsets.all(10* Responsive.getResponsive(context)),
                    decoration: BoxDecoration(
                      color: AppTheme.getColor(context).surface,
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(10* Responsive.getResponsive(context)),
                    ),
                    child: Column(
                      children: [
                        _buildDetailRowPlaceholder(context),
                        SizedBox(height: 0.008* Responsive.getHeight(context)),
                        _buildDetailRowPlaceholder(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

  /// Builds a placeholder for a single row inside the details box (e.g., "Institute: ...").
  Widget _buildDetailRowPlaceholder(BuildContext context) => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _placeholder(width: 0.006* Responsive.getWidth(context), height: 0.0014* Responsive.getHeight(context),context: context), // Title (e.g., "Institute")
        SizedBox(width: 0.008* Responsive.getWidth(context)),
        _placeholder(width: 0.001* Responsive.getWidth(context), height: 0.0014* Responsive.getHeight(context),context: context), // Colon
        SizedBox(width: 0.008* Responsive.getWidth(context)),
        Expanded(child: _placeholder(height: 0.0014* Responsive.getHeight(context),context: context)), // Description
      ],
    );
}