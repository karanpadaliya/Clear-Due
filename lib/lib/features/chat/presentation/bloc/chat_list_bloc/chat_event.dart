part of 'chat_bloc.dart';

sealed class ChatListEvent extends Equatable {
  const ChatListEvent();

  @override
  List<Object> get props => [];
}

class SearchEvent extends ChatListEvent {
  final String query;
  // final List chatList;

  const SearchEvent(this.query,
  //  this.chatList
   );

  @override
  List<Object> get props => [query,
  // chatList
  ];
}

class RemoveAvatar extends ChatListEvent {
  final List<Map<String, dynamic>> avtarList;
  final int index;

  const RemoveAvatar(this.avtarList , this.index);
  @override
  List<Object> get props => [avtarList , index];
  
}

// ignore: must_be_immutable
class GetMemberListEvent extends ChatListEvent {
  String? departmentId;
  GetMemberListEvent(this.departmentId);
  @override
  List<Object> get props => [departmentId ?? '0'];
}

class GetAllDepartmentsEvent extends ChatListEvent {
  @override
  List<Object> get props => [];
}

// Member ChatList
class GetMemberChatListEvent extends ChatListEvent {
  @override
  List<Object> get props => [];
}

class SearchMemberEvent extends ChatListEvent {
  final String query;
  // final List chatList;

  const SearchMemberEvent(
    this.query,
    //  this.chatList
  );

  @override
  List<Object> get props => [
    query,
    // chatList
  ];
}


// class GetGroupChatListEvent extends ChatListEvent {
//   @override
//   List<Object> get props => [];
// }