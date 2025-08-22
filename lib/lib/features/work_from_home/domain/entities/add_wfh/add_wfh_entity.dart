class GetWfhListEntity {
  final String? message;
  final String? status;
  final String? error;
  final List<GetWfhListItemEntity>? wfhList;
  final List<GetWfhAddressListEntity>? wfhAddressList;

  GetWfhListEntity({
    this.message,
    this.status,
    this.error,
    this.wfhList,
    this.wfhAddressList,
  });
}

class GetWfhListItemEntity {
  final String? wfhId;
  final String? year;
  final String? wfhLatitude;
  final String? wfhEndDate;
  final String? wfhReason;
  final String? wfhStartDateView;
  final String? approvedByName;
  final String? wfhEndDateView;
  final String? rejectedByName;
  final String? wfhAttachment;
  final String? wfhAddress;
  final String? wfhStatus;
  final String? month;
  final String? wfhLongitude;
  final String? wfhStartDate;
  final String? wfhDeclinedReason;
  final String? wfhAttachmentName;
  final String? wfhAttendanceRange;
  final String? wfhStatusView;
  final String? wfhDayType;
  final String? wfhFirstSecondHalf;
  final String? wfhGroupId;
  final bool? futureDate;
  final String? wfhCreatedAt;
  final String? wfhApprovedDate;
  final String? wfhDeclinedDate;

  GetWfhListItemEntity({
    this.wfhId,
    this.year,
    this.wfhLatitude,
    this.wfhEndDate,
    this.wfhReason,
    this.wfhStartDateView,
    this.approvedByName,
    this.wfhEndDateView,
    this.rejectedByName,
    this.wfhAttachment,
    this.wfhAddress,
    this.wfhStatus,
    this.month,
    this.wfhLongitude,
    this.wfhStartDate,
    this.wfhDeclinedReason,
    this.wfhAttachmentName,
    this.wfhAttendanceRange,
    this.wfhStatusView,
    this.wfhDayType,
    this.wfhFirstSecondHalf,
    this.wfhGroupId,
    this.futureDate,
    this.wfhCreatedAt,
    this.wfhApprovedDate,
    this.wfhDeclinedDate,
  });
}

class GetWfhAddressListEntity {
  final String? createdBy;
  final String? createdDate;
  final String? societyId;
  final String? addressType;
  final String? userId;
  final String? wfhAddressId;
  final String? wfhAddress;
  final String? wfhLongitude;
  final String? wfhLatitude;
  final String? wfhAddressTitle;
  final bool? collapsed;

  GetWfhAddressListEntity({
    this.createdBy,
    this.createdDate,
    this.societyId,
    this.addressType,
    this.userId,
    this.wfhAddressId,
    this.wfhAddress,
    this.wfhLongitude,
    this.wfhLatitude,
    this.wfhAddressTitle,
    this.collapsed,
  });
}
