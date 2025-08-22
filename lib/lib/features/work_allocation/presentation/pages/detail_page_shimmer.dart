import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/utils/responsive.dart';

class DetailPageShimmer extends StatelessWidget {
  const DetailPageShimmer({super.key});

  Widget _buildCircle(double size) => Container(
    height: size,
    width: size,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white,
    ),
  );

  Widget _buildLine(double height) => Container(
    width: 2,
    height: height,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    final r = Responsive.getResponsive(context);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: VariableBag.screenHorizontalPadding * r,
          vertical: VariableBag.formContentSpacingVertical * r,
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Assign To Card
              Container(
                height: 110 * r,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              SizedBox(height: 16 * r),

              // Work Detail Card
              Container(
                height: 220 * r,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              SizedBox(height: 24 * r),

              // Stepper
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stepper Column
                  Column(
                    children: [
                      _buildCircle(24 * r),
                      _buildLine(50 * r),
                      _buildCircle(24 * r),
                      _buildLine(50 * r),
                      _buildCircle(24 * r),
                      _buildLine(50 * r),
                      _buildCircle(24 * r),
                    ],
                  ),
                  SizedBox(width: 12 * r,height: 20 * r,),

                  // Stepper Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20 * r,
                          width: 100 * r,
                          color: Colors.white,
                        ),
                        SizedBox(height: 60 * r),

                        Container(
                          height: 20 * r,
                          width: 100 * r,
                          color: Colors.white,
                        ),
                        SizedBox(height: 50 * r),

                        Container(
                          height: 20 * r,
                          width: 100 * r,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10 * r),
                        Container(
                          height: 30 * r,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        SizedBox(height: 20 * r),

                        Container(
                          height: 20 * r,
                          width: 100 * r,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10 * r),
                        Container(
                          height: 80 * r,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
