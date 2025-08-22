// To parse this JSON data, do
//
//     final allEmployeeModel = allEmployeeModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:myco_flutter/features/chat/domain/entities/all_employee_entity.dart';

part 'all_employee_model.g.dart';

AllEmployeeModel allEmployeeModelFromJson(String str) => AllEmployeeModel.fromJson(json.decode(str));

String allEmployeeModelToJson(AllEmployeeModel data) => json.encode(data.toJson());

@JsonSerializable()
class AllEmployeeModel {
    @JsonKey(name: "branch_list")
    List<BranchList>? branchList;
    @JsonKey(name: "departments")
    List<Department>? departments;
    @JsonKey(name: "employees")
    List<Employee>? employees;
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "total_branch")
    int? totalBranch;
    @JsonKey(name: "total_department")
    int? totalDepartment;
    @JsonKey(name: "total_employees")
    int? totalEmployees;
    @JsonKey(name: "status")
    String? status;

    AllEmployeeModel({
        this.branchList,
        this.departments,
        this.employees,
        this.message,
        this.totalBranch,
        this.totalDepartment,
        this.totalEmployees,
        this.status,
    });

    factory AllEmployeeModel.fromJson(Map<String, dynamic> json) => _$AllEmployeeModelFromJson(json);

    Map<String, dynamic> toJson() => _$AllEmployeeModelToJson(this);
    AllEmployeeEntity toEntity() => AllEmployeeEntity(
        branchList: branchList?.map((b) => b.toEntity()).toList() ?? [],
        departments: departments?.map((d) => d.toEntity()).toList() ?? [],
        employees: employees?.map((e) => e.toEntity()).toList() ?? [],
        message: message ?? '',
        totalBranch: totalBranch ?? 0,
        totalDepartment: totalDepartment ?? 0,
        totalEmployees: totalEmployees ?? 0,
        status: status ?? '',
      );
}

@JsonSerializable()
class BranchList {
    @JsonKey(name: "block_id")
    String? blockId;
    @JsonKey(name: "society_id")
    String? societyId;
    @JsonKey(name: "block_name")
    String? blockName;

    BranchList({
        this.blockId,
        this.societyId,
        this.blockName,
    });

    factory BranchList.fromJson(Map<String, dynamic> json) => _$BranchListFromJson(json);

    Map<String, dynamic> toJson() => _$BranchListToJson(this);
    BranchEntity toEntity() => BranchEntity(
        blockId: blockId ?? '',
        societyId: societyId ?? '',
        blockName: blockName ?? '',
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
    @JsonKey(name: "block_name")
    String? blockName;
    @JsonKey(name: "department_name")
    String? departmentName;
    @JsonKey(name: "floor_name")
    String? floorName;
    @JsonKey(name: "is_my_department")
    bool? isMyDepartment;

    Department({
        this.floorId,
        this.societyId,
        this.blockId,
        this.blockName,
        this.departmentName,
        this.floorName,
        this.isMyDepartment,
    });

    factory Department.fromJson(Map<String, dynamic> json) => _$DepartmentFromJson(json);

    Map<String, dynamic> toJson() => _$DepartmentToJson(this);
    DepartmentEntity toEntity() => DepartmentEntity(
        floorId: floorId ?? '',
        societyId: societyId ?? '',
        blockId: blockId ?? '',
        blockName: blockName ?? '',
        departmentName: departmentName ?? '',
        floorName: floorName ?? '',
        isMyDepartment: isMyDepartment ?? false,
      );

}

@JsonSerializable()
class Employee {
    @JsonKey(name: "user_id")
    String? userId;
    @JsonKey(name: "unit_id")
    String? unitId;
    @JsonKey(name: "block_id")
    String? blockId;
    @JsonKey(name: "floor_id")
    String? floorId;
    @JsonKey(name: "user_first_name")
    String? userFirstName;
    @JsonKey(name: "user_last_name")
    String? userLastName;
    @JsonKey(name: "user_mobile")
    String? userMobile;
    @JsonKey(name: "user_full_name")
    String? userFullName;
    @JsonKey(name: "short_name")
    String? shortName;
    @JsonKey(name: "society_id")
    String? societyId;
    @JsonKey(name: "designation")
    String? designation;
    @JsonKey(name: "branch_name")
    String? branchName;
    @JsonKey(name: "department_name")
    String? departmentName;
    @JsonKey(name: "company_leave_date")
    String? companyLeaveDate;
    @JsonKey(name: "company_leave_date_view")
    String? companyLeaveDateView;
    @JsonKey(name: "is_future_date")
    bool? isFutureDate;
    @JsonKey(name: "user_active")
    bool? userActive;
    @JsonKey(name: "user_profile_pic")
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
        this.shortName,
        this.societyId,
        this.designation,
        this.branchName,
        this.departmentName,
        this.companyLeaveDate,
        this.companyLeaveDateView,
        this.isFutureDate,
        this.userActive,
        this.userProfilePic,
    });

    factory Employee.fromJson(Map<String, dynamic> json) => _$EmployeeFromJson(json);

    Map<String, dynamic> toJson() => _$EmployeeToJson(this);
    EmployeeEntity toEntity() => EmployeeEntity(
        userId: userId ?? '',
        unitId: unitId ?? '',
        blockId: blockId ?? '',
        floorId: floorId ?? '',
        userFirstName: userFirstName ?? '',
        userLastName: userLastName ?? '',
        userMobile: userMobile ?? '',
        userFullName: userFullName ?? '',
        shortName: shortName ?? '',
        societyId: societyId ?? '',
        designation: designation ?? '',
        branchName: branchName ?? '',
        departmentName: departmentName ?? '',
        companyLeaveDate: companyLeaveDate ?? '',
        companyLeaveDateView: companyLeaveDateView ?? '',
        isFutureDate: isFutureDate ?? false,
        userActive: userActive ?? false,
        userProfilePic: userProfilePic ?? '',
      );
}
