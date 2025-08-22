class PreviousChatRequestModel {
  String? getPrvChatNew;
  String? societyId;
  String? userId;
  // String? userId;
  String? sentTo;
  String? isRead;
  String? chatId;
  String? limitChat;

  PreviousChatRequestModel(
      {this.getPrvChatNew,
      this.societyId,
      this.userId,
      // this.userId,
      this.sentTo,
      this.isRead,
      this.chatId,
      this.limitChat});

  PreviousChatRequestModel.fromJson(Map<String, dynamic> json) {
    getPrvChatNew = json['getPrvChatNew'];
    societyId = json['society_id'];
    userId = json['user_id'];
    userId = json['userId'];
    sentTo = json['sentTo'];
    isRead = json['isRead'];
    chatId = json['chat_id'];
    limitChat = json['limit_chat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['getPrvChatNew'] = this.getPrvChatNew;
    data['society_id'] = this.societyId;
    data['user_id'] = this.userId;
    data['userId'] = this.userId;
    data['sentTo'] = this.sentTo;
    data['isRead'] = this.isRead;
    data['chat_id'] = this.chatId;
    data['limit_chat'] = this.limitChat;
    return data;
  }
}
