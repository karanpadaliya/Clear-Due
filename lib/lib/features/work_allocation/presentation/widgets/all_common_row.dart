import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/work_allocation/presentation/widgets/common_row.dart';

class AllCommonRow extends StatefulWidget {
  const AllCommonRow({super.key});

  @override
  State<AllCommonRow> createState() => _AllCommonRowState();
}

class _AllCommonRowState extends State<AllCommonRow> {
  @override
  Widget build(BuildContext context) => Column(
    children: [
      CommonRow(
        title: LanguageManager().get('work_category'),
        value: 'AI Tools',
        textColor: AppColors.textGray,
      ),
      SizedBox(height: 0.005 * Responsive.getHeight(context)),
      CommonRow(
        title: LanguageManager().get('project'),
        value: 'Fjc',
        textColor: AppColors.textGray,
      ),
      SizedBox(height: 0.005 * Responsive.getHeight(context)),
      CommonRow(
        title: LanguageManager().get('work_start_date'),
        value: '21st May 2025',
        textColor: AppColors.textGray,
      ),
      SizedBox(height: 0.005 * Responsive.getHeight(context)),
      CommonRow(
        title: LanguageManager().get('target_date_of_completion'),
        value: '22nd May 2025',
        textColor: AppColors.textGray,
      ),
      SizedBox(height: 0.005 * Responsive.getHeight(context)),
      Divider(color: AppTheme.getColor(context).secondary),
    ],
  );
}
