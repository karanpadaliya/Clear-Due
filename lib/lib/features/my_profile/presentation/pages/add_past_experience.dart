import 'package:flutter/material.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';

class AddPastExperience extends StatelessWidget {
  const AddPastExperience({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: CustomAppbar(
        title: LanguageManager().get('edit_past_experience'),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal:
              VariableBag.screenHorizontalPadding *
              Responsive.getResponsive(context),
        ),
        child: Column(
          spacing: VariableBag.formContentSpacingVertical*Responsive.getResponsive(context),
          children: [
            const NewTextField(
              label: 'designation',
              hintText: 'type_here',
            ),
            const NewTextField(label: 'company_name',hintText: 'type_here',),
            const NewTextField(label: 'work_from',hintText: 'type_here',),
            const NewTextField(label: 'work_to',hintText: 'type_here',),
            const NewTextField(label: 'location',hintText: 'type_here',),
            const Spacer(),
            MyCoButton(onTap: () {

            }, title: 'send_change_req'),
            SizedBox(height: 0.015*Responsive.getHeight(context),)
          ],
        ),
      ),
    );
}
