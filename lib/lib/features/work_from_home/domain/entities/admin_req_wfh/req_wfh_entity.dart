class WfhStatusMsgReqEntity {
  final String? message;
  final String? status;
  final String? error;

  WfhStatusMsgReqEntity({this.message, this.status, this.error});
}

class AdminWfhEntity {
  final String? message;
  final String? status;
  final String? error;
  final bool? modificationAccess;
  final List<AdminWfhItemEntity>? wfhList;

  AdminWfhEntity({
    this.message,
    this.status,
    this.error,
    this.modificationAccess,
    this.wfhList,
  });
}

class AdminWfhItemEntity {
  final String? branchName;
  final String? departmentName;
  final String? userDesignation;
  final String? userFullName;
  final String? userId;
  final String? userProfilePic;
  final String? wfhAttachment;
  final String? wfhAttendanceRange;
  final String? wfhEndDate;
  final String? wfhEndDateView;
  final String? wfhId;
  final String? wfhLatitude;
  final String? wfhLongitude;
  final String? wfhReason;
  final String? wfhStartDate;
  final String? wfhStartDateView;
  final String? wfhStatus;
  final String? wfhStatusView;
  final String? wfhAddress;
  final String? wfhDayType;
  final String? wfhFirstSecondHalf;
  final String? month;
  final String? year;
  final String? day;
  final String? shortName;
  final String? wfhStatusChangedByName;
  final String? wfhGroupId;
  final bool? isSelected;
  final String? wfhCreatedAt;
  final String? wfhApprovedDate;

  AdminWfhItemEntity({
    this.branchName,
    this.departmentName,
    this.userDesignation,
    this.userFullName,
    this.userId,
    this.userProfilePic,
    this.wfhAttachment,
    this.wfhAttendanceRange,
    this.wfhEndDate,
    this.wfhEndDateView,
    this.wfhId,
    this.wfhLatitude,
    this.wfhLongitude,
    this.wfhReason,
    this.wfhStartDate,
    this.wfhStartDateView,
    this.wfhStatus,
    this.wfhStatusView,
    this.wfhAddress,
    this.wfhDayType,
    this.wfhFirstSecondHalf,
    this.month,
    this.year,
    this.day,
    this.shortName,
    this.wfhStatusChangedByName,
    this.wfhGroupId,
    this.isSelected,
    this.wfhCreatedAt,
    this.wfhApprovedDate,
  });
}
