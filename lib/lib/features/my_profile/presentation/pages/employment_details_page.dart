import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/profile_entity.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';

class EmploymentDetailsPage extends StatelessWidget {
  final ProfileModelEntity profileModelEntity;

  const EmploymentDetailsPage({required this.profileModelEntity, super.key});

  @override
  Widget build(BuildContext context) {
    String getHintText(TextEditingController controller) =>
        controller.text.isEmpty ? 'No Data Available!' : 'Type here';

    final EmployeementSkillEntity employeementSkillEntity =
        profileModelEntity.employeementSkills?.first ??
        const EmployeementSkillEntity();

    final TextEditingController empDesignationController =
        TextEditingController(text: employeementSkillEntity.designation ?? '');
    final TextEditingController empIdController = TextEditingController(
      text: employeementSkillEntity.employeeId ?? '',
    );
    final TextEditingController empTypeController = TextEditingController(
      text: employeementSkillEntity.employmentType ?? '',
    );
    final TextEditingController joinDateController = TextEditingController(
      text: employeementSkillEntity.joiningDateView ?? '',
    );
    final TextEditingController probEndDate = TextEditingController(
      text: employeementSkillEntity.probationPeriodEndDate ?? '',
    );
    final TextEditingController totalExpController = TextEditingController(
      text: employeementSkillEntity.totalExperience ?? '',
    );
    final TextEditingController expController = TextEditingController(
      text: employeementSkillEntity.companyExperience ?? '',
    );
    final TextEditingController insuranceComNameController =
        TextEditingController(
          text: employeementSkillEntity.insuranceCompanyName ?? '',
        );

    final TextEditingController insuranceNumController = TextEditingController(
      text: employeementSkillEntity.insuranceNumber ?? '',
    );

    final TextEditingController insuranceExpiryDateController =
        TextEditingController(
          text: employeementSkillEntity.insuranceExpireDate ?? '',
        );

    final TextEditingController jobDescController = TextEditingController(
      text: profileModelEntity.jobDescription ?? '',
    );

    final TextEditingController userJobDescController = TextEditingController(
      text: profileModelEntity.userJobDescription ?? '',
    );

    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppbar(title: 'Employment Info'),

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
                  controller: empDesignationController,
                  label: 'Designation',
                  hintText: getHintText(empDesignationController),

                  prefix: SvgPicture.asset(AppAssets.employeeIcon),
                ),
                NewTextField(
                  controller: empIdController,
                  label: 'Employee Id',
                  hintText: getHintText(empIdController),
                  prefix: SvgPicture.asset(AppAssets.employeeIdCard),
                ),
                NewTextField(
                  controller: empTypeController,
                  label: 'Employment Type',
                  hintText: getHintText(empTypeController),
                  prefix: SvgPicture.asset(AppAssets.userSearch),
                ),
                NewTextField(
                  controller: joinDateController,
                  label: 'Joining Date',
                  hintText: getHintText(joinDateController),
                  prefix: SvgPicture.asset(AppAssets.noteFavorite1),
                ),
                NewTextField(
                  controller: probEndDate,
                  label: 'Probation End Date',
                  hintText: getHintText(probEndDate),
                  prefix: SvgPicture.asset(AppAssets.brifecaseTimer),
                ),
                NewTextField(
                  controller: totalExpController,
                  label: 'Total Experience',
                  hintText: getHintText(totalExpController),
                  prefix: SvgPicture.asset(AppAssets.favoriteChart),
                ),
                NewTextField(
                  controller: expController,
                  label: 'Experience',
                  hintText: getHintText(expController),
                  prefix: SvgPicture.asset(AppAssets.activityIcon),
                ),
                NewTextField(
                  controller: insuranceComNameController,
                  label: 'Insurance Company Name',
                  hintText: getHintText(insuranceComNameController),
                  prefix: SvgPicture.asset(AppAssets.buidingIcon),
                ),
                NewTextField(
                  controller: insuranceNumController,
                  label: 'Insurance Number',
                  hintText: getHintText(insuranceNumController),
                  prefix: SvgPicture.asset(AppAssets.callIcon),
                ),
                NewTextField(
                  controller: insuranceExpiryDateController,
                  label: 'Insurance Expiry Date',
                  hintText: getHintText(insuranceExpiryDateController),
                  prefix: SvgPicture.asset(AppAssets.calendarRemove),
                ),
                NewTextField(
                  controller: jobDescController,
                  label: 'Job Desctiption',
                  hintText: getHintText(jobDescController),
                  prefix: SvgPicture.asset(AppAssets.briefcaseIcon),
                ),
                NewTextField(
                  controller: userJobDescController,
                  label: 'User Job Description',
                  hintText: getHintText(userJobDescController),
                  prefix: SvgPicture.asset(AppAssets.noteText),
                ),
                Container(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
