class MyVisitModelEntity {
  final List<ExpenseCategoryEntity>? expenseCategory;
  final bool? startVisitWithOtp;
  final String? allowOutOfRangeVisitStartEnd;
  final bool? endVisitViewAdditionalField;
  final bool? takeEndVisitReport;
  final List<MyVisitEntity>? myVisits;
  final String? message;
  final String? status;

  MyVisitModelEntity({
    this.expenseCategory,
    this.startVisitWithOtp,
    this.allowOutOfRangeVisitStartEnd,
    this.endVisitViewAdditionalField,
    this.takeEndVisitReport,
    this.myVisits,
    this.message,
    this.status,
  });
}

class ExpenseCategoryEntity {
  final String? expenseCategoryId;
  final String? expenseCategoryName;

  ExpenseCategoryEntity({
    this.expenseCategoryId,
    this.expenseCategoryName,
  });
}

class MyVisitEntity {
  final String? retailerVisitById;
  final String? retailerVisitId;
  final String? retailerId;
  final String? workReportId;
  final String? templateId;
  final String? templateName;
  final String? societyId;
  final String? retailerName;
  final String? retailerCode;
  final String? retailerContactPerson;
  final String? retailerContactPersonNumber;
  final String? retailerContactPersonNumberWithCountryCode;
  final String? retailerAddress;
  final String? retailerLatitude;
  final String? retailerLongitude;
  final String? retailerGeofenceRange;
  final String? visitAddedByType;
  final String? visitEndRemark;
  final String? endVisitAttachment;
  final String? rescheduleAttachment;
  final String? isVisitEndRequest;
  final String? visitStatus;
  final String? visitStatusChangeName;
  final String? visitEndRequestStatus;
  final String? visitEndRequestStatusReason;
  final String? visitAddedBy;
  final String? visitAddedByName;
  final String? managerNames;
  final String? visitType;
  final String? visitRejectReason;
  final String? physicalOrVirtualVisit;
  final String? isAutoStartVisit;
  final String? isAutoEndVisit;
  final String? isEndVisitDataAdded;
  final String? orderTaken;
  final String? slotId;
  final String? visitEndRequestStatueChangeName;
  final String? crmMeetingId;
  final String? crmOutcomeId;
  final bool? takeEndVisitDetails;
  final String? visitEndRequestDate;
  final String? visitEndRequestStatueChangeDate;
  final String? visitPurpose;
  final String? myVisitStatus;
  final bool? isVisitRescheduled;
  final String? rescheduleReason;
  final DateTime? retailerVisitStartDatePass;
  final String? retailerVisitStartTimePass;
  final String? endVisitArea;
  final String? endVisitCatalogue;
  final String? endVisitContactPersonName;
  final String? visitTypeReason;
  final String? followUpVisitDate;
  final String? retailerVisitStartDate;
  final String? myVisitStartOnlyTime;
  final String? myVisitStartDatetime;
  final String? myVisitStartDatetimeView;
  final String? retailerVisitStartTime;
  final String? retailerVisitEndDate;
  final String? slotScheduleTime;
  final bool? isDateGone;
  final bool? showEndButton;
  final bool? isMyVisitStarted;
  final String? equipmentButtonVisibility;
  final bool? isMyVisitEnded;
  final String? shareContent;
  final String? startVisitDistanceMeter;
  final String? distanceMeter;
  final String? distanceKm;
  final String? distanceSort;
  final String? distanceInKmNew;
  final bool? isEquipmentButtonsVisible;
  final bool? serviceButtonVisibility;

  MyVisitEntity({
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
}
