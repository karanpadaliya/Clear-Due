import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/dashboard/presentation/widgets/my_team/my_team_section.dart';
import 'package:myco_flutter/features/idea_box/presentation/widgets/common_container.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_bloc.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_state.dart';
import 'package:myco_flutter/features/my_profile/presentation/widgets/my_profile_page_shimmer.dart';
import 'package:myco_flutter/features/my_profile/presentation/widgets/other_profile_details_card.dart';
import 'package:myco_flutter/features/my_profile/presentation/widgets/profile_personal_info_card.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class OtherProfilePage extends StatelessWidget {
  const OtherProfilePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: CustomAppbar(
      automaticallyImplyLeading: false,
      appBarBackgoundColor: Colors.transparent,
      leadingWidth: 0.1 * Responsive.getWidth(context),
      title: LanguageManager().get('profile'),
    ),
    body: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 18 * Responsive.getResponsive(context),
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
            return Container(
              child: Column(
                spacing: 0.015 * Responsive.getHeight(context),
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: 0.015 * Responsive.getHeight(context),
                        children: [
                          //Details Card
                          OtherProfileDetailsCard(
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

                          CommonCard(
                            title: 'Praises',
                            bottomWidget: Column(),
                            suffixIcon: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    right:
                                        10 * Responsive.getResponsive(context),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: AppTheme.getColor(
                                            context,
                                          ).onPrimary,
                                        ),
                                      ),
                                    ),
                                    child: CustomText(
                                      'Give Praise',
                                      fontSize:
                                          14 *
                                          Responsive.getResponsiveText(context),
                                      color: AppTheme.getColor(
                                        context,
                                      ).onPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //Personal Info Card
                          profileData.profileMenu != null &&
                                  profileData.profileMenu!.isNotEmpty
                              ? ProfilePersonalInfoCard(
                                  personalInfoList:
                                      profileData.profileMenu ?? [],
                            profileModelEntity: profileData,
                                )
                              : const SizedBox.shrink(),
                          //Overlaping image
                          profileData.myTeam != null &&
                                  profileData.myTeam!.isNotEmpty
                              ? MyTeamSection(myTeam: profileData.myTeam)
                              : const SizedBox.shrink(),
                          //MycoButton for apply
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing:
                                  VariableBag.buttonRowSpacing *
                                  Responsive.getResponsive(context),
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: AppTheme.getColor(
                                          context,
                                        ).onSurfaceVariant,
                                      ),
                                    ),
                                  ),
                                  child: CustomText(
                                    'Report User',
                                    fontSize:
                                        14 *
                                        Responsive.getResponsiveText(context),
                                    color: AppTheme.getColor(context).onSurfaceVariant,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: AppTheme.getColor(
                                          context,
                                        ).onSurfaceVariant,
                                      ),
                                    ),
                                  ),
                                  child: CustomText(
                                    'Block User',
                                    fontSize:
                                        14 *
                                        Responsive.getResponsiveText(context),
                                    color: AppTheme.getColor(context).onSurfaceVariant,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 0.015 * Responsive.getHeight(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return Center(
            child: CustomText(
               'Something went wrong',
              color: AppTheme.getColor(context).error,
              fontSize: 16 * Responsive.getResponsiveText(context),
            ),
          );
        },
      ),
    ),
  );
}
