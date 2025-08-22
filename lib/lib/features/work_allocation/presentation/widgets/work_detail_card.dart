import 'package:flutter/material.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/work_allocation/domain/entities/get_assignee_entity.dart';
import 'package:myco_flutter/features/work_allocation/presentation/widgets/common_row.dart';
import 'package:myco_flutter/widgets/border_container_wraper.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class WorkDetailCard extends StatelessWidget {
  final GetAssigneeResponseEntity workDetail;

  const WorkDetailCard({required this.workDetail, super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> commonRowData = [
      {
        'title': 'Work Category',
        'value': workDetail.workCategoryName ?? 'no_data_found_web',
      },
      {
        'title': 'Project',
        'value': workDetail.projectName ?? 'no_data_found_web',
      },
      {
        'title': 'Location',
        'value': workDetail.location ?? 'no_data_found_web',
      },
      {'title': 'Site', 'value': workDetail.site ?? 'no_data_found_web'},
      {
        'title': 'HOD Remark',
        'value': workDetail.hodRemark ?? 'no_data_found_web',
      },
      {
        'title': 'Created Date & Time',
        'value': workDetail.createdDate ?? 'no_data_found_web',
      },
    ];

    return BorderContainerWraper(
      borderRadius:
          VariableBag.containerBorderRadius * Responsive.getResponsive(context),
      borderColor: AppTheme.getColor(context).outline,
      padding: EdgeInsets.only(
        top: 16 * Responsive.getResponsive(context),
        bottom: 21 * Responsive.getResponsive(context),
        left: 12 * Responsive.getResponsive(context),
        right: 12 * Responsive.getResponsive(context),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Work Start Date
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    'Work Start Date',
                    fontWeight: FontWeight.w700,
                    color: AppTheme.getColor(context).onSurface,
                    fontSize: 14 * Responsive.getResponsiveText(context),
                  ),
                  CustomText(
                    workDetail.startDateView ?? 'no_data_found_web',
                    color: AppTheme.getColor(context).outline,
                    fontWeight: FontWeight.w500,
                    fontSize: 14 * Responsive.getResponsiveText(context),
                  ),
                ],
              ),

              /// Work Completion Date
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomText(
                    'Work Completion Date',
                    fontWeight: FontWeight.w700,
                    color: AppTheme.getColor(context).onSurface,
                    fontSize: 14 * Responsive.getResponsiveText(context),
                  ),
                  CustomText(
                    workDetail.endDateView ?? 'no_data_found_web',
                    color: AppTheme.getColor(context).outline,
                    fontWeight: FontWeight.w500,
                    fontSize: 14 * Responsive.getResponsiveText(context),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            color: AppTheme.getColor(context).secondary,
            thickness: 1 * Responsive.getResponsive(context),
          ),

          /// Dynamically render CommonRows with API data
          ...commonRowData.map(
            (item) => CommonRow(
              title: item['title'] ?? 'no_data_found_web',
              value: item['value'] ?? 'no_data_found_web',
              textColor: AppTheme.getColor(context).outline,
            ),
          ),
        ],
      ),
    );
  }
}
