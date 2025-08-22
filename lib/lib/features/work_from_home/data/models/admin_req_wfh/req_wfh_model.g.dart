// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'req_wfh_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminWfhResponse _$AdminWfhResponseFromJson(Map<String, dynamic> json) =>
    AdminWfhResponse(
      message: json['message'] as String?,
      status: json['status'] as String?,
      error: json['error'] as String?,
      modificationAccess: json['modification_access'] as bool?,
      wfhList: (json['wfh_list'] as List<dynamic>?)
          ?.map((e) => AdminWfhListResp.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdminWfhResponseToJson(AdminWfhResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'error': instance.error,
      'modification_access': instance.modificationAccess,
      'wfh_list': instance.wfhList,
    };

AdminWfhListResp _$AdminWfhListRespFromJson(Map<String, dynamic> json) =>
    AdminWfhListResp(
      branchName: json['branch_name'] as String?,
      departmentName: json['department_name'] as String?,
      userDesignation: json['user_designation'] as String?,
      userFullName: json['user_full_name'] as String?,
      userId: json['user_id'] as String?,
      userProfilePic: json['user_profile_pic'] as String?,
      wfhAttachment: json['wfh_attachment'] as String?,
      wfhAttendanceRange: json['wfh_attendance_range'] as String?,
      wfhEndDate: json['wfh_end_date'] as String?,
      wfhEndDateView: json['wfh_end_date_view'] as String?,
      wfhId: json['wfh_id'] as String?,
      wfhLatitude: json['wfh_latitude'] as String?,
      wfhLongitude: json['wfh_longitude'] as String?,
      wfhReason: json['wfh_reason'] as String?,
      wfhStartDate: json['wfh_start_date'] as String?,
      wfhStartDateView: json['wfh_start_date_view'] as String?,
      wfhStatus: json['wfh_status'] as String?,
      wfhStatusView: json['wfh_status_view'] as String?,
      wfhAddress: json['wfh_address'] as String?,
      wfhDayType: json['wfh_day_type'] as String?,
      wfhFirstSecondHalf: json['wfh_first_second_half'] as String?,
      month: json['month'] as String?,
      year: json['year'] as String?,
      day: json['day'] as String?,
      shortName: json['short_name'] as String?,
      wfhStatusChangedByName: json['wfh_status_changed_by_name'] as String?,
      wfhGroupId: json['wfh_group_id'] as String?,
      isSelected: json['isSelected'] as bool?,
      wfhCreatedAt: json['wfh_created_at'] as String?,
      wfhApprovedDate: json['wfh_approved_date'] as String?,
    );

Map<String, dynamic> _$AdminWfhListRespToJson(AdminWfhListResp instance) =>
    <String, dynamic>{
      'branch_name': instance.branchName,
      'department_name': instance.departmentName,
      'user_designation': instance.userDesignation,
      'user_full_name': instance.userFullName,
      'user_id': instance.userId,
      'user_profile_pic': instance.userProfilePic,
      'wfh_attachment': instance.wfhAttachment,
      'wfh_attendance_range': instance.wfhAttendanceRange,
      'wfh_end_date': instance.wfhEndDate,
      'wfh_end_date_view': instance.wfhEndDateView,
      'wfh_id': instance.wfhId,
      'wfh_latitude': instance.wfhLatitude,
      'wfh_longitude': instance.wfhLongitude,
      'wfh_reason': instance.wfhReason,
      'wfh_start_date': instance.wfhStartDate,
      'wfh_start_date_view': instance.wfhStartDateView,
      'wfh_status': instance.wfhStatus,
      'wfh_status_view': instance.wfhStatusView,
      'wfh_address': instance.wfhAddress,
      'wfh_day_type': instance.wfhDayType,
      'wfh_first_second_half': instance.wfhFirstSecondHalf,
      'month': instance.month,
      'year': instance.year,
      'day': instance.day,
      'short_name': instance.shortName,
      'wfh_status_changed_by_name': instance.wfhStatusChangedByName,
      'wfh_group_id': instance.wfhGroupId,
      'isSelected': instance.isSelected,
      'wfh_created_at': instance.wfhCreatedAt,
      'wfh_approved_date': instance.wfhApprovedDate,
    };
