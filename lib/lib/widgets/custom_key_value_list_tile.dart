import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class KeyValueListTileItem {
  final String key;
  final String value;

  KeyValueListTileItem({required this.key, required this.value});
}

class CustomKeyValueListTile extends StatelessWidget {
  final List<KeyValueListTileItem> items;

  CustomKeyValueListTile.map({
    required Map<String, String> data,
    super.key,
    this.keyFontSize,
    this.keyFontWeight,
    this.keyFontColor,
    this.separatorFontSize,
    this.separatorFontWeight,
    this.separatorFontColor,
    this.valueFontSize,
    this.valueFontWeight,
    this.valueFontColor,
  }) : items = data.entries
           .map((e) => KeyValueListTileItem(key: e.key, value: e.value))
           .toList();

  /// Key
  final double? keyFontSize;
  final FontWeight? keyFontWeight;
  final Color? keyFontColor;

  /// Separator
  final double? separatorFontSize;
  final FontWeight? separatorFontWeight;
  final Color? separatorFontColor;

  /// Value
  final double? valueFontSize;
  final FontWeight? valueFontWeight;
  final Color? valueFontColor;

  double _calculateMaxTitleWidth(BuildContext context) {
    double maxWidth = 0;
    final defaultTitleStyle = TextStyle(
      fontSize:
          keyFontSize ?? 14.0 * Responsive.getDashboardResponsiveText(context),
      fontWeight: keyFontWeight ?? FontWeight.w600,
      color: keyFontColor ?? AppTheme.getColor(context).primary,
    );

    for (final item in items) {
      final textPainter = TextPainter(
        text: TextSpan(text: item.key, style: defaultTitleStyle),
        textDirection: TextDirection.ltr,
        maxLines: 1,
      )..layout();

      if (textPainter.width > maxWidth) {
        maxWidth = textPainter.width;
      }
    }
    return maxWidth + 15;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final halfScreenWidth = screenWidth / 2 - 32 - 16;
    final maxTitleWidth = min(
      _calculateMaxTitleWidth(context),
      halfScreenWidth,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: maxTitleWidth,
                    child: CustomText(
                      item.key,
                      fontSize:
                          keyFontSize ??
                          14.0 * Responsive.getDashboardResponsiveText(context),
                      fontWeight: keyFontWeight ?? FontWeight.w600,
                      color: keyFontColor ?? AppTheme.getColor(context).primary,
                    ),
                  ),
                  CustomText(
                    ' : ',
                    fontSize:
                        separatorFontSize ??
                        14.0 * Responsive.getDashboardResponsiveText(context),
                    fontWeight: separatorFontWeight ?? FontWeight.w600,
                    color:
                        separatorFontColor ??
                        AppTheme.getColor(context).primary,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: CustomText(
                        item.value,
                        fontSize:
                            valueFontSize ??
                            14.0 *
                                Responsive.getDashboardResponsiveText(context),
                        fontWeight: valueFontWeight ?? FontWeight.w600,
                        color:
                            valueFontColor ??
                            AppTheme.getColor(context).primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
