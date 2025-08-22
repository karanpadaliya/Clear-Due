class AllEmployeeRequestModel {
  String? getEmployees;
  String? societyId;
  String? userId;
  String? languageId;

  AllEmployeeRequestModel(
      {this.getEmployees, this.societyId, this.userId, this.languageId});

  AllEmployeeRequestModel.fromJson(Map<String, dynamic> json) {
    getEmployees = json['getEmployees'];
    societyId = json['society_id'];
    userId = json['user_id'];
    languageId = json['language_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['getEmployees'] = this.getEmployees;
    data['society_id'] = this.societyId;
    data['user_id'] = this.userId;
    data['language_id'] = this.languageId;
    return data;
  }
}
