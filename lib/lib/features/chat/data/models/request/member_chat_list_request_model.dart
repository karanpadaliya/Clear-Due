class MemberChatListRequestModel {
  String? getRecentChatMember;
  String? societyId;
  String? unitId;
  String? groupId;
  String? floorId;
  String? floorIdAccess;
  String? blockId;
  String? userType;
  String? userId;
  String? languageId;

  MemberChatListRequestModel(
      {this.getRecentChatMember,
      this.societyId,
      this.unitId,
      this.groupId,
      this.floorId,
      this.floorIdAccess,
      this.blockId,
      this.userType,
      this.userId,
      this.languageId});

  MemberChatListRequestModel.fromJson(Map<String, dynamic> json) {
    getRecentChatMember = json['getRecentChatMember'];
    societyId = json['society_id'];
    unitId = json['unit_id'];
    groupId = json['group_id'];
    floorId = json['floor_id'];
    floorIdAccess = json['floor_id_access'];
    blockId = json['block_id'];
    userType = json['user_type'];
    userId = json['user_id'];
    languageId = json['language_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['getRecentChatMember'] = this.getRecentChatMember;
    data['society_id'] = this.societyId;
    data['unit_id'] = this.unitId;
    data['group_id'] = this.groupId;
    data['floor_id'] = this.floorId;
    data['floor_id_access'] = this.floorIdAccess;
    data['block_id'] = this.blockId;
    data['user_type'] = this.userType;
    data['user_id'] = this.userId;
    data['language_id'] = this.languageId;
    return data;
  }
}
