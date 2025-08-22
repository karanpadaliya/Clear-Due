import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/home_menu_response_entity.dart';
import 'package:myco_flutter/widgets/border_container_wraper.dart';
import 'package:myco_flutter/widgets/custom_cached_network_image.dart';
import 'package:myco_flutter/widgets/custom_shadow_container.dart';

class BigHomeMenu extends StatelessWidget {
  final List<AppMenuEntity> appMenuBig;
  const BigHomeMenu({required this.appMenuBig, super.key});

  @override
  Widget build(BuildContext context) {
    if (appMenuBig.isEmpty) {
      return const SizedBox.shrink();
    }
    return Row(
      spacing: 16,
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              context.pushNamed(appMenuBig.first.iosMenuClick ?? '');
            },
            child: BigHomeMenuIcon(
              context,
              icon: appMenuBig.first.menuIcon ?? '',
              title: appMenuBig.first.menuTitle ?? '',
              // height:Responsive.getResponsive(context) * 70,
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              context.pushNamed(appMenuBig.last.iosMenuClick ?? '');
            },
            child: BigHomeMenuIcon(
              context,
              icon: appMenuBig.last.menuIcon ?? '',
              title: appMenuBig.last.menuTitle ?? '',
              // height:  Responsive.getResponsive(context) * 70,
            ),
          ),
        ),
      ],
    );
  }
}

Widget BigHomeMenuIcon(
  BuildContext context, {
  String? icon,
  String? title,
  double? height,
}) => BorderContainerWraper(
  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  child: CustomShadowContainer(
    width: double.infinity,
    boxPadding: 0,
    imagePadding: 8 * Responsive.getResponsive(context),
    imgTitleSpacing: 8,
    isRect: true,
    image: CustomCachedNetworkImage(
      imageUrl: icon ?? '',
      height: height ?? Responsive.getDashboardResponsive(context) * 60,
      // placeholder: (context, url) => Shimmer.fromColors(
      //   baseColor: const Color.fromARGB(255, 81, 80, 80),
      //   highlightColor: Colors.grey.shade100,
      //   child: Container(
      //     width: 28,
      //     height: 28,
      //     decoration: BoxDecoration(
      //       color: Colors.white,
      //       borderRadius: BorderRadius.circular(4),
      //     ),
      //   ),
      // ),
      errorWidget: Image.asset('assets/images/logo.png'),
    ), // Replace with actual image if needed
    title: title,
  ),
);
