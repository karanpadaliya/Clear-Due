class PastExeperienceRequestModel {
  String? getExperience;
  String? societyId;
  String? userId;
  String? languageId;

  PastExeperienceRequestModel(
      {this.getExperience, this.societyId, this.userId, this.languageId});

  PastExeperienceRequestModel.fromJson(Map<String, dynamic> json) {
    getExperience = json['getExperience'];
    societyId = json['society_id'];
    userId = json['user_id'];
    languageId = json['language_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['getExperience'] = this.getExperience;
    data['society_id'] = this.societyId;
    data['user_id'] = this.userId;
    data['language_id'] = this.languageId;
    return data;
  }
}