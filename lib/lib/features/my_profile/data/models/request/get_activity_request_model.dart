class GetActivityRequestModel {
  final String? getActivity;
  final String? companyId;
  final String? userId;
  final String? languageId;

  GetActivityRequestModel({
    this.getActivity,
    this.companyId,
    this.userId,
    this.languageId,
  });

  Map<String, dynamic> toJson() => {
    'getAcitivity': getActivity,
    'society_id': companyId,
    'user_id': userId,
    'language_id': languageId,
  };
}
