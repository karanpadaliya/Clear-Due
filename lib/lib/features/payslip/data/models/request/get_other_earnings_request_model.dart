class GetOtherEarningsRequestModel {
  String? getOtherEarning;
  String? companyId;
  String? userId;
  String? languageId;
  String? leavePayoutYear;

  GetOtherEarningsRequestModel({
    this.getOtherEarning,
    this.companyId,
    this.userId,
    this.languageId,
    this.leavePayoutYear,
  });

  GetOtherEarningsRequestModel.fromJson(Map<String, dynamic> json) {
    getOtherEarning = json['getOtherEarning'];
    companyId = json['society_id'];
    userId = json['user_id'];
    languageId = json['language_id'];
    leavePayoutYear = json['leave_payout_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['getOtherEarning'] = this.getOtherEarning;
    data['society_id'] = this.companyId;
    data['user_id'] = this.userId;
    data['language_id'] = this.languageId;
    data['leave_payout_year'] = this.leavePayoutYear;
    return data;
  }
}
