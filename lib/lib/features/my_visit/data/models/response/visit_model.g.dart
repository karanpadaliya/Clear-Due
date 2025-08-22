// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyVisitModel _$MyVisitModelFromJson(Map<String, dynamic> json) => MyVisitModel(
      expenseCategory: (json['expense_category'] as List<dynamic>?)
          ?.map((e) => ExpenseCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      startVisitWithOtp: json['start_visit_with_otp'] as bool?,
      allowOutOfRangeVisitStartEnd:
          json['allow_out_of_range_visit_start_end'] as String?,
      endVisitViewAdditionalField:
          json['end_visit_view_additional_field'] as bool?,
      takeEndVisitReport: json['take_end_visit_report'] as bool?,
      myVisits: (json['my_visits'] as List<dynamic>?)
          ?.map((e) => MyVisit.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$MyVisitModelToJson(MyVisitModel instance) =>
    <String, dynamic>{
      'expense_category': instance.expenseCategory,
      'start_visit_with_otp': instance.startVisitWithOtp,
      'allow_out_of_range_visit_start_end':
          instance.allowOutOfRangeVisitStartEnd,
      'end_visit_view_additional_field': instance.endVisitViewAdditionalField,
      'take_end_visit_report': instance.takeEndVisitReport,
      'my_visits': instance.myVisits,
      'message': instance.message,
      'status': instance.status,
    };

ExpenseCategory _$ExpenseCategoryFromJson(Map<String, dynamic> json) =>
    ExpenseCategory(
      expenseCategoryId: json['expense_category_id'] as String?,
      expenseCategoryName: json['expense_category_name'] as String?,
    );

Map<String, dynamic> _$ExpenseCategoryToJson(ExpenseCategory instance) =>
    <String, dynamic>{
      'expense_category_id': instance.expenseCategoryId,
      'expense_category_name': instance.expenseCategoryName,
    };

MyVisit _$MyVisitFromJson(Map<String, dynamic> json) => MyVisit(
      retailerVisitById: json['retailer_visit_by_id'] as String?,
      retailerVisitId: json['retailer_visit_id'] as String?,
      retailerId: json['retailer_id'] as String?,
      workReportId: json['work_report_id'] as String?,
      templateId: json['template_id'] as String?,
      templateName: json['template_name'] as String?,
      societyId: json['society_id'] as String?,
      retailerName: json['retailer_name'] as String?,
      retailerCode: json['retailer_code'] as String?,
      retailerContactPerson: json['retailer_contact_person'] as String?,
      retailerContactPersonNumber:
          json['retailer_contact_person_number'] as String?,
      retailerContactPersonNumberWithCountryCode:
          json['retailer_contact_person_number_with_country_code'] as String?,
      retailerAddress: json['retailer_address'] as String?,
      retailerLatitude: json['retailer_latitude'] as String?,
      retailerLongitude: json['retailer_longitude'] as String?,
      retailerGeofenceRange: json['retailer_geofence_range'] as String?,
      visitAddedByType: json['visit_added_by_type'] as String?,
      visitEndRemark: json['visit_end_remark'] as String?,
      endVisitAttachment: json['end_visit_attachment'] as String?,
      rescheduleAttachment: json['reschedule_attachment'] as String?,
      isVisitEndRequest: json['is_visit_end_request'] as String?,
      visitStatus: json['visit_status'] as String?,
      visitStatusChangeName: json['visit_status_change_name'] as String?,
      visitEndRequestStatus: json['visit_end_request_status'] as String?,
      visitEndRequestStatusReason:
          json['visit_end_request_status_reason'] as String?,
      visitAddedBy: json['visit_added_by'] as String?,
      visitAddedByName: json['visit_added_by_name'] as String?,
      managerNames: json['manager_names'] as String?,
      visitType: json['visit_type'] as String?,
      visitRejectReason: json['visit_reject_reason'] as String?,
      physicalOrVirtualVisit: json['physical_or_virtual_visit'] as String?,
      isAutoStartVisit: json['is_auto_start_visit'] as String?,
      isAutoEndVisit: json['is_auto_end_visit'] as String?,
      isEndVisitDataAdded: json['is_end_visit_data_added'] as String?,
      orderTaken: json['order_taken'] as String?,
      slotId: json['slot_id'] as String?,
      visitEndRequestStatueChangeName:
          json['visit_end_request_statue_change_name'] as String?,
      crmMeetingId: json['crm_meeting_id'] as String?,
      crmOutcomeId: json['crm_outcome_id'] as String?,
      takeEndVisitDetails: json['take_end_visit_details'] as bool?,
      visitEndRequestDate: json['visit_end_request_date'] as String?,
      visitEndRequestStatueChangeDate:
          json['visit_end_request_statue_change_date'] as String?,
      visitPurpose: json['visit_purpose'] as String?,
      myVisitStatus: json['my_visit_status'] as String?,
      isVisitRescheduled: json['is_visit_rescheduled'] as bool?,
      rescheduleReason: json['reschedule_reason'] as String?,
      retailerVisitStartDatePass: json['retailer_visit_start_date_pass'] == null
          ? null
          : DateTime.parse(json['retailer_visit_start_date_pass'] as String),
      retailerVisitStartTimePass:
          json['retailer_visit_start_time_pass'] as String?,
      endVisitArea: json['end_visit_area'] as String?,
      endVisitCatalogue: json['end_visit_catalogue'] as String?,
      endVisitContactPersonName:
          json['end_visit_contact_person_name'] as String?,
      visitTypeReason: json['visit_type_reason'] as String?,
      followUpVisitDate: json['follow_up_visit_date'] as String?,
      retailerVisitStartDate: json['retailer_visit_start_date'] as String?,
      myVisitStartOnlyTime: json['my_visit_start_only_time'] as String?,
      myVisitStartDatetime: json['my_visit_start_datetime'] as String?,
      myVisitStartDatetimeView: json['my_visit_start_datetime_view'] as String?,
      retailerVisitStartTime: json['retailer_visit_start_time'] as String?,
      retailerVisitEndDate: json['retailer_visit_end_date'] as String?,
      slotScheduleTime: json['slot_schedule_time'] as String?,
      isDateGone: json['is_date_gone'] as bool?,
      showEndButton: json['show_end_button'] as bool?,
      isMyVisitStarted: json['is_my_visit_started'] as bool?,
      equipmentButtonVisibility: json['equipment_button_visibility'] as String?,
      isMyVisitEnded: json['is_my_visit_ended'] as bool?,
      shareContent: json['share_content'] as String?,
      startVisitDistanceMeter: json['start_visit_distance_meter'] as String?,
      distanceMeter: json['distance_meter'] as String?,
      distanceKm: json['distance_km'] as String?,
      distanceSort: json['distance_sort'] as String?,
      distanceInKmNew: json['distance_in_km_new'] as String?,
      isEquipmentButtonsVisible: json['is_equipment_buttons_visible'] as bool?,
      serviceButtonVisibility: json['service_button_visibility'] as bool?,
    );

Map<String, dynamic> _$MyVisitToJson(MyVisit instance) => <String, dynamic>{
      'retailer_visit_by_id': instance.retailerVisitById,
      'retailer_visit_id': instance.retailerVisitId,
      'retailer_id': instance.retailerId,
      'work_report_id': instance.workReportId,
      'template_id': instance.templateId,
      'template_name': instance.templateName,
      'society_id': instance.societyId,
      'retailer_name': instance.retailerName,
      'retailer_code': instance.retailerCode,
      'retailer_contact_person': instance.retailerContactPerson,
      'retailer_contact_person_number': instance.retailerContactPersonNumber,
      'retailer_contact_person_number_with_country_code':
          instance.retailerContactPersonNumberWithCountryCode,
      'retailer_address': instance.retailerAddress,
      'retailer_latitude': instance.retailerLatitude,
      'retailer_longitude': instance.retailerLongitude,
      'retailer_geofence_range': instance.retailerGeofenceRange,
      'visit_added_by_type': instance.visitAddedByType,
      'visit_end_remark': instance.visitEndRemark,
      'end_visit_attachment': instance.endVisitAttachment,
      'reschedule_attachment': instance.rescheduleAttachment,
      'is_visit_end_request': instance.isVisitEndRequest,
      'visit_status': instance.visitStatus,
      'visit_status_change_name': instance.visitStatusChangeName,
      'visit_end_request_status': instance.visitEndRequestStatus,
      'visit_end_request_status_reason': instance.visitEndRequestStatusReason,
      'visit_added_by': instance.visitAddedBy,
      'visit_added_by_name': instance.visitAddedByName,
      'manager_names': instance.managerNames,
      'visit_type': instance.visitType,
      'visit_reject_reason': instance.visitRejectReason,
      'physical_or_virtual_visit': instance.physicalOrVirtualVisit,
      'is_auto_start_visit': instance.isAutoStartVisit,
      'is_auto_end_visit': instance.isAutoEndVisit,
      'is_end_visit_data_added': instance.isEndVisitDataAdded,
      'order_taken': instance.orderTaken,
      'slot_id': instance.slotId,
      'visit_end_request_statue_change_name':
          instance.visitEndRequestStatueChangeName,
      'crm_meeting_id': instance.crmMeetingId,
      'crm_outcome_id': instance.crmOutcomeId,
      'take_end_visit_details': instance.takeEndVisitDetails,
      'visit_end_request_date': instance.visitEndRequestDate,
      'visit_end_request_statue_change_date':
          instance.visitEndRequestStatueChangeDate,
      'visit_purpose': instance.visitPurpose,
      'my_visit_status': instance.myVisitStatus,
      'is_visit_rescheduled': instance.isVisitRescheduled,
      'reschedule_reason': instance.rescheduleReason,
      'retailer_visit_start_date_pass':
          instance.retailerVisitStartDatePass?.toIso8601String(),
      'retailer_visit_start_time_pass': instance.retailerVisitStartTimePass,
      'end_visit_area': instance.endVisitArea,
      'end_visit_catalogue': instance.endVisitCatalogue,
      'end_visit_contact_person_name': instance.endVisitContactPersonName,
      'visit_type_reason': instance.visitTypeReason,
      'follow_up_visit_date': instance.followUpVisitDate,
      'retailer_visit_start_date': instance.retailerVisitStartDate,
      'my_visit_start_only_time': instance.myVisitStartOnlyTime,
      'my_visit_start_datetime': instance.myVisitStartDatetime,
      'my_visit_start_datetime_view': instance.myVisitStartDatetimeView,
      'retailer_visit_start_time': instance.retailerVisitStartTime,
      'retailer_visit_end_date': instance.retailerVisitEndDate,
      'slot_schedule_time': instance.slotScheduleTime,
      'is_date_gone': instance.isDateGone,
      'show_end_button': instance.showEndButton,
      'is_my_visit_started': instance.isMyVisitStarted,
      'equipment_button_visibility': instance.equipmentButtonVisibility,
      'is_my_visit_ended': instance.isMyVisitEnded,
      'share_content': instance.shareContent,
      'start_visit_distance_meter': instance.startVisitDistanceMeter,
      'distance_meter': instance.distanceMeter,
      'distance_km': instance.distanceKm,
      'distance_sort': instance.distanceSort,
      'distance_in_km_new': instance.distanceInKmNew,
      'is_equipment_buttons_visible': instance.isEquipmentButtonsVisible,
      'service_button_visibility': instance.serviceButtonVisibility,
    };
