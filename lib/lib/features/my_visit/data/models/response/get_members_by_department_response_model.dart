import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/get_members_by_department_entity.dart';

part 'get_members_by_department_response_model.g.dart';

GetMembersByDepartmentResponseModel getMembersByDepartmentFromJson(
  String str,
) => GetMembersByDepartmentResponseModel.fromJson(json.decode(str));

String getMembersByDepartmentToJson(GetMembersByDepartmentResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class GetMembersByDepartmentResponseModel {
  @JsonKey(name: 'employees')
  List<Employee>? employees;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'status')
  String? status;

  GetMembersByDepartmentResponseModel({
    this.employees,
    this.message,
    this.status,
  });

  factory GetMembersByDepartmentResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => _$GetMembersByDepartmentResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetMembersByDepartmentResponseModelToJson(this);
}

@JsonSerializable()
class Employee {
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'unit_id')
  String? unitId;
  @JsonKey(name: 'block_id')
  String? blockId;
  @JsonKey(name: 'floor_id')
  String? floorId;
  @JsonKey(name: 'user_first_name')
  String? userFirstName;
  @JsonKey(name: 'user_last_name')
  String? userLastName;
  @JsonKey(name: 'user_mobile')
  String? userMobile;
  @JsonKey(name: 'user_full_name')
  String? userFullName;
  @JsonKey(name: 'society_id')
  String? societyId;
  @JsonKey(name: 'designation')
  String? designation;
  @JsonKey(name: 'short_name')
  String? shortName;
  @JsonKey(name: 'user_profile_pic')
  String? userProfilePic;

  Employee({
    this.userId,
    this.unitId,
    this.blockId,
    this.floorId,
    this.userFirstName,
    this.userLastName,
    this.userMobile,
    this.userFullName,
    this.societyId,
    this.designation,
    this.shortName,
    this.userProfilePic,
  });

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);

  EmployeeEntity toEntity() => EmployeeEntity(
    userId: userId,
    unitId: unitId,
    blockId: blockId,
    floorId: floorId,
    userFirstName: userFirstName,
    userLastName: userLastName,
    userMobile: userMobile,
    userFullName: userFullName,
    societyId: societyId,
    designation: designation,
    shortName: shortName,
    userProfilePic: userProfilePic,
  );
}
