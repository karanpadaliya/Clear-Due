import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_myco_tabbar.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';
import 'package:myco_flutter/widgets/media_picker/widgets/custom_media_picker_container.dart';

class AddNewSupportTicket extends StatelessWidget {
  const AddNewSupportTicket({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> appointments = ['Add New', 'History'];
    final selectedIndex = 0;
    return Scaffold(
      appBar: const CustomAppbar(isKey: true, title: 'add_new_support_ticket'),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              VariableBag.screenHorizontalPadding *
              Responsive.getResponsive(context),
        ),
        child: Column(
          spacing: 12,
          children: [
            MyCustomTabBar(
              tabs: appointments,
              selectedBgColors: [
                AppTheme.getColor(context).secondary,
                AppTheme.getColor(context).primary,
              ],
              unselectedBorderAndTextColor: AppTheme.getColor(
                context,
              ).secondary,
              tabBarBorderColor: AppTheme.getColor(context).primary,
              isShadowBottomLeft: true,
              selectedIndex: selectedIndex,
              onTabChange: (index) {
                // context.read<TabbarBloc>().add(
                //   TabChangeEvent(index: index),
                // );
              },
            ),

            NewTextField(
              hintText: LanguageManager().get('+91 9909945983'),
              prefixIconPath: AppAssets.callCalling.toString(),
              isKey: true,
              enabled: false,
            ),

            NewTextField(
              hintText: LanguageManager().get('Contact@my-company.app'),
              prefixIconPath: AppAssets.companyEmail.toString(),
              isKey: true,
              enabled: false,
            ),


            NewTextField(
              hintText: LanguageManager().get('www.my-company.app'),
              prefixIconPath: AppAssets.globalSvg.toString(),
              isKey: true,
              enabled: false,
            ),

            NewTextField(
              isKey: true,
              label: LanguageManager().get('subject'),
              hintText: LanguageManager().get('type_here'),
              prefixIconPath: AppAssets.cardEdit.toString(),
              // controller: placeController,
              // formFieldKey: _placeFieldKey,
              enabled: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a place';
                }
                return null;
              },
            ),

            NewTextField(
              hintText: LanguageManager().get('enter_description'),
              label: 'Reason',
              enabled: true,
              maxLines: 5,
              minLines: 1,
              isRequired: true,

              prefixIconPath: AppAssets.assetStickyNote.toString(),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a reason';
                }
                return null;
              },
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
          ],
        ),
      ),
    );
  }
}
