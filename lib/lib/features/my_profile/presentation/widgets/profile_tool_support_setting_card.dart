import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/dashboard/presentation/widgets/custom_label_gifs.dart';
import 'package:myco_flutter/widgets/custom_shadow_container.dart';

class ProfileToolSupportSettingCard extends StatelessWidget {
  ProfileToolSupportSettingCard({super.key});

  List svgList = [
    "assets/dashboard/svgs/app_support.svg",
    "assets/dashboard/svgs/my_travel_summary.svg",
    "assets/dashboard/svgs/my_transaction.svg",
    "assets/dashboard/svgs/my_activities.svg",
    "assets/dashboard/svgs/rate_app.svg",
  ];
  List namesList = [
    "App Support",
    "Local Attendance",
    "My Transactions",
    "My Activities",
    "Rate App",
  ];
  List routeList = [
    RoutePaths.appSupport,
    '',
    '',
    RoutePaths.getActivity,
  ];

  @override
  Widget build(BuildContext context) => Column(
    spacing: 0.015 * Responsive.getHeight(context),
    children: [
      CustomLabelGifs(
        title: 'Tools, Supports & Settings',
        gifAssetPath: 'assets/gifs/profile_tool_support_setting.gif',
      ),
      GridView.builder(
        itemCount: 5,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 8,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.symmetric(
            vertical: 1 * Responsive.getResponsive(context),
          ),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(
              12 * Responsive.getResponsive(context),
            ),
            border: Border.all(color: AppTheme.getColor(context).outlineVariant),
          ),
          child: InkWell(
            onTap: () {
              context.push(routeList[index]);
            },
            child: CustomShadowContainer(
              image: SvgPicture.asset(svgList[index]),
              boxPadding: 20* Responsive.getResponsive(context),
              title: LanguageManager().get("${namesList[index]}"),
              height: 0.50 * Responsive.getHeight(context),
              
            ),
          ),
        ),
      ),
    ],
  );
}
