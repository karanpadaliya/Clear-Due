// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department_and_designation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepartmentAndDesignationResponseModel
_$DepartmentAndDesignationResponseModelFromJson(Map<String, dynamic> json) =>
    DepartmentAndDesignationResponseModel(
      designation:
          (json['designation'] as List<dynamic>?)
              ?.map((e) => Designation.fromJson(e as Map<String, dynamic>))
              .toList(),
      departments:
          (json['floors'] as List<dynamic>?)
              ?.map((e) => Department.fromJson(e as Map<String, dynamic>))
              .toList(),
      subDepartmentList:
          (json['sub_department_list'] as List<dynamic>?)
              ?.map(
                (e) => SubDepartmentList.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      message: json['message'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$DepartmentAndDesignationResponseModelToJson(
  DepartmentAndDesignationResponseModel instance,
) => <String, dynamic>{
  'designation': instance.designation,
  'floors': instance.departments,
  'sub_department_list': instance.subDepartmentList,
  'message': instance.message,
  'status': instance.status,
};

Designation _$DesignationFromJson(Map<String, dynamic> json) => Designation(
  designationId: json['designation_id'] as String?,
  designationName: json['designation_name'] as String?,
);

Map<String, dynamic> _$DesignationToJson(Designation instance) =>
    <String, dynamic>{
      'designation_id': instance.designationId,
      'designation_name': instance.designationName,
    };

Department _$DepartmentFromJson(Map<String, dynamic> json) => Department(
  departmentId: json['floor_id'] as String?,
  societyId: json['society_id'] as String?,
  blockId: json['block_id'] as String?,
  departmentName: json['floor_name'] as String?,
  departmentstatus: json['floor_status'] as String?,
);

Map<String, dynamic> _$DepartmentToJson(Department instance) =>
    <String, dynamic>{
      'floor_id': instance.departmentId,
      'society_id': instance.societyId,
      'block_id': instance.blockId,
      'floor_name': instance.departmentName,
      'floor_status': instance.departmentstatus,
    };

SubDepartmentList _$SubDepartmentListFromJson(Map<String, dynamic> json) =>
    SubDepartmentList(
      subDepartmentId: json['sub_department_id'] as String?,
      societyId: json['society_id'] as String?,
      blockId: json['block_id'] as String?,
      departmentId: json['floor_id'] as String?,
      subDepartmentName: json['sub_department_name'] as String?,
    );

Map<String, dynamic> _$SubDepartmentListToJson(SubDepartmentList instance) =>
    <String, dynamic>{
      'sub_department_id': instance.subDepartmentId,
      'society_id': instance.societyId,
      'block_id': instance.blockId,
      'floor_id': instance.departmentId,
      'sub_department_name': instance.subDepartmentName,
    };
