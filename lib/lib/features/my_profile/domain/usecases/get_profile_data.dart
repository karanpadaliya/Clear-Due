import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/my_profile/data/models/request/add_achievement_request_model.dart';
import 'package:myco_flutter/features/my_profile/data/models/request/app_support_request_model.dart';
import 'package:myco_flutter/features/my_profile/data/models/request/past_experience_request_model.dart';
import 'package:myco_flutter/features/my_profile/data/models/request/shift_details_request_model.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/app_support_entity.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/get_activity_response_entity.dart';
import 'package:myco_flutter/features/my_profile/data/models/request/achievement_education_request_model.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/achievement_education_entity.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/past_experience_entity.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/profile_entity.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/shift_details_response_entity.dart';
import 'package:myco_flutter/features/my_profile/domain/repositories/my_profile_repository.dart';

class GetProfileData {
  final MyProfileRepository repository;
  GetProfileData(this.repository);

  Future<Either<Failure, ProfileModelEntity>> getProileData(
    Map<String, dynamic> dataMap,
  ) async => await repository.getProfileData(dataMap);

  Future<Either<Failure, GetActivityResponseEntity>> getActivity(
    Map<String, dynamic> dataMap,
  ) async => await repository.getActivity(dataMap);

  Future<Either<Failure, ShiftDetailsResponseEntity>> getShiftDetails(
    ShiftDetailsRequestModel request,
  ) async => repository.getShiftDetails(request);

  Future<Either<Failure, AchievementEducationEntity>> getAchievementEducationData(
      AchievementEducationRequestModel achievementEducationRequestModel,
      ) async {
    return await repository.getAchievementEducationData(achievementEducationRequestModel);
  }

  Future<Either<Failure, PastExperienceEntity>> getPastExperienceData(
      PastExeperienceRequestModel pastExeperienceRequestModel,
      ) async {
    return await repository.getPastExperienceData(pastExeperienceRequestModel);
  }

  Future<Either<Failure, AppSupportEntity>> getAppSupportData(
      AppSupportRequestModel appSupportRequestModel,
      ) async {
    return await repository.getAppSupportData(appSupportRequestModel);
  }

  Future<Either<Failure, Map<String,dynamic>>> addAchievementData(
      AddAchievementRequestModel addAchievementRequestModel,
      ) async {
    return await repository.addAchievementData(addAchievementRequestModel);
  }
}
