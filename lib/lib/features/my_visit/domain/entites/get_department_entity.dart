class GetDepartmentEntity {
  final String currentMonth;
  final String totalPendingMembers;
  final List<dynamic> recentUser;
  final List<DepartmentEntity> departments;
  final String message;
  final String status;

  GetDepartmentEntity({
    required this.currentMonth,
    required this.totalPendingMembers,
    required this.recentUser,
    required this.departments,
    required this.message,
    required this.status,
  });
}

class DepartmentEntity {
  final String floorId;
  final String societyId;
  final String blockId;
  final String departmentName;
  final bool isMyDepartment;

  DepartmentEntity({
    required this.floorId,
    required this.societyId,
    required this.blockId,
    required this.departmentName,
    required this.isMyDepartment,
  });
}
