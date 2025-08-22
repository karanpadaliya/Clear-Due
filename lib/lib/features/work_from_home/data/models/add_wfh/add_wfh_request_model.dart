class GetMyWfhRequestModel {
  String? getMyWFH;
  String? societyId;
  String? unitId;
  String? userId;
  String? languageId;
  String? year;
  String? month;

  GetMyWfhRequestModel({
    this.getMyWFH,
    this.societyId,
    this.unitId,
    this.userId,
    this.languageId,
    this.year,
    this.month,
  });

  GetMyWfhRequestModel.fromJson(Map<String, dynamic> json) {
    getMyWFH = json['getMyWFH'];
    societyId = json['society_id'];
    unitId = json['unit_id'];
    userId = json['user_id'];
    languageId = json['language_id'];
    year = json['year'];
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['getMyWFH'] = this.getMyWFH;
    data['society_id'] = this.societyId;
    data['unit_id'] = this.unitId;
    data['user_id'] = this.userId;
    data['language_id'] = this.languageId;
    data['year'] = this.year;
    data['month'] = this.month;
    return data;
  }
}

class DeleteWfhRequestModel {
  String? deleteWFHRequest;
  String? societyId;
  String? unitId;
  String? userId;
  String? languageId;
  String? wfhId;
  DeleteWfhRequestModel({
    this.deleteWFHRequest,
    this.societyId,
    this.unitId,
    this.userId,
    this.languageId,
    this.wfhId,
  });

  DeleteWfhRequestModel.fromJson(Map<String, dynamic> json) {
    deleteWFHRequest = json['deleteWFHRequest'];
    societyId = json['society_id'];
    unitId = json['unit_id'];
    userId = json['user_id'];
    languageId = json['language_id'];
    wfhId = json['wfh_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deleteWFHRequest'] = deleteWFHRequest;
    data['society_id'] = societyId;
    data['unit_id'] = unitId;
    data['user_id'] = userId;
    data['language_id'] = languageId;
    data['wfh_id'] = wfhId;
    return data;
  }
}

class AddWfhRequestModel {
  String? addWFHRequest;
  String? societyId;
  String? unitId;
  String? userId;
  String? languageId;
  String? wfhId;
  String? wfhType;
  String? wfhFrom;
  String? wfhTo;
  String? wfhReason;
  String? wfhAddress;
  String? wfhLatitude;
  String? wfhLongitude;
  String? wfhApprovedBy;
  String? wfhApprovedDate;
  String? wfhStatus;

  AddWfhRequestModel({
    this.addWFHRequest,
    this.societyId,
    this.unitId,
    this.userId,
    this.languageId,
    this.wfhId,
    this.wfhType,
    this.wfhFrom,
    this.wfhTo,
    this.wfhReason,
    this.wfhAddress,
    this.wfhLatitude,
    this.wfhLongitude,
    this.wfhApprovedBy,
    this.wfhApprovedDate,
    this.wfhStatus,
  });

  AddWfhRequestModel.fromJson(Map<String, dynamic> json) {
    addWFHRequest = json['addWFHRequest'];
    societyId = json['society_id'];
    unitId = json['unit_id'];
    userId = json['user_id'];
    languageId = json['language_id'];
    wfhId = json['wfh_id'];
    wfhType = json['wfh_type'];
    wfhFrom = json['wfh_from'];
    wfhTo = json['wfh_to'];
    wfhReason = json['wfh_reason'];
    wfhAddress = json['wfh_address'];
    wfhLatitude = json['wfh_latitude'];
    wfhLongitude = json['wfh_longitude'];
    wfhApprovedBy = json['wfh_approved_by'];
    wfhApprovedDate = json['wfh_approved_date'];
    wfhStatus = json['wfh_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addWFHRequest'] = this.addWFHRequest;
    data['society_id'] = this.societyId;
    data['unit_id'] = this.unitId;
    data['user_id'] = this.userId;
    data['language_id'] = this.languageId;
    data['wfh_id'] = this.wfhId;
    data['wfh_type'] = this.wfhType;
    data['wfh_from'] = this.wfhFrom;
    data['wfh_to'] = this.wfhTo;
    data['wfh_reason'] = this.wfhReason;
    data['wfh_address'] = this.wfhAddress;
    data['wfh_latitude'] = this.wfhLatitude;
    data['wfh_longitude'] = this.wfhLongitude;
    data['wfh_approved_by'] = this.wfhApprovedBy;
    data['wfh_approved_date'] = this.wfhApprovedDate;
    data['wfh_status'] = this.wfhStatus;
    return data;
  }
}
