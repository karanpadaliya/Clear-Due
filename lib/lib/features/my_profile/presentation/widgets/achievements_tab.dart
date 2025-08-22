import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_bloc.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_event.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_state.dart';
import 'package:myco_flutter/widgets/custom_loader.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';

class AchievementsTab extends StatelessWidget {
  AchievementsTab({super.key});

  TextEditingController achievementNameController = TextEditingController();
  TextEditingController achievementDateController = TextEditingController();
  TextEditingController achievementFromController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
    body: BlocConsumer<MyProfileBloc, MyProfileState>(
      listener: (context, state) {

        if (state is AddAchievementSuccessState) {
          // 1. Safely get the message from the response map
          final message = state.responseData['message'] as String?;

          // 2. Add the condition to check the specific message
          if (message == 'Acheivement change request has been sent to HR.') {
            // 3. Show the toast (SnackBar) only if the condition is true
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Acheivement change request has been sent to HR.'),
                backgroundColor: Colors.green,
              ),
            );
          }

          // You can perform other actions for any successful response here.
          // For example, clearing the text fields.
          achievementNameController.clear();
          achievementFromController.clear();
          achievementDateController.clear();

          // If you wanted to navigate back, you could add it here:
          // Navigator.of(context).pop();

        }

        if (state is FetchProfileDataErrorState) {
          // ❌ Failure! Show an error message
          context.pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {

        return Column(
          spacing:
              VariableBag.formContentSpacingVertical *
              Responsive.getResponsive(context),
          children: [
            NewTextField(
              controller: achievementNameController,
              label: 'Achievement Name',
              hintText: 'Type here',
              prefix: SvgPicture.asset(AppAssets.specialSkill),
            ),

            NewTextField(
              controller: achievementDateController,
              label: 'Achievement Date',
              hintText: 'Type here',
              prefix: SvgPicture.asset(AppAssets.noteFavorite1),
            ),

            NewTextField(
              controller: achievementFromController,
              label: 'Achievement From',
              hintText: 'Type here',
              prefix: SvgPicture.asset(AppAssets.specialSkill),
            ),
            SizedBox(height: 0.33 * Responsive.getHeight(context)),

            MyCoButton(
              onTap: () {
                CustomLoader();
                context.read<MyProfileBloc>().add(
                  AddAchievementDataEvent(
                    achievementName: achievementNameController.text,
                    achievementDate: achievementDateController.text,
                    achievementFrom: achievementFromController.text,
                  ),
                );
              },
              title: 'SEND ADD REQUEST',
              boarderRadius:
                  VariableBag.buttonBorderRadius *
                  Responsive.getResponsive(context),
            ),
          ],
        );
      },
    ),
  );
}
