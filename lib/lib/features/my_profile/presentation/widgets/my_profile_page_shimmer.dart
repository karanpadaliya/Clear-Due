import 'package:flutter/material.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:shimmer/shimmer.dart';

class MyProfilePageShimmer extends StatelessWidget {
  const MyProfilePageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // Define a consistent padding, similar to your main page
    final screenPadding = EdgeInsets.symmetric(
      horizontal: 16.0 * Responsive.getResponsive(context),
    );
    final verticalSpacing = SizedBox(
      height: 16.0 * Responsive.getResponsive(context),
    );

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: screenPadding,
          child: Column(
            children: [
              verticalSpacing,
              _ProfileDetailsCardShimmer(),
              verticalSpacing,
              _ProfilePersonalInfoCardShimmer(),
              verticalSpacing,
              _ProfileToolSupportSettingCardShimmer(),
              verticalSpacing,
              _MyTeamSectionShimmer(),
              verticalSpacing,
              _placeholder(
                height: 0.05 * Responsive.getHeight(context),
                width: double.infinity,
                radius: 30,
              ), // Button
              verticalSpacing,
              _placeholder(
                height: 0.016 * Responsive.getHeight(context),
                width: 0.02 * Responsive.getWidth(context),
              ), // Footer Text 1
              SizedBox(height: 0.08 * Responsive.getHeight(context)),
              _placeholder(
                height: 0.016 * Responsive.getHeight(context),
                width: 0.012 * Responsive.getWidth(context),
              ), // Footer Text 2
              SizedBox(height: 0.08 * Responsive.getHeight(context)),
              _placeholder(
                height: 0.016 * Responsive.getHeight(context),
                width: 0.05 * Responsive.getWidth(context),
              ), // Footer Text 3
              verticalSpacing,
            ],
          ),
        ),
      ),
    );
  }
}

/// Shimmer for the main user details card.
class _ProfileDetailsCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _ShimmerCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _placeholder(
              height: 0.08 * Responsive.getResponsive(context),
              width: 0.08 * Responsive.getWidth(context),
              radius: 40,
            ), // Profile Picture
            SizedBox(width: 0.016 * Responsive.getWidth(context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 0.08 * Responsive.getHeight(context)),
                  _placeholder(
                    height: 0.02 * Responsive.getHeight(context),
                    width: 0.02 * Responsive.getWidth(context),
                  ), // Name
                  SizedBox(height: 0.008 * Responsive.getHeight(context)),
                  _placeholder(
                    height: 0.016 * Responsive.getHeight(context),
                    width: 0.012 * Responsive.getWidth(context),
                  ), // Employee ID
                  SizedBox(height: 0.008 * Responsive.getHeight(context)),
                  _placeholder(
                    height: 0.016 * Responsive.getHeight(context),
                    width: double.infinity,
                  ), // Designation
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 0.024 * Responsive.getHeight(context)),
        _placeholder(
          height: 0.008 * Responsive.getHeight(context),
          width: double.infinity,
        ), // Progress Bar
        SizedBox(height: 0.008 * Responsive.getHeight(context)),
        _placeholder(
          height: 16,
          width: 0.015 * Responsive.getWidth(context),
        ), // Profile Completion Text
        SizedBox(height: 0.012 * Responsive.getHeight(context)),
        Divider(),
        _buildInfoRow(context),
        SizedBox(height: 0.012 * Responsive.getHeight(context)),
        _buildInfoRow(context),
        SizedBox(height: 0.016 * Responsive.getHeight(context)),
        Row(
          children: List.generate(
            5,
            (_) => Padding(
              padding: EdgeInsets.only(
                right: 12.0 * Responsive.getResponsive(context),
              ),
              child: _placeholder(
                height: 0.035 * Responsive.getHeight(context),
                width: 0.035 * Responsive.getWidth(context),
              ), // Social Icons
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildInfoRow(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(
      vertical: 4.0 * Responsive.getResponsive(context),
    ),
    child: Row(
      children: [
        _placeholder(
          height: 0.024 * Responsive.getHeight(context),
          width: 0.024 * Responsive.getWidth(context),
        ), // Icon
        SizedBox(width: 0.012 * Responsive.getHeight(context)),
        _placeholder(
          height: 0.016 * Responsive.getHeight(context),
          width: 0.022 * Responsive.getWidth(context),
        ), // Text
      ],
    ),
  );
}

/// Shimmer for the grid-based cards like Personal Info and Tools.
class _ProfileGridCardShimmer extends StatelessWidget {
  final double titleWidth;
  const _ProfileGridCardShimmer({required this.titleWidth});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(
        children: [
          _placeholder(
            height: 0.028 * Responsive.getHeight(context),
            width: titleWidth,
          ),
          const Spacer(),
          _placeholder(
            height: 0.04 * Responsive.getHeight(context),
            width: 0.1 * Responsive.getWidth(context),
          ), // GIF placeholder
        ],
      ),
      SizedBox(height: 0.016 * Responsive.getHeight(context)),
      GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3, // Show 3 shimmer items
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 8,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              12 * Responsive.getResponsive(context),
            ),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _placeholder(
                height: 0.06 * Responsive.getHeight(context),
                width: 0.15 * Responsive.getWidth(context),
              ), // Icon
              SizedBox(height: 0.008 * Responsive.getHeight(context)),
              _placeholder(
                height: 0.014 * Responsive.getHeight(context),
                width: 0.1 * Responsive.getWidth(context),
              ), // Text
            ],
          ),
        ),
      ),
    ],
  );
}

// Specific shimmer widgets using the generic grid.
class _ProfilePersonalInfoCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      _ProfileGridCardShimmer(titleWidth: 0.22 * Responsive.getWidth(context));
}

class _ProfileToolSupportSettingCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      _ProfileGridCardShimmer(titleWidth: 0.22 * Responsive.getWidth(context));
}

/// Shimmer for the My Team section with overlapping images.
class _MyTeamSectionShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(
        children: [
          _placeholder(
            height: 0.024 * Responsive.getHeight(context),
            width: 0.1 * Responsive.getWidth(context),
          ), // "My Team"
          const Spacer(),
          _placeholder(
            height: 0.04 * Responsive.getHeight(context),
            width: 0.04 * Responsive.getWidth(context),
          ), // Icon
        ],
      ),
      SizedBox(height: 0.016 * Responsive.getHeight(context)),
      _ShimmerCard(
        height: 0.08 * Responsive.getHeight(context),
        child: Stack(
          children: List.generate(
            4,
            (index) => Positioned(
              left: index * 40.0,
              child: _placeholder(
                height: 0.06* Responsive.getHeight(context),
                width: 0.06* Responsive.getWidth(context),
                radius: 30* Responsive.getResponsive(context),
                hasBorder: true,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

// --- HELPER WIDGETS ---

/// A generic placeholder container widget.
Widget _placeholder({
  double? height,
  double? width,
  double radius = 8,
  bool hasBorder = false,
}) => Container(
  height: height,
  width: width,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(radius),
    border: hasBorder ? Border.all(color: Colors.white, width: 2) : null,
  ),
);

/// A wrapper that mimics the appearance of your `CommonCard`.
class _ShimmerCard extends StatelessWidget {
  final Widget child;
  final double? height;

  const _ShimmerCard({required this.child, this.height});

  @override
  Widget build(BuildContext context) => Container(
    height: height,
    padding: EdgeInsets.all(16.0 * Responsive.getResponsive(context)),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(
        12 * Responsive.getResponsive(context),
      ),
      border: Border.all(color: Colors.grey.shade200),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.5),
          blurRadius: 10 * Responsive.getResponsive(context),
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: child,
  );
}
