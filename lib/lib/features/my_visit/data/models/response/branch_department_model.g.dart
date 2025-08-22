// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_department_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchDepartmentModel _$BranchDepartmentModelFromJson(
  Map<String, dynamic> json,
) => BranchDepartmentModel(
  isBranchWise: json['isBranchWise'] as bool?,
  isDepartmentWise: json['isDepartmentWise'] as bool?,
  isEmployeeWise: json['isEmployeeWise'] as bool?,
  branchList:
      (json['branch_list'] as List<dynamic>?)
          ?.map((e) => BranchList.fromJson(e as Map<String, dynamic>))
          .toList(),
  departments:
      (json['departments'] as List<dynamic>?)
          ?.map((e) => Department.fromJson(e as Map<String, dynamic>))
          .toList(),
  employees: json['employees'] as List<dynamic>?,
  modificationAccess: json['modification_access'] as bool?,
  status: json['status'] as String?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$BranchDepartmentModelToJson(
  BranchDepartmentModel instance,
) => <String, dynamic>{
  'isBranchWise': instance.isBranchWise,
  'isDepartmentWise': instance.isDepartmentWise,
  'isEmployeeWise': instance.isEmployeeWise,
  'branch_list': instance.branchList,
  'departments': instance.departments,
  'employees': instance.employees,
  'modification_access': instance.modificationAccess,
  'status': instance.status,
  'message': instance.message,
};

BranchList _$BranchListFromJson(Map<String, dynamic> json) => BranchList(
  blockId: json['block_id'] as String?,
  blockName: json['block_name'] as String?,
  floorIds: json['floor_ids'] as String?,
);

Map<String, dynamic> _$BranchListToJson(BranchList instance) =>
    <String, dynamic>{
      'block_id': instance.blockId,
      'block_name': instance.blockName,
      'floor_ids': instance.floorIds,
    };

Department _$DepartmentFromJson(Map<String, dynamic> json) => Department(
  floorId: json['floor_id'] as String?,
  blockId: json['block_id'] as String?,
  departmentName: json['department_name'] as String?,
  branchName: json['branch_name'] as String?,
);

Map<String, dynamic> _$DepartmentToJson(Department instance) =>
    <String, dynamic>{
      'floor_id': instance.floorId,
      'block_id': instance.blockId,
      'department_name': instance.departmentName,
      'branch_name': instance.branchName,
    };
