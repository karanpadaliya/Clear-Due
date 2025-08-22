class AllDepartmentsEntity {
  final List<DepartmentEntity> departments;
  final String? message;
  final String? status;

  AllDepartmentsEntity({
    required this.departments,
    this.message,
    this.status,
  });
}

class DepartmentEntity {
  final String? blockId;
  final String? floorId;
  final String? departmentName;

  DepartmentEntity({
    this.blockId,
    this.floorId,
    this.departmentName,
  });
}
