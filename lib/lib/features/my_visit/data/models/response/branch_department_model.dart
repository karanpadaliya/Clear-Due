import 'package:json_annotation/json_annotation.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/branch_department_entity.dart';
import 'dart:convert';

part 'branch_department_model.g.dart';

BranchDepartmentModel branchDepartmentModelFromJson(String str) =>
    BranchDepartmentModel.fromJson(json.decode(str));

String branchDepartmentModelToJson(BranchDepartmentModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class BranchDepartmentModel {
  @JsonKey(name: "isBranchWise")
  bool? isBranchWise;

  @JsonKey(name: "isDepartmentWise")
  bool? isDepartmentWise;

  @JsonKey(name: "isEmployeeWise")
  bool? isEmployeeWise;

  @JsonKey(name: "branch_list")
  List<BranchList>? branchList;

  @JsonKey(name: "departments")
  List<Department>? departments;

  @JsonKey(name: "employees")
  List<dynamic>? employees;

  @JsonKey(name: "modification_access")
  bool? modificationAccess;

  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "message")
  String? message;

  BranchDepartmentModel({
    this.isBranchWise,
    this.isDepartmentWise,
    this.isEmployeeWise,
    this.branchList,
    this.departments,
    this.employees,
    this.modificationAccess,
    this.status,
    this.message,
  });

  factory BranchDepartmentModel.fromJson(Map<String, dynamic> json) =>
      _$BranchDepartmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$BranchDepartmentModelToJson(this);
}

@JsonSerializable()
class BranchList {
  @JsonKey(name: "block_id")
  String? blockId;

  @JsonKey(name: "block_name")
  String? blockName;

  @JsonKey(name: "floor_ids")
  String? floorIds;

  BranchList({
    this.blockId,
    this.blockName,
    this.floorIds,
  });

  factory BranchList.fromJson(Map<String, dynamic> json) =>
      _$BranchListFromJson(json);

  Map<String, dynamic> toJson() => _$BranchListToJson(this);
}

@JsonSerializable()
class Department {
  @JsonKey(name: "floor_id")
  String? floorId;

  @JsonKey(name: "block_id")
  String? blockId;

  @JsonKey(name: "department_name")
  String? departmentName;

  @JsonKey(name: "branch_name")
  String? branchName;

  Department({
    this.floorId,
    this.blockId,
    this.departmentName,
    this.branchName,
  });

  factory Department.fromJson(Map<String, dynamic> json) =>
      _$DepartmentFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentToJson(this);
}

extension BranchDepartmentModelMapper on BranchDepartmentModel {
  BranchDepartmentEntity toEntity() => BranchDepartmentEntity(
      isBranchWise: isBranchWise ?? false,
      isDepartmentWise: isDepartmentWise ?? false,
      isEmployeeWise: isEmployeeWise ?? false,
      branchList: branchList?.map((e) => e.toEntity()).toList() ?? [],
      departments: departments?.map((e) => e.toEntity()).toList() ?? [],
      employees: employees ?? [],
      modificationAccess: modificationAccess ?? false,
      status: status ?? '',
      message: message ?? '',
    );
}

extension BranchListMapper on BranchList {
  BranchEntity toEntity() => BranchEntity(
      blockId: blockId ?? '',
      blockName: blockName ?? '',
      floorIds: floorIds ?? '',
    );
}

extension DepartmentMapper on Department {
  DepartmentEntity toEntity() => DepartmentEntity(
      floorId: floorId ?? '',
      blockId: blockId ?? '',
      departmentName: departmentName ?? '',
      branchName: branchName ?? '',
    );
}
