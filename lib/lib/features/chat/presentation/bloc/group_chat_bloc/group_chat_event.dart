part of 'group_chat_bloc.dart';

sealed class GroupChatEvent extends Equatable {
  const GroupChatEvent();

  @override
  List<Object> get props => [];
}

class SearchEventGroup extends GroupChatEvent {
  final String query;
  // final List chatList;

  const SearchEventGroup(
    this.query,
    //  this.chatList
  );

  @override
  List<Object> get props => [
    query,
    // chatList
  ];
}

// another api event
class GetGroupChatListEvent extends GroupChatEvent {
  @override
  List<Object> get props => [];
}
