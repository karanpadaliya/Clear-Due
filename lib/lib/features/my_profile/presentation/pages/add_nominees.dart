import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';

class AddNominees extends StatelessWidget {
  const AddNominees({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const CustomAppbar(title: 'Add Nominee Details'),
    body: Container(
      padding: EdgeInsets.symmetric(
        horizontal:
            VariableBag.screenHorizontalPadding *
            Responsive.getResponsive(context),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing:
              VariableBag.formContentSpacingVertical *
              Responsive.getResponsive(context),
          children: [
            NewTextField(
              label: 'Nomination For',
              prefix: SvgPicture.asset(AppAssets.noOfFamily),
              hintText: 'Select',
            ),
            NewTextField(
              label: 'Nominee Name',
              prefix: SvgPicture.asset(AppAssets.userSquare),
              hintText: 'Select',
            ),
            NewTextField(
              label: 'Nominee Relation',
              prefix: SvgPicture.asset(AppAssets.noOfFamily),
              hintText: 'Select',
            ),
            NewTextField(
              label: 'Aadhar Number',
              prefix: SvgPicture.asset(AppAssets.cardIcon),
              hintText: 'Select',
            ),
            NewTextField(
              label: LanguageManager().get('email_address'),
              prefix: SvgPicture.asset(AppAssets.companyEmail),
              hintText: 'Select',
            ),
            NewTextField(
              label: LanguageManager().get('address'),
              prefix: SvgPicture.asset(AppAssets.home),
              hintText: 'Select',
            ),
            NewTextField(
              label: 'Percentage(Available Percentage : 0.00)',
              prefix: SvgPicture.asset(AppAssets.percentageSqr),
              hintText: 'Select',
            ),

            SizedBox(height: 0.002 * Responsive.getHeight(context)),
            MyCoButton(
              onTap: () {},
              isShadowBottomLeft: true,
              title: LanguageManager().get('submit'),
              boarderRadius:
                  VariableBag.buttonBorderRadius *
                  Responsive.getResponsive(context),
            ),
            SizedBox(height: 0.011 * Responsive.getHeight(context)),
          ],
        ),
      ),
    ),
  );
}
