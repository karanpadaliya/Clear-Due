import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';

class EducationTab extends StatelessWidget {
  EducationTab({super.key});

  TextEditingController degreeController = TextEditingController();
  TextEditingController passingYearController = TextEditingController();
  TextEditingController universityController = TextEditingController();


  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(
      spacing:
          VariableBag.formContentSpacingVertical *
          Responsive.getResponsive(context),
      children: [
        NewTextField(
          label: 'Degree',
          hintText: 'Type here',
          prefix: SvgPicture.asset(AppAssets.degreeIcon),
        ),
        NewTextField(
          label: 'Passing Year',
          hintText: 'Type here',
          prefix: SvgPicture.asset(AppAssets.noteFavorite1),
        ),
        NewTextField(
          label: 'University/College/School',
          hintText: 'Type here',
          prefix: SvgPicture.asset(AppAssets.instuteType),
        ),
        SizedBox(height: 0.36 * Responsive.getHeight(context)),
        MyCoButton(
          onTap: () {},
          isShadowBottomLeft: true,
          title: 'SEND ADD REQUEST',
          boarderRadius:
              VariableBag.buttonBorderRadius *
              Responsive.getResponsive(context),
        ),
      ],
    ),
  );
}
