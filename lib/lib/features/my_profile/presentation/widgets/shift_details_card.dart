import 'package:flutter/material.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/my_profile/data/models/request/week_off_item.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class ShiftDetailsCardRow extends StatelessWidget {
  final String title;
  final String value;

  const ShiftDetailsCardRow({
    required this.title,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(VariableBag.commonCardBorderRadius),
    ),
    child: Table(
      columnWidths: const {
        0: FlexColumnWidth(5),
        1: FixedColumnWidth(14),
        2: FlexColumnWidth(3),
      },
      children: [
        TableRow(
          children: [
            CustomText(
              title,
              overflow: TextOverflow.visible,
              fontWeight: FontWeight.w500,
              fontSize: 14 * Responsive.getResponsiveText(context),
            ),
            CustomText(
              ':',
              fontWeight: FontWeight.w500,
              fontSize: 12 * Responsive.getResponsiveText(context),
            ),
            CustomText(
              value,
              fontWeight: FontWeight.w500,
              fontSize: 12 * Responsive.getResponsiveText(context),
              overflow: TextOverflow.visible,
            ),
          ],
        ),
      ],
    ),
  );
}

class ShiftDetailsCard extends StatelessWidget {
  final bool isSubTitle;
  final String subTitle;
  final List<WeekOffItem> weekOffData;
  const ShiftDetailsCard({
    required this.weekOffData,
    this.isSubTitle = false,
    this.subTitle = '',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final validItems = weekOffData
        .where(
          (item) =>
              item.value.trim().isNotEmpty &&
              item.value.toLowerCase() != 'null' &&
              item.title.trim().isNotEmpty &&
              item.title.toLowerCase() != 'null',
        )
        .toList();

    if (validItems.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: EdgeInsets.all(12 * Responsive.getResponsive(context)),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.getColor(context).primary,
          width: 1.5 * Responsive.getResponsive(context),
        ),
        borderRadius: BorderRadius.circular(
          VariableBag.containerBorderRadius * Responsive.getResponsive(context),
        ),
      ),
      child: Column(
        children: [
          ListView.builder(
            itemCount: validItems.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final item = validItems[index];
              // if (item.value.trim().isEmpty ||
              //     item.value.toLowerCase() == 'null' ||
              //     item.title.trim().isEmpty ||
              //     item.title.toLowerCase() == 'null') {
              //   return const SizedBox.shrink();
              // }
              return ShiftDetailsCardRow(title: item.title, value: item.value);
            },
          ),
          if (isSubTitle == true) const CustomText('late_in_early_out_warning'),
        ],
      ),
    );
  }
}
