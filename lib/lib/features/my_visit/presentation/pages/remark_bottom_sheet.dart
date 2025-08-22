import 'package:flutter/material.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/lost_and_found/presentation/widgets/custom_radio_button.dart';
import 'package:myco_flutter/features/my_visit/presentation/pages/test_new_visit1.dart';
import 'package:myco_flutter/widgets/custom_checkbox.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';
import 'package:myco_flutter/widgets/media_picker/widgets/custom_media_picker_container.dart';

class RemarkBottomSheet extends StatelessWidget {
  const RemarkBottomSheet({
    super.key,
    this.selectedVisitTime,
    this.selectedVisitDate,
  });

  final String selectedGender = '';

  final String? selectedVisitTime;

  final String? selectedVisitDate;

  final bool autoStartVisit = false;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.only(
        left:
            VariableBag.bottomSheetLeftPadding *
            Responsive.getResponsive(context),
        right:
            VariableBag.bottomSheetRightPadding *
            Responsive.getResponsive(context),
        top:
            VariableBag.bottomSheetTopPadding *
            Responsive.getResponsive(context),
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
          // Remark text field
          const NewTextField(
            label: 'remark',
            hintText: 'type_here',
            prefixIconPath: AppAssets.assetMessageEdit,
          ),

          //  widget Follow-up time and date selection
          Row(
            children: [
              const Expanded(
                child: NewTextField(
                  label: 'follow_up_visit_time',
                  hintText: 'select',
                  prefixIconPath: AppAssets.assetClock,
                  suffixIconPath: AppAssets.downArrow,
                ),
              ),

              SizedBox(
                width:
                    VariableBag.textFieldRowGap *
                    Responsive.getResponsive(context),
              ), // spacing between dropdowns
              const Expanded(
                child: NewTextField(
                  label: 'Follow Up Visit Date',
                  hintText: 'select',
                  prefixIconPath: AppAssets.assetNoteFavorite,
                  suffixIconPath: AppAssets.downArrow,
                ),
              ),
            ],
          ),

          CustomRadioButton(
            options: const ['Field Visit', 'Virtual Visit'],
            onChanged: (_) {},
            height: 0.065 * Responsive.getHeight(context),
          ),

          // Textfield for Visit Area
          const NewTextField(
            label: 'visit_area',
            hintText: 'type_here',
            prefixIconPath: AppAssets.assetArrowSquare,
          ),

          //TextField for Visit Catalogue
          const NewTextField(
            label: 'visit_catalogue',
            hintText: 'type_here',
            prefixIconPath: AppAssets.assetNoteFavorite,
          ),

          //Textfield for Contact Person Name
          const NewTextField(
            label: 'Visit Contact Person Name',
            hintText: 'type_here',
            prefixIconPath: AppAssets.assetProfileCircle,
          ),

          // label for Attachment
          CustomMediaPickerContainer(
            title: 'attachment',
            titleColor: AppTheme.getColor(context).onSurfaceVariant,
            titleFontSize: 16 * Responsive.getResponsiveText(context),
            imageTitle: 'select_attachment',
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

          SizedBox(height: 0.05 * Responsive.getHeight(context)),

          // Checkbox for "Order Placed?"
          Row(
            spacing: 8 * Responsive.getResponsive(context),
            children: [
              CustomCheckbox(
                value: autoStartVisit,
                onChanged: (value) => {},
                borderColor: AppTheme.getColor(context).onSurface,
                activeColor: AppTheme.getColor(context).primary,
                checkColor: AppTheme.getColor(context).onPrimary,
                height: 0.02 * Responsive.getHeight(context),
                width: 0.042 * Responsive.getWidth(context),
                unCheckedBackground: AppTheme.getColor(context).onSecondary,
              ),
              const CustomText('Order Placed ?'),
            ],
          ),

          // Buttons Close & End Visit
          Row(
            children: [
              MyCoButton(
                onTap: () => Navigator.pop(context),
                title: 'CLOSE',
                textStyle: TextStyle(
                  color: AppTheme.getColor(context).primary,
                  fontWeight: FontWeight.bold,
                ),
                backgroundColor: AppColors.transparent,
                boarderRadius:
                    VariableBag.buttonBorderRadius *
                    Responsive.getResponsive(context),
                width: 0.41 * Responsive.getWidth(context),
                height: 0.06 * Responsive.getHeight(context),
                borderColor: AppTheme.getColor(context).primary,
              ),
              SizedBox(
                width:
                    VariableBag.buttonRowSpacing *
                    Responsive.getResponsive(context),
              ),
              MyCoButton(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                          16 * Responsive.getResponsive(context),
                        ),
                      ),
                    ),
                    builder: (context) => const TestNewVisit1(),
                  );
                },
                title: 'END VISIT',
                textStyle: TextStyle(
                  color: AppTheme.getColor(context).onPrimary,
                  fontWeight: FontWeight.bold,
                ),
                backgroundColor: AppTheme.getColor(context).primary,
                boarderRadius:
                    VariableBag.buttonBorderRadius *
                    Responsive.getResponsive(context),
                width: 0.41 * Responsive.getWidth(context),
                height: 0.06 * Responsive.getHeight(context),
                wantBorder: false,
                isShadowBottomLeft: true,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
