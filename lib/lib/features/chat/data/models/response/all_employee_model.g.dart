// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_employee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllEmployeeModel _$AllEmployeeModelFromJson(Map<String, dynamic> json) =>
    AllEmployeeModel(
      branchList:
          (json['branch_list'] as List<dynamic>?)
              ?.map((e) => BranchList.fromJson(e as Map<String, dynamic>))
              .toList(),
      departments:
          (json['departments'] as List<dynamic>?)
              ?.map((e) => Department.fromJson(e as Map<String, dynamic>))
              .toList(),
      employees:
          (json['employees'] as List<dynamic>?)
              ?.map((e) => Employee.fromJson(e as Map<String, dynamic>))
              .toList(),
      message: json['message'] as String?,
      totalBranch: (json['total_branch'] as num?)?.toInt(),
      totalDepartment: (json['total_department'] as num?)?.toInt(),
      totalEmployees: (json['total_employees'] as num?)?.toInt(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$AllEmployeeModelToJson(AllEmployeeModel instance) =>
    <String, dynamic>{
      'branch_list': instance.branchList,
      'departments': instance.departments,
      'employees': instance.employees,
      'message': instance.message,
      'total_branch': instance.totalBranch,
      'total_department': instance.totalDepartment,
      'total_employees': instance.totalEmployees,
      'status': instance.status,
    };

BranchList _$BranchListFromJson(Map<String, dynamic> json) => BranchList(
  blockId: json['block_id'] as String?,
  societyId: json['society_id'] as String?,
  blockName: json['block_name'] as String?,
);

Map<String, dynamic> _$BranchListToJson(BranchList instance) =>
    <String, dynamic>{
      'block_id': instance.blockId,
      'society_id': instance.societyId,
      'block_name': instance.blockName,
    };

Department _$DepartmentFromJson(Map<String, dynamic> json) => Department(
  floorId: json['floor_id'] as String?,
  societyId: json['society_id'] as String?,
  blockId: json['block_id'] as String?,
  blockName: json['block_name'] as String?,
  departmentName: json['department_name'] as String?,
  floorName: json['floor_name'] as String?,
  isMyDepartment: json['is_my_department'] as bool?,
);

Map<String, dynamic> _$DepartmentToJson(Department instance) =>
    <String, dynamic>{
      'floor_id': instance.floorId,
      'society_id': instance.societyId,
      'block_id': instance.blockId,
      'block_name': instance.blockName,
      'department_name': instance.departmentName,
      'floor_name': instance.floorName,
      'is_my_department': instance.isMyDepartment,
    };

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
  userId: json['user_id'] as String?,
  unitId: json['unit_id'] as String?,
  blockId: json['block_id'] as String?,
  floorId: json['floor_id'] as String?,
  userFirstName: json['user_first_name'] as String?,
  userLastName: json['user_last_name'] as String?,
  userMobile: json['user_mobile'] as String?,
  userFullName: json['user_full_name'] as String?,
  shortName: json['short_name'] as String?,
  societyId: json['society_id'] as String?,
  designation: json['designation'] as String?,
  branchName: json['branch_name'] as String?,
  departmentName: json['department_name'] as String?,
  companyLeaveDate: json['company_leave_date'] as String?,
  companyLeaveDateView: json['company_leave_date_view'] as String?,
  isFutureDate: json['is_future_date'] as bool?,
  userActive: json['user_active'] as bool?,
  userProfilePic: json['user_profile_pic'] as String?,
);

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
  'user_id': instance.userId,
  'unit_id': instance.unitId,
  'block_id': instance.blockId,
  'floor_id': instance.floorId,
  'user_first_name': instance.userFirstName,
  'user_last_name': instance.userLastName,
  'user_mobile': instance.userMobile,
  'user_full_name': instance.userFullName,
  'short_name': instance.shortName,
  'society_id': instance.societyId,
  'designation': instance.designation,
  'branch_name': instance.branchName,
  'department_name': instance.departmentName,
  'company_leave_date': instance.companyLeaveDate,
  'company_leave_date_view': instance.companyLeaveDateView,
  'is_future_date': instance.isFutureDate,
  'user_active': instance.userActive,
  'user_profile_pic': instance.userProfilePic,
};
