import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/my_profile/data/models/request/add_achievement_request_model.dart';
import 'package:myco_flutter/features/my_profile/data/models/response/app_support_response_model.dart';
import 'package:myco_flutter/features/my_profile/data/models/request/achievement_education_request_model.dart';
import 'package:myco_flutter/features/my_profile/data/models/request/app_support_request_model.dart';
import 'package:myco_flutter/features/my_profile/data/models/request/past_experience_request_model.dart';
import 'package:myco_flutter/features/my_profile/data/models/response/achievement_education_model.dart';
import 'package:myco_flutter/features/my_profile/data/models/response/past_experience_response_model.dart';
import 'package:myco_flutter/features/my_profile/data/models/response/profile_model.dart';
import 'package:myco_flutter/features/my_profile/data/models/request/shift_details_request_model.dart';
import 'package:myco_flutter/features/my_profile/data/models/response/get_activity_response_model.dart';
import 'package:myco_flutter/features/my_profile/data/models/response/shift_details_response_model.dart';
import 'package:myco_flutter/features/my_profile/presentation/pages/add_past_experience.dart';

abstract class MyProfileRemoteDataSource {
  Future<Either<Failure, ProfileModel>> getProfileData(
    Map<String, dynamic> dataMap,
  );

  Future<Either<Failure, GetActivityResponseModel>> getActivity(
    Map<String, dynamic> dataMap,
  );

  Future<ShiftDetailsResponseModel> getShiftDetails(
    ShiftDetailsRequestModel request,
  );
  Future<Either<Failure, AchievementEducationModel>>
  getAchievementEducationData(
    AchievementEducationRequestModel achievementEducationRequestModel,
  );

  Future<Either<Failure, PastExperienceModel>> getPastExperienceData(
    PastExeperienceRequestModel pastExeperienceRequestModel,
  );

  Future<Either<Failure, AppSupportResponseModel>> getAppSupportData(
      AppSupportRequestModel appSupportRequestModel,
      );

  Future<Either<Failure, Map<String,dynamic>>> addAcheivementData(
      AddAchievementRequestModel addAchievementRequestModel,
      );

}
