import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/features/my_profile/data/models/request/get_activity_request_model.dart';
import 'package:myco_flutter/features/my_profile/domain/usecases/get_profile_data.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_bloc.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_event.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_state.dart';
import 'package:myco_flutter/features/my_profile/presentation/widgets/my_activities_card.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:shimmer/shimmer.dart';

class MyActivitiesPage extends StatefulWidget {
  const MyActivitiesPage({super.key});

  @override
  State<MyActivitiesPage> createState() => _MyActivitiesCardState();
}

class _MyActivitiesCardState extends State<MyActivitiesPage> {
  final useCase = GetIt.I<GetProfileData>();

  @override
  void initState() {
    super.initState();
    _fetchGetActivity();
  }

  Future<void> _fetchGetActivity() async {
    final preferenceManager = GetIt.I<PreferenceManager>();
    final companyId = await preferenceManager.getCompanyId();
    final userId = await preferenceManager.getUserId();
    final languageId = await preferenceManager.getLanguageId();

    if (userId != null && companyId != null) {
      final request = GetActivityRequestModel(
        getActivity: 'getAcitivity',
        companyId: companyId,
        userId: userId,
        languageId: languageId,
      );
      context.read<MyProfileBloc>().add(FetchGetActivityEvent(request));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const CustomAppbar(isKey: true, title: 'my_activities'),
    body: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: VariableBag.screenHorizontalPadding,
      ),
      child: SingleChildScrollView(
        child: BlocBuilder<MyProfileBloc, MyProfileState>(
          builder: (context, state) {
            if (state is InitialMyProfileState ||
                state is FetchProfileDataLoadingState) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 6,
                  itemBuilder: (_, __) => Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppTheme.getColor(context).onPrimary,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
              );
            } else if (state is GetActivityLoadedState) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.entity.logname?.length,
                itemBuilder: (context, index) {
                  final activity = state.entity.logname?[index];
                  return MyActivitiesCard(
                    iconUrl: activity?.logImage?.toString() ?? '',
                    title: activity?.logName?.toString() ?? '',
                    subtitle: activity?.logTime?.toString() ?? '',
                  );
                },
              );
            } else if (state is FetchProfileDataErrorState) {
              return Center(
                child: CustomText(
                  state.errorMessage,
                  color: AppTheme.getColor(context).error,
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    ),
  );
}
