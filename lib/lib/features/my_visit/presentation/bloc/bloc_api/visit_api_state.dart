import 'package:equatable/equatable.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/branch_department_entity.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/get_employee_detail_entity.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/visit_entity.dart';

abstract class VisitApiState extends Equatable {
  const VisitApiState();

  @override
  List<Object?> get props => [];
}

class VisitInitialState extends VisitApiState {}

class VisitLoadingState extends VisitApiState {}

class VisitSuccessState extends VisitApiState {
  final String message;

  const VisitSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class VisitFailureState extends VisitApiState {
  final String message;

  const VisitFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class VisitApiLoaded extends VisitApiState {
  final MyVisitModelEntity visitModelEntity;
  final String loadedFilterDate;
  final List<Map<String, String>> VisitWithBranches;
  final List<Map<String, String>> VisitWithDepartments;
  final List<Map<String, String>> VisitWithEmployee;
  final List<BranchEntity> branches;
  final List<DepartmentEntity> departments;
  final List<BranchEntity> selectedBranch;
  final List<DepartmentEntity> selectedDepartment;
  final List<EmployeeEntity> EmployeeDetails;
  final String SelectedFloorID;
  final String SelectedBlockID;

  const VisitApiLoaded({
    required this.visitModelEntity,
    required this.loadedFilterDate,
    this.VisitWithBranches = const [],
    this.VisitWithDepartments = const [],
    this.VisitWithEmployee = const [],
    required this.branches,
    required this.departments,
    this.selectedBranch = const [],
    this.selectedDepartment = const [],
    this.EmployeeDetails = const [],
    this.SelectedBlockID = '',
    this.SelectedFloorID = '',
  });

  VisitApiLoaded copyWith({
    MyVisitModelEntity? visitModelEntity,
    String? loadedFilterDate,
    List<Map<String, String>>? VisitWithBranches,
    List<Map<String, String>>? VisitWithDepartments,
    List<Map<String, String>>? VisitWithEmployee,
    List<BranchEntity>? branches,
    List<DepartmentEntity>? departments,
    List<EmployeeEntity>? EmployeeDetails,
    List<BranchEntity>? selectedBranch,
    List<DepartmentEntity>? selectedDepartment,
    String? SelectedBlockID,
    String? SelectedFloorID,
  }) => VisitApiLoaded(
    visitModelEntity: visitModelEntity ?? this.visitModelEntity,
    loadedFilterDate: loadedFilterDate ?? this.loadedFilterDate,
    VisitWithBranches: VisitWithBranches ?? this.VisitWithBranches,
    VisitWithDepartments: VisitWithDepartments ?? this.VisitWithDepartments,
    VisitWithEmployee: VisitWithEmployee ?? this.VisitWithEmployee,
    branches: branches ?? this.branches,
    departments: departments ?? this.departments,
    selectedBranch: selectedBranch ?? this.selectedBranch,
    selectedDepartment: selectedDepartment ?? this.selectedDepartment,
    EmployeeDetails: EmployeeDetails ?? this.EmployeeDetails,
    SelectedBlockID: SelectedBlockID ?? this.SelectedBlockID,
    SelectedFloorID: SelectedFloorID ?? this.SelectedFloorID,
  );

  @override
  List<Object?> get props => [
    visitModelEntity,
    loadedFilterDate,
    VisitWithBranches,
    VisitWithDepartments,
    VisitWithEmployee,
    branches,
    departments,
    selectedBranch,
    selectedDepartment,
    EmployeeDetails,
    SelectedFloorID,
    SelectedBlockID,
  ];
}

class VisitApiError extends VisitApiState {
  final String message;

  const VisitApiError(this.message);

  @override
  List<Object?> get props => [message];
}
