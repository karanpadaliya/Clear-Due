import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:myco_flutter/features/common_api/domain/entities/department_and_designation_response_entity.dart';

part 'department_and_designation_response.g.dart';

DepartmentAndDesignationResponseModel DepartmentAndDesignationResponseModelFromJson(String str) =>
    DepartmentAndDesignationResponseModel.fromJson(json.decode(str));

@JsonSerializable()
class DepartmentAndDesignationResponseModel {
  @JsonKey(name: "designation")
  final List<Designation>? designation;
  @JsonKey(name: "floors")
  final List<Department>? departments;
  @JsonKey(name: "sub_department_list")
  final List<SubDepartmentList>? subDepartmentList;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "status")
  final String? status;

  DepartmentAndDesignationResponseModel({
    this.designation,
    this.departments,
    this.subDepartmentList,
    this.message,
    this.status,
  });

  factory DepartmentAndDesignationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DepartmentAndDesignationResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentAndDesignationResponseModelToJson(this);

  /// ✅ Convert to Entity
  DepartmentAndDesignationResponseEntity toEntity() => DepartmentAndDesignationResponseEntity(
    designation: designation?.map((e) => e.toEntity()).toList(),
    departments: departments?.map((e) => e.toEntity()).toList(),
    subDepartmentList: subDepartmentList?.map((e) => e.toEntity()).toList(),
    message: message,
    status: status,
  );
}

@JsonSerializable()
class Designation {
  @JsonKey(name: "designation_id")
  final String? designationId;
  @JsonKey(name: "designation_name")
  final String? designationName;

  Designation({
    this.designationId,
    this.designationName,
  });

  factory Designation.fromJson(Map<String, dynamic> json) =>
      _$DesignationFromJson(json);

  Map<String, dynamic> toJson() => _$DesignationToJson(this);

  /// ✅ Convert to Entity
  DesignationEntity toEntity() => DesignationEntity(
    designationId: designationId,
    designationName: designationName,
  );
}
@JsonSerializable()
class Department {
  @JsonKey(name: "floor_id")
  final String? departmentId;
  @JsonKey(name: "society_id")
  final String? societyId;
  @JsonKey(name: "block_id")
  final String? blockId;
  @JsonKey(name: "floor_name")
  final String? departmentName;
  @JsonKey(name: "floor_status")
  final String? departmentstatus;

  // 1. Constructor ka naam theek kiya gaya hai
  Department({
    this.departmentId,
    this.societyId,
    this.blockId,
    this.departmentName,
    this.departmentstatus,
  });

  factory Department.fromJson(Map<String, dynamic> json) =>
      _$DepartmentFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentToJson(this);


  DepartmentEntity toEntity() => DepartmentEntity(
    departmentId: departmentId,
    societyId: societyId,
    blockId: blockId,
    departmentName: departmentName,
    departmentStatus: departmentstatus,
  );
} // 3. Extra 'departments' shabd yahan se hata diya gaya hai

@JsonSerializable()
class SubDepartmentList {
  @JsonKey(name: "sub_department_id")
  final String? subDepartmentId;
  @JsonKey(name: "society_id")
  final String? societyId;
  @JsonKey(name: "block_id")
  final String? blockId;
  @JsonKey(name: "floor_id")
  final String? departmentId;
  @JsonKey(name: "sub_department_name")
  final String? subDepartmentName;

  SubDepartmentList({
    this.subDepartmentId,
    this.societyId,
    this.blockId,
    this.departmentId,
    this.subDepartmentName,
  });

  factory SubDepartmentList.fromJson(Map<String, dynamic> json) =>
      _$SubDepartmentListFromJson(json);

  Map<String, dynamic> toJson() => _$SubDepartmentListToJson(this);

  /// ✅ Convert to Entity
  SubDepartmentEntity toEntity() => SubDepartmentEntity(
    subDepartmentId: subDepartmentId,
    societyId: societyId,
    blockId: blockId,
    departmentId: departmentId,
    subDepartmentName: subDepartmentName,
  );
}
