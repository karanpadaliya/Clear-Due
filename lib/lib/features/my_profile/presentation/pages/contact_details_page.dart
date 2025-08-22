import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/profile_entity.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';

class ContactDetailsPage extends StatelessWidget {
  final ProfileModelEntity profileModelEntity;
  const ContactDetailsPage({required this.profileModelEntity, super.key});

  @override
  Widget build(BuildContext context) {
    String getHintText(TextEditingController controller) =>
        controller.text.isEmpty ? 'No Data Available!' : 'Type here';

    final ContactEntity contactEntity =
        profileModelEntity.contact?.first ?? const ContactEntity();

    final TextEditingController callController = TextEditingController(
      text: contactEntity.userMobile ?? '',
    );
    final TextEditingController alternateController = TextEditingController(
      text: contactEntity.altMobile ?? '',
    );
    final TextEditingController emergencyController = TextEditingController(
      text: contactEntity.emergencyNumber ?? '',
    );
    final TextEditingController whatsappController = TextEditingController(
      text: contactEntity.whatsappNumber ?? '',
    );
    final TextEditingController companyMailController = TextEditingController(
      text: contactEntity.userEmail ?? '',
    );
    final TextEditingController personalMailController = TextEditingController(
      text: contactEntity.personalEmail ?? '',
    );
    final TextEditingController currentAddController = TextEditingController(
      text: contactEntity.currentAddress ?? '',
    );
    final TextEditingController permanentAddController = TextEditingController(
      text: contactEntity.permanentAddress ?? '',
    );

    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppbar(title: 'Contact Details'),

        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal:
                VariableBag.screenHorizontalPadding *
                Responsive.getResponsive(context),
          ),
          child: SingleChildScrollView(
            child: Column(
              spacing:
                  VariableBag.formContentSpacingVertical *
                  Responsive.getResponsive(context),
              mainAxisSize: MainAxisSize.min,
              children: [
                NewTextField(
                  controller: callController,
                  label: 'Contact',
                  hintText: getHintText(callController),
                  prefix: SvgPicture.asset(AppAssets.callCaling),
                ),
                NewTextField(
                  controller: alternateController,
                  label: 'Alternate',
                  hintText: getHintText(alternateController),
                  prefix: SvgPicture.asset(AppAssets.alternateCaling),
                ),
                NewTextField(
                  controller: emergencyController,
                  label: 'Emergency',
                  hintText: getHintText(emergencyController),
                  prefix: SvgPicture.asset(AppAssets.emergencyCaling),
                ),
                NewTextField(
                  controller: whatsappController,
                  label: 'WhatsApp',
                  hintText: getHintText(whatsappController),
                  prefix: SvgPicture.asset(AppAssets.whatsapp),
                ),
                NewTextField(
                  controller: companyMailController,
                  label: 'Company Email',
                  hintText: getHintText(companyMailController),
                  prefix: SvgPicture.asset(AppAssets.companyEmail),
                ),
                NewTextField(
                  controller: personalMailController,
                  label: 'Personal Email',
                  hintText: getHintText(personalMailController),
                  prefix: SvgPicture.asset(AppAssets.personalEmail),
                ),
                NewTextField(
                  controller: currentAddController,
                  label: 'Current Address',
                  hintText: getHintText(currentAddController),
                  prefix: SvgPicture.asset(AppAssets.currentAddress),
                ),
                NewTextField(
                  controller: permanentAddController,
                  label: 'Permanent Address',
                  hintText: getHintText(permanentAddController),
                  prefix: SvgPicture.asset(AppAssets.homeAddress),
                ),
                Container(height: 30),
              ],
            ),
          ),
        ),
        floatingActionButton: MyCoButton(
          width: 0.080 * Responsive.getHeight(context),
          height: 0.080 * Responsive.getHeight(context),
          onTap: () {},
          title: '',
          image: SvgPicture.asset(AppAssets.editIcon),
          boarderRadius: VariableBag.buttonBorderRadius,
        ),
      ),
    );
  }
}
