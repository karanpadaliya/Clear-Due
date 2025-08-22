class AppSupportRequestModel {
  final String getFaq;
  final String companyId;
  final String languageId;

  AppSupportRequestModel({
    required this.getFaq,
    required this.companyId,
    required this.languageId,
  });

  factory AppSupportRequestModel.fromJson(Map<String, dynamic> json) {
    return AppSupportRequestModel(
      getFaq: json['getFaq'] ?? '',
      companyId: json['company_id'] ?? '',
      languageId: json['language_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'getFaq': getFaq,
      'company_id': companyId,
      'language_id': languageId,
    };
  }
}