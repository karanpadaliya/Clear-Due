import 'package:flutter/material.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/my_profile/presentation/widgets/bullet_text_row.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class BreakDetailsCard extends StatelessWidget {
  final bool showPenaltyRules;
  final String starTime;
  final String endTime;
  final String totalHours;
  final String daysName;
  final List<Map<String, String>> bulletItems;
  const BreakDetailsCard({
    required this.showPenaltyRules,
    required this.bulletItems,
    required this.starTime,
    required this.endTime,
    required this.totalHours,
    required this.daysName,
    super.key,
  });

  Widget paddedText(
    BuildContext context,
    String text, {
    FontWeight? fontWeight,
  }) => Padding(
    padding: EdgeInsets.all(8.0 * Responsive.getResponsive(context)),
    child: CustomText(
      text,
      fontSize: 10 * Responsive.getResponsiveText(context),
      textAlign: TextAlign.center,
      fontWeight: FontWeight.w500,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final String days = daysName.replaceAll(' &', ',');
    final List<String> dayShorts = days
        .split(',')
        .map((day) => day.trim().substring(0, 3))
        .toList();
    final String shortDays = dayShorts.join(', ');
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.getColor(context).primary),
        borderRadius: BorderRadius.circular(
          VariableBag.containerBorderRadius * Responsive.getResponsive(context),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10 * Responsive.getResponsive(context),
              horizontal: 12 * Responsive.getResponsive(context),
            ),
            child: CustomText(
              shortDays,
              overflow: TextOverflow.visible,
              fontSize: 14 * Responsive.getResponsiveText(context),
              fontWeight: FontWeight.w600,
            ),
          ),
          Divider(color: AppTheme.getColor(context).outline),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10 * Responsive.getResponsive(context),
              horizontal: 16 * Responsive.getResponsive(context),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 10 * Responsive.getResponsive(context),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        starTime,
                        fontSize: 14 * Responsive.getResponsiveText(context),
                        fontWeight: FontWeight.w500,
                      ),
                      bulletLine(context),
                      CustomText(
                        totalHours,
                        fontSize: 14 * Responsive.getResponsiveText(context),
                        color: AppTheme.getColor(context).primary,
                        fontWeight: FontWeight.w500,
                      ),
                      bulletLine(context),
                      CustomText(
                        endTime,
                        fontSize: 14 * Responsive.getResponsiveText(context),
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                if (bulletItems.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: bulletItems
                        .map(
                          (item) => BulletTextRow(
                            trailingText: item['text'] ?? '',
                            leadingText: item['text2'] ?? '',
                          ),
                        )
                        .toList(),
                  )
                else
                  const SizedBox.shrink(),
                if (showPenaltyRules) penaltyTable(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding penaltyTable(BuildContext context) => Padding(
    padding: EdgeInsets.all(12 * Responsive.getResponsive(context)),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.getColor(context).outline),
        borderRadius: BorderRadius.circular(
          VariableBag.containerBorderRadius * Responsive.getResponsive(context),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CustomText('penalty_rules', fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(3),
                2: FlexColumnWidth(6),
                3: FlexColumnWidth(2),
                4: FlexColumnWidth(2),
              },
              border: TableBorder.symmetric(
                inside: BorderSide(color: AppTheme.getColor(context).outline),
              ),
              children: [
                TableRow(
                  children: List.generate(
                    5,
                    (_) => Container(
                      height: 1 * Responsive.getResponsive(context),
                      color: AppTheme.getColor(context).outline,
                    ),
                  ),
                ),
                TableRow(
                  children: [
                    paddedText(
                      context,
                      'penalty_notification_sound',
                      fontWeight: FontWeight.w500,
                    ),
                    paddedText(context, 'punch_in_between'),
                    paddedText(context, 'no_of_leave_attendance'),
                    paddedText(context, 'type_keyword'),
                    paddedText(context, 'value'),
                  ],
                ),
                TableRow(
                  children: [
                    paddedText(context, 'late_in_minutes'),
                    paddedText(context, 'na'),
                    paddedText(context, 'na'),
                    paddedText(context, 'flat'),
                    paddedText(context, '10'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Expanded bulletLine(BuildContext context) => Expanded(
    child: CustomText(
      '---------- ',
      maxLines: 1,
      overflow: TextOverflow.clip,
      fontSize: 14 * Responsive.getResponsiveText(context),
      fontWeight: FontWeight.w500,
    ),
  );
}
