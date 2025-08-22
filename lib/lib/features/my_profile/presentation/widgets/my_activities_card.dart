import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class MyActivitiesCard extends StatelessWidget {
  final String iconUrl;
  final String title;
  final String subtitle;

  const MyActivitiesCard({
    required this.iconUrl,
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) => DefaultTextStyle.merge(
    style: TextStyle(height: 1.2 * Responsive.getResponsive(context)),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 5 * Responsive.getResponsive(context),
            bottom: 5 * Responsive.getResponsive(context),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                iconUrl,
                fit: BoxFit.contain,
                width: 0.09 * Responsive.getWidth(context),
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                    width: 0.09 * Responsive.getWidth(context),
                    height: 0.09 * Responsive.getWidth(context),
                    child: const CircularProgressIndicator(strokeWidth: 1),
                  );
                },
              ),
              SizedBox(width: 0.02 * Responsive.getWidth(context)),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      title,
                      overflow: TextOverflow.visible,
                      fontSize: 14 * Responsive.getResponsiveText(context),
                      color: AppTheme.getColor(context).onSurface,
                    ),
                    SizedBox(height: 5 * Responsive.getResponsive(context)),
                    CustomText(
                      subtitle,
                      overflow: TextOverflow.visible,
                      fontSize: 12 * Responsive.getResponsiveText(context),
                      color: AppTheme.getColor(context).onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Divider(
          thickness: 1 * Responsive.getResponsive(context),
          color: AppTheme.getColor(context).outline,
        ),
      ],
    ),
  );
}
