class GetDepartmentRequestModel {
  final String? getDepartmentsDiscussion;
  final String? Userid;
  final String? LanguageId;
  final String? companyId;
  final String? blockId;
  final String? SelectedBlockId;
  final String? MyFloorId;


  const GetDepartmentRequestModel({
    this.getDepartmentsDiscussion,
    this.Userid,
    this.LanguageId,
    this.companyId,
    this.blockId,
    this.SelectedBlockId,
    this.MyFloorId,
  });

  Map<String, dynamic> toJson() => {
    'getDepartmentsNew': getDepartmentsDiscussion,
    'language_id': LanguageId,
    'society_id': companyId,
    'user_id': Userid,
    'block_id': blockId,
    'selected_block_id': SelectedBlockId,
    'my_floor_id': MyFloorId,
  };
}