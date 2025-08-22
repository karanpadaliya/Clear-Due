import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:myco_flutter/features/chat/data/models/employee_model.dart';

import 'package:myco_flutter/features/chat/data/models/request/all_department_request_model.dart';
import 'package:myco_flutter/features/chat/data/models/request/all_employee_request_model.dart';
import 'package:myco_flutter/features/chat/domain/usecases/get_all_departments.dart';
import 'package:myco_flutter/features/chat/domain/usecases/get_all_employee.dart';
import 'package:myco_flutter/features/chat/presentation/bloc/bloc/select_emp_state.dart';


part 'select_emp_event.dart';


class SelectEmpBloc extends Bloc<SelectEmpEvent, SelectEmpState> {
    final GetAllDepartments AllDepartmentUsecases;
    final GetAllEmployee getAllEmployeeUsecases;
  SelectEmpBloc(  this.AllDepartmentUsecases , this.getAllEmployeeUsecases) : super(const SelectEmpState()) {
   on<LoadEmployeesEvent>(_onLoadEmployees);
   on<LoadDepartmentsEvent>(_onLoadDepartments);
    on<FilterEmployeesByDepartmentEvent>(_onFilterEmployees);
    on<ToggleEmployeeSelectionEvent>(_onToggleEmployeeSelection);
    on<RemoveSelectedEmployeeEvent>(_onRemoveSelectedEmployee);
    on<ClearAllSelectionsEvent>(_onClearAllSelections);
    on<SearchEmployeesEvent>(_onSearchEmployees);
     on<SelectAllVisibleEmployeesEvent>(_onSelectAllVisibleEmployees);
    on<UnselectAllEmployeesEvent>(_onUnselectAllEmployees);
  }

   Future<void> _onLoadEmployees(LoadEmployeesEvent event, Emitter<SelectEmpState> emit) async {
    emit(state.copyWith(isLoadingEmployees: true));
    try {
      final requestModel = AllEmployeeRequestModel(
      getEmployees: "getEmployees",
      societyId: "1",
      userId: "1365",
      languageId: "0",
    );
    final result = await getAllEmployeeUsecases.getAllEmployee(requestModel);
    
    result.fold(
      (failure) => emit(state.copyWith(isLoadingEmployees: false, employeeError: failure.message)),
      (response) {
       final data = response.employees;

       final employees = data.map((EmployeeEntity) => EmployeeSelectModel.fromMember(EmployeeEntity)).toList();
         emit(state.copyWith(
        isLoadingEmployees: false,
        allEmployees: employees,
        filteredEmployees: employees,
        selectedEmployees: [], // Reset selection on fetch
      ));
      },
    );
     
    } catch (e) {
      emit(state.copyWith(isLoadingEmployees: false, employeeError: e.toString()));
    }
  }

  Future<void> _onLoadDepartments(
    LoadDepartmentsEvent event,
    Emitter<SelectEmpState> emit,
  ) async {
    emit(state.copyWith(isLoadingDepartments: true));
    try {
      final requestModel = AllDepartmentRequestModel(
      getAllDepartments: "getAllDepartments",
      societyId: "1",
      userId: "1776",
      languageId: "1",
    );

    final result = await AllDepartmentUsecases.getAllDepartments(requestModel);
    log(result.toString(), name: 'get departments');
    result.fold(
      (failure) => emit(state.copyWith(isLoadingDepartments: false, departmentError: failure.message)),
      (response) {
       final data = response.departments;
       final departments = data.map((DepartmentEntity) => Department.fromJson(DepartmentEntity)).toList();
         emit(state.copyWith(
       departments: departments,
        isLoadingDepartments: false,
      ));
      },
    );
     
    } catch (e) {
      emit(state.copyWith(isLoadingDepartments: false, departmentError: e.toString()));
    }
  }

  
 void _onFilterEmployees(
    FilterEmployeesByDepartmentEvent event,
    Emitter<SelectEmpState> emit,
  ) {
    // List<EmployeeSelectModel> filtered;
    final filtered = _applyDepartmentFilter(state.allEmployees, event.departmentId ?? []);
    log(filtered.toString(), name: 'filtered employees');
    emit(state.copyWith(
      filteredEmployees: filtered,
      selectedDepartmentId: event.departmentId,
    ));
  }
  void _onSearchEmployees(
    SearchEmployeesEvent event,
    Emitter<SelectEmpState> emit,
  ) {
    final filtered = _applyAllFilters(state.allEmployees, state.selectedDepartmentId ?? [], event.searchQuery);

    emit(state.copyWith(
      filteredEmployees: filtered,
      searchQuery: event.searchQuery,
    ));
  }

  List<EmployeeSelectModel> _applyAllFilters(List<EmployeeSelectModel> employees, List<String> departmentIds, String searchQuery) {
    List<EmployeeSelectModel> filtered = employees;
    
    // Apply department filter
    if (departmentIds.isNotEmpty) {
      final selectedDepartmentNames = state.departments
          .where((dept) => departmentIds.contains(dept.id))
          .map((dept) => dept.name)
          .toSet();
      
      filtered = filtered
          .where((employee) => selectedDepartmentNames.contains(employee.department))
          .toList();
    }
    
    // Apply search filter
    if (searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase().trim();
      final filterstartsWithResults = filtered
          .where((employee) => 
              employee.name.toLowerCase().startsWith(query) )
          .toList();
          //  final filtercontainsResults = filtered
          // .where((employee) => 
          //     employee.name.toLowerCase().contains(query) )
          // .toList(); 
    filtered = [...filterstartsWithResults];
    }
    return filtered;
  }
 void _onToggleEmployeeSelection(
    ToggleEmployeeSelectionEvent event,
    Emitter<SelectEmpState> emit,
  ) {
    final List<EmployeeSelectModel> updatedSelected = List.from(state.selectedEmployees);
    
    if (updatedSelected.contains(event.employee)) {
      updatedSelected.remove(event.employee);
    } else {
      updatedSelected.add(event.employee);
    }

    emit(state.copyWith(selectedEmployees: updatedSelected));
  }

  void _onRemoveSelectedEmployee(
    RemoveSelectedEmployeeEvent event,
    Emitter<SelectEmpState> emit,
  ) {
    final List<EmployeeSelectModel> updatedSelected = List.from(state.selectedEmployees);
    updatedSelected.remove(event.employee);

    emit(state.copyWith(selectedEmployees: updatedSelected));
  }
  void _onSelectAllVisibleEmployees(
    SelectAllVisibleEmployeesEvent event,
    Emitter<SelectEmpState> emit,
  ) {
    final List<EmployeeSelectModel> updatedSelected = List.from(state.selectedEmployees);
    
    // Add all visible employees that aren't already selected
    for (final employee in state.filteredEmployees) {
      if (!updatedSelected.contains(employee)) {
        updatedSelected.add(employee);
      }
    }

    emit(state.copyWith(selectedEmployees: updatedSelected));
  }

  void _onUnselectAllEmployees(
    UnselectAllEmployeesEvent event,
    Emitter<SelectEmpState> emit,
  ) {
    emit(state.copyWith(selectedEmployees: []));
  }
  void _onClearAllSelections(
    ClearAllSelectionsEvent event,
    Emitter<SelectEmpState> emit,
  ) {
    emit(state.copyWith(selectedEmployees: []));
  }

  List<EmployeeSelectModel> _applyDepartmentFilter(List<EmployeeSelectModel> employees, List<String> departmentIds) {
    if (departmentIds.isEmpty) {
      return employees;
    }
    
    // Get department names from IDs
    final selectedDepartmentNames = state.departments
        .where((dept) => departmentIds.contains(dept.id))
        .map((dept) => dept.id)
        .toSet();
    log(selectedDepartmentNames.toString(), name: 'selectedDepartmentNames amit');
    log(employees.toString(), name: 'employees amit');
   final List<EmployeeSelectModel> filteredList = [];

  for (final deptId in departmentIds) {
    final deptEmployees = employees
        .where((member) => member.departmentId.toString() == deptId)
        .toList();
    filteredList.addAll(deptEmployees);
  }
    log(filteredList.toString(), name: 'filtered w amit');
    return filteredList;
  }
}
