import 'package:myco_flutter/features/chat/data/models/employee_model.dart';

class SelectEmpState {
  final List<EmployeeSelectModel> allEmployees;
  final List<EmployeeSelectModel> filteredEmployees;
  final List<EmployeeSelectModel> selectedEmployees;
  final List<Department> departments;
  final List<String>? selectedDepartmentId;
  final String searchQuery;
  final bool isLoadingEmployees;
  final bool isLoadingDepartments;
  final String? employeeError;
  final String? departmentError;

  const SelectEmpState({
    this.allEmployees = const [],
    this.filteredEmployees = const [],
    this.selectedEmployees = const [],
    this.departments = const [],
    this.selectedDepartmentId,
    this.searchQuery = '',
    this.isLoadingEmployees = false,
    this.isLoadingDepartments = false,
    this.employeeError,
    this.departmentError,
  });

  SelectEmpState copyWith({
    List<EmployeeSelectModel>? allEmployees,
    List<EmployeeSelectModel>? filteredEmployees,
    List<EmployeeSelectModel>? selectedEmployees,
    List<Department>? departments,
    List<String>? selectedDepartmentId,
    String? searchQuery,
    bool? isLoadingEmployees,
    bool? isLoadingDepartments,
    String? employeeError,
    String? departmentError,
  }) => SelectEmpState(
      allEmployees: allEmployees ?? this.allEmployees,
      filteredEmployees: filteredEmployees ?? this.filteredEmployees,
      selectedEmployees: selectedEmployees ?? this.selectedEmployees,
      departments: departments ?? this.departments,
      selectedDepartmentId: selectedDepartmentId ?? this.selectedDepartmentId,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoadingEmployees: isLoadingEmployees ?? this.isLoadingEmployees,
      isLoadingDepartments: isLoadingDepartments ?? this.isLoadingDepartments,
      employeeError: employeeError ?? this.employeeError,
      departmentError: departmentError ?? this.departmentError,
    );

  bool isEmployeeSelected(EmployeeSelectModel employee) {
    return selectedEmployees.contains(employee);
  }

  bool isDepartmentSelected(String departmentId) {
    return selectedDepartmentId?.contains(departmentId) ?? false;
  }

  bool get isLoading => isLoadingEmployees || isLoadingDepartments;
  
  bool get hasError => employeeError != null || departmentError != null;
  
  String? get errorMessage => employeeError ?? departmentError;

  List<Department> get selectedDepartments => departments
        .where((dept) => selectedDepartmentId?.contains(dept.id) ?? false)
        .toList();

  bool get hasActiveFilter => selectedDepartmentId?.isNotEmpty ?? false;


  int get filteredCount => filteredEmployees.length;
  int get totalCount => allEmployees.length;

  bool get areAllVisibleSelected {
    if (filteredEmployees.isEmpty) return false;
    return filteredEmployees.every((employee) => selectedEmployees.contains(employee));
  }

  bool get areSomeVisibleSelected {
    return filteredEmployees.any((employee) => selectedEmployees.contains(employee));
  }

  int get selectedVisibleCount {
    return filteredEmployees.where((employee) => selectedEmployees.contains(employee)).length;
  }
}