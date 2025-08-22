import 'package:equatable/equatable.dart';

class DepartmentAndDesignationResponseEntity extends Equatable {
  final List<DesignationEntity>? designation;
  final List<DepartmentEntity>? departments;
  final List<SubDepartmentEntity>? subDepartmentList;
  final String? message;
  final String? status;

  const DepartmentAndDesignationResponseEntity({
    this.designation,
    this.departments,
    this.subDepartmentList,
    this.message,
    this.status,
  });

  @override
  List<Object?> get props => [
    designation,
    departments,
    subDepartmentList,
    message,
    status,
  ];
}

class DesignationEntity extends Equatable {
  final String? designationId;
  final String? designationName;

  const DesignationEntity({
    this.designationId,
    this.designationName,
  });

  @override
  List<Object?> get props => [designationId, designationName];
}

class DepartmentEntity extends Equatable {
  final String? departmentId;
  final String? societyId;
  final String? blockId;
  final String? departmentName;
  final String? departmentStatus;

  const DepartmentEntity({
    this.departmentId,
    this.societyId,
    this.blockId,
    this.departmentName,
    this.departmentStatus,
  });

  @override
  List<Object?> get props => [
    departmentId,
    societyId,
    blockId,
    departmentName,
    departmentStatus,
  ];
}

class SubDepartmentEntity extends Equatable {
  final String? subDepartmentId;
  final String? societyId;
  final String? blockId;
  final String? departmentId;
  final String? subDepartmentName;

  const SubDepartmentEntity({
    this.subDepartmentId,
    this.societyId,
    this.blockId,
    this.departmentId,
    this.subDepartmentName,
  });

  @override
  List<Object?> get props => [
    subDepartmentId,
    societyId,
    blockId,
    departmentId,
    subDepartmentName,
  ];
}
