import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/dashboard/presentation/widgets/my_team/my_team_section.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_bloc.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_state.dart';
import 'package:myco_flutter/features/my_profile/presentation/widgets/my_profile_page_shimmer.dart';
import 'package:myco_flutter/features/my_profile/presentation/widgets/profile_details_card.dart';
import 'package:myco_flutter/features/my_profile/presentation/widgets/profile_personal_info_card.dart';
import 'package:myco_flutter/features/my_profile/presentation/widgets/profile_reporting_card.dart';
import 'package:myco_flutter/features/my_profile/presentation/widgets/profile_tool_support_setting_card.dart';
import 'package:myco_flutter/main.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // context.read<MyProfileBloc>().add(FetchProfileDataEvent());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: CustomAppbar(
      automaticallyImplyLeading: false,
      appBarBackgoundColor: Colors.transparent,
      leadingWidth: 0.1 * Responsive.getWidth(context),
      title: LanguageManager().get('profile'),
      actions: [
        // Add the theme toggle button here
        ValueListenableBuilder<ThemeMode>(
          valueListenable: themeService,
          builder: (context, themeMode, child) => IconButton(
            icon: Icon(
              themeMode == ThemeMode.light
                  ? Icons.dark_mode
                  : themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.settings_system_daydream,
            ),
            onPressed: themeService.toggleTheme,
          ),
        ),
        Row(
          // crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 0.015 * Responsive.getWidth(context),
          children: [
            Container(
              height: 0.04 * Responsive.getHeight(context),
              width: 0.32 * Responsive.getWidth(context),
              decoration: BoxDecoration(
                color: AppTheme.getColor(context).primary,
                borderRadius: BorderRadius.circular(
                  10 * Responsive.getResponsive(context),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12 * Responsive.getResponsive(context),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => context.push(RoutePaths.adminView),
                      child: Container(
                        height: 0.03 * Responsive.getHeight(context),
                        width: 0.07 * Responsive.getWidth(context),
                        decoration: BoxDecoration(
                          color: AppTheme.getColor(context).onPrimary,
                          borderRadius: BorderRadius.circular(
                            10 * Responsive.getResponsive(context),
                          ),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/dashboard/svgs/admin_view_icon.svg',
                            height: 0.02 * Responsive.getHeight(context),
                          ),
                        ),
                      ),
                    ),
                    CustomText(
                      LanguageManager().get('admin_view'),
                      fontSize: 12 * Responsive.getResponsiveText(context),
                      color: AppTheme.getColor(context).onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 0.035 * Responsive.getHeight(context),
              width: 0.08 * Responsive.getWidth(context),
              decoration: BoxDecoration(
                color: AppTheme.getColor(
                  context,
                ).tertiary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(
                  30 * Responsive.getResponsive(context),
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/dashboard/svgs/profile_exit.svg',
                  height: 0.015 * Responsive.getHeight(context),
                ),
              ),
            ),
            Container(
              height: 0.035 * Responsive.getHeight(context),
              width: 0.08 * Responsive.getWidth(context),
              decoration: BoxDecoration(
                color: AppTheme.getColor(
                  context,
                ).tertiary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(
                  30 * Responsive.getResponsive(context),
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/dashboard/svgs/profile_setting.svg',
                  height: 0.015 * Responsive.getHeight(context),
                ),
              ),
            ),
            Container(
              height: 0.035 * Responsive.getHeight(context),
              width: 0.08 * Responsive.getWidth(context),
              decoration: BoxDecoration(
                color: AppTheme.getColor(
                  context,
                ).tertiary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(
                  30 * Responsive.getResponsive(context),
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/dashboard/svgs/profile_share.svg',
                  height: 0.015 * Responsive.getHeight(context),
                ),
              ),
            ),
            SizedBox(width: 0.01 * Responsive.getWidth(context)),
          ],
        ),
      ],
    ),
    body: Padding(
      padding: EdgeInsets.symmetric(
        horizontal:
            VariableBag.screenHorizontalPadding *
            Responsive.getResponsive(context),
      ),
      child: BlocBuilder<MyProfileBloc, MyProfileState>(
        builder: (context, state) {
          if (state is FetchProfileDataLoadingState) {
            return const MyProfilePageShimmer();
          }

          if (state is FetchProfileDataErrorState) {
            return Center(
              child: CustomText(
                state.errorMessage,
                color: AppTheme.getColor(context).error,
                fontSize: 16 * Responsive.getResponsiveText(context),
              ),
            );
          }

          if (state is FetchProfileDataSuccessState) {
            // You can access the profile data here
            final profileData = state.profileEntity;
            // Use profileData to build your UI
            return Column(
              spacing: 0.015 * Responsive.getHeight(context),
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 0.015 * Responsive.getHeight(context),
                      children: [
                        //Details Card
                        ProfileDetailsCard(
                          fullName: profileData.userFullName.toString(),
                          employeeId: profileData.employeeId.toString(),
                          designation: profileData.designation.toString(),
                          department: profileData.departmentName.toString(),
                          branchName: profileData.branchName.toString(),
                          phoneNumber: profileData.userMobile.toString(),
                          email: profileData.userEmail.toString(),
                          profileImage: profileData.userProfilePic.toString(),
                          social_link: profileData.socialLink ?? [],
                        ),

                        //Reporting Card
                        profileData.reportingPersons != null &&
                                profileData.reportingPersons!.isNotEmpty
                            ? ProfileReportingCard(
                                reportingPersonsList:
                                    profileData.reportingPersons ?? [],
                              )
                            : const SizedBox.shrink(),

                        //Personal Info Card
                        profileData.profileMenu != null &&
                                profileData.profileMenu!.isNotEmpty
                            ? ProfilePersonalInfoCard(
                                personalInfoList: profileData.profileMenu ?? [],
                                profileModelEntity: profileData,
                              )
                            : const SizedBox.shrink(),

                        //Work Atendance Card
                        // ProfileWordAttendanceCard(),

                        //Tool Support Setting Card
                        ProfileToolSupportSettingCard(),

                        //Overlaping image
                        MyTeamSection(myTeam: profileData.myTeam),
                        //MycoButton for apply
                        MyCoButton(
                          boarderRadius: 30 * Responsive.getResponsive(context),
                          onTap: () {},
                          title: LanguageManager().get('apply_resignation'),
                          isShadowBottomLeft: true,
                        ),
                        Column(
                          children: [
                            CustomText(
                              'WWW.MY-COMPANY.APP',
                              color: AppTheme.getColor(context).primary,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomText(
                              'What’s New',
                              fontWeight: FontWeight.bold,
                              color: AppTheme.getColor(context).primary,
                              decoration: TextDecoration.underline,
                            ),
                            const CustomText(
                              'V.211',
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        SizedBox(height: 0.13 * Responsive.getHeight(context)),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return Center(
            child: CustomText(
              LanguageManager().get(
                'something_went_wrong_please_try_again_later',
              ),
              color: AppTheme.getColor(context).error,
              fontSize: 16 * Responsive.getResponsiveText(context),
            ),
          );
        },
      ),
    ),
  );
}
