import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/encryption/gzip_util.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/core/network/api_client.dart';
import 'package:myco_flutter/core/utils/safe_api_call.dart';
import 'package:myco_flutter/features/my_profile/data/datasources/myprofile_remote_data_source.dart';
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

class MyprofileRemoteDataSourceImpl extends MyProfileRemoteDataSource {
  final ApiClient apiClient;
  final SafeApiCall safeApiCall;
  final ApiClient masterApiClient;

  MyprofileRemoteDataSourceImpl({
    required this.masterApiClient,
    required this.apiClient,
    required this.safeApiCall,
  });

  @override
  Future<Either<Failure, ProfileModel>> getProfileData(
    Map<String, dynamic> dataMap,
  ) async => await safeApiCall.execute<ProfileModel>(() async {
    final response = await apiClient.postFormDynamic(
      'profileMenuController.php',
      dataMap,
    );
    return ProfileModel.fromJson(jsonDecode(response));
  });

  @override
  Future<Either<Failure, GetActivityResponseModel>> getActivity(
    Map<String, dynamic> dataMap,
  ) async => await safeApiCall.execute(() async {
    final response = await apiClient.postFormDynamic(
      'myactivity_controller.php',
      dataMap,
    );
    return GetActivityResponseModel.fromJson(jsonDecode(response));
  });

  @override
  Future<Either<Failure, AchievementEducationModel>>
  getAchievementEducationData(
    AchievementEducationRequestModel achievementEducationRequestModel,
  ) async {
    final dataMap = achievementEducationRequestModel.toJson();
    return await safeApiCall.execute<AchievementEducationModel>(() async {
      final response = await apiClient.postFormDynamic(
        "resident_data_update_controller.php",
        dataMap,
      );
      return AchievementEducationModel.fromJson(jsonDecode(response));
    });
  }

  @override
  Future<ShiftDetailsResponseModel> getShiftDetails(
    ShiftDetailsRequestModel request,
  ) async {
    final encryptedBody = GzipUtil.encryptAES(jsonEncode(request));
    final response = await GetIt.I<ApiClient>(
      instanceName: VariableBag.employeeMobileApi,
    ).postDynamic('shift_controller.php', encryptedBody);

    return ShiftDetailsResponseModel.fromJson(
      json.decode(GzipUtil.decryptAES(response)),
    );
  }

  @override
  Future<Either<Failure, PastExperienceModel>> getPastExperienceData(
    PastExeperienceRequestModel pastExeperienceRequestModel,
  ) async => await safeApiCall.execute(() async {
    final dataMap = pastExeperienceRequestModel.toJson();
    final response = await apiClient.postFormDynamic(
      'profileMenuController.php',
      dataMap,
    );
    return PastExperienceModel.fromJson(jsonDecode(response));
  });

  @override
  Future<Either<Failure, AppSupportResponseModel>> getAppSupportData(
    AppSupportRequestModel model,
  ) async {
    final encryptedBody = GzipUtil.encryptAES(jsonEncode(model));
    return await safeApiCall.execute<AppSupportResponseModel>(() async {
      final response = await masterApiClient.postDynamic(
        'faqController.php',
        encryptedBody,
      );
      return AppSupportResponseModel.fromJson(
        json.decode(GzipUtil.decryptAES(response)),
      );
    });
  }

  @override
  Future<Either<Failure, Map<String,dynamic>>> addAcheivementData(
      AddAchievementRequestModel model,
      ) async {
    final encryptedBody = model.toJson();
    return await safeApiCall.execute<Map<String,dynamic>>(() async {
      final response = await apiClient.postFormDynamic(
        'profileMenuController.php',
        encryptedBody,
      );
      return jsonDecode(response);
    });
  }
}
