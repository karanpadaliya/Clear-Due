import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/core/utils/util.dart';
import 'package:myco_flutter/features/dashboard/presentation/widgets/timer_and_slider/timer_and_slider.dart';
// import 'package:myco_flutter/features/dashboard/presentation/widgets/timer_and_slider/timer_and_slider.dart';
import 'package:myco_flutter/features/home_screen/bloc/bottom_navigation_bar_bloc.dart';
import 'package:myco_flutter/features/speech_menu_search/presentation/bloc/speech_bloc.dart';
import 'package:myco_flutter/features/speech_menu_search/presentation/widgets/menu_selection_bottom_sheet.dart';
import 'package:myco_flutter/features/speech_menu_search/presentation/widgets/voice_search_bottom_sheet.dart';
import 'package:myco_flutter/widgets/custom_cached_network_image.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class DashboardAppBar extends StatelessWidget {
  final String? userId;
  final String? userName;
  final String? designation;
  final String? profilePictureUrl;

  const DashboardAppBar({
    super.key,
    this.userId,
    this.userName,
    this.designation,
    this.profilePictureUrl,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    width: double.infinity,
    decoration: BoxDecoration(
      color: AppTheme.getColor(context).surface,
      boxShadow: [
        BoxShadow(
          color: Util.applyOpacity(AppTheme.getColor(context).surface, 1),
          blurRadius: 7,
          spreadRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 9,
      children: [
        InkWell(
          onTap: () {
            context.read<BottomNavigationBarBloc>().add(
              const ChangeNavigationIndexEvent(3),
            );
            // context.pushNamed("my-profile");

            //do not remove thhis code, it is used for other profile page
            // final args = OtherProfilePageArgs(
            //   userId: "1504" ,
            //   societyId: "1",
            //   unitId: "21",
            //   blockId: "1",
            //   floorId: "1",
            //   myUserId: "1504",
            //   myProfile: "1",
            //   getProfileMenuDetails: 'getProfileMenuDetails',
            //   otherUserBlockId: '',
            //   otherUserFloorId: '',
            //
            // );
            // context.pushNamed('other-profile',extra: args);
          },
          child: CustomCachedNetworkImage(
            imageUrl: profilePictureUrl ?? '',
            userName: userName ?? '',
            isCircular: true,
            height: 44 * Responsive.getDashboardResponsive(context),
            // errorWidget: SvgPicture.asset(
            //   AppAssets.user,
            //   height: 44 * Responsive.getDashboardResponsive(context),
            // ),
          ),
        ),

        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: CustomText(
                      userName ?? '',
                      fontWeight: FontWeight.w700,
                      fontSize:
                          14 * Responsive.getDashboardResponsiveText(context),
                    ),
                  ),
                  const WidgetSpan(child: SizedBox(width: 10)),
                  WidgetSpan(child: Image.asset(AppAssets.verified)),
                ],
              ),
            ),

            CustomText(
              designation ?? '',
              fontWeight: FontWeight.w600,
              fontSize: 12 * Responsive.getDashboardResponsiveText(context),
              color: AppColors.spanishYellow,
            ),
            LiveClock(
              isAppBar: true,
              fontSize: 10 * Responsive.getDashboardResponsiveText(context),
            ),

            // CustomText(
            //   'date and time now',
            //   fontWeight: FontWeight.w500,
            //   fontSize: 10,
            //   color: AppTheme.getColor(context).onSurfaceVariant,
            // ),
          ],
        ),

        // TODO: Add a button for notifications and search
        const Spacer(),
        // Search button with voice search functionality
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (_) => BlocProvider.value(
                value: context.read<SpeechBloc>(),
                child: SizedBox(
                  width: 0.9 * Responsive.getWidth(context),
                  child: VoiceSearchBottomSheet(
                    onResult: (filteredList) {
                      // context.pop();
                      for (var element in filteredList) {
                        log(
                          element.iosMenuClick.toString(),
                          name: 'menuTitleSearch',
                        );
                      }
                      if (filteredList.length == 1) {
                        if (filteredList.first.iosMenuClick != null) {
                          if (filteredList.first.iosMenuClick == 'ProfileVC') {
                            context.read<BottomNavigationBarBloc>().add(
                              const ChangeNavigationIndexEvent(3),
                            );
                          } else {
                            context.pushNamed(
                              filteredList.first.iosMenuClick.toString(),
                            );
                          }
                        }
                      } else {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) => SizedBox(
                            width: 0.9 * Responsive.getWidth(context),
                            child: MenuSelectionBottomSheet(
                              items: filteredList,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            );
          },
          icon: Container(
            decoration: BoxDecoration(
              color: Util.applyOpacity(AppColors.myCoCyan, 0.1),
              shape: BoxShape.circle,
            ),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            child: Image.asset(AppAssets.search),
          ),
        ),
        IconButton(
          onPressed: () {
            // TODO: Implement notification functionality
          },
          icon: Container(
            decoration: BoxDecoration(
              color: Util.applyOpacity(AppColors.myCoCyan, 0.1),
              shape: BoxShape.circle,
            ),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            child: Image.asset(AppAssets.notification),
          ),
        ),
      ],
    ),
  );
}
