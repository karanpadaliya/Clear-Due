import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:myco_flutter/features/chat/data/models/request/all_department_request_model.dart';
import 'package:myco_flutter/features/chat/data/models/request/member_chat_list_request_model.dart';
import 'package:myco_flutter/features/chat/data/models/request/member_list_request_model.dart';
import 'package:myco_flutter/features/chat/domain/entities/all_departments_entities.dart';
import 'package:myco_flutter/features/chat/domain/entities/member_chat_list_entities.dart';
import 'package:myco_flutter/features/chat/domain/entities/member_list_entities.dart';
import 'package:myco_flutter/features/chat/domain/usecases/get_all_departments.dart';
import 'package:myco_flutter/features/chat/domain/usecases/get_member_list.dart';
import 'package:myco_flutter/features/chat/domain/usecases/grt_member_chat_list.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final GetMemberList getMemberListUsecases;
  final GetMemberChatList getMemberChatListUsecases;
  final GetAllDepartments AllDepartmentUsecases;

  ChatListBloc(this.getMemberListUsecases, this.AllDepartmentUsecases,
      this.getMemberChatListUsecases)
      : super(const ChatListState()) {
    on<SearchEvent>(_onSearch);
    on<GetMemberListEvent>(getMemberList);
    on<GetAllDepartmentsEvent>(getAllDepartmentsList);
    on<GetMemberChatListEvent>(_getMemberChatList);
    on<SearchMemberEvent>(_onSearchEventMember);
  }

  void _onSearch(SearchEvent event, Emitter<ChatListState> emit) {
    final query = event.query.trim().toLowerCase();
    if (query.isEmpty) {
      emit(state.copyWith(filteredFullMemberList: state.fullMemberList));
    } else {
      final fullList = state.fullMemberList ?? [];
      final startsWithResults = fullList
          .where(
            (item) =>
                item.userFullName?.toLowerCase().startsWith(query) ?? false,
          )
          .toList();

      final containsResults = fullList
          .where(
            (item) =>
                !(item.userFullName?.toLowerCase().startsWith(query) ?? false) &&
                (item.userFullName?.toLowerCase().contains(query) ?? false),
          )
          .toList();

      final filtered = [...startsWithResults, ...containsResults];
      emit(state.copyWith(filteredFullMemberList: filtered));
    }
  }

  FutureOr<void> getMemberList(
    GetMemberListEvent event,
    Emitter<ChatListState> emit,
  ) async {
    emit(state.copyWith(isLoadingFullMemberList: true, clearError: true));
    final requestModel = MemberListRequestModel(
      getMemberListNew: "getMemberListNew",
      societyId: "1",
      unitId: "0",
      groupId: "0",
      floorId: event.departmentId,
      floorIdAccess: "0",
      blockId: "1",
      userType: "1",
      userId: "1776",
      languageId: "1",
    );
    final result = await getMemberListUsecases.getMemberList(requestModel);

    result.fold(
      (failure) => emit(state.copyWith(
          isLoadingFullMemberList: false, error: failure.message)),
      (response) {
        emit(state.copyWith(
          isLoadingFullMemberList: false,
          fullMemberList: response.member ?? [],
          filteredFullMemberList: response.member ?? [],
        ));
      },
    );
  }

  FutureOr<void> getAllDepartmentsList(
    GetAllDepartmentsEvent event,
    Emitter<ChatListState> emit,
  ) async {
    // Avoid refetching if we already have the data
    if (state.allDepartmentsList != null) return;

    emit(state.copyWith(isLoadingDepartments: true, clearError: true));
    final requestModel = AllDepartmentRequestModel(
      getAllDepartments: "getAllDepartments",
      societyId: "1",
      floorId: "0",
      blockId: "1",
      userId: "1776",
      languageId: "1",
    );

    final result = await AllDepartmentUsecases.getAllDepartments(requestModel);
    result.fold(
      (failure) => emit(
          state.copyWith(isLoadingDepartments: false, error: failure.message)),
      (response) => emit(state.copyWith(
          isLoadingDepartments: false, allDepartmentsList: response)),
    );
  }

  FutureOr<void> _getMemberChatList(
      GetMemberChatListEvent event, Emitter<ChatListState> emit) async {
    // Avoid refetching if we already have the data
    if (state.memberChatList != null) return;

    emit(state.copyWith(isLoadingMemberChatList: true, clearError: true));
    final requestModel = MemberChatListRequestModel(
      getRecentChatMember: "getRecentChatMember",
      societyId: "1",
      unitId: "1",
      groupId: "",
      floorId: "0",
      floorIdAccess: "1",
      blockId: "1",
      userId: "1776",
      userType: "",
      languageId: "1",
    );

    final result =
        await getMemberChatListUsecases.getMemberChatList(requestModel);
    result.fold(
        (failure) => emit(state.copyWith(
            isLoadingMemberChatList: false, error: failure.message)),
        (response) {
      emit(state.copyWith(
        isLoadingMemberChatList: false,
        memberChatList: response.member,
        filteredMemberChatList: response.member,
      ));
    });
  }

  void _onSearchEventMember(
      SearchMemberEvent event, Emitter<ChatListState> emit) {
    final query = event.query.trim().toLowerCase();
    if (query.isEmpty) {
      emit(state.copyWith(filteredMemberChatList: state.memberChatList));
    } else {
      final memberChatList = state.memberChatList ?? [];
      final startsWithResults = memberChatList
          .where((item) =>
              item.userFullName?.toLowerCase().startsWith(query) ?? false)
          .toList();

      final containsResults = memberChatList
          .where((item) =>
              !(item.userFullName?.toLowerCase().startsWith(query) ?? false) &&
              (item.userFullName?.toLowerCase().contains(query) ?? false))
          .toList();

      final filtered = [...startsWithResults, ...containsResults];
      emit(state.copyWith(filteredMemberChatList: filtered));
    }
  }
}
