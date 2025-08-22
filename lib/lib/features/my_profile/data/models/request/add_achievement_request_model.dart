class AddAchievementRequestModel {
  String? achievementRequest;
  String? societyId;
  String? userId;
  String? achievementChangeReq;
  String? userName;

  AddAchievementRequestModel(
      {this.achievementRequest,
        this.societyId,
        this.userId,
        this.achievementChangeReq,
        this.userName});

  AddAchievementRequestModel.fromJson(Map<String, dynamic> json) {
    achievementRequest = json['achievementRequest'];
    societyId = json['society_id'];
    userId = json['user_id'];
    achievementChangeReq = json['achievement_change_req'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['achievementRequest'] = this.achievementRequest;
    data['society_id'] = this.societyId;
    data['user_id'] = this.userId;
    data['achievement_change_req'] = this.achievementChangeReq;
    data['user_name'] = this.userName;
    return data;
  }
}
