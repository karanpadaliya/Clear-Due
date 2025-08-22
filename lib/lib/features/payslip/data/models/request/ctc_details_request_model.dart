class CtcDetailsRequestModel {
  String? getCTCDetails;
  String? companyId;
  String? languageId;
  String? userId;

  CtcDetailsRequestModel({
    this.getCTCDetails,
    this.companyId,
    this.languageId,
    this.userId,
  });

  CtcDetailsRequestModel.fromJson(Map<String, dynamic> json) {
    getCTCDetails = json['getCTCDetails'];
    companyId = json['society_id'];
    languageId = json['language_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['getCTCDetails'] = this.getCTCDetails;
    data['society_id'] = this.companyId;
    data['language_id'] = this.languageId;
    data['user_id'] = this.userId;
    return data;
  }
}
