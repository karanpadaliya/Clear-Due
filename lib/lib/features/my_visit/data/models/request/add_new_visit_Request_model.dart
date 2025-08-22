class AddNewVisitRequestModel {
  String? addMyVisit;
  String? companyId;
  String? userId;
  String? retailerId;
  String? retailerName;
  String? visitDate;
  String? visitTime;
  String? visitTypeReason;
  String? visitRemark;
  String? currentLat;
  String? currentLang;
  String? retailerVisitById;
  String? userName;
  String? retailerVisitStartDatetime;
  String? isVisitRescheduled;
  String? rescheduleReason;
  String? rescheduledVisitId;
  String? rescheduledVisitDate;
  String? languageId;
  String? isOtherVisit;
  String? branchId;
  String? DepartmentId;
  String? otherUserId;
  String? otherUserName;
  String? managerName;
  String? physicalOrVirtualVisit;
  String? shiftTimeZone;
  String? slotId;
  String? thirdPartyJson;

  AddNewVisitRequestModel({
    this.addMyVisit,
    this.companyId,
    this.userId,
    this.retailerId,
    this.retailerName,
    this.visitDate,
    this.visitTime,
    this.visitTypeReason,
    this.visitRemark,
    this.currentLat,
    this.currentLang,
    this.retailerVisitById,
    this.userName,
    this.retailerVisitStartDatetime,
    this.isVisitRescheduled,
    this.rescheduleReason,
    this.rescheduledVisitId,
    this.rescheduledVisitDate,
    this.languageId,
    this.isOtherVisit,
    this.branchId,
    this.DepartmentId,
    this.otherUserId,
    this.otherUserName,
    this.managerName,
    this.physicalOrVirtualVisit,
    this.shiftTimeZone,
    this.slotId,
    this.thirdPartyJson,
  });

  Map<String, dynamic> toJson() => {
    'addMyVisit': addMyVisit,
    'society_id': companyId,
    'user_id': userId,
    'retailer_id': retailerId,
    'retailer_name': retailerName,
    'visit_date': visitDate,
    'visit_time': visitTime,
    'visit_type_reason': visitTypeReason,
    'visit_remark': visitRemark,
    'current_lat': currentLat,
    'current_lang': currentLang,
    'retailer_visit_by_id': retailerVisitById,
    'user_name': userName,
    'retailer_visit_start_datetime': retailerVisitStartDatetime,
    'is_visit_rescheduled': isVisitRescheduled,
    'reschedule_reason': rescheduleReason,
    'rescheduled_visit_id': rescheduledVisitId,
    'rescheduled_visit_date': rescheduledVisitDate,
    'language_id': languageId,
    'is_other_visit': isOtherVisit,
    'block_id': branchId,
    'floor_id': DepartmentId,
    'other_user_id': otherUserId,
    'other_user_name': otherUserName,
    'manager_name': managerName,
    'physical_or_virtual_visit': physicalOrVirtualVisit,
    'shift_time_zone': shiftTimeZone,
    'slot_id': slotId,
    'third_party_json': thirdPartyJson,
  };
}
