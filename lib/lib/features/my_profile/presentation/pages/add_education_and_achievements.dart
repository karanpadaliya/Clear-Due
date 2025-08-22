import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/my_profile/domain/usecases/get_profile_data.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_bloc.dart';
import 'package:myco_flutter/features/my_profile/presentation/widgets/achievements_tab.dart';
import 'package:myco_flutter/features/my_profile/presentation/widgets/education_tab.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_myco_tabbar.dart';

class AddEducationAndAchievements extends StatefulWidget {
  const AddEducationAndAchievements({super.key});

  @override
  State<AddEducationAndAchievements> createState() =>
      _EmployeeAchivementsState();
}

class _EmployeeAchivementsState extends State<AddEducationAndAchievements> {
  var selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabBorderColor = selectIndex == 0
        ? AppColors.secondary
        : AppColors.primary;

    return BlocProvider(
      create: (context)=> MyProfileBloc(GetIt.I<GetProfileData>()),
      child: Scaffold(
        appBar: CustomAppbar(title: 'Add Achievements & Education'),
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal:
                VariableBag.screenHorizontalPadding *
                Responsive.getResponsive(context),
          ),
          child: Column(
            children: [
              ///Custom Tab Bar - for Tabs swithcing for Achievements and education
              MyCustomTabBar(
                tabs: ['Achievements', 'Education'],
                selectedBgColors: [
                  AppTheme.getColor(context).secondary,
                  AppTheme.getColor(context).primary,
                ],
                unselectedBorderAndTextColor: tabBorderColor,
                tabBarBorderColor: tabBorderColor,
                selectedIndex: selectIndex,
                onTabChange: (index) {
                  setState(() {
                    selectIndex = index;
                  });
                },
              ),
              SizedBox(height: 0.027 * Responsive.getHeight(context)),
      
              ///Pass EducationTab and AchievementTab
              Expanded(
                child: selectIndex == 0
                    ? AchievementsTab()
                    : EducationTab(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
