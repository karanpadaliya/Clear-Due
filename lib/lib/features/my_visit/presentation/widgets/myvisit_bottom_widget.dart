import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/core/utils/util.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/visit_entity.dart';
import 'package:myco_flutter/features/my_visit/presentation/pages/reschedule_visit_page.dart';
import 'package:myco_flutter/features/my_visit/presentation/widgets/end_visit_bottom_sheet.dart';
import 'package:myco_flutter/features/my_visit/presentation/widgets/get_common_row.dart';
import 'package:myco_flutter/features/my_visit/presentation/widgets/start_visit_bottom_sheet.dart';
import 'package:myco_flutter/widgets/custom_common_row.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

Widget MyVisitBottomWidget(
  BuildContext context,
  MyVisitEntity visit,
  int index,
) {
  final bool showExtraButtons = visit.takeEndVisitDetails == true;
  // final bool showStartedVisit = visit.isVisitRescheduled == true;
  final bool isSixthContainer = visit.isMyVisitStarted == true;
  // final bool hideOrderButtons = visit.showEndButton == true;

  final String buttonText = LanguageManager().get('start_visit');
  // if (req) {
  //   buttonText = LanguageManager().get('request_to_end_visit');
  // } else if (showExtraButtons) {
  //   buttonText = (!hideOrderButtons && showStartedVisit)
  //       ? LanguageManager().get('request_to_end_visit')
  //       : LanguageManager().get('add_expenses');
  // }

  final statusText = visit.isMyVisitStarted! ? 'Visit Started' : 'Visit Not Started';
  final statusColor = statusText == 'visit started'
      ? AppTheme.getColor(context).secondary
      : AppColors.spanishYellow;

  return Padding(
    padding: EdgeInsets.all(Responsive.getWidth(context) * 0.03),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Row(
        children: [
          MyCoButton(
            height: 0.034 * Responsive.getHeight(context),
            width: 0.35 * Responsive.getWidth(context),
            onTap: () {},
            title: LanguageManager().get(statusText),
            backgroundColor: Colors.transparent,
            textStyle: TextStyle(
              color: statusColor,
              fontSize: 14 * Responsive.getResponsiveText(context),
              fontWeight: FontWeight.w400,
            ),
            boarderRadius: VariableBag.buttonBorderRadius,
            borderColor: statusColor,
            borderWidth: 1,
          ),
          const Spacer(),
          MyCoButton(
            height: 0.034 * Responsive.getHeight(context),
            width: 0.34 * Responsive.getWidth(context),
            onTap: () => context.pushNamed('view-visit-details' , extra: visit),
            title: LanguageManager().get('view_details'),
            backgroundColor: AppTheme.getColor(context).primary,
            textStyle: TextStyle(
              color: AppTheme.getColor(context).onPrimary,
              fontSize: 15 * Responsive.getResponsiveText(context),
              fontWeight: FontWeight.w400,
            ),
            boarderRadius: VariableBag.buttonBorderRadius,
            wantBorder: false,
            isShadowBottomLeft: true,
          ),
        ],
      ),

        SizedBox(height: Responsive.getHeight(context) * 0.02),

        // Visit details
        CommonRow(
          title: 'Visit',
          value: visit.physicalOrVirtualVisit == '0' ? 'physical' : 'virtual',
          textColor: AppColors.textGray,
        ),
        CommonRow(
          title: 'Visit Status',
          value: visit.visitStatus == '1' ? 'Approved' : 'Pending',
          textColor: (visit.visitStatus == '1')
              ? AppTheme.getColor(context).secondary
              : AppColors.spanishYellow,
        ),
        CommonRow(
          title: 'Retailer Address',
          value: visit.retailerAddress ?? 'N/A',
        ),
        SizedBox(height: Responsive.getHeight(context) * 0.04),

        // Reschedule & Icons Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RescheduleVisitPage()),
              ),
              child: CustomText(
                'Reschedule Visit?',
                fontWeight: FontWeight.w600,
                fontSize: 14 * Responsive.getResponsiveText(context),
                color: AppTheme.getColor(context).primary,
                decoration: TextDecoration.underline,
              ),
            ),
            Row(
              children: [
                if (visit.serviceButtonVisibility == true) ...[
                  SvgPicture.asset(AppAssets.whatsapp),
                  SizedBox(width: Responsive.getWidth(context) * 0.03),
                ],
                if (visit.serviceButtonVisibility == true) ...[
                  SvgPicture.asset(AppAssets.share),
                  SizedBox(width: Responsive.getWidth(context) * 0.03),
                ],
                if (visit.serviceButtonVisibility == true)
                  SvgPicture.asset(AppAssets.delete),
              ],
            ),
          ],
        ),
        SizedBox(height: Responsive.getHeight(context) * 0.02),

        // END VISIT & TAKE ORDER
        if (visit.showEndButton == true)
          Column(
            children: [
              Row(
                children: <Widget>[
                  MyCoButton(
                    onTap: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      builder: (_) => const EndVisitBottomSheet(),
                    ),
                    title: 'END VISIT',
                    boarderRadius: VariableBag.buttonBorderRadius,
                    backgroundColor: Util.applyOpacity(AppColors.red, 0.1),
                    textStyle: TextStyle(
                      color: AppColors.red,
                      fontSize: 12 * Responsive.getResponsiveText(context),
                      fontWeight: FontWeight.bold,
                    ),
                    isShadowBottomLeft: true,
                    height: 0.050 * Responsive.getHeight(context),
                    width: 0.38 * Responsive.getWidth(context),
                  ),
                  const Spacer(),
                  MyCoButton(
                    onTap: () {},
                    title: 'TAKE ORDER',
                    backgroundColor: AppTheme.getColor(context).primary,
                    boarderRadius: VariableBag.buttonBorderRadius,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 12 * Responsive.getResponsiveText(context),
                      fontWeight: FontWeight.bold,
                    ),
                    isShadowBottomLeft: true,
                    height: 0.050 * Responsive.getHeight(context),
                    width: 0.38 * Responsive.getWidth(context),
                  ),
                ],
              ),
              SizedBox(height: Responsive.getHeight(context) * 0.01),
            ],
          ),

        if (visit.isVisitEndRequest== 'true')
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                'You Already Have sent End Visit Request',
                fontWeight: FontWeight.w600,
                fontSize: 15 * Responsive.getResponsiveText(context),
                color: AppTheme.getColor(context).primary,
              ),
              SizedBox(height: Responsive.getHeight(context) * 0.007),
              getCommonRow(
                context,
                title: 'Requested On',
                value: '03:58 PM , 03 Jun 2025',
                textColor: AppTheme.getColor(context).onSurface,
                onTap: () {},
              ),
            ],
          ),

        if (visit.isVisitEndRequest== 'true')
          Center(
            child: CustomText(
              'forgot_to_end_visit',
              fontSize: 14 * Responsive.getResponsiveText(context),
              fontWeight: FontWeight.w600,
              color: AppTheme.getColor(context).primary,
              textAlign: TextAlign.center,
            ),
          ),

        if (visit.isAutoEndVisit != 'true')
          MyCoButton(
            onTap: () {
              if (!showExtraButtons && !isSixthContainer) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: AppTheme.getColor(context).onPrimary,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  builder: (_) => startVisitBottomSheet(context),
                );
              }
            },
            title: buttonText,
            backgroundColor: AppTheme.getColor(context).secondary,
            textStyle: TextStyle(
              color: AppTheme.getColor(context).onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 14 * Responsive.getResponsiveText(context),
            ),
            boarderRadius: VariableBag.buttonBorderRadius,
            isShadowBottomLeft: true,
          ),

        if (visit.isVisitEndRequest == '1')
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                'end_visit_request',
                fontWeight: FontWeight.w600,
                fontSize: 14 * Responsive.getResponsiveText(context),
                color: AppTheme.getColor(context).primary,
              ),
              SizedBox(height: Responsive.getHeight(context) * 0.015),
              getCommonRow(
                context,
                title: LanguageManager().get('rejected_by'),
                value: 'vatsal soni (UIUX Designer)',
                onTap: () {},
              ),
              getCommonRow(
                context,
                title: LanguageManager().get('date'),
                value: '03:58 PM , 03 Jun 2025',
                onTap: () {},
              ),
              getCommonRow(
                context,
                title: LanguageManager().get('reason'),
                value: 'There were lots of missing data here',
                onTap: () {},
              ),
            ],
          ),
      ],
    ),
  );
}
