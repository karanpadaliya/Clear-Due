// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepartmentModel _$DepartmentModelFromJson(Map<String, dynamic> json) =>
    DepartmentModel(
      departmentId: json['floor_id'] as String?,
      companyId: json['society_id'] as String?,
      branchId: json['block_id'] as String?,
      branchName: json['block_name'] as String?,
      departmentName: json['department_name'] as String?,
      isMyDepartment: json['is_my_department'] as bool?,
    );

Map<String, dynamic> _$DepartmentModelToJson(DepartmentModel instance) =>
    <String, dynamic>{
      'floor_id': instance.departmentId,
      'society_id': instance.companyId,
      'block_id': instance.branchId,
      'block_name': instance.branchName,
      'department_name': instance.departmentName,
      'is_my_department': instance.isMyDepartment,
    };
