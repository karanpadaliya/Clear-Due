import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_cached_network_image.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_searchfield.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  final String loadingFor;
  const ShimmerLoading({super.key, this.loadingFor = ''});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      if (loadingFor == 'v1')
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Column(
            children: [
              CustomSearchField(),
              SizedBox(height: 0.02 * Responsive.getHeight(context)),
              SizedBox(
                height: 0.4 * Responsive.getHeight(context),
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.only(
                      top: 10 * Responsive.getResponsive(context),
                    ),
                    height: 0.06 * Responsive.getHeight(context),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppTheme.getColor(context).outline,
                      ),
                      borderRadius: BorderRadius.circular(
                        12 * Responsive.getResponsive(context),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(
                        left: 12 * Responsive.getResponsive(context),
                        right: 12 * Responsive.getResponsive(context),
                      ),
                      title: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          getCategoryChip(
                            context,
                            categories: 'categories',
                            isSelected: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      if (loadingFor == 'v3')
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Column(
            children: [
              const CustomSearchField(),
              SizedBox(height: 0.02 * Responsive.getHeight(context)),
              Row(
                children: [
                  getCategoryChip(
                    context,
                    categories: 'categories',
                    isSelected: false,
                  ),
                  SizedBox(width: 0.02 * Responsive.getWidth(context)),
                  getCategoryChip(
                    context,
                    categories: 'categories',
                    isSelected: false,
                  ),
                  SizedBox(width: 0.02 * Responsive.getWidth(context)),
                  getCategoryChip(
                    context,
                    categories: 'categories',
                    isSelected: false,
                  ),
                ],
              ),
              SizedBox(height: 0.02 * Responsive.getHeight(context)),
              SizedBox(
                height: 0.4 * Responsive.getHeight(context),
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.only(
                      top: 10 * Responsive.getResponsive(context),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppTheme.getColor(context).outline,
                      ),
                      borderRadius: BorderRadius.circular(
                        12 * Responsive.getResponsive(context),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(
                        left: 12.0 * Responsive.getResponsive(context),
                        right: 12.0 * Responsive.getResponsive(context),
                      ),
                      leading: CustomCachedNetworkImage(
                        imageUrl: '',
                        width: 0.12 * Responsive.getWidth(context),
                        height: 0.05 * Responsive.getHeight(context),
                      ),

                      title: Container(
                        height: 0.02 * Responsive.getHeight(context),
                        color: Colors.grey.shade300,
                      ),
                      subtitle: Container(
                        height: 0.009 * Responsive.getHeight(context),
                        color: Colors.grey.shade300,
                      ),

                      trailing: Column(
                        children: [
                          MyCoButton(
                            onTap: () {},
                            title: 'title',
                            boarderRadius:
                                30 * Responsive.getResponsive(context),
                            width: 0.17 * Responsive.getWidth(context),
                            height: 0.028 * Responsive.getHeight(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    ],
  );

  Container getCategoryChip(
    BuildContext context, {
    required String categories,
    required bool isSelected,
  }) => Container(
    padding: EdgeInsets.symmetric(
      horizontal: 8 * Responsive.getResponsive(context),
      vertical: 2 * Responsive.getResponsive(context),
    ),
    decoration: BoxDecoration(
      color: isSelected
          ? AppTheme.getColor(context).primary
          : AppTheme.getColor(context).surface,
      border: Border.all(color: AppTheme.getColor(context).outline),
      borderRadius: BorderRadius.circular(
        12 * Responsive.getResponsive(context),
      ),
    ),
    child: CustomText(
      categories,
      color: isSelected
          ? AppTheme.getColor(context).onPrimary
          : AppTheme.getColor(context).primary,
      fontWeight: FontWeight.w600,
      fontSize: 14 * Responsive.getResponsiveText(context),
    ),
  );
}
