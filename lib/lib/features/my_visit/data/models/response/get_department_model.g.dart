// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_department_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDepartmentModel _$GetDepartmentModelFromJson(Map<String, dynamic> json) =>
    GetDepartmentModel(
      currentMonth: json['current_month'] as String?,
      totalPendingMembers: json['total_pending_members'] as String?,
      recentUser: json['recent_user'] as List<dynamic>?,
      departments:
          (json['departments'] as List<dynamic>?)
              ?.map((e) => Department.fromJson(e as Map<String, dynamic>))
              .toList(),
      message: json['message'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$GetDepartmentModelToJson(GetDepartmentModel instance) =>
    <String, dynamic>{
      'current_month': instance.currentMonth,
      'total_pending_members': instance.totalPendingMembers,
      'recent_user': instance.recentUser,
      'departments': instance.departments,
      'message': instance.message,
      'status': instance.status,
    };

Department _$DepartmentFromJson(Map<String, dynamic> json) => Department(
  floorId: json['floor_id'] as String?,
  societyId: json['society_id'] as String?,
  blockId: json['block_id'] as String?,
  departmentName: json['department_name'] as String?,
  isMyDepartment: json['is_my_department'] as bool?,
);

Map<String, dynamic> _$DepartmentToJson(Department instance) =>
    <String, dynamic>{
      'floor_id': instance.floorId,
      'society_id': instance.societyId,
      'block_id': instance.blockId,
      'department_name': instance.departmentName,
      'is_my_department': instance.isMyDepartment,
    };
