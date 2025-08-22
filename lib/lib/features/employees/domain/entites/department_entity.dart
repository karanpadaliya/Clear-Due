import 'package:equatable/equatable.dart';

class Department extends Equatable {
  final String? departmentId;
  final String? companyId;
  final String? branchId;
  final String? branchName;
  final String? departmentName;
  final bool? isMyDepartment;

  const Department({
    this.departmentId,
    this.companyId,
    this.branchId,
    this.branchName,
    this.departmentName,
    this.isMyDepartment,
  });

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
