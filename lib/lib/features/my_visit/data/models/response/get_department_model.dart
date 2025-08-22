import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:myco_flutter/features/my_visit/domain/entites/get_department_entity.dart';

part 'get_department_model.g.dart';

GetDepartmentModel getDepartmentModelFromJson(String str) =>
    GetDepartmentModel.fromJson(json.decode(str));

String getDepartmentModelToJson(GetDepartmentModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class GetDepartmentModel {
  @JsonKey(name: "current_month")
  String? currentMonth;

  @JsonKey(name: "total_pending_members")
  String? totalPendingMembers;

  @JsonKey(name: "recent_user")
  List<dynamic>? recentUser;

  @JsonKey(name: "departments")
  List<Department>? departments;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "status")
  String? status;

  GetDepartmentModel({
    this.currentMonth,
    this.totalPendingMembers,
    this.recentUser,
    this.departments,
    this.message,
    this.status,
  });

  factory GetDepartmentModel.fromJson(Map<String, dynamic> json) =>
      _$GetDepartmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetDepartmentModelToJson(this);

  /// Converts this model to its domain entity
  GetDepartmentEntity toEntity() => GetDepartmentEntity(
      currentMonth: currentMonth ?? '',
      totalPendingMembers: totalPendingMembers ?? '',
      recentUser: recentUser ?? [],
      departments: departments?.map((e) => e.toEntity()).toList() ?? [],
      message: message ?? '',
      status: status ?? '',
    );
}

@JsonSerializable()
class Department {
  @JsonKey(name: "floor_id")
  String? floorId;

  @JsonKey(name: "society_id")
  String? societyId;

  @JsonKey(name: "block_id")
  String? blockId;

  @JsonKey(name: "department_name")
  String? departmentName;

  @JsonKey(name: "is_my_department")
  bool? isMyDepartment;

  Department({
    this.floorId,
    this.societyId,
    this.blockId,
    this.departmentName,
    this.isMyDepartment,
  });

  factory Department.fromJson(Map<String, dynamic> json) =>
      _$DepartmentFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentToJson(this);


  DepartmentEntity toEntity() {
    return DepartmentEntity(
      floorId: floorId ?? '',
      societyId: societyId ?? '',
      blockId: blockId ?? '',
      departmentName: departmentName ?? '',
      isMyDepartment: isMyDepartment ?? false,
    );
  }
}
