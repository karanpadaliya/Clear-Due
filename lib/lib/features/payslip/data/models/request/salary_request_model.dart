class SalaryRequestModel {
  String? getSalaries;
  String? branchId;
  String? languageId;
  String? userId;
  String? companyId;
  String? departmentId;
  String? salaryYear;

  SalaryRequestModel({
    this.getSalaries,
    this.branchId,
    this.languageId,
    this.userId,
    this.companyId,
    this.departmentId,
    this.salaryYear,
  });

  SalaryRequestModel.fromJson(Map<String, dynamic> json) {
    getSalaries = json['getSalaries'];
    branchId = json['block_id'];
    languageId = json['language_id'];
    userId = json['user_id'];
    companyId = json['society_id'];
    departmentId = json['floor_id'];
    salaryYear = json['salary_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['getSalaries'] = this.getSalaries;
    data['block_id'] = this.branchId;
    data['language_id'] = this.languageId;
    data['user_id'] = this.userId;
    data['society_id'] = this.companyId;
    data['floor_id'] = this.departmentId;
    data['salary_year'] = this.salaryYear;
    return data;
  }
}
