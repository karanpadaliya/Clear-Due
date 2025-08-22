import 'package:json_annotation/json_annotation.dart';
import 'package:myco_flutter/features/work_from_home/domain/entities/admin_req_wfh/req_wfh_entity.dart';

part 'req_wfh_model.g.dart';

@JsonSerializable()
class AdminWfhResponse {
  final String? message;
  final String? status;
  final String? error;
  @JsonKey(name: 'modification_access')
  final bool? modificationAccess;
  @JsonKey(name: 'wfh_list')
  final List<AdminWfhListResp>? wfhList;

  AdminWfhResponse({
    this.message,
    this.status,
    this.error,
    this.modificationAccess,
    this.wfhList,
  });

  factory AdminWfhResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminWfhResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminWfhResponseToJson(this);
}

extension AdminWfhResponseMapper on AdminWfhResponse {
  AdminWfhEntity toEntity() => AdminWfhEntity(
    message: message,
    status: status,
    error: error,
    modificationAccess: modificationAccess,
    wfhList: wfhList?.map((item) => item.toEntity()).toList(),
  );
}

@JsonSerializable()
class AdminWfhListResp {
  @JsonKey(name: 'branch_name')
  final String? branchName;
  @JsonKey(name: 'department_name')
  final String? departmentName;
  @JsonKey(name: 'user_designation')
  final String? userDesignation;
  @JsonKey(name: 'user_full_name')
  final String? userFullName;
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(name: 'user_profile_pic')
  final String? userProfilePic;
  @JsonKey(name: 'wfh_attachment')
  final String? wfhAttachment;
  @JsonKey(name: 'wfh_attendance_range')
  final String? wfhAttendanceRange;
  @JsonKey(name: 'wfh_end_date')
  final String? wfhEndDate;
  @JsonKey(name: 'wfh_end_date_view')
  final String? wfhEndDateView;
  @JsonKey(name: 'wfh_id')
  final String? wfhId;
  @JsonKey(name: 'wfh_latitude')
  final String? wfhLatitude;
  @JsonKey(name: 'wfh_longitude')
  final String? wfhLongitude;
  @JsonKey(name: 'wfh_reason')
  final String? wfhReason;
  @JsonKey(name: 'wfh_start_date')
  final String? wfhStartDate;
  @JsonKey(name: 'wfh_start_date_view')
  final String? wfhStartDateView;
  @JsonKey(name: 'wfh_status')
  final String? wfhStatus;
  @JsonKey(name: 'wfh_status_view')
  final String? wfhStatusView;
  @JsonKey(name: 'wfh_address')
  final String? wfhAddress;
  @JsonKey(name: 'wfh_day_type')
  final String? wfhDayType;
  @JsonKey(name: 'wfh_first_second_half')
  final String? wfhFirstSecondHalf;
  final String? month;
  final String? year;
  final String? day;
  @JsonKey(name: 'short_name')
  final String? shortName;
  @JsonKey(name: 'wfh_status_changed_by_name')
  final String? wfhStatusChangedByName;
  @JsonKey(name: 'wfh_group_id')
  final String? wfhGroupId;
  final bool? isSelected;
  @JsonKey(name: 'wfh_created_at')
  final String? wfhCreatedAt;
  @JsonKey(name: 'wfh_approved_date')
  final String? wfhApprovedDate;

  AdminWfhListResp({
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

  factory AdminWfhListResp.fromJson(Map<String, dynamic> json) =>
      _$AdminWfhListRespFromJson(json);

  Map<String, dynamic> toJson() => _$AdminWfhListRespToJson(this);
}

extension AdminWfhListRespMapper on AdminWfhListResp {
  AdminWfhItemEntity toEntity() => AdminWfhItemEntity(
    branchName: branchName,
    departmentName: departmentName,
    userDesignation: userDesignation,
    userFullName: userFullName,
    userId: userId,
    userProfilePic: userProfilePic,
    wfhAttachment: wfhAttachment,
    wfhAttendanceRange: wfhAttendanceRange,
    wfhEndDate: wfhEndDate,
    wfhEndDateView: wfhEndDateView,
    wfhId: wfhId,
    wfhLatitude: wfhLatitude,
    wfhLongitude: wfhLongitude,
    wfhReason: wfhReason,
    wfhStartDate: wfhStartDate,
    wfhStartDateView: wfhStartDateView,
    wfhStatus: wfhStatus,
    wfhStatusView: wfhStatusView,
    wfhAddress: wfhAddress,
    wfhDayType: wfhDayType,
    wfhFirstSecondHalf: wfhFirstSecondHalf,
    month: month,
    year: year,
    day: day,
    shortName: shortName,
    wfhStatusChangedByName: wfhStatusChangedByName,
    wfhGroupId: wfhGroupId,
    isSelected: isSelected ?? false, // Default to false if null
    wfhCreatedAt: wfhCreatedAt,
    wfhApprovedDate: wfhApprovedDate,
  );
}
