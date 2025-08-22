import 'package:equatable/equatable.dart';
import 'package:myco_flutter/features/my_profile/data/models/request/add_achievement_request_model.dart';
import 'package:myco_flutter/features/my_profile/data/models/request/get_activity_request_model.dart';
import 'package:myco_flutter/features/my_profile/data/models/request/shift_details_request_model.dart';

sealed class MyProfileEvent extends Equatable {
  const MyProfileEvent();
  @override
  List<Object?> get props => [];
}

class GetProfileDataEvent extends MyProfileEvent {
  final String? getProfileMenuDetails,
      societyId,
      userId,
      unitId,
      blockId,
      floorId,
      otherUserBlockId,
      otherUserFloorId,
      myUserId,
      myProfile;

  const GetProfileDataEvent({
    this.getProfileMenuDetails = 'getProfileMenuDetails',
    this.societyId = '1',
    this.userId = '1504',
    this.unitId = '0',
    this.blockId = '1',
    this.floorId = '1',
    this.otherUserBlockId = '',
    this.otherUserFloorId = '',
    this.myUserId = '1504',
    this.myProfile = '1',
  });

  @override
  List<Object?> get props => [
    getProfileMenuDetails,
    societyId,
    userId,
    unitId,
    blockId,
    floorId,
    otherUserBlockId,
    otherUserFloorId,
    myUserId,
    myProfile,
  ];
}

class GetOtherProfileDataEvent extends MyProfileEvent {
  final String? getProfileMenuDetails,
      societyId,
      userId,
      unitId,
      blockId,
      floorId,
      otherUserBlockId,
      otherUserFloorId,
      myUserId,
      myProfile;

  const GetOtherProfileDataEvent({
    this.getProfileMenuDetails = 'getProfileMenuDetails',
    this.societyId,
    this.userId,
    this.unitId,
    this.blockId,
    this.floorId,
    this.otherUserBlockId,
    this.otherUserFloorId,
    this.myUserId,
    this.myProfile,
  });

  @override
  List<Object?> get props => [
    getProfileMenuDetails,
    societyId,
    userId,
    unitId,
    blockId,
    floorId,
    otherUserBlockId,
    otherUserFloorId,
    myUserId,
    myProfile,
  ];
}

// Inside MyProfileEvent
class FacebookClickEvent extends MyProfileEvent {
  final String url;
  const FacebookClickEvent(this.url);

  @override
  List<Object?> get props => [url];
}

class LinkedInClickEvent extends MyProfileEvent {
  final String url;
  const LinkedInClickEvent(this.url);

  @override
  List<Object?> get props => [url];
}

class InstagramClickEvent extends MyProfileEvent {
  final String url;
  const InstagramClickEvent(this.url);

  @override
  List<Object?> get props => [url];
}

class TwitterClickEvent extends MyProfileEvent {
  final String url;
  const TwitterClickEvent(this.url);

  @override
  List<Object?> get props => [url];
}

class WhatsappClickEvent extends MyProfileEvent {
  final String phoneNumber;
  const WhatsappClickEvent(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class FetchAchievementEducationEvent extends MyProfileEvent {
  final String? getAchivment, societyId, unitId, userId, languageId;

  const FetchAchievementEducationEvent({
    this.getAchivment = 'getAchivment',
    this.societyId = "1",
    this.unitId = "0",
    this.userId = '1775',
    this.languageId = '1',
  });

  @override
  List<Object?> get props => [
    getAchivment,
    societyId,
    unitId,
    userId,
    languageId,
  ];
}

class FetchProfileDataEvent extends MyProfileEvent {
  const FetchProfileDataEvent();

  @override
  List<Object?> get props => [];
}

class FetchGetActivityEvent extends MyProfileEvent {
  final GetActivityRequestModel request;

  const FetchGetActivityEvent(this.request);
  @override
  List<Object?> get props => [request];
}

class FetchShiftDetailsEvent extends MyProfileEvent {
  final ShiftDetailsRequestModel request;

  const FetchShiftDetailsEvent(this.request);
  @override
  List<Object?> get props => [request];
}

class FetchPastExperienceEvent extends MyProfileEvent {
  final String? getExperience, societyId, userId, languageId;

  const FetchPastExperienceEvent({
    this.getExperience = 'getExperience',
    this.societyId = '1',
    this.userId = '1775',
    this.languageId = '1',
  });

  @override
  List<Object?> get props => [getExperience, societyId, userId, languageId];
}

class FetchAppSupportEvent extends MyProfileEvent {
  final String? getFaq, companyId, languageId;
  const FetchAppSupportEvent({
    this.getFaq = 'getFaq',
    this.companyId = '1',
    this.languageId = '1',
  });

  @override
  List<Object?> get props => [getFaq, companyId, languageId];
}

// New events for UI interaction:
class SelectFaqCategoryEvent extends MyProfileEvent {
  final String category;
  const SelectFaqCategoryEvent(this.category);
  @override
  List<Object?> get props => [category];
}

class SearchFaqEvent extends MyProfileEvent {
  final String query;
  const SearchFaqEvent(this.query);
  @override
  List<Object?> get props => [query];
}

class ToggleFaqExpandEvent extends MyProfileEvent {
  final int faqIndex;
  const ToggleFaqExpandEvent(this.faqIndex);
  @override
  List<Object?> get props => [faqIndex];
}

class AddAchievementDataEvent extends MyProfileEvent {
  final String? achievementRequest, education_change_req, user_name;
  final String? achievementName;
  final String? achievementDate;
  final String? achievementFrom;
  AddAchievementDataEvent({
    this.achievementName ,
    this.achievementDate,
    this.achievementFrom,
    this.achievementRequest='achievementRequest',
    this.education_change_req,
    this.user_name,
  });

  @override
  List<Object?> get props => [
    achievementName,
    achievementDate,
    achievementFrom,
    achievementRequest,
    education_change_req,
    user_name,
  ];
}
