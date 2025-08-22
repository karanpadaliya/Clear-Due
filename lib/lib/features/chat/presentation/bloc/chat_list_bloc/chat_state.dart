part of 'chat_bloc.dart';

class ChatListState extends Equatable {
  // Data for ChatListScreen
  final List? memberChatList;
  final List? filteredMemberChatList;

  // Data for StartNewChatScreen
  final List? fullMemberList;
  final List? filteredFullMemberList;
  final AllDepartmentsEntity? allDepartmentsList;

  // Status flags for both screens
  final bool isLoadingMemberChatList;
  final bool isLoadingFullMemberList;
  final bool isLoadingDepartments;
  final String? error;

  const ChatListState({
    this.memberChatList,
    this.filteredMemberChatList,
    this.fullMemberList,
    this.filteredFullMemberList,
    this.allDepartmentsList,
    this.isLoadingMemberChatList = false,
    this.isLoadingFullMemberList = false,
    this.isLoadingDepartments = false,
    this.error,
  });

  // copyWith allows us to create a new state by updating only the fields we need,
  // preserving the rest of the data.
  ChatListState copyWith({
    List? memberChatList,
    List? filteredMemberChatList,
    List? fullMemberList,
    List? filteredFullMemberList,
    AllDepartmentsEntity? allDepartmentsList,
    bool? isLoadingMemberChatList,
    bool? isLoadingFullMemberList,
    bool? isLoadingDepartments,
    String? error,
    bool clearError = false,
  }) {
    return ChatListState(
      memberChatList: memberChatList ?? this.memberChatList,
      filteredMemberChatList: filteredMemberChatList ?? this.filteredMemberChatList,
      fullMemberList: fullMemberList ?? this.fullMemberList,
      filteredFullMemberList: filteredFullMemberList ?? this.filteredFullMemberList,
      allDepartmentsList: allDepartmentsList ?? this.allDepartmentsList,
      isLoadingMemberChatList: isLoadingMemberChatList ?? this.isLoadingMemberChatList,
      isLoadingFullMemberList: isLoadingFullMemberList ?? this.isLoadingFullMemberList,
      isLoadingDepartments: isLoadingDepartments ?? this.isLoadingDepartments,
      error: clearError ? null : error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        memberChatList,
        filteredMemberChatList,
        fullMemberList,
        filteredFullMemberList,
        allDepartmentsList,
        isLoadingMemberChatList,
        isLoadingFullMemberList,
        isLoadingDepartments,
        error,
      ];
}
