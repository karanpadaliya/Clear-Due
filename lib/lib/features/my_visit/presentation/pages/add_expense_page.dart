import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/lost_and_found/presentation/widgets/custom_radio_button.dart';
import 'package:myco_flutter/features/my_visit/presentation/pages/remark_bottom_sheet.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';
import 'package:myco_flutter/widgets/media_picker/widgets/custom_media_picker_container.dart';

class AddExpensePage extends StatelessWidget {
   const AddExpensePage({super.key, this.selectedExpenseType, this.selectedSiteType});

  final String? selectedExpenseType;

  final String? selectedSiteType;

  final String selectedGender = '';

  final bool selectedValue = true;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const CustomAppbar(title: 'add_expense', isKey: true),
    body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              VariableBag.screenHorizontalPadding *
              Responsive.getResponsive(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing:
              VariableBag.formContentSpacingVertical *
              Responsive.getResponsive(context),
          children: [
            // Text field for entering expense title
            const NewTextField(
              label: 'title',
              hintText: 'type_here',
              prefixIconPath: AppAssets.assetBookmark,
            ),

            // Date picker for selecting Date of Birth
            NewTextField(
              label: 'date_of_birth',
              hintText:'select_date',
              prefixIconPath: AppAssets.assetNoteFavorite,
              onTap: () {},
            ),

            // Dropdown for selecting expense type
            const NewTextField(
              label: 'select_expense',
              prefixIconPath: AppAssets.assetCard_Edit,
              suffixIconPath: AppAssets.downArrow,
              hintText:'select',
            ),

            // Dropdown for selecting site
            const NewTextField(
              label: 'site',
              hintText:'select',
              prefixIconPath: AppAssets.assetGlobal,
              suffixIconPath: AppAssets.downArrow,
            ),

            // Text area for entering a detailed description
            const NewTextField(
              label: 'description',
              hintText: 'enter_description',
              prefixIconPath: AppAssets.assetStickyNote,
              maxLines: 5,
            ),

            // label for Attachment and Add More
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  'attachment',
                  fontWeight: FontWeight.w700,
                  color: AppTheme.getColor(context).onSurfaceVariant,
                  fontSize: 14 * Responsive.getResponsiveText(context),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.assetAddCircle,
                      fit: BoxFit.scaleDown,
                    ),

                    SizedBox(width: 0.01 * Responsive.getWidth(context)),

                    CustomText(
                      'add_more',
                      fontSize: 14 * Responsive.getResponsiveText(context),
                    ),
                  ],
                ),
              ],
            ),

            CustomMediaPickerContainer(
              titleColor: AppTheme.getColor(context).onSurfaceVariant,
              titleFontSize: 16 * Responsive.getResponsiveText(context),
              imageTitle: 'select_attachment',
              containerHeight: 0.115 * Responsive.getHeight(context),
              multipleImage: 5,
              imagePath: AppAssets.assetBookmark_2,
              isCameraShow: true,
              isGalleryShow: true,
              isDocumentShow: true,
              isCropImage: true,
              imageTitleSize: 14 * Responsive.getResponsiveText(context),
              imageTitleColor: AppTheme.getColor(context).onSurfaceVariant,
            ),
            //Radio buttons to select if the invoice includes GST
            CustomRadioButton(
              options: [
                LanguageManager().get('yes'),
                LanguageManager().get('no'),
              ],
              onChanged: (_) {},
              height: 0.055 * Responsive.getHeight(context),
              title: 'Is GST Invoice',
            ),

            SizedBox(height: 0.05 * Responsive.getHeight(context)),

            //submit button
            MyCoButton(
              title: 'submit',
              boarderRadius:
                  VariableBag.buttonBorderRadius *
                  Responsive.getResponsive(context),
              isShadowBottomLeft: true,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  showDragHandle: true,
                  builder: (context) => const RemarkBottomSheet(),
                );
              },
            ),

            SizedBox(height: 0.03 * Responsive.getHeight(context)),
          ],
        ),
      ),
    ),
  );
}
