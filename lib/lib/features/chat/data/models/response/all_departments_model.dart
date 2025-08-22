// To parse this JSON data, do
//
//     final allDepartmentsModel = allDepartmentsModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:myco_flutter/features/chat/domain/entities/all_departments_entities.dart';

part 'all_departments_model.g.dart';

AllDepartmentsModel allDepartmentsModelFromJson(String str) =>
    AllDepartmentsModel.fromJson(json.decode(str));

String allDepartmentsModelToJson(AllDepartmentsModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class AllDepartmentsModel {
  @JsonKey(name: "departments")
  List<Department>? departments;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "status")
  String? status;

  AllDepartmentsModel({this.departments, this.message, this.status});

  factory AllDepartmentsModel.fromJson(Map<String, dynamic> json) =>
      _$AllDepartmentsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AllDepartmentsModelToJson(this);
  AllDepartmentsEntity toEntity() => AllDepartmentsEntity(
    departments: departments?.map((d) => d.toEntity()).toList() ?? [],
    message: message,
    status: status,
  );
}

@JsonSerializable()
class Department {
  @JsonKey(name: "block_id")
  String? blockId;
  @JsonKey(name: "floor_id")
  String? floorId;
  @JsonKey(name: "department_name")
  String? departmentName;

  Department({this.blockId, this.floorId, this.departmentName});

  factory Department.fromJson(Map<String, dynamic> json) =>
      _$DepartmentFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentToJson(this);
  DepartmentEntity toEntity() => DepartmentEntity(
    blockId: blockId,
    floorId: floorId,
    departmentName: departmentName,
  );
}
