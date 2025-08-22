class AddSalaryIssueRequestModel {
  String? addSalaryIssue;
  String? companyId;
  String? languageId;
  String? userId;
  String? salarySlipId;
  String? salaryIssue;
  String? userName;

  AddSalaryIssueRequestModel({
    this.addSalaryIssue,
    this.companyId,
    this.languageId,
    this.userId,
    this.salarySlipId,
    this.salaryIssue,
    this.userName,
  });

  AddSalaryIssueRequestModel.fromJson(Map<String, dynamic> json) {
    addSalaryIssue = json['addSalaryIssue'];
    companyId = json['society_id'];
    languageId = json['language_id'];
    userId = json['user_id'];
    salarySlipId = json['salary_slip_id'];
    salaryIssue = json['salary_issue'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addSalaryIssue'] = this.addSalaryIssue;
    data['society_id'] = this.companyId;
    data['language_id'] = this.languageId;
    data['user_id'] = this.userId;
    data['salary_slip_id'] = this.salarySlipId;
    data['salary_issue'] = this.salaryIssue;
    data['user_name'] = this.userName;
    return data;
  }
}
