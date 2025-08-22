import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_common_row.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class CardBottomContent extends StatefulWidget {
  final bool isOrderTaken;
  final bool isOnlyVisit;

  const CardBottomContent({
    super.key,
    this.isOrderTaken = false,
    this.isOnlyVisit = false,
  });

  @override
  State<CardBottomContent> createState() => _CardBottomContentState();
}

class _CardBottomContentState extends State<CardBottomContent> {
  bool isExpanded = false;

  void toggleExpand() {
    if (!widget.isOrderTaken && !widget.isOnlyVisit) {
      setState(() => isExpanded = !isExpanded);
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.getResponsive(context);
    final responsiveHeight = Responsive.getHeight(context);
    final responsiveWidth = Responsive.getWidth(context);
    final textResponsive = Responsive.getResponsiveText(context);

    final isNoOrder = !widget.isOrderTaken && !widget.isOnlyVisit;
    final colorTheme = AppTheme.getColor(context);

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Main Content Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Left Column (Customer Info)
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.all(16 * responsive),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomText(
                            'category : ',
                            fontSize: 14 * textResponsive,
                            fontWeight: FontWeight.w600,
                          ),
                          CustomText(
                            'CHPL',
                            fontSize: 14 * textResponsive,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      SizedBox(height: 0.009 * responsiveHeight),
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.profileCircle,
                            height: 0.020 * responsiveHeight,
                          ),
                          const SizedBox(width: 8),
                          CustomText(
                            'Yash Soni',
                            fontSize: 14 * textResponsive,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      SizedBox(height: 0.008 * responsiveHeight),
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.callCalling,
                            height: 0.018 * responsiveHeight,
                          ),
                          SizedBox(width: 0.030 * responsiveWidth),
                          CustomText(
                            '+91 9909945983',
                            fontSize: 14 * textResponsive,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ],
                      ),
                      SizedBox(height: 0.010 * responsiveHeight),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            AppAssets.location,
                            height: 0.018 * responsiveHeight,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: CustomText(
                              '101, Sanand - Sarkhej Rd, Makarba, Ahmedabad...',
                              fontSize: 12 * textResponsive,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              /// Right Column (Distance & Cart icon)
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 12 * responsive,
                    horizontal: 12 * responsive,
                  ),
                  child: Column(
                    spacing: 10 * responsive,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (isNoOrder)
                        SvgPicture.asset(
                          AppAssets.cart,
                          height: 0.035 * responsiveHeight,
                          width: 0.035 * responsiveWidth,
                        ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            AppAssets.map,
                            height: 0.035 * responsiveHeight,
                            width: 0.035 * responsiveWidth,
                          ),
                          SizedBox(width: 0.006 * responsiveWidth),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomText(
                                '333.04 Km',
                                fontSize: 14 * textResponsive,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(height: 0.0001 * responsiveHeight),
                              CustomText(
                                '(Air Distance)',
                                fontSize: 12 * textResponsive,
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (widget.isOrderTaken && !widget.isOnlyVisit)
                        Padding(
                          padding: EdgeInsets.only(
                            right: 10 * responsive,
                            top: 10 * responsive,
                          ),
                          child: SvgPicture.asset(
                            AppAssets.cart_no,
                            height: 0.035 * responsiveHeight,
                            width: 0.035 * responsiveWidth,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          /// Last Visit History
          GestureDetector(
            onTap: toggleExpand,
            child: Padding(
              padding: EdgeInsets.only(
                right: 10 * responsive,
                bottom: 10 * responsive,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomText(
                    'last_visit_history',
                    fontSize: 13 * textResponsive,
                    fontWeight: FontWeight.w600,
                    color: colorTheme.primary,
                  ),
                  SizedBox(width: 0.020 * responsiveWidth),
                  SvgPicture.asset(
                    isNoOrder
                        ? isExpanded
                              ? AppAssets.CaretCircleDown
                              : AppAssets.CaretCircleUp
                        : AppAssets.CaretCircleDown,
                    height: 0.018 * responsiveHeight,
                    width: 0.018 * responsiveWidth,
                  ),
                ],
              ),
            ),
          ),

          /// Expanded Last Visit Info
          if (isExpanded)
            Column(
              children: [
                Divider(
                  color: colorTheme.primary,
                  height: 0.001 * responsiveHeight,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(16 * responsive),
                    ),
                    color: AppTheme.getColor(context).surfaceContainer,
                  ),
                  width: double.infinity,
                  padding: EdgeInsets.all(16 * responsive),
                  child: Column(
                    spacing: 0.0070 * responsiveHeight,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonRow(
                        title: 'last_order_date',
                        value: '02:21 PM, 25th Mar 2025',
                        textColor: colorTheme.primary,
                      ),
                      CommonRow(
                        title: 'last_visit_date',
                        value: '02:21 PM, 25th Mar 2025',
                        textColor: colorTheme.primary,
                      ),
                      CommonRow(
                        title: 'last_order_amount',
                        value: '1164.70',
                        textColor: colorTheme.primary,
                      ),
                      CommonRow(
                        title: 'last_visit_by',
                        value: 'Manish Chandra (Tester)',
                        textColor: colorTheme.primary,
                      ),
                      CommonRow(
                        title: 'last_visit_remarks',
                        value: 'Done',
                        textColor: colorTheme.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
