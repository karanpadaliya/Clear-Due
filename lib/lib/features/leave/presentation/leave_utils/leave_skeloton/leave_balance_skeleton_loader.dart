import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LeaveBalanceListViewSkeleton extends StatelessWidget {
  const LeaveBalanceListViewSkeleton({super.key});

  @override
  Widget build(BuildContext context) => ListView.separated(
    padding: const EdgeInsets.all(16.0),
    itemCount: 5, // Display 4 skeleton cards while loading
    separatorBuilder: (context, index) => const SizedBox(height: 16),
    itemBuilder: (context, index) => Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: _buildSkeletonCard(context),
    ),
  );

  /// Builds a single placeholder card that mimics your LeaveExpandableCard.
  Widget _buildSkeletonCard(BuildContext context) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey[300]!),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. Placeholder for the Header
        Container(
          height: 60, // Approximate height of your header
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            color: Colors.white, // IMPORTANT: Must be a solid color
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(11), // Slightly less to fit inside border
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Placeholder for the title
              Container(height: 20, width: 200, color: Colors.white),
              // Placeholder for the expand/collapse icon
              Container(
                height: 24,
                width: 24,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),

        // 2. Placeholder for the Collapsed Chips section
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              2,
              (_) => Expanded(
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
