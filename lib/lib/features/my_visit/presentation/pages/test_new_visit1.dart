import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';
import 'package:myco_flutter/widgets/media_picker/widgets/custom_media_picker_container.dart';

class TestNewVisit1 extends StatelessWidget {
  const TestNewVisit1({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(
      left:
          VariableBag.bottomSheetLeftPadding *
          Responsive.getResponsive(context),
      right:
          VariableBag.bottomSheetRightPadding *
          Responsive.getResponsive(context),
      top:
          VariableBag.bottomSheetTopPadding * Responsive.getResponsive(context),
      bottom:
          VariableBag.bottomSheetBottomPadding *
          Responsive.getResponsive(context),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing:
          VariableBag.formContentSpacingVertical *
          Responsive.getResponsive(context),
      children: [
        //label for Test New Visit
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              'Test New Visit',
              fontWeight: FontWeight.w600,
              fontSize: 16 * Responsive.getResponsiveText(context),
            ),
            SvgPicture.asset(AppAssets.assetVector, fit: BoxFit.scaleDown),
          ],
        ),

        //dropdown for branch selection
        const NewTextField(
          label: 'branch',
          hintText: 'select',
          prefixIconPath: AppAssets.assetData,
          suffixIconPath: AppAssets.downArrow,
        ),

        // Media Picker container
        CustomMediaPickerContainer(
          title: 'Media',
          titleColor: AppTheme.getColor(context).onSurfaceVariant,
          titleFontSize: 16 * Responsive.getResponsiveText(context),
          imageTitle: 'select_media',
          containerHeight: 0.115 * Responsive.getHeight(context),
          multipleImage: 5,
          imagePath: AppAssets.galleryExport,
          isCameraShow: true,
          isGalleryShow: true,
          isDocumentShow: true,
          isCropImage: true,
          imageTitleSize: 14 * Responsive.getResponsiveText(context),
          imageTitleColor: AppTheme.getColor(context).onSurfaceVariant,
        ),

        // Text field for "Today's Work"
        const NewTextField(
          label: 'Today Work',
          hintText: 'type_here',
          prefixIconPath: AppAssets.assetDocumentText,
        ),
        SizedBox(height: 0.04 * Responsive.getHeight(context)),
        //submit button
        MyCoButton(
          boarderRadius:
              VariableBag.buttonBorderRadius *
              Responsive.getResponsive(context),
          isShadowBottomLeft: true,
          onTap: () {},
          title: 'submit',
        ),
      ],
    ),
  );
}
