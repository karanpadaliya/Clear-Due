import 'package:flutter/material.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:shimmer/shimmer.dart';

/// A widget that displays a shimmering placeholder for the TimeSheetPage content.
class TimeSheetShimmer extends StatelessWidget {
  const TimeSheetShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.getResponsive(context);
    final shimmerBaseColor = Colors.grey.shade300;
    final shimmerHighlightColor = Colors.grey.shade100;

    return Scaffold(
      // We can use the same AppBar for a consistent look
      appBar: CustomAppbar(
        title: 'timesheet',
        isKey: true,
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Container(
              width: 80,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),

      body: Shimmer.fromColors(
        baseColor: shimmerBaseColor,
        highlightColor: shimmerHighlightColor,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCalendarShimmer(context, responsive),
              const SizedBox(height: 20),
              _buildProgressBarShimmer(context, responsive),
              const SizedBox(height: 20),
              _buildPieChartAndGridShimmer(context, responsive),
            ],
          ),
        ),
      ),
    );
  }

  // Shimmer for the Calendar component
  Widget _buildCalendarShimmer(BuildContext context, double r) => Padding(
      padding: EdgeInsets.symmetric(
        horizontal: VariableBag.screenHorizontalPadding * r,
        vertical: 16 * r,
      ),
      child: Column(
        children: [
          // Header: Arrows and Title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildShimmerContainer(height: 30 * r, width: 30 * r, radius: 15),
              _buildShimmerContainer(height: 20 * r, width: 120 * r),
              _buildShimmerContainer(height: 30 * r, width: 30 * r, radius: 15),
            ],
          ),
          const SizedBox(height: 16),
          // Days of the Week
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              7,
                  (_) => _buildShimmerContainer(height: 15 * r, width: 25 * r),
            ),
          ),
          const SizedBox(height: 12),
          // Calendar Days Grid
          GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 8 * r,
            crossAxisSpacing: 8 * r,
            children: List.generate(
              35, // 5 rows
                  (_) => _buildShimmerContainer(height: 35 * r, width: 35 * r, radius: 17.5),
            ),
          ),
        ],
      ),
    );

  // Shimmer for the Progress Bar Card
  Widget _buildProgressBarShimmer(BuildContext context, double r) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * r),
      child: Container(
        height: 120 * r,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12 * r),
        ),
      ),
    );

  // Shimmer for the Pie Chart and the Status Card Grid
  Widget _buildPieChartAndGridShimmer(BuildContext context, double r) => Column(
      children: [
        // Pie Chart
        Container(
          width: 180 * r,
          height: 180 * r,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 24),
        // Card Grid
        Padding(
          padding: EdgeInsets.symmetric(horizontal: VariableBag.screenHorizontalPadding * r),
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 2,
            mainAxisSpacing: 16 * r,
            crossAxisSpacing: 16 * r,
            children: List.generate(4, (_) => _buildShimmerContainer(height: 80 * r)),
          ),
        ),
      ],
    );

  // A helper to build generic shimmer containers easily
  Widget _buildShimmerContainer({
    required double height,
    double? width,
    double radius = 8.0,
  }) => Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
}