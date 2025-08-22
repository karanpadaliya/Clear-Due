class GetAllEmployeeRequest {
  final String? getAllEmployee;
  final String? companyId;
  final String? userId;
  final String? languageId;

  const GetAllEmployeeRequest({
    this.getAllEmployee,
    this.companyId,
    this.userId,
    this.languageId,
  });

  Map<String, dynamic> toJson() => {
    'getAllEmployee': getAllEmployee,
    'society_id': companyId,
    'user_id': 1401,
    'language_id': languageId,
  };
}
