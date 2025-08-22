// lib/domain/entities/all_employee_entity.dart

class AllEmployeeEntity {
  final List<BranchEntity> branchList;
  final List<DepartmentEntity> departments;
  final List<EmployeeEntity> employees;
  final String message;
  final int totalBranch;
  final int totalDepartment;
  final int totalEmployees;
  final String status;

  AllEmployeeEntity({
    required this.branchList,
    required this.departments,
    required this.employees,
    required this.message,
    required this.totalBranch,
    required this.totalDepartment,
    required this.totalEmployees,
    required this.status,
  });
}

class BranchEntity {
  final String blockId;
  final String societyId;
  final String blockName;

  BranchEntity({
    required this.blockId,
    required this.societyId,
    required this.blockName,
  });
}

class DepartmentEntity {
  final String floorId;
  final String societyId;
  final String blockId;
  final String blockName;
  final String departmentName;
  final String floorName;
  final bool isMyDepartment;

  DepartmentEntity({
    required this.floorId,
    required this.societyId,
    required this.blockId,
    required this.blockName,
    required this.departmentName,
    required this.floorName,
    required this.isMyDepartment,
  });
}

class EmployeeEntity {
  final String userId;
  final String unitId;
  final String blockId;
  final String floorId;
  final String userFirstName;
  final String userLastName;
  final String userMobile;
  final String userFullName;
  final String shortName;
  final String societyId;
  final String designation;
  final String branchName;
  final String departmentName;
  final String companyLeaveDate;
  final String companyLeaveDateView;
  final bool isFutureDate;
  final bool userActive;
  final String userProfilePic;

  EmployeeEntity({
    required this.userId,
    required this.unitId,
    required this.blockId,
    required this.floorId,
    required this.userFirstName,
    required this.userLastName,
    required this.userMobile,
    required this.userFullName,
    required this.shortName,
    required this.societyId,
    required this.designation,
    required this.branchName,
    required this.departmentName,
    required this.companyLeaveDate,
    required this.companyLeaveDateView,
    required this.isFutureDate,
    required this.userActive,
    required this.userProfilePic,
  });
}
