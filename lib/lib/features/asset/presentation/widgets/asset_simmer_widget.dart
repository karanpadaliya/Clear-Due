import 'package:flutter/material.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:shimmer/shimmer.dart';

class AssetsShimmerWidget extends StatelessWidget {
  const AssetsShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(
          10 * Responsive.getResponsive(context),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16 * Responsive.getResponsive(context)),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide()),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 0.4 * Responsive.getWidth(context),
                  height: 0.02 * Responsive.getHeight(context),
                  color: Colors.white,
                ),
                SizedBox(height: 0.010 * Responsive.getHeight(context)),
                Container(
                  width: 0.3 * Responsive.getWidth(context),
                  height: 0.015 * Responsive.getHeight(context),
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16 * Responsive.getResponsive(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: 0.3 * Responsive.getWidth(context),
                        height: 0.15 * Responsive.getHeight(context),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            12 * Responsive.getResponsive(context),
                          ),
                        ),
                      ),
                      SizedBox(width: 0.012 * Responsive.getHeight(context)),
                      const VerticalDivider(color: Colors.white, thickness: 1),
                      SizedBox(width: 0.012 * Responsive.getHeight(context)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _shimmerText(context),
                            _verticalGap(context),
                            _shimmerText(context),
                            _verticalGap(context),
                            _shimmerText(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 0.02 * Responsive.getHeight(context)),
                Row(
                  children: [
                    Container(
                      width: 0.36 * Responsive.getWidth(context),
                      height: 0.020 * Responsive.getHeight(context),
                      color: Colors.white,
                    ),
                    SizedBox(width: 0.012 * Responsive.getHeight(context)),
                    Expanded(
                      child: Wrap(
                        spacing: 10 * Responsive.getResponsive(context),
                        children: List.generate(
                          3,
                          (_) => Container(
                            width: 0.12 * Responsive.getWidth(context),
                            height: 0.12 * Responsive.getWidth(context),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                10 * Responsive.getResponsive(context),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _shimmerText(BuildContext context) => Container(
    width: 0.5 * Responsive.getWidth(context),
    height: 18 * Responsive.getResponsiveText(context),
    color: Colors.white,
  );

  Widget _verticalGap(BuildContext context) =>
      SizedBox(height: 0.02 * Responsive.getHeight(context));
}

class AssetDetailsShimmerWidget extends StatelessWidget {
  const AssetDetailsShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade400),
      borderRadius: BorderRadius.circular(
        12 * Responsive.getResponsive(context),
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Shimmer.fromColors(
          baseColor: AppTheme.getColor(context).secondary.withAlpha(180),
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: double.infinity,
            height: 0.06 * Responsive.getHeight(context),
            decoration: BoxDecoration(
              color: AppTheme.getColor(context).secondary,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(12 * Responsive.getResponsive(context)),
              ),
            ),
          ),
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Padding(
            padding: EdgeInsets.all(16 * Responsive.getResponsive(context)),
            child: Column(
              children: [
                Container(
                  width: 0.35 * Responsive.getWidth(context),
                  height: 0.35 * Responsive.getWidth(context),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      12 * Responsive.getResponsive(context),
                    ),
                  ),
                ),
                SizedBox(height: 16 * Responsive.getResponsive(context)),
                Row(
                  children: [
                    Container(
                      width: 0.32 * Responsive.getWidth(context),
                      height: 18,
                      color: Colors.white,
                    ),
                    const Spacer(),
                    Container(
                      width: 0.32 * Responsive.getWidth(context),
                      height: 18,
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: Colors.white, thickness: 1),
                const SizedBox(height: 16),
                ...List.generate(
                  5,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 0.32 * Responsive.getWidth(context),
                          height: 18,
                          color: Colors.white,
                        ),
                        const Spacer(),
                        Container(
                          width: 0.4 * Responsive.getWidth(context),
                          height: 18,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(color: Colors.white, thickness: 1),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      width: 0.36 * Responsive.getWidth(context),
                      height: 20,
                      color: Colors.white,
                    ),
                    const Spacer(),
                    Container(
                      width: 0.2 * Responsive.getWidth(context),
                      height: 20,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class AssetHistoryShimmerWidget extends StatelessWidget {
  const AssetHistoryShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(
          12 * Responsive.getResponsive(context),
        ),
      ),
      padding: EdgeInsets.all(
        VariableBag.commonContainerPadding * Responsive.getResponsive(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile info shimmer
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _shimmerLine(context, widthFactor: 0.5),
                    const SizedBox(height: 8),
                    _shimmerLine(context, widthFactor: 0.3),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white, thickness: 1),
          const SizedBox(height: 16),

          // handover/takeover shimmer row
          Row(
            children: [
              Expanded(child: _shimmerBlock(context)),
              const SizedBox(width: 12),
              Expanded(child: _shimmerBlock(context)),
            ],
          ),
          const SizedBox(height: 16),
          _shimmerLine(context, widthFactor: 0.4),
        ],
      ),
    ),
  );

  Widget _shimmerLine(BuildContext context, {double widthFactor = 0.5}) =>
      Container(
        width: widthFactor * Responsive.getWidth(context),
        height: 16,
        color: Colors.white,
      );

  Widget _shimmerBlock(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _shimmerLine(context, widthFactor: 0.5),
      const SizedBox(height: 12),
      Wrap(
        spacing: 8,
        children: List.generate(
          3,
          (_) => Container(
            width: 0.12 * Responsive.getWidth(context),
            height: 0.12 * Responsive.getWidth(context),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                10 * Responsive.getResponsive(context),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
