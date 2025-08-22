import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/visit_entity.dart';
import 'package:myco_flutter/features/my_visit/presentation/widgets/myvisit_bottom_widget.dart';
import 'package:myco_flutter/widgets/common_card.dart';

Widget buildVisitCard(
  BuildContext context,
  MyVisitEntity visit,
  int index,
  int totalLength,
) => Padding(
  padding: EdgeInsets.only(bottom: Responsive.getHeight(context) * 0.02),
  child: Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.8)),
    child: CommonCard(
      title: visit.retailerName != null && visit.retailerCode != null
          ? '${visit.retailerName} (${visit.retailerCode})'
          : visit.retailerName ?? visit.retailerCode ?? 'Unknown',

      borderRadius: 12.8,
      suffixIcon: index >= totalLength - 5
          ? SvgPicture.asset(AppAssets.ref)
          : null,
      subTitle:
          '${visit.retailerVisitStartDate}(${visit.retailerVisitStartTime})to ${visit.retailerVisitEndDate}',
      subTitleIcon: SvgPicture.asset(AppAssets.calendar),
      onTap: () {},
      headerColor: AppTheme.getColor(context).primary,
      borderColor: AppTheme.getColor(context).outline,
      showBlackShadowInChild: true,
      bottomWidget: MyVisitBottomWidget(context, visit, index),
    ),
  ),
);
