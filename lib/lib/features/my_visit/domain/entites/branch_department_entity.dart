class BranchDepartmentEntity {
  final bool isBranchWise;
  final bool isDepartmentWise;
  final bool isEmployeeWise;
  final List<BranchEntity> branchList;
  final List<DepartmentEntity> departments;
  final List<dynamic> employees;
  final bool modificationAccess;
  final String status;
  final String message;

  BranchDepartmentEntity({
    required this.isBranchWise,
    required this.isDepartmentWise,
    required this.isEmployeeWise,
    required this.branchList,
    required this.departments,
    required this.employees,
    required this.modificationAccess,
    required this.status,
    required this.message,
  });
}

class BranchEntity {
  final String blockId;
  final String blockName;
  final String floorIds;

  BranchEntity({
    required this.blockId,
    required this.blockName,
    required this.floorIds,
  });
}

class DepartmentEntity {
  final String floorId;
  final String blockId;
  final String departmentName;
  final String branchName;

  DepartmentEntity({
    required this.floorId,
    required this.blockId,
    required this.departmentName,
    required this.branchName,
  });
}
