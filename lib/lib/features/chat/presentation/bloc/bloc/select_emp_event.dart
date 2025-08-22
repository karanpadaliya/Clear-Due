part of 'select_emp_bloc.dart';


abstract class SelectEmpEvent {}

class LoadEmployeesEvent extends SelectEmpEvent {}

class LoadDepartmentsEvent extends SelectEmpEvent {}

class LoadInitialDataEvent extends SelectEmpEvent {}
class FilterEmployeesByDepartmentEvent extends SelectEmpEvent {
  final List<String>? departmentId;
  FilterEmployeesByDepartmentEvent(this.departmentId);
}
class SearchEmployeesEvent extends SelectEmpEvent {
  final String searchQuery;
  SearchEmployeesEvent(this.searchQuery);
}
class ToggleEmployeeSelectionEvent extends SelectEmpEvent {
  final EmployeeSelectModel employee;
  ToggleEmployeeSelectionEvent(this.employee);
}

class RemoveSelectedEmployeeEvent extends SelectEmpEvent {
  final EmployeeSelectModel employee;
  RemoveSelectedEmployeeEvent(this.employee);
}


class SelectAllVisibleEmployeesEvent extends SelectEmpEvent {}

class UnselectAllEmployeesEvent extends SelectEmpEvent {}

class ClearAllSelectionsEvent extends SelectEmpEvent {}