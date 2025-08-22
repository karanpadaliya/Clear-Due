import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/core/utils/util.dart';
import 'package:myco_flutter/widgets/cached_image_holder.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button_theme.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class NewAppointmentRequestDialog extends StatefulWidget {
  final String userFullName;
  final String userProfilePic;
  final String appointmentForUserId;
  final String userDesignation;
  final String appointmentDateTime;
  final String location;
  final String reason;

  const NewAppointmentRequestDialog({
    required this.userFullName,
    required this.userProfilePic,
    required this.appointmentForUserId,
    required this.userDesignation,
    required this.appointmentDateTime,
    required this.location,
    required this.reason,
    super.key,
  });

  @override
  State<NewAppointmentRequestDialog> createState() =>
      _NewAppointmentRequestDialogState();
}

class _NewAppointmentRequestDialogState
    extends State<NewAppointmentRequestDialog> {
  @override
  Widget build(BuildContext context) {
    final Widget errorPlaceholder = Center(
      child: CustomText(
        Util.getInitials(
          widget.userFullName.trim().isNotEmpty ? widget.userFullName : 'NA',
        ),
        fontSize: 20 * Responsive.getResponsiveText(context),
        fontWeight: FontWeight.w700,
        color: AppTheme.getColor(context).primary,
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: 12 * Responsive.getResponsive(context),
          ),
          decoration: BoxDecoration(
            color: AppTheme.getColor(context).primary,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(
                VariableBag.commonCardBorderRadius *
                    Responsive.getResponsive(context),
              ),
              topLeft: Radius.circular(
                VariableBag.commonCardBorderRadius *
                    Responsive.getResponsive(context),
              ),
            ),
          ),
          child: Center(
            child: CustomText(
              'New Appointment Request',
              fontWeight: FontWeight.w700,
              color: AppTheme.getColor(context).onPrimary,
            ),
          ),
        ),

        Container(
          color: AppTheme.getColor(context).surface,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal:
                  VariableBag.screenHorizontalPadding *
                  Responsive.getResponsive(context),
            ),
            child: Column(
              children: [
                SizedBox(height: 0.02 * Responsive.getHeight(context)),
                Card(
                  color: AppTheme.getColor(context).surfaceContainerHigh,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12 * Responsive.getResponsive(context),
                    ),
                    side: BorderSide(color: AppTheme.getColor(context).primary),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: VariableBag.commonCardHorizontalPadding,
                      vertical: VariableBag.commonCardVerticalPadding,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height:
                                        60 * Responsive.getResponsive(context),
                                    width:
                                        60 * Responsive.getResponsive(context),
                                    child: ClipOval(
                                      clipBehavior: Clip.hardEdge,
                                      child: (widget.userProfilePic.isNotEmpty)
                                          ? CachedImage(
                                              key: ValueKey(
                                                widget.appointmentForUserId,
                                              ),
                                              imageProvider: NetworkImage(
                                                widget.userProfilePic,
                                              ),
                                              errorWidget: errorPlaceholder,
                                            )
                                          : CircleAvatar(
                                              child: Center(
                                                child: errorPlaceholder,
                                              ),
                                            ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 0.08 * Responsive.getWidth(context),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          widget.userFullName,
                                          color: AppTheme.getColor(
                                            context,
                                          ).primary,
                                          fontWeight: FontWeight.w700,
                                          fontSize:
                                              17 *
                                              Responsive.getResponsiveText(
                                                context,
                                              ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        CustomText(
                                          widget.userDesignation,
                                          color: AppColors.textGray,
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              14 *
                                              Responsive.getResponsiveText(
                                                context,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 0.08 * Responsive.getHeight(context),
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(AppAssets.calenderPrimary),
                                  SizedBox(
                                    width: 0.06 * Responsive.getWidth(context),
                                  ),
                                  CustomText(
                                    widget.appointmentDateTime,
                                    fontSize:
                                        12 *
                                        Responsive.getResponsiveText(context),
                                    color: AppTheme.getColor(
                                      context,
                                    ).tertiaryContainer,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 0.06 * Responsive.getHeight(context),
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(AppAssets.location),
                                  const SizedBox(width: 6),
                                  CustomText(
                                    widget.location,
                                    fontSize:
                                        12 *
                                        Responsive.getResponsiveText(context),
                                    color: AppTheme.getColor(
                                      context,
                                    ).tertiaryContainer,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 0.08 * Responsive.getWidth(context)),
                        Image.asset(
                          AppAssets.timerTrack,
                          height: 110,
                          width: 110,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 0.02 * Responsive.getHeight(context)),
                Container(
                  height: 0.1 * Responsive.getHeight(context),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: VariableBag.commonCardHorizontalPadding,
                    vertical: VariableBag.commonCardVerticalPadding,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppTheme.getColor(context).outlineVariant,
                    ),
                    borderRadius: BorderRadius.circular(
                      8 * Responsive.getResponsive(context),
                    ),
                    color: AppTheme.getColor(context).surface,
                  ),
                  child: CustomText(
                    widget.reason,
                    fontSize: 15 * Responsive.getResponsiveText(context),
                    color: AppTheme.getColor(context).tertiaryContainer,
                  ),
                ),
                SizedBox(height: 0.025 * Responsive.getHeight(context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: MyCoButton(
                        title: LanguageManager().get('reject'),
                        height: Responsive.getHeight(context) * .05,
                        boarderRadius: 30 * Responsive.getResponsive(context),
                        width: Responsive.getWidth(context) * .450,
                        backgroundColor: AppColors.white,
                        border: Border.all(
                          color: AppTheme.getColor(context).primary,
                        ),
                        textStyle: MyCoButtonTheme.getWhiteBackgroundTextStyle(
                          context,
                        ),
                        onTap: () {},
                      ),
                    ),
                    SizedBox(width: 0.08 * Responsive.getWidth(context)),
                    Expanded(
                      child: MyCoButton(
                        title: LanguageManager().get('approve'),
                        height: Responsive.getHeight(context) * .05,
                        isShadowBottomLeft: true,
                        boarderRadius: VariableBag.buttonBorderRadius,
                        width: Responsive.getWidth(context) * .450,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.02 * Responsive.getHeight(context)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
