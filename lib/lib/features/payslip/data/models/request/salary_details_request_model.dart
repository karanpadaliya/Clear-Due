class SalaryDetailsRequestModel {
  String? getSalaryDetails;
  String? companyId;
  String? languageId;
  String? userId;
  String? salarySlipId;

  SalaryDetailsRequestModel({
    this.getSalaryDetails,
    this.companyId,
    this.languageId,
    this.userId,
    this.salarySlipId,
  });

  SalaryDetailsRequestModel.fromJson(Map<String, dynamic> json) {
    getSalaryDetails = json['getSalaryDetails'];
    companyId = json['society_id'];
    languageId = json['language_id'];
    userId = json['user_id'];
    salarySlipId = json['salary_slip_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['getSalaryDetails'] = this.getSalaryDetails;
    data['society_id'] = this.companyId;
    data['language_id'] = this.languageId;
    data['user_id'] = this.userId;
    data['salary_slip_id'] = this.salarySlipId;
    return data;
  }
}
