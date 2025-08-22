import 'package:json_annotation/json_annotation.dart';
import 'package:myco_flutter/features/work_from_home/domain/entities/add_wfh/add_wfh_entity.dart';

part 'add_wfh_model.g.dart';

@JsonSerializable()
class AddWfhResponse {
  final String? message;
  final String? status;
  final String? error;
  @JsonKey(name: 'wfh_list')
  final List<AddWfhList>? wfhList;
  @JsonKey(name: 'wfh_address_list')
  final List<WfhAddressList>? wfhAddressList;

  AddWfhResponse({
    this.message,
    this.status,
    this.error,
    this.wfhList,
    this.wfhAddressList,
  });

  factory AddWfhResponse.fromJson(Map<String, dynamic> json) =>
      _$AddWfhResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddWfhResponseToJson(this);
}

@JsonSerializable()
class AddWfhList {
  @JsonKey(name: 'wfh_id')
  final String? wfhId;
  final String? year;
  @JsonKey(name: 'wfh_latitude')
  final String? wfhLatitude;
  @JsonKey(name: 'wfh_end_date')
  final String? wfhEndDate;
  @JsonKey(name: 'wfh_reason')
  final String? wfhReason;
  @JsonKey(name: 'wfh_start_date_view')
  final String? wfhStartDateView;
  @JsonKey(name: 'approved_by_name')
  final String? approvedByName;
  @JsonKey(name: 'wfh_end_date_view')
  final String? wfhEndDateView;
  @JsonKey(name: 'rejected_by_name')
  final String? rejectedByName;
  @JsonKey(name: 'wfh_attachment')
  final String? wfhAttachment;
  @JsonKey(name: 'wfh_address')
  final String? wfhAddress;
  @JsonKey(name: 'wfh_status')
  final String? wfhStatus;
  final String? month;
  @JsonKey(name: 'wfh_longitude')
  final String? wfhLongitude;
  @JsonKey(name: 'wfh_start_date')
  final String? wfhStartDate;
  @JsonKey(name: 'wfh_declined_reason')
  final String? wfhDeclinedReason;
  @JsonKey(name: 'wfh_attachment_name')
  final String? wfhAttachmentName;
  @JsonKey(name: 'wfh_attendance_range')
  final String? wfhAttendanceRange;
  @JsonKey(name: 'wfh_status_view')
  final String? wfhStatusView;
  @JsonKey(name: 'wfh_day_type')
  final String? wfhDayType;
  @JsonKey(name: 'wfh_first_second_half')
  final String? wfhFirstSecondHalf;
  @JsonKey(name: 'wfh_group_id')
  final String? wfhGroupId;
  @JsonKey(name: 'future_date')
  final bool? futureDate;
  @JsonKey(name: 'wfh_created_at')
  final String? wfhCreatedAt;
  @JsonKey(name: 'wfh_approved_date')
  final String? wfhApprovedDate;
  @JsonKey(name: 'wfh_declined_date')
  final String? wfhDeclinedDate;

  AddWfhList({
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

  factory AddWfhList.fromJson(Map<String, dynamic> json) =>
      _$AddWfhListFromJson(json);

  Map<String, dynamic> toJson() => _$AddWfhListToJson(this);
}

@JsonSerializable()
class WfhAddressList {
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'created_date')
  final String? createdDate;
  @JsonKey(name: 'society_id')
  final String? societyId;
  @JsonKey(name: 'address_type')
  final String? addressType;
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(name: 'wfh_address_id')
  final String? wfhAddressId;
  @JsonKey(name: 'wfh_address')
  final String? wfhAddress;
  @JsonKey(name: 'wfh_longitude')
  final String? wfhLongitude;
  @JsonKey(name: 'wfh_latitude')
  final String? wfhLatitude;
  @JsonKey(name: 'wfh_address_title')
  final String? wfhAddressTitle;
  bool? collapsed;

  WfhAddressList({
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

  factory WfhAddressList.fromJson(Map<String, dynamic> json) =>
      _$WfhAddressListFromJson(json);

  Map<String, dynamic> toJson() => _$WfhAddressListToJson(this);
}
// ...existing code...

extension AddWfhResponseMapper on AddWfhResponse {
  GetWfhListEntity toEntity() => GetWfhListEntity(
    message: message,
    status: status,
    error: error,
    wfhList: wfhList?.map((item) => item.toEntity()).toList(),
    wfhAddressList: wfhAddressList?.map((item) => item.toEntity()).toList(),
  );
}

extension AddWfhListMapper on AddWfhList {
  GetWfhListItemEntity toEntity() => GetWfhListItemEntity(
    wfhId: wfhId,
    year: year,
    wfhLatitude: wfhLatitude,
    wfhEndDate: wfhEndDate,
    wfhReason: wfhReason,
    wfhStartDateView: wfhStartDateView,
    approvedByName: approvedByName,
    wfhEndDateView: wfhEndDateView,
    rejectedByName: rejectedByName,
    wfhAttachment: wfhAttachment,
    wfhAddress: wfhAddress,
    wfhStatus: wfhStatus,
    month: month,
    wfhLongitude: wfhLongitude,
    wfhStartDate: wfhStartDate,
    wfhDeclinedReason: wfhDeclinedReason,
    wfhAttachmentName: wfhAttachmentName,
    wfhAttendanceRange: wfhAttendanceRange,
    wfhStatusView: wfhStatusView,
    wfhDayType: wfhDayType,
    wfhFirstSecondHalf: wfhFirstSecondHalf,
    wfhGroupId: wfhGroupId,
    futureDate: futureDate,
    wfhCreatedAt: wfhCreatedAt,
    wfhApprovedDate: wfhApprovedDate,
    wfhDeclinedDate: wfhDeclinedDate,
  );
}

extension WfhAddressListMapper on WfhAddressList {
  GetWfhAddressListEntity toEntity() => GetWfhAddressListEntity(
    createdBy: createdBy,
    createdDate: createdDate,
    societyId: societyId,
    addressType: addressType,
    userId: userId,
    wfhAddressId: wfhAddressId,
    wfhAddress: wfhAddress,
    wfhLongitude: wfhLongitude,
    wfhLatitude: wfhLatitude,
    wfhAddressTitle: wfhAddressTitle,
    collapsed: collapsed,
  );
}
