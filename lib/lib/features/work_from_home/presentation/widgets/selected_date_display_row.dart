import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';

/// this is for ADD NEW TABBAR
class SelectedDateDisplayRow extends StatelessWidget {
  final DateTime date;
  final String dayPart;
  final VoidCallback onDelete;

  const SelectedDateDisplayRow({
    required this.date,
    required this.dayPart,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      children: [
        SvgPicture.asset(
          AppAssets.calendar,
          colorFilter: ColorFilter.mode(
            AppTheme.getColor(context).primary,
            BlendMode.srcIn,
          ),
          width: 24,
        ),
        const SizedBox(width: 12),
        Text(
          DateFormat('E, dd MMM').format(date),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const Spacer(),
        Text(
          dayPart.toTitleCase(),
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.getColor(context).primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8),
        InkWell(
          onTap: onDelete,
          borderRadius: BorderRadius.circular(30),
          child: Icon(
            Icons.cancel_outlined,
            color: AppTheme.getColor(context).error,
            size: 24,
          ),
        ),
      ],
    ),
  );
}

extension StringCasingExtension on String {
  String toTitleCase() {
    if (isEmpty) return this;
    if (this == 'fullDay') return 'Full Day';
    if (this == 'firstHalf') return '1st Half';
    if (this == 'secondHalf') return '2nd Half';
    return this;
  }
}
