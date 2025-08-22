import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myco_flutter/features/chat/data/models/request/group_chat_list_request_model.dart';
import 'package:myco_flutter/features/chat/domain/entities/group_chat_list_entities.dart';
import 'package:myco_flutter/features/chat/domain/usecases/get_group_chat_list.dart';

part 'group_chat_event.dart';
part 'group_chat_state.dart';

class GroupChatBloc extends Bloc<GroupChatEvent, GroupChatState> {
  final GetGroupChatList getGroupChatListUseCase;
  List fullList = [];
  GroupChatBloc(this.getGroupChatListUseCase) : super(GroupChatInitial()) {
    on<SearchEventGroup>(_onSearchGroup);
    on<GetGroupChatListEvent>(getGroupChat);
  }
  void _onSearchGroup(SearchEventGroup event, Emitter<GroupChatState> emit) {
    final query = event.query.trim().toLowerCase();
    log(fullList.toString(), name: 'fullList in _onSearch');
    log(fullList.length.toString(), name: 'fullList in _onSearch_length');
    if (query.isEmpty) {
      emit(GroupSearchQueryState(filteredListGroup: fullList));
    } else {
      // Prioritize startsWith
      final startsWithResults = fullList
          .where(
            (item) => item.topicName?.toLowerCase().startsWith(query) ?? false,
          )
          .toList();

      log(startsWithResults.toString(), name: 'startsWithResults in onSearch');
      // Fallback contains (excluding already matched items)
      final containsResults = fullList
          .where(
            (item) =>
                !(item.userFullName?.toLowerCase().startsWith(query) ??
                    false) &&
                (item.userFullName?.toLowerCase().contains(query) ?? false),
          )
          .toList();

      // Combine both
      final filtered = [...startsWithResults, ...containsResults];

      emit(GroupSearchQueryState(filteredListGroup: filtered));
    }
  }

  FutureOr<void> getGroupChat(
    GetGroupChatListEvent event,
    Emitter<GroupChatState> emit,
  ) async {
    emit(GetGroupChatListLoadingState());
    final requestModel = GroupChatListRequestModel(
      getGroupListRecentNew: 'getGroupListRecentNew',
      societyId: '1',
      userId: '1776',
      unitId: '2',
      blockId: '30',
      floorId: '151',
      zoneId: '0',
      levelId: '3',
      userToken: 'f2uTcR19SjSIuBygfK4TOP%3AAPA91bGbY9nHxA0cDE5lnTL4teMy_Nn4p9tH-Pcfnj1ySZM733nvIleUb5xZ8NUrujp8mS2rll8WcYzE65ms3b46kH9e9T9WAhay1Ta-ofYvHzzBj4PsALbN1ug60aBI_3bUlq8JpL3z',
      device: 'android',
      languageId: '1',
      
    );
    final result = await getGroupChatListUseCase.getGroupChatList(requestModel);
    log(result.toString(), name: 'getMemberGroupChatList');
    result.fold(
      (failure) => emit(GetGroupChatListErrorState(message: failure.message)),
      (response) {
        fullList = response.member ?? [];
        emit(GetGroupChatListSuccessState(groupChatList: response));
      },
    );
  }
}
