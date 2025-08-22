class MemberListRequestModel {
  String? getMemberListNew;
  String? societyId;
  String? unitId;
  String? groupId;
  String? floorId;
  String? floorIdAccess;
  String? blockId;
  String? userType;
  String? userId;
  String? languageId;

  MemberListRequestModel(
      {this.getMemberListNew,
      this.societyId,
      this.unitId,
      this.groupId,
      this.floorId,
      this.floorIdAccess,
      this.blockId,
      this.userType,
      this.userId,
      this.languageId});

  MemberListRequestModel.fromJson(Map<String, dynamic> json) {
    getMemberListNew = json[' getMemberListNew'];
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
    data[' getMemberListNew'] = getMemberListNew;
    data['society_id'] = societyId;
    data['unit_id'] = unitId;
    data['group_id'] = groupId;
    data['floor_id'] = floorId;
    data['floor_id_access'] = floorIdAccess;
    data['block_id'] = blockId;
    data['user_type'] = userType;
    data['user_id'] = userId;
    data['language_id'] = languageId;
    return data;
  }
}
