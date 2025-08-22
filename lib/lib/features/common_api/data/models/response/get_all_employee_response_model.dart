import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:myco_flutter/features/common_api/domain/entities/get_all_employee_response_entity.dart';

part 'get_all_employee_response_model.g.dart';

GetAllEmployeeResponseModel getAllEmployeeResponseModelFromJson(String str) =>
    GetAllEmployeeResponseModel.fromJson(json.decode(str));

@JsonSerializable()
class GetAllEmployeeResponseModel {
  @JsonKey(name: 'total_employee')
  final String? totalEmployee;

  @JsonKey(name: 'employees')
  final List<EmployeeModel>? employees;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'status')
  final String? status;

  const GetAllEmployeeResponseModel({
    this.totalEmployee,
    this.employees,
    this.message,
    this.status,
  });

  factory GetAllEmployeeResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetAllEmployeeResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllEmployeeResponseModelToJson(this);

  GetAllEmployeeResponseEntity toEntity() => GetAllEmployeeResponseEntity(
    totalEmployee: totalEmployee,
    employees: employees?.map((e) => e.toEntity()).toList(),
    message: message,
    status: status,
  );
}

@JsonSerializable()
class EmployeeModel {
  String color;
  bool isEmployeeSelected;
  bool isAllEmployeeSelected;
  bool isSelected;
  String targetAmount;

  @JsonKey(name: 'branch_name')
  final String? branchName;

  @JsonKey(name: 'company_name')
  final String? companyName;

  @JsonKey(name: 'unit_id')
  final String? unitId;

  @JsonKey(name: 'block_id')
  final String? blockId;

  @JsonKey(name: 'floor_id')
  final String? floorId;

  @JsonKey(name: 'user_id')
  final String? userId;

  @JsonKey(name: 'is_future_date')
  final bool? isFutureDate;

  @JsonKey(name: 'user_active')
  final bool? userActive;

  @JsonKey(name: 'user_first_name')
  final String? userFirstName;

  @JsonKey(name: 'user_last_name')
  final String? userLastName;

  @JsonKey(name: 'user_mobile')
  final String? userMobile;

  @JsonKey(name: 'user_full_name')
  final String? userFullName;

  @JsonKey(name: 'society_id')
  final String? societyId;

  @JsonKey(name: 'designation')
  final String? designation;

  @JsonKey(name: 'department_name')
  final String? departmentName;

  @JsonKey(name: 'user_profile_pic')
  final String? userProfilePic;

  @JsonKey(name: 'short_name')
  final String? shortName;

  @JsonKey(name: 'colorBackGround')
  final String? colorBackGround;

  @JsonKey(name: 'floor_name')
  final String? floorName;

  @JsonKey(name: 'block_name')
  final String? blockName;

  @JsonKey(name: 'user_full_name_view')
  final String? userFullNameView;

  @JsonKey(name: 'user_designation')
  final String? userDesignation;

  EmployeeModel({
    this.color = '',
    this.isEmployeeSelected = false,
    this.isAllEmployeeSelected = false,
    this.isSelected = false,
    this.targetAmount = '00.0',
    this.branchName,
    this.companyName,
    this.unitId,
    this.blockId,
    this.floorId,
    this.userId,
    this.isFutureDate,
    this.userActive,
    this.userFirstName,
    this.userLastName,
    this.userMobile,
    this.userFullName,
    this.societyId,
    this.designation,
    this.departmentName,
    this.userProfilePic,
    this.shortName,
    this.colorBackGround,
    this.floorName,
    this.blockName,
    this.userFullNameView,
    this.userDesignation,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeModelToJson(this);

  EmployeeEntity toEntity() => EmployeeEntity(
    color: color,
    isEmployeeSelected: isEmployeeSelected,
    isAllEmployeeSelected: isAllEmployeeSelected,
    isSelected: isSelected,
    targetAmount: targetAmount,
    branchName: branchName,
    companyName: companyName,
    unitId: unitId,
    blockId: blockId,
    floorId: floorId,
    userId: userId,
    isFutureDate: isFutureDate,
    userActive: userActive,
    userFirstName: userFirstName,
    userLastName: userLastName,
    userMobile: userMobile,
    userFullName: userFullName,
    societyId: societyId,
    designation: designation,
    departmentName: departmentName,
    userProfilePic: userProfilePic,
    shortName: shortName,
    colorBackGround: colorBackGround,
    floorName: floorName,
    blockName: blockName,
    userFullNameView: userFullNameView,
    userDesignation: userDesignation,
  );
}
