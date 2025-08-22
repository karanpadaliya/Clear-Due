import 'package:equatable/equatable.dart';

// The main response entity that your UI and business logic will use.
class AdminViewResponseEntity extends Equatable {
  final List<EmployeeEntity>? employeeList;
  final List<BranchEntity>? branchList;
  final List<DepartmentEntity>? departmentList;
  final List<AdminMenuCategoryEntity>? adminMenuCategory;
  final String? message;
  final String? status;

  const AdminViewResponseEntity({
    this.employeeList,
    this.branchList,
    this.departmentList,
    this.adminMenuCategory,
    this.message,
    this.status,
  });

  @override
  List<Object?> get props => [
    employeeList,
    branchList,
    departmentList,
    adminMenuCategory,
    message,
    status,
  ];
}

// --- Nested Entities ---

class AdminMenuCategoryEntity extends Equatable {
  final String? accessTypeId;
  final String? accessTypeParentId;
  final String? accessType;
  final String? accessTypeFor;
  final String? accessTypeImage;
  final String? accessTypeImageNew;
  final List<AdminSubMenuEntity>? adminSubMenu;

  const AdminMenuCategoryEntity({
    this.accessTypeId,
    this.accessTypeParentId,
    this.accessType,
    this.accessTypeFor,
    this.accessTypeImage,
    this.accessTypeImageNew,
    this.adminSubMenu,
  });

  @override
  List<Object?> get props => [
    accessTypeId,
    accessTypeParentId,
    accessType,
    accessTypeFor,
    accessTypeImage,
    accessTypeImageNew,
    adminSubMenu,
  ];
}

class AdminSubMenuEntity extends Equatable {
  final String? accessTypeId;
  final String? accessTypeParentId;
  final String? accessType;
  final String? accessTypeFor;
  final String? accessTypeImage;
  final String? accessTypeImageNew;
  final String? branchIds;
  final String? departmentIds;
  final String? employeeIds;
  final bool? isBranchWise;
  final bool? isDepartmentWise;
  final bool? isEmployeeWise;
  final bool? modificationAccess;
  final String? pendingCount;

  const AdminSubMenuEntity({
    this.accessTypeId,
    this.accessTypeParentId,
    this.accessType,
    this.accessTypeFor,
    this.accessTypeImage,
    this.accessTypeImageNew,
    this.branchIds,
    this.departmentIds,
    this.employeeIds,
    this.isBranchWise,
    this.isDepartmentWise,
    this.isEmployeeWise,
    this.modificationAccess,
    this.pendingCount
  });

  @override
  List<Object?> get props => [
    accessTypeId,
    accessTypeParentId,
    accessType,
    accessTypeFor,
    accessTypeImage,
    accessTypeImageNew,
    branchIds,
    departmentIds,
    employeeIds,
    isBranchWise,
    isDepartmentWise,
    isEmployeeWise,
    modificationAccess,
  ];
}

class BranchEntity extends Equatable {
  final String? branchId;
  final String? branchName;

  const BranchEntity({this.branchId, this.branchName});

  @override
  List<Object?> get props => [branchId, branchName];
}

class DepartmentEntity extends Equatable {
  final String? departmentId;
  final String? branchId;
  final String? departmentName;
  final String? branchName;

  const DepartmentEntity({
    this.departmentId,
    this.branchId,
    this.departmentName,
    this.branchName,
  });

  @override
  List<Object?> get props => [departmentId, branchId, departmentName, branchName];
}

class EmployeeEntity extends Equatable {
  final String? userId;
  final String? branchId;
  final String? departmentId;
  final String? userFullName;
  final String? userProfilePic;
  final String? branchName;
  final String? departmentName;

  const EmployeeEntity({
    this.userId,
    this.branchId,
    this.departmentId,
    this.userFullName,
    this.userProfilePic,
    this.branchName,
    this.departmentName,
  });

  @override
  List<Object?> get props => [
    userId,
    branchId,
    departmentId,
    userFullName,
    userProfilePic,
    branchName,
    departmentName,
  ];
}
