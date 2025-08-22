// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_employee_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllEmployeeResponseModel _$GetAllEmployeeResponseModelFromJson(
  Map<String, dynamic> json,
) => GetAllEmployeeResponseModel(
  totalEmployee: json['total_employee'] as String?,
  employees:
      (json['employees'] as List<dynamic>?)
          ?.map((e) => EmployeeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  message: json['message'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$GetAllEmployeeResponseModelToJson(
  GetAllEmployeeResponseModel instance,
) => <String, dynamic>{
  'total_employee': instance.totalEmployee,
  'employees': instance.employees,
  'message': instance.message,
  'status': instance.status,
};

EmployeeModel _$EmployeeModelFromJson(Map<String, dynamic> json) =>
    EmployeeModel(
      color: json['color'] as String? ?? '',
      isEmployeeSelected: json['isEmployeeSelected'] as bool? ?? false,
      isAllEmployeeSelected: json['isAllEmployeeSelected'] as bool? ?? false,
      isSelected: json['isSelected'] as bool? ?? false,
      targetAmount: json['targetAmount'] as String? ?? '00.0',
      branchName: json['branch_name'] as String?,
      companyName: json['company_name'] as String?,
      unitId: json['unit_id'] as String?,
      blockId: json['block_id'] as String?,
      floorId: json['floor_id'] as String?,
      userId: json['user_id'] as String?,
      isFutureDate: json['is_future_date'] as bool?,
      userActive: json['user_active'] as bool?,
      userFirstName: json['user_first_name'] as String?,
      userLastName: json['user_last_name'] as String?,
      userMobile: json['user_mobile'] as String?,
      userFullName: json['user_full_name'] as String?,
      societyId: json['society_id'] as String?,
      designation: json['designation'] as String?,
      departmentName: json['department_name'] as String?,
      userProfilePic: json['user_profile_pic'] as String?,
      shortName: json['short_name'] as String?,
      colorBackGround: json['colorBackGround'] as String?,
      floorName: json['floor_name'] as String?,
      blockName: json['block_name'] as String?,
      userFullNameView: json['user_full_name_view'] as String?,
      userDesignation: json['user_designation'] as String?,
    );

Map<String, dynamic> _$EmployeeModelToJson(EmployeeModel instance) =>
    <String, dynamic>{
      'color': instance.color,
      'isEmployeeSelected': instance.isEmployeeSelected,
      'isAllEmployeeSelected': instance.isAllEmployeeSelected,
      'isSelected': instance.isSelected,
      'targetAmount': instance.targetAmount,
      'branch_name': instance.branchName,
      'company_name': instance.companyName,
      'unit_id': instance.unitId,
      'block_id': instance.blockId,
      'floor_id': instance.floorId,
      'user_id': instance.userId,
      'is_future_date': instance.isFutureDate,
      'user_active': instance.userActive,
      'user_first_name': instance.userFirstName,
      'user_last_name': instance.userLastName,
      'user_mobile': instance.userMobile,
      'user_full_name': instance.userFullName,
      'society_id': instance.societyId,
      'designation': instance.designation,
      'department_name': instance.departmentName,
      'user_profile_pic': instance.userProfilePic,
      'short_name': instance.shortName,
      'colorBackGround': instance.colorBackGround,
      'floor_name': instance.floorName,
      'block_name': instance.blockName,
      'user_full_name_view': instance.userFullNameView,
      'user_designation': instance.userDesignation,
    };
