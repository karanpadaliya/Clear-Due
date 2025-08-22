import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/features/my_profile/data/models/add_achievement_education_model.dart';
import 'package:myco_flutter/features/my_profile/data/models/request/achievement_education_request_model.dart';
import 'package:myco_flutter/features/my_profile/data/models/request/add_achievement_request_model.dart';
import 'package:myco_flutter/features/my_profile/data/models/request/app_support_request_model.dart';
import 'package:myco_flutter/features/my_profile/data/models/request/past_experience_request_model.dart';
import 'package:myco_flutter/features/my_profile/domain/usecases/get_profile_data.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_event.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_state.dart';
import 'package:url_launcher/url_launcher.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  GetProfileData getProfileData;

  MyProfileBloc(this.getProfileData) : super(InitialMyProfileState()) {
    // Handler for your original event
    on<GetProfileDataEvent>(fetchMyProfileData);

    // Add a new handler for the other profile event
    on<GetOtherProfileDataEvent>(fetchOtherProfileData);

    on<FacebookClickEvent>(_handleFacebookClick);
    on<LinkedInClickEvent>(_handleLinkedInClick);
    on<InstagramClickEvent>(_handleInstagramClick);
    on<TwitterClickEvent>(_handleTwitterClick);
    on<WhatsappClickEvent>(_handleWhatsappClick);
    on<FetchAchievementEducationEvent>(_fetchAchievementEducationData);
    on<FetchGetActivityEvent>(_fetchGetActivity);
    on<FetchShiftDetailsEvent>(_FetchShiftDetails);
    on<FetchPastExperienceEvent>(_fetchPastExperienceData);
    // on<FetchAppSupportEvent>(_fetchAppSupportData);
    on<FetchAppSupportEvent>(_fetchAppSupportData);
    on<SelectFaqCategoryEvent>(_onSelectFaqCategory);
    on<SearchFaqEvent>(_onSearchFaq);
    on<ToggleFaqExpandEvent>(_onToggleFaqExpand);
    on<AddAchievementDataEvent>(_onAddAchievementData);
  }

  // Your original method
  FutureOr<void> fetchMyProfileData(
    GetProfileDataEvent event,
    Emitter<MyProfileState> emit,
  ) async {
    // ... same logic as before
    final prefs = GetIt.I<PreferenceManager>();

    final userId = await prefs.getUserId();
    final societyId = await prefs.getCompanyId();
    final blockId = await prefs.getBranchId();
    final floorId = await prefs.getDepartmentId();
    emit(FetchProfileDataLoadingState());
    final Map<String, dynamic> dataMap = {
      'getProfileMenuDetails': event.getProfileMenuDetails,
      'society_id': societyId,
      'user_id': userId,
      'unit_id': event.unitId,
      'block_id': blockId,
      'floor_id': floorId,
      'other_user_block_id': event.otherUserBlockId,
      'other_user_floor_id': event.otherUserFloorId,
      'my_user_id': userId,
      'my_profile': event.myProfile,
    };
    final result = await getProfileData.getProileData(dataMap);
    result.fold(
      (failure) => emit(FetchProfileDataErrorState(failure.message)),
      (profileEntity) => emit(FetchProfileDataSuccessState(profileEntity)),
    );
  }

  // The new method to handle GetOtherProfileDataEvent
  FutureOr<void> fetchOtherProfileData(
    GetOtherProfileDataEvent event, // Note the different event type here
    Emitter<MyProfileState> emit,
  ) async {
    emit(FetchProfileDataLoadingState());
    // The logic is identical, just using the new event object
    final Map<String, dynamic> dataMap = {
      'getProfileMenuDetails': event.getProfileMenuDetails,
      'society_id': event.societyId,
      'user_id': event.userId, // This will be the other user's ID
      'unit_id': event.unitId,
      'block_id': event.blockId,
      'floor_id': event.floorId,
      'other_user_block_id': event.otherUserBlockId,
      'other_user_floor_id': event.otherUserFloorId,
      'my_user_id': event.myUserId, // This would be your own ID
      'my_profile': event.myProfile, // This would likely be '0'
    };
    final result = await getProfileData.getProileData(dataMap);
    result.fold(
      (failure) => emit(FetchProfileDataErrorState(failure.message)),
      (profileEntity) => emit(FetchProfileDataSuccessState(profileEntity)),
    );
  }

  Future<void> _handleFacebookClick(
    FacebookClickEvent event,
    Emitter<MyProfileState> emit,
  ) async {
    final url = event.url.contains('facebook.com')
        ? event.url.startsWith('http')
              ? event.url
              : 'https://${event.url}'
        : 'https://www.facebook.com/${event.url}';

    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      emit(const FetchProfileDataErrorState('Unable to open Facebook'));
    }
  }

  Future<void> _handleLinkedInClick(
    LinkedInClickEvent event,
    Emitter<MyProfileState> emit,
  ) async {
    final url = event.url.contains('linkedin.com')
        ? event.url.startsWith('http')
              ? event.url
              : 'https://${event.url}'
        : 'https://www.linkedin.com/in/${event.url}';

    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      emit(const FetchProfileDataErrorState('Unable to open LinkedIn'));
    }
  }

  Future<void> _handleInstagramClick(
    InstagramClickEvent event,
    Emitter<MyProfileState> emit,
  ) async {
    final url = event.url.contains('instagram.com')
        ? event.url.startsWith('http')
              ? event.url
              : 'https://${event.url}'
        : 'https://instagram.com/_u/${event.url}';

    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      emit(const FetchProfileDataErrorState('Unable to open Instagram'));
    }
  }

  Future<void> _handleTwitterClick(
    TwitterClickEvent event,
    Emitter<MyProfileState> emit,
  ) async {
    final url = event.url.startsWith('http')
        ? event.url
        : 'https://twitter.com/${event.url}';

    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      emit(const FetchProfileDataErrorState('Unable to open Twitter'));
    }
  }

  Future<void> _handleWhatsappClick(
    WhatsappClickEvent event,
    Emitter<MyProfileState> emit,
  ) async {
    final url =
        'https://wa.me/${event.phoneNumber}?text=${Uri.encodeComponent("Hello, \n")}';

    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      emit(const FetchProfileDataErrorState('Unable to open WhatsApp'));
    }
  }

  Future<void> _fetchAchievementEducationData(
    FetchAchievementEducationEvent event,
    Emitter<MyProfileState> emit,
  ) async {
    emit(FetchAchievementEducationDataLoadingState());
    final achievementEducationRequestModel = AchievementEducationRequestModel(
      getAchivment: event.getAchivment,
      societyId: event.societyId,
      unitId: event.unitId,
      userId: event.userId,
      languageId: event.languageId,
    );
    final result = await getProfileData.getAchievementEducationData(
      achievementEducationRequestModel,
    );
    result.fold(
      (failure) => emit(FetchProfileDataErrorState(failure.message)),
      (achievementEducationEntity) => emit(
        FetchAchievementEducationDataSuccessState(achievementEducationEntity),
        
      ),
    );
  }

  Future<void> _fetchGetActivity(
    FetchGetActivityEvent event,
    Emitter<MyProfileState> emit,
  ) async {
    emit(FetchProfileDataLoadingState());

    try {
      final result = await getProfileData.getActivity(event.request.toJson());
      result.fold(
        (failure) => emit(FetchProfileDataErrorState(failure.message)),
        (response) {
          emit(GetActivityLoadedState(response));
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _FetchShiftDetails(
    FetchShiftDetailsEvent event,
    Emitter<MyProfileState> emit,
  ) async {
    try {
      final result = await getProfileData.getShiftDetails(event.request);
      result.fold(
        (failure) {
          print('Bloc: Failed to fetch shift details');
          emit(FetchProfileDataErrorState(failure.message));
        },
        (response) {
          print('Bloc: Shift details loaded successfully');
          emit(ShiftDetailsLoadedState(response));
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _fetchPastExperienceData(
    FetchPastExperienceEvent event,
    Emitter<MyProfileState> emit,
  ) async {
    final prefs = GetIt.I<PreferenceManager>();

    final userId = await prefs.getUserId();
    final societyId = await prefs.getCompanyId();
    emit(FetchPastExperienceDataLoadingState());
    final pastExperienceModel = PastExeperienceRequestModel(
      getExperience: event.getExperience,
      languageId: event.languageId,
      societyId: societyId,
      userId: userId,
    );
    final result = await getProfileData.getPastExperienceData(
      pastExperienceModel,
    );
    result.fold(
      (failure) => emit(FetchProfileDataErrorState(failure.message)),
      (pastExperienceEntity) =>
          emit(FetchPastExperienceDataSuccessState(pastExperienceEntity)),
    );
  }

  Future<void> _fetchAppSupportData(
    FetchAppSupportEvent event,
    Emitter<MyProfileState> emit,
  ) async {
    emit(AppSupportDataLoadingState());
    final req = AppSupportRequestModel(
      getFaq: event.getFaq ?? 'getFaq',
      companyId: event.companyId ?? '1',
      languageId: event.languageId ?? '1',
    );
    final result = await getProfileData.getAppSupportData(req);

    result.fold(
      (failure) => emit(FetchProfileDataErrorState(failure.message)),
      (entity) {
        final categoryMap = {
          for (var cat in entity.categoryList) cat.categoryId: cat.categoryName,
        };
        final categoryNames =
            entity.categoryList.map((cat) => cat.categoryName).toSet().toList()
              ..sort();
        final categories = ['All', ...categoryNames];

        emit(
          AppSupportUiState(
            allFaqList: entity.faqList,
            filteredFaqList: List.from(entity.faqList),
            categories: categories,
            selectedCategory: 'All',
            categoryMap: categoryMap,
            searchQuery: '',
            expandedFaqIndices: {},
          ),
        );
      },
    );
  }

  void _onSelectFaqCategory(
    SelectFaqCategoryEvent event,
    Emitter<MyProfileState> emit,
  ) {
    final curr = state;
    if (curr is! AppSupportUiState) return;
    final selectedCategory = event.category;
    final filtered = curr.allFaqList.where((faq) {
      final catName = curr.categoryMap[faq.categoryId] ?? '';
      return (selectedCategory == 'All' || catName == selectedCategory) &&
          (curr.searchQuery.isEmpty ||
              faq.question.toLowerCase().contains(
                curr.searchQuery.toLowerCase(),
              ));
    }).toList();
    emit(
      curr.copyWith(
        selectedCategory: selectedCategory,
        filteredFaqList: filtered,
        expandedFaqIndices: {},
      ),
    );
  }

  void _onSearchFaq(SearchFaqEvent event, Emitter<MyProfileState> emit) {
    final curr = state;
    if (curr is! AppSupportUiState) return;
    final query = event.query;
    final filtered = curr.allFaqList.where((faq) {
      final catName = curr.categoryMap[faq.categoryId] ?? '';
      return (curr.selectedCategory == 'All' ||
              catName == curr.selectedCategory) &&
          (query.isEmpty ||
              faq.question.toLowerCase().contains(query.toLowerCase()));
    }).toList();
    emit(
      curr.copyWith(
        searchQuery: query,
        filteredFaqList: filtered,
        expandedFaqIndices: {},
      ),
    );
  }

  void _onToggleFaqExpand(
    ToggleFaqExpandEvent event,
    Emitter<MyProfileState> emit,
  ) {
    final curr = state;
    if (curr is! AppSupportUiState) return;
    final indices = Set<int>.from(curr.expandedFaqIndices);
    if (indices.contains(event.faqIndex)) {
      indices.remove(event.faqIndex);
    } else {
      indices.add(event.faqIndex);
    }
    emit(curr.copyWith(expandedFaqIndices: indices));
  }

  // Future<void> _fetchAppSupportData(
  //   FetchAppSupportEvent event,
  //   Emitter<MyProfileState> emit,
  // ) async {
  //   emit(AppSupportDataLoadingState());
  //   final appSupportRequestModel = AppSupportRequestModel(
  //     getFaq: event.getFaq ?? 'getFaq',
  //     companyId: event.companyId ?? '1',
  //     languageId: event.languageId ?? '1',
  //   );
  //   final result = await getProfileData.getAppSupportData(
  //     appSupportRequestModel,
  //   );
  //   log(name: 'jenil', result.toString());
  //
  //   result.fold(
  //     (failure) => emit(FetchProfileDataErrorState(failure.message)),
  //     (appSupportEntity) => emit(AppSupportDataSuccessState(appSupportEntity)),
  //   );
  // }

  Future<void> _onAddAchievementData(
    AddAchievementDataEvent event,
    Emitter<MyProfileState> emit,
  ) async {
    emit(AddAchievementLoadingState());
    final prefs = GetIt.I<PreferenceManager>();

    final userFirstName = await prefs.getUserFirstName().toString();
    final userLastName = await prefs.getUserLastName().toString();
    final userDesignation = await prefs.getDesignation().toString();
    final userBranch = await prefs.getCompanyName().toString();
    final userName =
        userFirstName + userLastName + userDesignation + userBranch;

    final societyId = await prefs.getCompanyId();
    final userId = await prefs.getUserId();
    final addAchievementEducationModel = AddAchievementEducationModel(
      employeeAchievementId: "",
      achievementName: event.achievementName.toString(),
      achievementDate: event.achievementDate.toString(),
      universityBoardName: event.achievementFrom.toString(),
      archiType: "0",
      view: "Achievement",
    );
    final data = jsonEncode(addAchievementEducationModel.toJson());
    final addAchievementRequestModel = AddAchievementRequestModel(
      achievementRequest: event.achievementRequest,
      societyId: societyId,
      userId: userId,
      achievementChangeReq: data,
      userName: userName,
    );
    print(addAchievementRequestModel.achievementRequest);
    print(addAchievementRequestModel.userId);
    print(addAchievementRequestModel.societyId);
    print(addAchievementRequestModel.achievementChangeReq);
    print(addAchievementRequestModel.userName);

    final result = await getProfileData.addAchievementData(
      addAchievementRequestModel,
    );

    result.fold(
      (failure) => emit(FetchProfileDataErrorState(failure.message)),
      // MODIFIED: Pass the map from the API response into the success state
      (successMap) => emit(AddAchievementSuccessState(successMap)),
    );
  }
}
