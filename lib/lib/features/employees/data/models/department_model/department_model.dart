import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:myco_flutter/features/employees/domain/entites/department_entity.dart';

part 'department_model.g.dart';

DepartmentModel departmentModelFromJson(String str) =>
    DepartmentModel.fromJson(json.decode(str));

String departmentModelToJson(DepartmentModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class DepartmentModel extends Equatable {
  @JsonKey(name: "floor_id")
  final String? departmentId;

  @JsonKey(name: "society_id")
  final String? companyId;

  @JsonKey(name: "block_id")
  final String? branchId;

  @JsonKey(name: "block_name")
  final String? branchName;

  @JsonKey(name: "department_name")
  final String? departmentName;

  @JsonKey(name: "is_my_department")
  final bool? isMyDepartment;

  const DepartmentModel({
    this.departmentId,
    this.companyId,
    this.branchId,
    this.branchName,
    this.departmentName,
    this.isMyDepartment,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) =>
      _$DepartmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentModelToJson(this);

  Department toEntity() => Department(
    departmentId: departmentId,
    companyId: companyId,
    branchId: branchId,
    branchName: branchName,
    departmentName: departmentName,
    isMyDepartment: isMyDepartment,
  );

  @override
  List<Object?> get props => [
    departmentId,
    companyId,
    branchId,
    branchName,
    departmentName,
    isMyDepartment,
  ];
}
