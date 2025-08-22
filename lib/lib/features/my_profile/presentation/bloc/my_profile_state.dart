import 'package:myco_flutter/features/my_profile/domain/entites/achievement_education_entity.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/app_support_entity.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/get_activity_response_entity.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/past_experience_entity.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/profile_entity.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/shift_details_response_entity.dart';

sealed class MyProfileState {
  const MyProfileState();

  @override
  List<Object?> get props => [];
}

final class InitialMyProfileState extends MyProfileState {}

class FetchProfileDataLoadingState extends MyProfileState {}

class FetchProfileDataSuccessState extends MyProfileState {
  final ProfileModelEntity profileEntity;

  const FetchProfileDataSuccessState(this.profileEntity);

  @override
  List<Object?> get props => [profileEntity];
}

class GetActivityLoadedState extends MyProfileState {
  final GetActivityResponseEntity entity;

  GetActivityLoadedState(this.entity);

  @override
  List<Object?> get props => [entity];
}

class ShiftDetailsLoadedState extends MyProfileState {
  final ShiftDetailsResponseEntity entity;

  ShiftDetailsLoadedState(this.entity);
  @override
  List<Object?> get props => [entity];
}

class FetchProfileDataErrorState extends MyProfileState {
  final String errorMessage;

  const FetchProfileDataErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class FetchOtherProfileDataSuccessState extends MyProfileState {
  final ProfileModelEntity profileEntity;

  const FetchOtherProfileDataSuccessState(this.profileEntity);

  @override
  List<Object?> get props => [profileEntity];
}

class FetchOtherProfileDataErrorState extends MyProfileState {
  final String errorMessage;

  const FetchOtherProfileDataErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class FetchAchievementEducationDataLoadingState extends MyProfileState {}

class FetchAchievementEducationDataSuccessState extends MyProfileState {
  final AchievementEducationEntity achievementEducationEntity;

  const FetchAchievementEducationDataSuccessState(this.achievementEducationEntity);

  @override
  List<Object?> get props => [achievementEducationEntity];
}
class FetchPastExperienceDataLoadingState extends MyProfileState {}

class FetchPastExperienceDataSuccessState extends MyProfileState {
  final PastExperienceEntity pastExperienceEntity;

  const FetchPastExperienceDataSuccessState(this.pastExperienceEntity);

  @override
  List<Object?> get props => [pastExperienceEntity];
}




class AppSupportDataLoadingState extends MyProfileState {}

class AppSupportDataSuccessState extends MyProfileState {
  final AppSupportEntity appSupportEntity;

  const AppSupportDataSuccessState(this.appSupportEntity);

  @override
  List<Object?> get props => [appSupportEntity];
}

class AppSupportUiState extends MyProfileState {
  final List<FaqEntity> allFaqList;
  final List<FaqEntity> filteredFaqList;
  final List<String> categories;
  final Map<String, String> categoryMap;
  final String selectedCategory;
  final String searchQuery;
  final Set<int> expandedFaqIndices;

  const AppSupportUiState({
    required this.allFaqList,
    required this.filteredFaqList,
    required this.categories,
    required this.categoryMap,
    required this.selectedCategory,
    required this.searchQuery,
    required this.expandedFaqIndices,
  });

  AppSupportUiState copyWith({
    List<FaqEntity>? allFaqList,
    List<FaqEntity>? filteredFaqList,
    List<String>? categories,
    Map<String, String>? categoryMap,
    String? selectedCategory,
    String? searchQuery,
    Set<int>? expandedFaqIndices,
  }) {
    return AppSupportUiState(
      allFaqList: allFaqList ?? this.allFaqList,
      filteredFaqList: filteredFaqList ?? this.filteredFaqList,
      categories: categories ?? this.categories,
      categoryMap: categoryMap ?? this.categoryMap,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      expandedFaqIndices: expandedFaqIndices ?? this.expandedFaqIndices,
    );
  }
}
class AddAchievementLoadingState extends MyProfileState {}

// MODIFIED: This state now carries the API response map
class AddAchievementSuccessState extends MyProfileState {
  final Map<String, dynamic> responseData;
  const AddAchievementSuccessState(this.responseData);

  @override
  List<Object?> get props => [responseData];
}

