import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/lost_and_found/presentation/widgets/custom_radio_button.dart';
import 'package:myco_flutter/widgets/big_textfield.dart';
import 'package:myco_flutter/widgets/custom_inner_outer_shadow.dart';
import 'package:myco_flutter/widgets/custom_myco_button/common_card.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';

class OverTimeRequest extends StatelessWidget {
  // header section
  final bool buttonVisible;
  final String title;
  final String secondTitle;
  final String subTitle;

  // button section
  final void Function()? requestForOvertime;
  final void Function()? requestForLeave;

  // radio section
  final void Function(String) radioOnChanged;
  final String initialValue;
  final bool dateVisible;

  // time
  final dynamic Function()? dateTimeOnTap;
  final TextEditingController? hoursController;
  final TextEditingController? minutesController;

  // reason
  final TextEditingController? reasonController;

  // request and dialog close button
  final void Function()? onSendRequest;
  final void Function()? onDialogClose;

  const OverTimeRequest({
    required this.buttonVisible,
    required this.requestForOvertime,
    required this.requestForLeave,
    required this.initialValue,
    required this.radioOnChanged,
    required this.title,
    required this.secondTitle,
    required this.subTitle,
    required this.onSendRequest,
    required this.onDialogClose,
    this.reasonController,
    this.dateVisible = false,
    this.hoursController,
    this.minutesController,
    this.dateTimeOnTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (context, constraints) => ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: constraints.maxHeight * 0.9, // still gives breathing room
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: CommonCard(
            title: title,
            secondTitle: buttonVisible ? null : secondTitle,
            subTitle: buttonVisible ? null : subTitle,
            headerPadding: const EdgeInsets.symmetric(
              horizontal: VariableBag.commonCardHorizontalPadding + 4,
              vertical: VariableBag.commonCardVerticalPadding,
            ),

            bottomWidget: Padding(
              padding: EdgeInsets.all(14.0 * Responsive.getResponsive(context)),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: SizeTransition(
                    sizeFactor: animation,
                    axisAlignment: -1.0,
                    child: child,
                  ),
                ),
                child: buttonVisible
                    ? _buildInitialButtons(context)
                    : ConstrainedBox(
                        key: const ValueKey(
                          'form',
                        ), // helps AnimatedSwitcher know which widget is which
                        constraints: BoxConstraints(
                          maxHeight: constraints.maxHeight * 0.5,
                        ),
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(bottom: bottomPadding),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [_buildOvertimeForm(context)],
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- Section: Initial Buttons ---
  Widget _buildInitialButtons(BuildContext context) => Padding(
    padding: const EdgeInsets.only(
      top: VariableBag.commonCardVerticalPadding,
      bottom: VariableBag.commonCardVerticalPadding,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildRequestButton(
          context: context,
          title: 'request_for_overtime',
          onTap: requestForOvertime,
          backgroundColor: AppTheme.getColor(context).secondary,
          textColor: AppTheme.getColor(context).surface,
        ),
        _buildRequestButton(
          context: context,
          title: 'request_for_leave',
          onTap: requestForLeave,
          backgroundColor: AppTheme.getColor(context).primary,
          textColor: AppTheme.getColor(context).surface,
        ),
      ],
    ),
  );

  // --- Section: Overtime Form ---
  Widget _buildOvertimeForm(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      if (dateVisible)
        _buildTimeSelector(context)
      else
        _buildRadioSelector(context),
      SizedBox(height: 12 * Responsive.getResponsive(context)),
      _buildReasonField(context),
      SizedBox(height: 18 * Responsive.getResponsive(context)),
      _buildActionButtons(context, onDialogClose, onSendRequest),
      SizedBox(height: 18 * Responsive.getResponsive(context)),
    ],
  );

  // --- Subcomponent: Request Button ---
  Widget _buildRequestButton({
    required BuildContext context,
    required String title,
    required void Function()? onTap,
    required Color backgroundColor,
    required Color textColor,
  }) => CustomInnerOuterShadow(
    innerShadows: const [
      Shadow(offset: Offset(2, 4), blurRadius: 4, color: Colors.black26),
    ],
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: 0.06 * Responsive.getHeight(context),
        width: 0.45 * Responsive.getWidth(context),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(
            8 * Responsive.getResponsive(context),
          ),
        ),
        alignment: Alignment.center,
        child: CustomText(
          title,
          fontSize: 14 * Responsive.getResponsiveText(context),
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );

  // --- Subcomponent: Time Selector ---
  Widget _buildTimeSelector(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(
        'Select Hour(s) & Minute(s) For Overtime*',
        color: AppTheme.getColor(context).onSurfaceVariant,
        fontSize: 13 * Responsive.getResponsiveText(context),
        fontWeight: FontWeight.bold,
      ),
      SizedBox(height: 6 * Responsive.getResponsive(context)),
      Row(
        children: [
          Expanded(
            child: NewTextField(
              label: 'Hours',
              hintText: '0',
              controller: hoursController,
              onTap: dateTimeOnTap,
            ),
          ),
          SizedBox(width: 0.02 * Responsive.getWidth(context)),
          Expanded(
            child: NewTextField(
              label: 'Minutes',
              hintText: '0',
              controller: minutesController,
              onTap: dateTimeOnTap,
              enabled: false,
            ),
          ),
        ],
      ),
    ],
  );

  // --- Subcomponent: Radio Selector ---
  Widget _buildRadioSelector(BuildContext context) => CustomRadioButton(
    title: 'Request for overtime',
    options: const ['Field Visit', 'Virtual Visit '],
    height: 0.055 * Responsive.getHeight(context),
    initialValue: initialValue,
    onChanged: radioOnChanged,
    isRequired: true,
  );

  // --- Subcomponent: Reason Field ---
  Widget _buildReasonField(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(
        'Reason',
        color: AppTheme.getColor(context).onSurfaceVariant,
        fontSize: 13 * Responsive.getResponsiveText(context),
        fontWeight: FontWeight.bold,
      ),
      BigMyCoTextField(
        maxLines: 5,
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.getColor(context).primary),
          borderRadius: BorderRadius.circular(
            12 * Responsive.getResponsive(context),
          ),
        ),
        controller: reasonController,
        hintText: 'Type here',
        prefixImage: SvgPicture.asset(
          AppAssets.assetStickyNote,
          height: 0.035 * Responsive.getHeight(context),
        ),
        keyboardType: TextInputType.text,
      ),
    ],
  );

  // --- Subcomponent: Action Buttons ---
  Widget _buildActionButtons(
    BuildContext context,
    void Function()? onTapDialogClose,
    void Function()? onTapSendRequest,
  ) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Expanded(
        child: MyCoButton(
          title: 'Close',
          onTap: onTapDialogClose,
          backgroundColor: Colors.white,
          boarderRadius: 30 * Responsive.getResponsive(context),
          border: Border.all(color: AppTheme.getColor(context).primary),
          textStyle: TextStyle(color: AppTheme.getColor(context).primary),
        ),
      ),
      SizedBox(width: 0.02 * Responsive.getWidth(context)),
      Expanded(
        child: MyCoButton(
          title: 'Send Request',
          isShadowBottomLeft: true,
          boarderRadius: 30 * Responsive.getResponsive(context),
          onTap: onTapSendRequest,
        ),
      ),
    ],
  );
}
