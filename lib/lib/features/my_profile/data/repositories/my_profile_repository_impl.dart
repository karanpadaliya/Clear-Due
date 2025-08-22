import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/core/utils/safe_api_call.dart';
import 'package:myco_flutter/features/my_profile/data/datasources/myprofile_remote_data_source.dart';
import 'package:myco_flutter/features/my_profile/data/models/request/add_achievement_request_model.dart';
import 'package:myco_flutter/features/my_profile/data/models/response/app_support_response_model.dart';
import 'package:myco_flutter/features/my_profile/data/models/request/achievement_education_request_model.dart';
import 'package:myco_flutter/features/my_profile/data/models/request/app_support_request_model.dart';
import 'package:myco_flutter/features/my_profile/data/models/request/past_experience_request_model.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/achievement_education_entity.dart';
import 'package:myco_flutter/features/my_profile/data/models/request/shift_details_request_model.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/app_support_entity.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/get_activity_response_entity.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/past_experience_entity.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/profile_entity.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/shift_details_response_entity.dart';
import 'package:myco_flutter/features/my_profile/domain/repositories/my_profile_repository.dart';

class MyProfileRepositoryImpl implements MyProfileRepository {
  final MyProfileRemoteDataSource remoteDataSource;
  final SafeApiCall safeApiCall;

  MyProfileRepositoryImpl(this.remoteDataSource, this.safeApiCall);
  @override
  Future<Either<Failure, ProfileModelEntity>> getProfileData(
    Map<String, dynamic> dataMap,
  ) async {
    final result = await remoteDataSource.getProfileData(dataMap);

    return result.fold(
      Left.new,
      (profileModel) => Right(profileModel.toEntity()),
    );
  }

  @override
  Future<Either<Failure, AchievementEducationEntity>> getAchievementEducationData(
      AchievementEducationRequestModel achievementEducationRequestModel,
      ) async {
    final result = await remoteDataSource.getAchievementEducationData(achievementEducationRequestModel);

    return result.fold(
          (failure)=> Left(failure),
          (achievementEducationEntity) => Right(achievementEducationEntity.toEntity()),
    );
  }
   @override
  Future<Either<Failure, GetActivityResponseEntity>> getActivity(
    Map<String, dynamic> dataMap,
  ) async {
    final result = await remoteDataSource.getActivity(dataMap);
    return result.fold(
      Left.new,
      (getActivity) => Right(getActivity.toEntity()),
    );
  }

  @override
  Future<Either<Failure, ShiftDetailsResponseEntity>> getShiftDetails(
    ShiftDetailsRequestModel request,
  ) async => safeApiCall.execute(() async {
    final response = await remoteDataSource.getShiftDetails(request);
    return response.toEntity();
  });

  @override
  Future<Either<Failure, PastExperienceEntity>> getPastExperienceData(
      PastExeperienceRequestModel pastExeperienceRequestModel,
      ) async {
    final result = await remoteDataSource.getPastExperienceData(pastExeperienceRequestModel);

    return result.fold(
          (failure)=> Left(failure),
          (pastExperienceEntity) => Right(pastExperienceEntity.toEntity()),
    );
  }

  @override
  Future<Either<Failure, AppSupportEntity>> getAppSupportData(
      AppSupportRequestModel appSupportRequestModel,
      ) async {
    final result = await remoteDataSource.getAppSupportData(
      appSupportRequestModel,
    );

    return result.fold(
          (failure) => Left(failure),
          (appSupportEntity) => Right(appSupportEntity.toEntity()),
    );
  }

  @override
  Future<Either<Failure, Map<String,dynamic>>> addAchievementData(
      AddAchievementRequestModel addAchievementRequestModel,
      ) async {
    final result = await remoteDataSource.addAcheivementData(
      addAchievementRequestModel,
    );

    return result;
  }
}
