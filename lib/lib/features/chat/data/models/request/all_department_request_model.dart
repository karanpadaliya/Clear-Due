class AllDepartmentRequestModel {
  String? getAllDepartments;
  String? societyId;
  String? floorId;
  String? blockId;
  String? userId;
  String? languageId;

  AllDepartmentRequestModel(
      {this.getAllDepartments,
      this.societyId,
      this.floorId,
      this.blockId,
      this.userId,
      this.languageId});

  AllDepartmentRequestModel.fromJson(Map<String, dynamic> json) {
    getAllDepartments = json['getAllDepartments'];
    societyId = json['society_id'];
    floorId = json['floor_id'];
    blockId = json['block_id'];
    userId = json['user_id'];
    languageId = json['language_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['getAllDepartments'] = this.getAllDepartments;
    data['society_id'] = this.societyId;
    data['floor_id'] = this.floorId;
    data['block_id'] = this.blockId;
    data['user_id'] = this.userId;
    data['language_id'] = this.languageId;
    return data;
  }
}
