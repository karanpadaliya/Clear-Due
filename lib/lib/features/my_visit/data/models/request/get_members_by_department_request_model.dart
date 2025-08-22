class GetMembersByDepartmentRequestModel {
  String? getMembersByDepartment;
  String? societyId;
  String? blockId;
  String? floorId;
  String? userId;
  String? languageId;

  GetMembersByDepartmentRequestModel({
    this.getMembersByDepartment,
    this.societyId,
    this.blockId,
    this.floorId,
    this.userId,
    this.languageId,
  });

  Map<String, dynamic> toJson() => {
    'getMembersByDepartment': getMembersByDepartment,
    'society_id': societyId,
    'block_id': blockId,
    'floor_id': floorId,
    'user_id': userId,
    'language_id': languageId,
  };
}
