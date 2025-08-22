import 'package:flutter/material.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/common_card.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerVisitCard extends StatelessWidget {
  const ShimmerVisitCard({super.key});

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.only(bottom: Responsive.getHeight(context) * 0.02),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.8),
        ),
        child: CommonCard(
          title: '',
          borderRadius: 12.8,
          headerColor: AppTheme.getColor(context).primary,
          borderColor: AppTheme.getColor(context).outline,
          showBlackShadowInChild: true,
          bottomWidget: _Body(context),
        ),
      ),
    );


  Widget _Body(BuildContext context) {
    final height = Responsive.getHeight(context);
    final width = Responsive.getWidth(context);
    final textScale = Responsive.getResponsiveText(context);
    final vGap = height * 0.015;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: vGap),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: _box(context,
                    height: 28 * textScale, radius: 30),
              ),
              SizedBox(width: width * 0.03),
              Flexible(
                child: _box(context,
                    height: 36 * textScale, radius: 8),
              ),
            ],
          ),
          SizedBox(height: vGap * 1.5),
          _row(context, titleFlex: 3, valueFlex: 4),
          SizedBox(height: vGap),
          _row(context, titleFlex: 3, valueFlex: 5),
          SizedBox(height: vGap),
          _row(context, titleFlex: 3, valueFlex: 7),
          SizedBox(height: vGap / 2),
          _box(context, width: double.infinity, height: 14 * textScale),
          SizedBox(height: vGap / 2),
          _box(context, width: width * 0.6, height: 14 * textScale),

          SizedBox(height: vGap * 2),
          Row(
            children: [
              Expanded(
                child: _box(context, height: 14 * textScale),
              ),
              SizedBox(width: width * 0.03),
              ...List.generate(3, (_) => Padding(
                  padding: EdgeInsets.only(right: width * 0.03),
                  child: _box(context,
                      height: 24 * textScale, width: 24 * textScale),
                )),
            ],
          ),

          SizedBox(height: vGap * 2),
          Row(
            children: [
              Expanded(
                child: _box(context,
                    height: 40 * textScale,
                    radius: VariableBag.buttonBorderRadius),
              ),
              SizedBox(width: width * 0.04),
              Expanded(
                child: _box(context,
                    height: 40 * textScale,
                    radius: VariableBag.buttonBorderRadius),
              ),
            ],
          ),

          SizedBox(height: vGap),
          _box(context,
              width: double.infinity,
              height: 45 * textScale,
              radius: VariableBag.buttonBorderRadius),
        ],
      ),
    );
  }

  Widget _row(BuildContext context,
      {required int titleFlex, required int valueFlex}) {
    final textScale = Responsive.getResponsiveText(context);
    return Row(
      children: [
        Flexible(
          flex: titleFlex,
          child: _box(context, height: 14 * textScale),
        ),
        SizedBox(width: Responsive.getWidth(context) * 0.02),
        Flexible(
          flex: valueFlex,
          child: _box(context, height: 14 * textScale),
        ),
      ],
    );
  }

  Widget _box(
      BuildContext context, {
        required double height, double? width,
        double radius = 6,
      }) => Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
}
