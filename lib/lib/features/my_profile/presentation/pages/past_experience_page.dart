import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/past_experience_entity.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_bloc.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_state.dart';
import 'package:myco_flutter/features/my_profile/presentation/widgets/past_experience_page_shimmer.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_no_data_widget.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_vertical_stepper.dart';

class PastExperiencePage extends StatelessWidget {
  const PastExperiencePage({super.key});

  List<StepData> _buildAchievementSteps(
      List<ExperienceItemEntity>? experienceItems,
      ) =>
      experienceItems
          ?.map(
            (experience) => StepData(
          title: experience.designation.toString(),
          status: StepStatus.completed,
          isStepIconShow: false,
          details: [
            StepDetail(
              title: 'Work From',
              description:
              experience.workFrom?.toString() ?? 'N/A',
            ),
            StepDetail(
              title: 'Company Location',
              description: experience.companyLocation.toString() ?? 'N/A',
            ),
            StepDetail(
              title: 'Company Name',
              description: experience.expCompanyName.toString() ?? 'N/A',
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
      appBar: CustomAppbar(title: LanguageManager().get("past_experience"),),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              VariableBag.screenHorizontalPadding *
              Responsive.getResponsive(context),
        ),
        child: BlocBuilder<MyProfileBloc, MyProfileState>(
          builder: (context, state) {
            if (state is FetchPastExperienceDataLoadingState) {
              return const PastExperienceShimmer();
            }
            if (state is FetchProfileDataErrorState) {
              return Center(child: CustomText(state.errorMessage));
            }
            if (state is FetchPastExperienceDataSuccessState) {
              final PastExperienceEntity pastExperienceEntity = state.pastExperienceEntity;
              if (pastExperienceEntity.experience == null ||
                  pastExperienceEntity.experience!.isEmpty) {
                return Center(
                  child: CustomNoDataWidget(
                    message: LanguageManager().get('no_data_available_web'),
                  ),
                );
              }
              final experienceItems = _buildAchievementSteps(state.pastExperienceEntity.experience);
              return CustomVerticalStepper(
                steps: experienceItems,
              );
            }
            return Center(
              child: CustomText(
                LanguageManager().get('something_went_wrong_please_try_again_later'),
                isKey: true,
                fontSize: 16 * Responsive.getResponsiveText(context),
              ),
            );
          },
        ),
      ),
    );
  }
}
