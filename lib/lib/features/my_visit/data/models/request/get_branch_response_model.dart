class GetBranchRequestModel {
  final String? getBranchList;
  final String? Userid;
  final String? LanguageId;
  final String? companyId;
  final String? blockId;

  const GetBranchRequestModel({
    this.getBranchList,
    this.Userid,
    this.LanguageId,
    this.companyId,
    this.blockId,
  });

  Map<String, dynamic> toJson() => {
    'getBranchList': getBranchList,
    'language_id': LanguageId,
    'society_id': companyId,
    'user_id': Userid,
    'block_id': blockId,
  };
}
