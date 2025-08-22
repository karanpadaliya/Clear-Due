// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_departments_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllDepartmentsModel _$AllDepartmentsModelFromJson(Map<String, dynamic> json) =>
    AllDepartmentsModel(
      departments:
          (json['departments'] as List<dynamic>?)
              ?.map((e) => Department.fromJson(e as Map<String, dynamic>))
              .toList(),
      message: json['message'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$AllDepartmentsModelToJson(
  AllDepartmentsModel instance,
) => <String, dynamic>{
  'departments': instance.departments,
  'message': instance.message,
  'status': instance.status,
};

Department _$DepartmentFromJson(Map<String, dynamic> json) => Department(
  blockId: json['block_id'] as String?,
  floorId: json['floor_id'] as String?,
  departmentName: json['department_name'] as String?,
);

Map<String, dynamic> _$DepartmentToJson(Department instance) =>
    <String, dynamic>{
      'block_id': instance.blockId,
      'floor_id': instance.floorId,
      'department_name': instance.departmentName,
    };
