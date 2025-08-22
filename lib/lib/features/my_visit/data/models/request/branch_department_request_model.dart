class BranchDepartmentRequestModel {
  final String? checkAccessVisit;
  final String? Userid;
  final String? LanguageId;
  final String? companyId;


  const BranchDepartmentRequestModel({
    this.checkAccessVisit,
    this.Userid,
    this.LanguageId,
    this.companyId,
  });

  Map<String, dynamic> toJson() => {
    'checkAccessVisit': checkAccessVisit,
    'language_id': LanguageId,
    'society_id': companyId,
    'user_id': Userid,
  };
}