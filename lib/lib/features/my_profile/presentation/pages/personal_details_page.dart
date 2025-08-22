import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/profile_entity.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';

class PersonalDetailsPage extends StatelessWidget {
  final ProfileModelEntity profileModelEntity;
  const PersonalDetailsPage({required this.profileModelEntity, super.key});

  @override
  Widget build(BuildContext context) {
    String getHintText(TextEditingController controller) =>
        controller.text.isEmpty ? 'No Data Available!' : 'Type here';

    final PersonalEntity personalEntity =
        profileModelEntity.personal?.first ?? const PersonalEntity();

    final TextEditingController dobContoller = TextEditingController(
      text: personalEntity.memberDateOfBirth ?? '',
    );
    final TextEditingController bloodGroupController = TextEditingController(
      text: personalEntity.bloodGroup ?? '',
    );
    final TextEditingController genderController = TextEditingController(
      text: personalEntity.gender ?? '',
    );
    final TextEditingController meritalStatusContoller = TextEditingController(
      text: personalEntity.maritalStatus ?? '',
    );
    final TextEditingController noOfFamilyController = TextEditingController(
      text: personalEntity.totalFamilyMembers ?? '',
    );
    final TextEditingController nationalityController = TextEditingController(
      text: personalEntity.nationality ?? '',
    );
    final TextEditingController intrestController = TextEditingController(
      text: personalEntity.intrestHobbies ?? '',
    );
    final TextEditingController profSkillController = TextEditingController(
      text: personalEntity.professionalSkills ?? '',
    );

    final TextEditingController specSkillController = TextEditingController(
      text: personalEntity.specialSkills ?? '',
    );

    final TextEditingController langKnowController = TextEditingController(
      text: personalEntity.languageKnown ?? '',
    );

    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppbar(title: 'Personal Info'),

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
                  controller: dobContoller,
                  label: 'Date Of Birth',
                  hintText: getHintText(dobContoller),
                  prefix: SvgPicture.asset(AppAssets.noteFavorite1),
                ),
                NewTextField(
                  controller: bloodGroupController,
                  label: 'Blood Group',
                  hintText: getHintText(bloodGroupController),
                  prefix: SvgPicture.asset(AppAssets.bloodDrop),
                ),
                NewTextField(
                  controller: genderController,
                  label: 'Gender',
                  hintText: getHintText(genderController),
                  prefix: SvgPicture.asset(AppAssets.genderIcon),
                ),
                NewTextField(
                  controller: meritalStatusContoller,
                  label: 'Merital Status',
                  hintText: getHintText(meritalStatusContoller),
                  prefix: SvgPicture.asset(AppAssets.maritalStatus),
                ),
                NewTextField(
                  controller: noOfFamilyController,
                  label: 'No.of Family Members',
                  hintText: getHintText(noOfFamilyController),
                  prefix: SvgPicture.asset(AppAssets.noOfFamily),
                ),
                NewTextField(
                  controller: nationalityController,
                  label: 'Nationality',
                  hintText: getHintText(nationalityController),
                  prefix: SvgPicture.asset(AppAssets.personalEmail),
                ),
                NewTextField(
                  controller: intrestController,
                  label: 'Interest/Hobbies',
                  hintText: getHintText(intrestController),
                  prefix: SvgPicture.asset(AppAssets.interestIcon),
                ),
                NewTextField(
                  controller: profSkillController,
                  label: 'Professional Skills',
                  hintText: getHintText(profSkillController),
                  prefix: SvgPicture.asset(AppAssets.profSkill),
                ),
                NewTextField(
                  controller: specSkillController,
                  label: 'Special Skills',
                  hintText: getHintText(specSkillController),
                  prefix: SvgPicture.asset(AppAssets.specialSkill),
                ),
                NewTextField(
                  controller: langKnowController,
                  label: 'Language Known',
                  hintText: getHintText(langKnowController),
                  prefix: SvgPicture.asset(AppAssets.langKnown),
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
