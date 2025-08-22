class GroupChatListRequestModel {
  String? getGroupListRecentNew;
  String? societyId;
  String? userId;
  String? unitId;
  String? blockId;
  String? floorId;
  String? zoneId;
  String? levelId;
  String? userToken;
  String? device;
  String? languageId;

  GroupChatListRequestModel(
      {this.getGroupListRecentNew,
      this.societyId,
      this.userId,
      this.unitId,
      this.blockId,
      this.floorId,
      this.zoneId,
      this.levelId,
      this.userToken,
      this.device,
      this.languageId});

  GroupChatListRequestModel.fromJson(Map<String, dynamic> json) {
    getGroupListRecentNew = json['getGroupListRecentNew'];
    societyId = json['society_id'];
    userId = json['user_id'];
    unitId = json['unit_id'];
    blockId = json['block_id'];
    floorId = json['floor_id'];
    zoneId = json['zone_id'];
    levelId = json['level_id'];
    userToken = json['user_token'];
    device = json['device'];
    languageId = json['language_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['getGroupListRecentNew'] = this.getGroupListRecentNew;
    data['society_id'] = this.societyId;
    data['user_id'] = this.userId;
    data['unit_id'] = this.unitId;
    data['block_id'] = this.blockId;
    data['floor_id'] = this.floorId;
    data['zone_id'] = this.zoneId;
    data['level_id'] = this.levelId;
    data['user_token'] = this.userToken;
    data['device'] = this.device;
    data['language_id'] = this.languageId;
    return data;
  }
}
