import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

/// this is for bottomSheet
class SelectedDateRow extends StatelessWidget {
  final DateTime date;
  final String dayPart;
  final ValueChanged<String> onDayPartChanged;
  final VoidCallback onDelete;

  const SelectedDateRow({
    required this.date,
    required this.dayPart,
    required this.onDayPartChanged,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(
      vertical: 1.0 * Responsive.getResponsive(context),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 117 * Responsive.getResponsive(context),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.getColor(context).secondary,
              borderRadius: BorderRadius.circular(23),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Center(
                child: CustomText(
                  DateFormat('dd MMM, yyyy').format(date),
                  color: AppTheme.getColor(context).onSecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 11 * Responsive.getResponsiveText(context),
                ),
              ),
            ),
          ),
        ),

        Expanded(
          child: Center(
            child: Radio<String>(
              value: 'fullDay',
              groupValue: dayPart,
              onChanged: (v) => onDayPartChanged(v!),
            ),
          ),
        ),

        Expanded(
          child: Center(
            child: Radio<String>(
              value: 'firstHalf',
              groupValue: dayPart,
              onChanged: (v) => onDayPartChanged(v!),
            ),
          ),
        ),

        Expanded(
          child: Center(
            child: Radio<String>(
              value: 'secondHalf',
              groupValue: dayPart,
              onChanged: (v) => onDayPartChanged(v!),
            ),
          ),
        ),

        IconButton(
          icon: const Icon(Icons.cancel_outlined, color: Colors.red),
          onPressed: onDelete,
        ),
      ],
    ),
  );
}
