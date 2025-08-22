import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/visit_entity.dart';
import 'package:myco_flutter/features/my_visit/presentation/widgets/custom_table.dart';
import 'package:myco_flutter/widgets/common_card.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_common_row.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class ViewVisitDetailsPage extends StatelessWidget {
  final MyVisitEntity visit;
   const ViewVisitDetailsPage({required this.visit, super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: CustomAppbar(
      title: LanguageManager().get('visit_details'),
    ),
    body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal:
                  VariableBag.commonCardHorizontalPadding *
                  Responsive.getResponsive(context),
              vertical:
                  VariableBag.commonCardVerticalPadding *
                  Responsive.getResponsive(context),
            ),
            child: CommonCard(
              borderRadius:
                  VariableBag.commonCardBorderRadius *
                  Responsive.getResponsive(context),
              showBlackShadowInChild: true,
              headerColor: AppTheme.getColor(context).primary,
              title: visit.retailerName ?? 'unknown',
              subTitleIcon: SvgPicture.asset(AppAssets.calendar),
              subTitle: '${visit.retailerVisitStartDate}(${visit.retailerVisitStartTime}) to ${visit.retailerVisitEndDate}',
              bottomWidget: Padding(
                padding: EdgeInsets.all(12 * Responsive.getResponsive(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Contact Person Details
                     CommonRow(
                      title: 'contact_person_name',
                      value: visit.retailerContactPerson ?? 'unknown'
                    ),
                    CommonRow(
                      title: 'Contact Person Number',
                      valueWidget: RichText(
                        text: TextSpan(
                          text: '+91 ',
                          style: TextStyle(
                            color: AppTheme.getColor(context).primary,
                            fontSize:
                                13 * Responsive.getResponsiveText(context),
                          ),
                          children: [
                            TextSpan(
                              text: visit.retailerContactPersonNumber,
                              style: TextStyle(
                                color: AppTheme.getColor(context).onSurface,
                                fontSize:
                                    13 * Responsive.getResponsiveText(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                      value: '',
                    ),
                    CommonRow(
                      title: 'visit_status',
                      value: visit.visitStatus == '1' ? 'Approved' : 'Pending',
                      textColor: AppTheme.getColor(context).secondary,
                    ),
                    CommonRow(title: 'visit_type', value: visit.physicalOrVirtualVisit == '0' ? 'physical' : 'virtuale'),
                    CommonRow(title: 'visit_purpose', value: visit.visitPurpose ?? 'unknown'),
                    CommonRow(
                      title: 'address',
                      valueWidget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            visit.retailerAddress ?? 'nothing',
                            fontSize:
                                13 * Responsive.getResponsiveText(context),
                            fontWeight: FontWeight.w500,
                          ),
                          CustomText(
                            '(you are in range)',
                            fontSize:
                                13 * Responsive.getResponsiveText(context),
                            color: AppTheme.getColor(context).secondary,
                          ),
                        ],
                      ),
                      value: '',
                    ),
                    SizedBox(height: 0.007 * Responsive.getHeight(context)),
                    Divider(color: AppTheme.getColor(context).primary),

                    /// Visit start and end time
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                'visit_start_date_time',
                                fontSize:
                                    14 * Responsive.getResponsiveText(context),
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(
                                height: 0.007 * Responsive.getHeight(context),
                              ),
                              CustomText(
                                  '${visit.retailerVisitStartTime}, ${visit.retailerVisitStartDate}',
                                fontSize:
                                    14 * Responsive.getResponsiveText(context),
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                'visit_end_date_time',
                                fontSize:
                                    14 * Responsive.getResponsiveText(context),
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(
                                height: 0.007 * Responsive.getHeight(context),
                              ),
                              CustomText(
                                visit.retailerVisitEndDate ?? '',
                                fontSize:
                                    14 * Responsive.getResponsiveText(context),
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 0.004 * Responsive.getHeight(context)),
                    Divider(color: AppTheme.getColor(context).primary),
                    SizedBox(height: 0.017 * Responsive.getHeight(context)),

                    /// Visit Remark Status
                    Column(
                      children: [
                          CommonRow(
                          title: 'end_visit_remark',
                          value: visit.visitEndRemark??'unknown',
                        ),
                         CommonRow(title: 'end_visit_area', value: visit.endVisitArea ?? 'unknown'),
                          CommonRow(
                          title: 'end_visit_catalogue',
                          value: visit.endVisitCatalogue ?? 'unknown',
                        ),
                        CommonRow(
                          title: 'contact_person_number',
                          valueWidget: RichText(
                            text: TextSpan(
                              text: '',
                              style: TextStyle(
                                color: AppTheme.getColor(context).primary,
                                fontSize:
                                    13 * Responsive.getResponsiveText(context),
                              ),
                              children: [
                                TextSpan(
                                  text: 'nothing',
                                  style: TextStyle(
                                    color: AppTheme.getColor(context).onSurface,
                                    fontSize:
                                        13 *
                                        Responsive.getResponsiveText(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          value: '',
                        ),
                      ],
                    ),
                    SizedBox(height: 0.017 * Responsive.getHeight(context)),

                    /// Visit With
                    Row(
                      children: [
                        CustomText(
                          LanguageManager().get('visit_with'),
                          fontSize: 15 * Responsive.getResponsiveText(context),
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(width: 0.015 * Responsive.getWidth(context)),
                        const CustomText(':'),
                      ],
                    ),
                    SizedBox(height: 0.009 * Responsive.getHeight(context)),

                    /// Table for visit with
                    CustomTableWidget(
                      name: 'Yash Soni',
                      designation: '(UI UX)',
                    ),
                    SizedBox(height: 0.018 * Responsive.getHeight(context)),

                    /// Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyCoButton(
                          onTap: () {},
                          backgroundColor: AppTheme.getColor(context).onPrimary,
                          title: 'visit_complete',
                          width: 0.30 * Responsive.getWidth(context),
                          height: 0.033 * Responsive.getHeight(context),
                          boarderRadius: VariableBag.bottomSheetBorderRadius,
                          textStyle: TextStyle(
                            color: AppTheme.getColor(context).secondary,
                          ),
                          borderColor: AppTheme.getColor(context).secondary,
                        ),
                        CustomText(
                          'view_attachment',
                          color: AppTheme.getColor(context).secondary,
                          fontSize: 14 * Responsive.getResponsiveText(context),
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationColor: AppTheme.getColor(context).secondary,
                        ),
                      ],
                    ),

                    SizedBox(height: 0.017 * Responsive.getHeight(context)),

                    /// Share + Report Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(AppAssets.whatsapp),
                            SizedBox(
                              width: 0.045 * Responsive.getWidth(context),
                            ),
                            SvgPicture.asset(AppAssets.share),
                          ],
                        ),
                        MyCoButton(
                          onTap: () {
                            context.pushNamed('visit_report');
                          },
                          title: LanguageManager().get('view_report'),
                          isShadowBottomLeft: true,
                          width: 0.33 * Responsive.getWidth(context),
                          height: 0.033 * Responsive.getHeight(context),
                          boarderRadius:
                              VariableBag.buttonBorderRadius *
                              Responsive.getResponsive(context),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.020 * Responsive.getHeight(context)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    ),
  );
}
