import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/achievement_education_entity.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_bloc.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_state.dart';
import 'package:myco_flutter/features/my_profile/presentation/widgets/achievement_education_shimmer.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_no_data_widget.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_vertical_stepper.dart';

class EducationAchievmentsPage extends StatelessWidget {
  const EducationAchievmentsPage({super.key});

  List<StepData> _buildAchievementSteps(
    List<AchievementEntity>? achievements,
  ) =>
      achievements
          ?.map(
            (achievement) => StepData(
              title: achievement.achievementName.toString(),
              status: StepStatus.completed,
              isStepIconShow: false,
              details: [
                StepDetail(
                  title: 'Institute',
                  description:
                      achievement.universityBoardName?.toString() ?? 'N/A',
                ),
                StepDetail(
                  title: 'Date',
                  description: achievement.achievementDate?.toString() ?? 'N/A',
                ),
              ],
            ),
          )
          .toList() ??
      [];

  List<StepData> _buildEducationSteps(List<AchievementEntity>? educationList) =>
      educationList
          ?.map(
            (education) => StepData(
              title: education.achievementName?.toString() ?? 'N/A',
              status: StepStatus.completed,
              isStepIconShow: false,
              details: [
                StepDetail(
                  title: 'Institute',
                  description:
                      education.universityBoardName?.toString() ?? 'N/A',
                ),
                StepDetail(
                  title: 'Date',
                  description: education.achievementDate?.toString() ?? 'N/A',
                ),
              ],
            ),
          )
          .toList() ??
      [];

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      appBar: CustomAppbar(
        title: LanguageManager().get('achievements_education'),
        isKey: true,
      ),
      body: BlocBuilder<MyProfileBloc, MyProfileState>(
        builder: (context, state) {
          if (state is FetchAchievementEducationDataLoadingState) {
            return const AchievementEducationShimmer();
          }
          if (state is FetchProfileDataErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppAssets.employees),
                  const SizedBox(height: 10),
                  CustomText(
                    state.errorMessage,
                    textAlign: TextAlign.center,
                    fontSize: 16 * Responsive.getResponsiveText(context),
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            );
          }
          if (state is FetchAchievementEducationDataSuccessState) {
            final achievementSteps = _buildAchievementSteps(
              state.achievementEducationEntity.achievement,
            );
            final educationSteps = _buildEducationSteps(
              state.achievementEducationEntity.education,
            );

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal:
                      VariableBag.screenHorizontalPadding *
                      Responsive.getResponsive(context),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      LanguageManager().get('achievements'),
                      fontWeight: FontWeight.w700,
                    ),
                    achievementSteps.isNotEmpty
                        ? CustomVerticalStepper(steps: achievementSteps)
                        : Center(
                            child: CustomNoDataWidget(
                              message: LanguageManager().get('no_data_available_web'),
                              assetPath: AppAssets.achiementNodata,
                            ),
                          ),

                    CustomText(
                      LanguageManager().get('education'),
                      fontWeight: FontWeight.w700,
                    ),
                    educationSteps.isNotEmpty
                        ? CustomVerticalStepper(steps: educationSteps)
                        : Center(
                            child: CustomNoDataWidget(
                              message: LanguageManager().get('no_data_available_web'),
                              assetPath: AppAssets.educationNodata,
                            ),
                          ),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: CustomText(
              LanguageManager().get('something_went_wrong_please_try_again_later'),
              isKey: true,
              color: AppTheme.getColor(context).error,
              fontSize: 16 * Responsive.getResponsiveText(context),
            ),
          );
        },
      ),

      ///Add Education and Achievement details Icon
      floatingActionButton: MyCoButton(
        isShadowBottomLeft: true,
        onTap: () {
          context.push('/add_acheivement_education');
        },
        height: 0.080 * Responsive.getHeight(context),
        width: 0.080 * Responsive.getHeight(context),
        title: '',
        boarderRadius: VariableBag.buttonBorderRadius,
        image: Icon(
          Icons.add,
          color: AppTheme.getColor(context).onPrimary,
          size: 50,
        ),
      ),
    );
  }
}
