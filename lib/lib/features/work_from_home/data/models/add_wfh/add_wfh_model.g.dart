// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_wfh_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddWfhResponse _$AddWfhResponseFromJson(Map<String, dynamic> json) =>
    AddWfhResponse(
      message: json['message'] as String?,
      status: json['status'] as String?,
      error: json['error'] as String?,
      wfhList: (json['wfh_list'] as List<dynamic>?)
          ?.map((e) => AddWfhList.fromJson(e as Map<String, dynamic>))
          .toList(),
      wfhAddressList: (json['wfh_address_list'] as List<dynamic>?)
          ?.map((e) => WfhAddressList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddWfhResponseToJson(AddWfhResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'error': instance.error,
      'wfh_list': instance.wfhList,
      'wfh_address_list': instance.wfhAddressList,
    };

AddWfhList _$AddWfhListFromJson(Map<String, dynamic> json) => AddWfhList(
      wfhId: json['wfh_id'] as String?,
      year: json['year'] as String?,
      wfhLatitude: json['wfh_latitude'] as String?,
      wfhEndDate: json['wfh_end_date'] as String?,
      wfhReason: json['wfh_reason'] as String?,
      wfhStartDateView: json['wfh_start_date_view'] as String?,
      approvedByName: json['approved_by_name'] as String?,
      wfhEndDateView: json['wfh_end_date_view'] as String?,
      rejectedByName: json['rejected_by_name'] as String?,
      wfhAttachment: json['wfh_attachment'] as String?,
      wfhAddress: json['wfh_address'] as String?,
      wfhStatus: json['wfh_status'] as String?,
      month: json['month'] as String?,
      wfhLongitude: json['wfh_longitude'] as String?,
      wfhStartDate: json['wfh_start_date'] as String?,
      wfhDeclinedReason: json['wfh_declined_reason'] as String?,
      wfhAttachmentName: json['wfh_attachment_name'] as String?,
      wfhAttendanceRange: json['wfh_attendance_range'] as String?,
      wfhStatusView: json['wfh_status_view'] as String?,
      wfhDayType: json['wfh_day_type'] as String?,
      wfhFirstSecondHalf: json['wfh_first_second_half'] as String?,
      wfhGroupId: json['wfh_group_id'] as String?,
      futureDate: json['future_date'] as bool?,
      wfhCreatedAt: json['wfh_created_at'] as String?,
      wfhApprovedDate: json['wfh_approved_date'] as String?,
      wfhDeclinedDate: json['wfh_declined_date'] as String?,
    );

Map<String, dynamic> _$AddWfhListToJson(AddWfhList instance) =>
    <String, dynamic>{
      'wfh_id': instance.wfhId,
      'year': instance.year,
      'wfh_latitude': instance.wfhLatitude,
      'wfh_end_date': instance.wfhEndDate,
      'wfh_reason': instance.wfhReason,
      'wfh_start_date_view': instance.wfhStartDateView,
      'approved_by_name': instance.approvedByName,
      'wfh_end_date_view': instance.wfhEndDateView,
      'rejected_by_name': instance.rejectedByName,
      'wfh_attachment': instance.wfhAttachment,
      'wfh_address': instance.wfhAddress,
      'wfh_status': instance.wfhStatus,
      'month': instance.month,
      'wfh_longitude': instance.wfhLongitude,
      'wfh_start_date': instance.wfhStartDate,
      'wfh_declined_reason': instance.wfhDeclinedReason,
      'wfh_attachment_name': instance.wfhAttachmentName,
      'wfh_attendance_range': instance.wfhAttendanceRange,
      'wfh_status_view': instance.wfhStatusView,
      'wfh_day_type': instance.wfhDayType,
      'wfh_first_second_half': instance.wfhFirstSecondHalf,
      'wfh_group_id': instance.wfhGroupId,
      'future_date': instance.futureDate,
      'wfh_created_at': instance.wfhCreatedAt,
      'wfh_approved_date': instance.wfhApprovedDate,
      'wfh_declined_date': instance.wfhDeclinedDate,
    };

WfhAddressList _$WfhAddressListFromJson(Map<String, dynamic> json) =>
    WfhAddressList(
      createdBy: json['created_by'] as String?,
      createdDate: json['created_date'] as String?,
      societyId: json['society_id'] as String?,
      addressType: json['address_type'] as String?,
      userId: json['user_id'] as String?,
      wfhAddressId: json['wfh_address_id'] as String?,
      wfhAddress: json['wfh_address'] as String?,
      wfhLongitude: json['wfh_longitude'] as String?,
      wfhLatitude: json['wfh_latitude'] as String?,
      wfhAddressTitle: json['wfh_address_title'] as String?,
      collapsed: json['collapsed'] as bool?,
    );

Map<String, dynamic> _$WfhAddressListToJson(WfhAddressList instance) =>
    <String, dynamic>{
      'created_by': instance.createdBy,
      'created_date': instance.createdDate,
      'society_id': instance.societyId,
      'address_type': instance.addressType,
      'user_id': instance.userId,
      'wfh_address_id': instance.wfhAddressId,
      'wfh_address': instance.wfhAddress,
      'wfh_longitude': instance.wfhLongitude,
      'wfh_latitude': instance.wfhLatitude,
      'wfh_address_title': instance.wfhAddressTitle,
      'collapsed': instance.collapsed,
    };
