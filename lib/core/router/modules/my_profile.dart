import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/features/my_profile/data/models/other_profile_args_model.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/profile_entity.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_bloc.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_event.dart';
import 'package:myco_flutter/features/my_profile/presentation/pages/add_education_and_achievements.dart';
import 'package:myco_flutter/features/my_profile/presentation/pages/add_new_support_ticket.dart';
import 'package:myco_flutter/features/my_profile/presentation/pages/add_nominees.dart';
import 'package:myco_flutter/features/my_profile/presentation/pages/add_past_experience.dart';
import 'package:myco_flutter/features/my_profile/presentation/pages/app_support.dart';
import 'package:myco_flutter/features/my_profile/presentation/pages/community_post_page.dart';
import 'package:myco_flutter/features/my_profile/presentation/pages/contact_details_page.dart';
import 'package:myco_flutter/features/my_profile/presentation/pages/education_achievments_page.dart';
import 'package:myco_flutter/features/my_profile/presentation/pages/employment_details_page.dart';
import 'package:myco_flutter/features/my_profile/presentation/pages/my_activities_page.dart';
import 'package:myco_flutter/features/my_profile/presentation/pages/my_profile_page.dart';
import 'package:myco_flutter/features/my_profile/presentation/pages/nominee_details_page.dart';
import 'package:myco_flutter/features/my_profile/presentation/pages/notification_sound_setting_page.dart';
import 'package:myco_flutter/features/my_profile/presentation/pages/other_profile_page.dart';
import 'package:myco_flutter/features/my_profile/presentation/pages/past_experience_page.dart';
import 'package:myco_flutter/features/my_profile/presentation/pages/personal_details_page.dart';
import 'package:myco_flutter/features/my_profile/presentation/pages/shift_details_page.dart';

List<RouteBase> myProfileRoutes = [
  GoRoute(
    path: RoutePaths.myProfile,
    name: 'my-profile',
    builder: (context, state) => BlocProvider(
      create: (context) =>
          GetIt.I<MyProfileBloc>()..add(const GetProfileDataEvent()),
      child: const MyProfilePage(),
    ),
  ),

  GoRoute(
    path: RoutePaths.communityPostPage,
    name: 'community-post-page',
    builder: (context, state) => const CommunityPostPage(),
  ),

  GoRoute(
    path: RoutePaths.otherProfile,
    name: 'other-profile',
    builder: (context, state) {
      // Extract the strongly-typed object from 'extra'
      final args = state.extra as OtherProfilePageArgs;

      return BlocProvider(
        create: (context) => GetIt.I<MyProfileBloc>()
          ..add(
            GetOtherProfileDataEvent(
              userId: args.userId,
              societyId: args.societyId,
              unitId: args.unitId,
              blockId: args.blockId,
              floorId: args.floorId,
              myUserId: args.myUserId,
              myProfile: args.myProfile,
              otherUserBlockId: args.otherUserBlockId,
              otherUserFloorId: args.otherUserFloorId,
            ),
          ),
        child: const OtherProfilePage(),
      );
    },
  ),

  GoRoute(
    path: RoutePaths.achievementAndEducatioin,
    name: 'achievements_education',
    builder: (context, state) => BlocProvider(
      create: (context) =>
          GetIt.I<MyProfileBloc>()..add(FetchAchievementEducationEvent()),
      child: EducationAchievmentsPage(),
    ),
  ),

  GoRoute(
    path: RoutePaths.myContactDetails,
    name: 'contact_detail',
    builder: (context, state) {
      final profileModelEntity = state.extra as ProfileModelEntity;
      return ContactDetailsPage(profileModelEntity: profileModelEntity);
    },
  ),
  GoRoute(
    path: RoutePaths.myEmploymentDetails,
    name: 'employment_detail',
    builder: (context, state) {
      final profileModelEntity = state.extra as ProfileModelEntity;
      return EmploymentDetailsPage(profileModelEntity: profileModelEntity);
    },
  ),
  GoRoute(
    path: RoutePaths.myPesonalDetails,
    name: 'personal_info',
    builder: (context, state) {
      final profileModelEntity = state.extra as ProfileModelEntity;
      return PersonalDetailsPage(profileModelEntity: profileModelEntity);
    },
  ),
  GoRoute(
    path: RoutePaths.addAcheivementEducation,
    name: 'add_acheivement_education',
    builder: (context, state) {
      return AddEducationAndAchievements();
    },
  ),GoRoute(
    path: RoutePaths.nomineeDetails,
    name: 'nominees',
    builder: (context, state) {
      return NomineeDetailsPage();
    },
  ),
  GoRoute(
    path: RoutePaths.addNominees,
    name: 'add_nominess',
    builder: (context, state) {
      return AddNominees();
    },
  ),

  GoRoute(
    path: RoutePaths.appSupport,
    name: RoutePaths.appSupport,
    builder: (context, state) => BlocProvider(
      create: (context) => GetIt.I<MyProfileBloc>()..add(const FetchAppSupportEvent()),
      child:  AppSupport(),
    ),
  ),

  GoRoute(
    path: RoutePaths.pastExperience,
    name: RoutePaths.pastExperience,
    builder: (context, state) => BlocProvider(
      create: (context) => GetIt.I<MyProfileBloc>()..add(const FetchPastExperienceEvent()),
      child: const PastExperiencePage(),
    ),
  ),
  GoRoute(
    path: RoutePaths.getActivity,
    name: 'get-activity',
    builder: (context, state) => BlocProvider<MyProfileBloc>(
      create: (_) => GetIt.I<MyProfileBloc>(),
      child: const MyActivitiesPage(),
    ),
  ),

  GoRoute(
    path: RoutePaths.notificationSoundSetting,
    name: 'notification_setting',
    builder: (context, state) => const NotificationSoundSettingPage(),
  ),
  GoRoute(
    path: RoutePaths.shiftsDetails,
    name: 'shift_details',
    builder: (context, state) => BlocProvider<MyProfileBloc>(
      create: (_) => GetIt.I<MyProfileBloc>(),
      child: const ShiftDetailsPage(),
    ),
  ),

  GoRoute(
    path: RoutePaths.addNewSupportTicket,
    name: 'add-new-support-ticket',
    builder: (context, state) => const AddNewSupportTicket(),
  ),

  GoRoute(
    path: RoutePaths.addPastExperience,
    name: RoutePaths.addPastExperience,
    builder: (context, state) => const AddPastExperience(),
  ),
];
