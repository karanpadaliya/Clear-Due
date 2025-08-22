class GetEmployeeRequestModel {
  final String? getMembersByDepartment;
  final String? checkAccessVisit;
  final String? societyId;
  final String? blockId;
  final String? floorId;
  final String? userId;
  final String? languageId;
  final String? selfUserType;

  GetEmployeeRequestModel({
    this.getMembersByDepartment,
    this.checkAccessVisit,
    this.societyId,
    this.blockId,
    this.floorId,
    this.userId,
    this.languageId,
    this.selfUserType,
  });

  Map<String, dynamic> toJson() => {
    'getMembersByDepartment': getMembersByDepartment,
    'checkAccessVisit': checkAccessVisit,
    'society_id': societyId,
    'block_id': blockId,
    'floor_id': floorId,
    'user_id': userId,
    'language_id': languageId,
    'self_user_type': selfUserType,
  };
}
