class AchievementEducationRequestModel {
  String? getAchivment;
  String? societyId;
  String? unitId;
  String? userId;
  String? languageId;

  AchievementEducationRequestModel(
      {this.getAchivment,
        this.societyId,
        this.unitId,
        this.userId,
        this.languageId});

  AchievementEducationRequestModel.fromJson(Map<String, dynamic> json) {
    getAchivment = json['getAchivment'];
    societyId = json['society_id'];
    unitId = json['unit_id'];
    userId = json['user_id'];
    languageId = json['language_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['getAchivment'] = this.getAchivment;
    data['society_id'] = this.societyId;
    data['unit_id'] = this.unitId;
    data['user_id'] = this.userId;
    data['language_id'] = this.languageId;
    return data;
  }
}
