import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/idea_box/presentation/widgets/common_container.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/profile_entity.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_bloc.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_event.dart';
import 'package:myco_flutter/widgets/custom_cached_network_image.dart';
import 'package:myco_flutter/widgets/custom_progress_bar.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class ProfileDetailsCard extends StatelessWidget {
  final String fullName;
  final String employeeId;
  final String designation;
  final String department;
  final String branchName;
  final String phoneNumber;
  final String email;
  final String profileImage;
  final List social_link;

  const ProfileDetailsCard({
    super.key,
    required this.fullName,
    required this.employeeId,
    required this.designation,
    required this.department,
    required this.branchName,
    required this.phoneNumber,
    required this.email,
    required this.profileImage,
    required this.social_link,
  });

  @override
  Widget build(BuildContext context) {
    final SocialLinkEntity socialLinks = social_link[0];
    return CommonCard(
      title: 'Developer QA',
      bottomWidget: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              VariableBag.commonCardHorizontalPadding *
              Responsive.getResponsive(context),
          vertical:
              VariableBag.commonCardVerticalPadding *
              Responsive.getResponsive(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                badges.Badge(
                  badgeStyle: const badges.BadgeStyle(
                    // Kept the badge background transparent as in your original code
                    badgeColor: Colors.transparent,
                    // Set elevation to 0 to avoid the badge's default shadow
                    elevation: 0,
                  ),
                  position: badges.BadgePosition.bottomEnd(
                    bottom: -17 * Responsive.getResponsive(context),
                    end: -6 * Responsive.getResponsive(context),
                  ),
                  badgeContent: ClipRRect(
                    child: SvgPicture.asset(
                      'assets/sign_in/camera_icon.svg',
                      height: 0.04 * Responsive.getHeight(context),
                    ),
                  ),
                  // MODIFICATION: The original child is wrapped in a Container to add a shadow.
                  child: Container(
                    height: 0.1 * Responsive.getHeight(context),
                    width: 0.1 * Responsive.getHeight(context),
                    decoration: BoxDecoration(
                      // The shape of the decoration should be circular to match the image.
                      shape: BoxShape.circle,
                      // The boxShadow property takes a list of BoxShadows.
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(
                            alpha: 0.4,
                          ), // Shadow color
                          spreadRadius: 2, // How far the shadow extends
                          blurRadius: 4, // The blurriness of the shadow
                          offset: const Offset(0, 4), // Moves the shadow (x, y)
                        ),
                      ],
                    ),
                    child: CustomCachedNetworkImage(
                      imageUrl: profileImage,
                      borderRadius: BorderRadius.circular(
                        50 * Responsive.getResponsive(context),
                      ),
                      errorWidget: Container(
                        color: AppTheme.getColor(context).outlineVariant,
                        child: Icon(
                          Icons.person_outline,
                          color: AppTheme.getColor(context).outline,
                          size: 0.06 * Responsive.getHeight(context),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 0.03 * Responsive.getWidth(context)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      fullName,
                      fontSize: 18 * Responsive.getResponsiveText(context),
                      fontWeight: FontWeight.w700,
                    ),
                    CustomText(
                      employeeId,
                      fontSize: 14 * Responsive.getResponsiveText(context),
                      fontWeight: FontWeight.w500,
                    ),
                    CustomText(
                      designation,
                      fontSize: 14 * Responsive.getResponsiveText(context),
                      fontWeight: FontWeight.w700,
                      color: AppTheme.getColor(context).outline,
                    ),
                    SizedBox(
                      width: 0.55 * Responsive.getWidth(context),
                      child: CustomText(
                        '$branchName - $department - $designation',
                        color: AppTheme.getColor(context).outline,
                        fontSize: 14 * Responsive.getResponsiveText(context),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 0.07 * Responsive.getHeight(context)),
            Container(
              child: CustomSegmentedProgressBar(
                totalSegments: 4,
                percentComplete: 90,
                gradientColors: [
                  AppTheme.getColor(context).primary,
                  AppTheme.getColor(context).tertiary,
                  AppTheme.getColor(context).onTertiaryContainer,
                  AppTheme.getColor(context).tertiary,
                  AppTheme.getColor(context).primary,
                ],
              ),
            ),
            CustomText(
              LanguageManager().get('profile_completion'),
              color: AppTheme.getColor(context).primary,
              fontSize: 16 * Responsive.getResponsiveText(context),
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 0.01 * Responsive.getHeight(context)),
            Container(
              width: 0.9 * Responsive.getWidth(context),
              child: Divider(color: AppTheme.getColor(context).onTertiary),
            ),
            Row(
              spacing: 0.015 * Responsive.getWidth(context),
              children: [
                SvgPicture.asset('assets/dashboard/svgs/call-calling.svg'),
                CustomText(
                  phoneNumber,
                  fontWeight: FontWeight.w500,
                  fontSize: 16 * Responsive.getResponsiveText(context),
                ),
              ],
            ),
            SizedBox(height: 0.005 * Responsive.getHeight(context)),
            Row(
              spacing: 0.015 * Responsive.getWidth(context),
              children: [
                SvgPicture.asset('assets/dashboard/svgs/sms.svg'),
                CustomText(
                  email,
                  fontWeight: FontWeight.w500,
                  fontSize: 16 * Responsive.getResponsiveText(context),
                ),
              ],
            ),
            SizedBox(height: 0.02 * Responsive.getHeight(context)),
            Row(
              spacing: 0.02 * Responsive.getWidth(context),
              children: [
                InkWell(
                  onTap: () {
                    // final SocialLinkEntity socialLinks = social_link[0];
                    context.read<MyProfileBloc>().add(
                      FacebookClickEvent(socialLinks.facebook.toString()),
                    );
                  },
                  child: Image.asset(
                    'assets/dashboard/facebook_logo.png',
                    height: 0.035 * Responsive.getHeight(context),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.read<MyProfileBloc>().add(
                      LinkedInClickEvent(socialLinks.linkedin.toString()),
                    );
                  },
                  child: Image.asset(
                    'assets/dashboard/linked_in_logo.png',
                    height: 0.035 * Responsive.getHeight(context),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.read<MyProfileBloc>().add(
                      TwitterClickEvent(socialLinks.twitter.toString()),
                    );
                  },
                  child: Image.asset(
                    'assets/dashboard/x_logo.png',
                    height: 0.035 * Responsive.getHeight(context),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.read<MyProfileBloc>().add(
                      InstagramClickEvent(socialLinks.instagram.toString()),
                    );
                  },
                  child: Image.asset(
                    'assets/dashboard/instagram_logo.png',
                    height: 0.035 * Responsive.getHeight(context),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.read<MyProfileBloc>().add(
                      WhatsappClickEvent(
                        socialLinks.whatsappNumberWithoutCountryCode.toString(),
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/dashboard/whatsapp_logo.png',
                    height: 0.035 * Responsive.getHeight(context),
                  ),
                ),
                Spacer(),
                SvgPicture.asset(
                  'assets/dashboard/svgs/message-edit.svg',
                  height: 0.035 * Responsive.getHeight(context),
                ),
              ],
            ),
          ],
        ),
      ),
      subTitle: 'WTT, S.G Highway, Ahmedabad',
    );
  }
}
