class GetAdminWfhRequestModel {
  String? getAllWFH;
  String? languageId;
  String? userId;
  String? societyId;
  String? sort;
  String? startDate;
  String? endDate;
  String? allData;
  String? userIds;
  String? wfhStatus;
  String? searchUserId;

  GetAdminWfhRequestModel({
    this.getAllWFH,
    this.languageId,
    this.userId,
    this.societyId,
    this.sort,
    this.startDate,
    this.endDate,
    this.allData,
    this.userIds,
    this.wfhStatus,
    this.searchUserId,
  });

  GetAdminWfhRequestModel.fromJson(Map<String, dynamic> json) {
    getAllWFH = json['getAllWFH'];
    languageId = json['language_id'];
    userId = json['user_id'];
    societyId = json['society_id'];
    sort = json['sort'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    allData = json['all_data'];
    userIds = json['userIds'];
    wfhStatus = json['wfh_status'];
    searchUserId = json['search_user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['getAllWFH'] = getAllWFH;
    data['language_id'] = languageId;
    data['user_id'] = userId;
    data['society_id'] = societyId;
    data['sort'] = sort;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['all_data'] = allData;
    data['userIds'] = userIds;
    data['wfh_status'] = wfhStatus;
    data['search_user_id'] = searchUserId;
    return data;
  }
}

class AdminWfhApproveRequestModel {
  String? approveWFHNew;
  String? languageId;
  String? userId;
  String? societyId;
  String? unitId;
  String? floorId;
  String? wfhUserId;
  String? wfhAttendanceRange;
  String? wfhId;
  String? userName;
  String? wfhStartDate;
  String? wfhGroupId;
  String? fullDayToHalfDay;
  String? selfieAttendance;

  AdminWfhApproveRequestModel({
    this.approveWFHNew,
    this.languageId,
    this.userId,
    this.societyId,
    this.unitId,
    this.floorId,
    this.wfhUserId,
    this.wfhAttendanceRange,
    this.wfhId,
    this.userName,
    this.wfhStartDate,
    this.wfhGroupId,
    this.fullDayToHalfDay,
    this.selfieAttendance,
  });

  AdminWfhApproveRequestModel.fromJson(Map<String, dynamic> json) {
    approveWFHNew = json['approveWFHNew'];
    languageId = json['language_id'];
    userId = json['user_id'];
    societyId = json['society_id'];
    unitId = json['unit_id'];
    floorId = json['floor_id'];
    wfhUserId = json['wfh_user_id'];
    wfhAttendanceRange = json['wfh_attendance_range'];
    wfhId = json['wfh_id'];
    userName = json['user_name'];
    wfhStartDate = json['wfh_start_date'];
    wfhGroupId = json['wfh_group_id'];
    fullDayToHalfDay = json['full_day_to_half_day'];
    selfieAttendance = json['selfie_attendance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['approveWFHNew'] = approveWFHNew;
    data['language_id'] = languageId;
    data['user_id'] = userId;
    data['society_id'] = societyId;
    data['unit_id'] = unitId;
    data['floor_id'] = floorId;
    data['wfh_user_id'] = wfhUserId;
    data['wfh_attendance_range'] = wfhAttendanceRange;
    data['wfh_id'] = wfhId;
    data['user_name'] = userName;
    data['wfh_start_date'] = wfhStartDate;
    data['wfh_group_id'] = wfhGroupId;
    data['full_day_to_half_day'] = fullDayToHalfDay;
    data['selfie_attendance'] = selfieAttendance;
    return data;
  }
}

class AdminWfhRejectRequestModel {
  String? rejectWFHNew;
  String? languageId;
  String? userId;
  String? societyId;
  String? floorId;
  String? wfhUserId;
  String? wfhId;
  String? userName;
  String? wfhStartDate;
  String? wfhDeclinedReason;

  AdminWfhRejectRequestModel({
    this.rejectWFHNew,
    this.languageId,
    this.userId,
    this.societyId,
    this.floorId,
    this.wfhUserId,
    this.wfhId,
    this.userName,
    this.wfhStartDate,
    this.wfhDeclinedReason,
  });

  AdminWfhRejectRequestModel.fromJson(Map<String, dynamic> json) {
    rejectWFHNew = json['rejectWFHNew'];
    languageId = json['language_id'];
    userId = json['user_id'];
    societyId = json['society_id'];
    floorId = json['floor_id'];
    wfhUserId = json['wfh_user_id'];
    wfhId = json['wfh_id'];
    userName = json['user_name'];
    wfhStartDate = json['wfh_start_date'];
    wfhDeclinedReason = json['wfh_declined_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rejectWFHNew'] = rejectWFHNew;
    data['language_id'] = languageId;
    data['user_id'] = userId;
    data['society_id'] = societyId;
    data['floor_id'] = floorId;
    data['wfh_user_id'] = wfhUserId;
    data['wfh_id'] = wfhId;
    data['user_name'] = userName;
    data['wfh_start_date'] = wfhStartDate;
    data['wfh_declined_reason'] = wfhDeclinedReason;
    return data;
  }
}
