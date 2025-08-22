// To parse this JSON data, do
//
//     final myVisitModel = myVisitModelFromJson(jsonString);
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/visit_entity.dart';

part 'visit_model.g.dart';

MyVisitModel myVisitModelFromJson(String str) =>
    MyVisitModel.fromJson(json.decode(str));

String myVisitModelToJson(MyVisitModel data) => json.encode(data.toJson());

@JsonSerializable()
class MyVisitModel {
  @JsonKey(name: 'expense_category')
  List<ExpenseCategory>? expenseCategory;
  @JsonKey(name: 'start_visit_with_otp')
  bool? startVisitWithOtp;
  @JsonKey(name: 'allow_out_of_range_visit_start_end')
  String? allowOutOfRangeVisitStartEnd;
  @JsonKey(name: 'end_visit_view_additional_field')
  bool? endVisitViewAdditionalField;
  @JsonKey(name: 'take_end_visit_report')
  bool? takeEndVisitReport;
  @JsonKey(name: 'my_visits')
  List<MyVisit>? myVisits;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'status')
  String? status;

  MyVisitModel({
    this.expenseCategory,
    this.startVisitWithOtp,
    this.allowOutOfRangeVisitStartEnd,
    this.endVisitViewAdditionalField,
    this.takeEndVisitReport,
    this.myVisits,
    this.message,
    this.status,
  });

  factory MyVisitModel.fromJson(Map<String, dynamic> json) =>
      _$MyVisitModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyVisitModelToJson(this);
}

@JsonSerializable()
class ExpenseCategory {
  @JsonKey(name: 'expense_category_id')
  String? expenseCategoryId;
  @JsonKey(name: 'expense_category_name')
  String? expenseCategoryName;

  ExpenseCategory({this.expenseCategoryId, this.expenseCategoryName});

  factory ExpenseCategory.fromJson(Map<String, dynamic> json) =>
      _$ExpenseCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseCategoryToJson(this);
}

@JsonSerializable()
class MyVisit {
  @JsonKey(name: 'retailer_visit_by_id')
  String? retailerVisitById;
  @JsonKey(name: 'retailer_visit_id')
  String? retailerVisitId;
  @JsonKey(name: 'retailer_id')
  String? retailerId;
  @JsonKey(name: 'work_report_id')
  String? workReportId;
  @JsonKey(name: 'template_id')
  String? templateId;
  @JsonKey(name: 'template_name')
  String? templateName;
  @JsonKey(name: 'society_id')
  String? societyId;
  @JsonKey(name: 'retailer_name')
  String? retailerName;
  @JsonKey(name: 'retailer_code')
  String? retailerCode;
  @JsonKey(name: 'retailer_contact_person')
  String? retailerContactPerson;
  @JsonKey(name: 'retailer_contact_person_number')
  String? retailerContactPersonNumber;
  @JsonKey(name: 'retailer_contact_person_number_with_country_code')
  String? retailerContactPersonNumberWithCountryCode;
  @JsonKey(name: 'retailer_address')
  String? retailerAddress;
  @JsonKey(name: 'retailer_latitude')
  String? retailerLatitude;
  @JsonKey(name: 'retailer_longitude')
  String? retailerLongitude;
  @JsonKey(name: 'retailer_geofence_range')
  String? retailerGeofenceRange;
  @JsonKey(name: 'visit_added_by_type')
  String? visitAddedByType;
  @JsonKey(name: 'visit_end_remark')
  String? visitEndRemark;
  @JsonKey(name: 'end_visit_attachment')
  String? endVisitAttachment;
  @JsonKey(name: 'reschedule_attachment')
  String? rescheduleAttachment;
  @JsonKey(name: 'is_visit_end_request')
  String? isVisitEndRequest;
  @JsonKey(name: 'visit_status')
  String? visitStatus;
  @JsonKey(name: 'visit_status_change_name')
  String? visitStatusChangeName;
  @JsonKey(name: 'visit_end_request_status')
  String? visitEndRequestStatus;
  @JsonKey(name: 'visit_end_request_status_reason')
  String? visitEndRequestStatusReason;
  @JsonKey(name: 'visit_added_by')
  String? visitAddedBy;
  @JsonKey(name: 'visit_added_by_name')
  String? visitAddedByName;
  @JsonKey(name: 'manager_names')
  String? managerNames;
  @JsonKey(name: 'visit_type')
  String? visitType;
  @JsonKey(name: 'visit_reject_reason')
  String? visitRejectReason;
  @JsonKey(name: 'physical_or_virtual_visit')
  String? physicalOrVirtualVisit;
  @JsonKey(name: 'is_auto_start_visit')
  String? isAutoStartVisit;
  @JsonKey(name: 'is_auto_end_visit')
  String? isAutoEndVisit;
  @JsonKey(name: 'is_end_visit_data_added')
  String? isEndVisitDataAdded;
  @JsonKey(name: 'order_taken')
  String? orderTaken;
  @JsonKey(name: 'slot_id')
  String? slotId;
  @JsonKey(name: 'visit_end_request_statue_change_name')
  String? visitEndRequestStatueChangeName;
  @JsonKey(name: 'crm_meeting_id')
  String? crmMeetingId;
  @JsonKey(name: 'crm_outcome_id')
  String? crmOutcomeId;
  @JsonKey(name: 'take_end_visit_details')
  bool? takeEndVisitDetails;
  @JsonKey(name: 'visit_end_request_date')
  String? visitEndRequestDate;
  @JsonKey(name: 'visit_end_request_statue_change_date')
  String? visitEndRequestStatueChangeDate;
  @JsonKey(name: 'visit_purpose')
  String? visitPurpose;
  @JsonKey(name: 'my_visit_status')
  String? myVisitStatus;
  @JsonKey(name: 'is_visit_rescheduled')
  bool? isVisitRescheduled;
  @JsonKey(name: 'reschedule_reason')
  String? rescheduleReason;
  @JsonKey(name: 'retailer_visit_start_date_pass')
  DateTime? retailerVisitStartDatePass;
  @JsonKey(name: 'retailer_visit_start_time_pass')
  String? retailerVisitStartTimePass;
  @JsonKey(name: 'end_visit_area')
  String? endVisitArea;
  @JsonKey(name: 'end_visit_catalogue')
  String? endVisitCatalogue;
  @JsonKey(name: 'end_visit_contact_person_name')
  String? endVisitContactPersonName;
  @JsonKey(name: 'visit_type_reason')
  String? visitTypeReason;
  @JsonKey(name: 'follow_up_visit_date')
  String? followUpVisitDate;
  @JsonKey(name: 'retailer_visit_start_date')
  String? retailerVisitStartDate;
  @JsonKey(name: 'my_visit_start_only_time')
  String? myVisitStartOnlyTime;
  @JsonKey(name: 'my_visit_start_datetime')
  String? myVisitStartDatetime;
  @JsonKey(name: 'my_visit_start_datetime_view')
  String? myVisitStartDatetimeView;
  @JsonKey(name: 'retailer_visit_start_time')
  String? retailerVisitStartTime;
  @JsonKey(name: 'retailer_visit_end_date')
  String? retailerVisitEndDate;
  @JsonKey(name: 'slot_schedule_time')
  String? slotScheduleTime;
  @JsonKey(name: 'is_date_gone')
  bool? isDateGone;
  @JsonKey(name: 'show_end_button')
  bool? showEndButton;
  @JsonKey(name: 'is_my_visit_started')
  bool? isMyVisitStarted;
  @JsonKey(name: 'equipment_button_visibility')
  String? equipmentButtonVisibility;
  @JsonKey(name: 'is_my_visit_ended')
  bool? isMyVisitEnded;
  @JsonKey(name: 'share_content')
  String? shareContent;
  @JsonKey(name: 'start_visit_distance_meter')
  String? startVisitDistanceMeter;
  @JsonKey(name: 'distance_meter')
  String? distanceMeter;
  @JsonKey(name: 'distance_km')
  String? distanceKm;
  @JsonKey(name: 'distance_sort')
  String? distanceSort;
  @JsonKey(name: 'distance_in_km_new')
  String? distanceInKmNew;
  @JsonKey(name: 'is_equipment_buttons_visible')
  bool? isEquipmentButtonsVisible;
  @JsonKey(name: 'service_button_visibility')
  bool? serviceButtonVisibility;

  MyVisit({
    this.retailerVisitById,
    this.retailerVisitId,
    this.retailerId,
    this.workReportId,
    this.templateId,
    this.templateName,
    this.societyId,
    this.retailerName,
    this.retailerCode,
    this.retailerContactPerson,
    this.retailerContactPersonNumber,
    this.retailerContactPersonNumberWithCountryCode,
    this.retailerAddress,
    this.retailerLatitude,
    this.retailerLongitude,
    this.retailerGeofenceRange,
    this.visitAddedByType,
    this.visitEndRemark,
    this.endVisitAttachment,
    this.rescheduleAttachment,
    this.isVisitEndRequest,
    this.visitStatus,
    this.visitStatusChangeName,
    this.visitEndRequestStatus,
    this.visitEndRequestStatusReason,
    this.visitAddedBy,
    this.visitAddedByName,
    this.managerNames,
    this.visitType,
    this.visitRejectReason,
    this.physicalOrVirtualVisit,
    this.isAutoStartVisit,
    this.isAutoEndVisit,
    this.isEndVisitDataAdded,
    this.orderTaken,
    this.slotId,
    this.visitEndRequestStatueChangeName,
    this.crmMeetingId,
    this.crmOutcomeId,
    this.takeEndVisitDetails,
    this.visitEndRequestDate,
    this.visitEndRequestStatueChangeDate,
    this.visitPurpose,
    this.myVisitStatus,
    this.isVisitRescheduled,
    this.rescheduleReason,
    this.retailerVisitStartDatePass,
    this.retailerVisitStartTimePass,
    this.endVisitArea,
    this.endVisitCatalogue,
    this.endVisitContactPersonName,
    this.visitTypeReason,
    this.followUpVisitDate,
    this.retailerVisitStartDate,
    this.myVisitStartOnlyTime,
    this.myVisitStartDatetime,
    this.myVisitStartDatetimeView,
    this.retailerVisitStartTime,
    this.retailerVisitEndDate,
    this.slotScheduleTime,
    this.isDateGone,
    this.showEndButton,
    this.isMyVisitStarted,
    this.equipmentButtonVisibility,
    this.isMyVisitEnded,
    this.shareContent,
    this.startVisitDistanceMeter,
    this.distanceMeter,
    this.distanceKm,
    this.distanceSort,
    this.distanceInKmNew,
    this.isEquipmentButtonsVisible,
    this.serviceButtonVisibility,
  });

  factory MyVisit.fromJson(Map<String, dynamic> json) =>
      _$MyVisitFromJson(json);

  Map<String, dynamic> toJson() => _$MyVisitToJson(this);
}

extension MyVisitModelMapper on MyVisitModel {
  MyVisitModelEntity toEntity() => MyVisitModelEntity(
    expenseCategory: expenseCategory?.map((e) => e.toEntity()).toList(),
    startVisitWithOtp: startVisitWithOtp,
    allowOutOfRangeVisitStartEnd: allowOutOfRangeVisitStartEnd,
    endVisitViewAdditionalField: endVisitViewAdditionalField,
    takeEndVisitReport: takeEndVisitReport,
    myVisits: myVisits?.map((e) => e.toEntity()).toList(),
    message: message,
    status: status,
  );
}

extension ExpenseCategoryMapper on ExpenseCategory {
  ExpenseCategoryEntity toEntity() => ExpenseCategoryEntity(
    expenseCategoryId: expenseCategoryId,
    expenseCategoryName: expenseCategoryName,
  );
}

extension MyVisitMapper on MyVisit {
  MyVisitEntity toEntity() => MyVisitEntity(
    retailerVisitById: retailerVisitById,
    retailerVisitId: retailerVisitId,
    retailerId: retailerId,
    workReportId: workReportId,
    templateId: templateId,
    templateName: templateName,
    societyId: societyId,
    retailerName: retailerName,
    retailerCode: retailerCode,
    retailerContactPerson: retailerContactPerson,
    retailerContactPersonNumber: retailerContactPersonNumber,
    retailerContactPersonNumberWithCountryCode:
        retailerContactPersonNumberWithCountryCode,
    retailerAddress: retailerAddress,
    retailerLatitude: retailerLatitude,
    retailerLongitude: retailerLongitude,
    retailerGeofenceRange: retailerGeofenceRange,
    visitAddedByType: visitAddedByType,
    visitEndRemark: visitEndRemark,
    endVisitAttachment: endVisitAttachment,
    rescheduleAttachment: rescheduleAttachment,
    isVisitEndRequest: isVisitEndRequest,
    visitStatus: visitStatus,
    visitStatusChangeName: visitStatusChangeName,
    visitEndRequestStatus: visitEndRequestStatus,
    visitEndRequestStatusReason: visitEndRequestStatusReason,
    visitAddedBy: visitAddedBy,
    visitAddedByName: visitAddedByName,
    managerNames: managerNames,
    visitType: visitType,
    visitRejectReason: visitRejectReason,
    physicalOrVirtualVisit: physicalOrVirtualVisit,
    isAutoStartVisit: isAutoStartVisit,
    isAutoEndVisit: isAutoEndVisit,
    isEndVisitDataAdded: isEndVisitDataAdded,
    orderTaken: orderTaken,
    slotId: slotId,
    visitEndRequestStatueChangeName: visitEndRequestStatueChangeName,
    crmMeetingId: crmMeetingId,
    crmOutcomeId: crmOutcomeId,
    takeEndVisitDetails: takeEndVisitDetails,
    visitEndRequestDate: visitEndRequestDate,
    visitEndRequestStatueChangeDate: visitEndRequestStatueChangeDate,
    visitPurpose: visitPurpose,
    myVisitStatus: myVisitStatus,
    isVisitRescheduled: isVisitRescheduled,
    rescheduleReason: rescheduleReason,
    retailerVisitStartDatePass: retailerVisitStartDatePass,
    retailerVisitStartTimePass: retailerVisitStartTimePass,
    endVisitArea: endVisitArea,
    endVisitCatalogue: endVisitCatalogue,
    endVisitContactPersonName: endVisitContactPersonName,
    visitTypeReason: visitTypeReason,
    followUpVisitDate: followUpVisitDate,
    retailerVisitStartDate: retailerVisitStartDate,
    myVisitStartOnlyTime: myVisitStartOnlyTime,
    myVisitStartDatetime: myVisitStartDatetime,
    myVisitStartDatetimeView: myVisitStartDatetimeView,
    retailerVisitStartTime: retailerVisitStartTime,
    retailerVisitEndDate: retailerVisitEndDate,
    slotScheduleTime: slotScheduleTime,
    isDateGone: isDateGone,
    showEndButton: showEndButton,
    isMyVisitStarted: isMyVisitStarted,
    equipmentButtonVisibility: equipmentButtonVisibility,
    isMyVisitEnded: isMyVisitEnded,
    shareContent: shareContent,
    startVisitDistanceMeter: startVisitDistanceMeter,
    distanceMeter: distanceMeter,
    distanceKm: distanceKm,
    distanceSort: distanceSort,
    distanceInKmNew: distanceInKmNew,
    isEquipmentButtonsVisible: isEquipmentButtonsVisible,
    serviceButtonVisibility: serviceButtonVisibility,
  );
}
