import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/core/services/hive_cache_service.dart'; // Keep this import
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/features/employees/domain/usecases/get_employees_usecase.dart';
import 'package:myco_flutter/features/employees/domain/usecases/get_user_data_usecase.dart';
import 'package:myco_flutter/features/employees/presentation/bloc/employee_event.dart';
import 'package:myco_flutter/features/employees/presentation/bloc/employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final GetUserDataUseCase getUserData;
  final GetEmployeesUseCase getEmployees;

  // Use the concrete type HiveCacheService here
  // final HiveCacheService _hiveCacheService = GetIt.I<HiveCacheService>();
  final PreferenceManager preferenceManager = GetIt.I<PreferenceManager>();

  String? _userId;
  String? _companyId;

  bool _hasLoadedOnce = false;

  EmployeeBloc({required this.getUserData, required this.getEmployees})
    : super(EmployeeInitial()) {
    on<LoadUserData>(_onLoadUserData);
    on<ChangeBranch>(_onChangeBranch);
    on<ChangeDepartment>(_onChangeDepartment);
    on<SearchEmployees>(_onSearch);
    on<ToggleEmployeeSelection>(_onToggleEmployeeSelection);
    on<RefreshEmployeeData>(_onRefreshEmployeeData);
  }

  Future<void> _onLoadUserData(
    LoadUserData evt,
    Emitter<EmployeeState> emit,
  ) async {
    emit(EmployeeLoading());

    // Use HiveCacheService to get user and company ID
    // final userId = await _hiveCacheService.get<String>('userBox', 'userId') ?? '';
    // final companyId = await _hiveCacheService.get<String>('userBox', 'companyId') ?? '';

    _userId ??= await preferenceManager.getUserId();
    _companyId ??= await preferenceManager.getCompanyId();

    final userId = _userId ?? '';
    final companyId = _companyId ?? '';

    if (userId.isEmpty || companyId.isEmpty) {
      emit(
        EmployeeError('User ID or Company ID not found. Please log in again.'),
      );
      return;
    }

    if (_hasLoadedOnce) {
      // If data has been loaded once, only refresh the employee list if needed
      // based on selected branch/department or a specific refresh event
      // This logic depends on your app's requirements for subsequent loads.
    } else {
      final result = await getUserData.call(
        userId: userId,
        companyId: companyId,
      );

      result.fold(
        (failure) => emit(EmployeeError(_mapFailureToMessage(failure))),
        (data) {
          final branches = data.value1;
          final departments = data.value2;
          final employees = data.value3;

          _hasLoadedOnce = true;

          final currentUser = employees.firstWhere(
            (e) => e.userId == userId,
            orElse: () => employees.first,
          );

          final userDept = departments.firstWhere(
            (d) => d.departmentId == currentUser.departmentId,
            orElse: () => departments.first,
          );

          final userBranch = branches.firstWhere(
            (b) => b.branchId == userDept.branchId,
            orElse: () => branches.first,
          );

          final employeesFiltered = employees
              .where(
                (e) =>
                    e.branchId == userDept.branchId &&
                    e.departmentId == userDept.departmentId,
              )
              .toList();
          emit(
            EmployeeLoaded(
              branches: branches,
              departments: departments,
              employees: employeesFiltered,
              allEmployees: employeesFiltered,
              selectedBranch: userBranch,
              selectedDepartment: userDept,
              selectedEmployeeIds: <String>{},
              searchQuery: '',
            ),
          );
        },
      );
    }
  }

  Future<void> _onChangeBranch(
    ChangeBranch evt,
    Emitter<EmployeeState> emit,
  ) async {
    if (state is EmployeeLoaded) {
      final st = state as EmployeeLoaded;
      emit(EmployeeLoading());

      final userId = _userId ?? '';
      final companyId = _companyId ?? '';

      final newBranch = evt.branch;
      final possibleDepts = st.departments
          .where((d) => d.branchId == newBranch.branchId)
          .toList();

      final newDept = possibleDepts.isNotEmpty ? possibleDepts.first : null;

      final result = await getEmployees.call(
        GetEmployeesParams(
          userId: userId,
          companyId: companyId,
          branchId: newBranch.branchId,
          departmentId: newDept?.departmentId,
        ),
      );

      result.fold(
        (failure) => emit(EmployeeError(_mapFailureToMessage(failure))),
        (employees) {
          emit(
            EmployeeLoaded(
              branches: st.branches,
              departments: st.departments,
              employees: employees,
              allEmployees: employees,
              selectedBranch: newBranch,
              selectedDepartment: newDept,
              searchQuery: '',
              selectedEmployeeIds: <String>{},
            ),
          );
        },
      );
    }
  }

  Future<void> _onChangeDepartment(
    ChangeDepartment evt,
    Emitter<EmployeeState> emit,
  ) async {
    if (state is EmployeeLoaded) {
      final st = state as EmployeeLoaded;
      emit(EmployeeLoading());

      final userId = _userId ?? '';
      final companyId = _companyId ?? '';

      final newDept = evt.department;

      final result = await getEmployees.call(
        GetEmployeesParams(
          userId: userId,
          companyId: companyId,
          branchId: newDept.branchId,
          departmentId: newDept.departmentId,
        ),
      );

      result.fold(
        (failure) => emit(EmployeeError(_mapFailureToMessage(failure))),
        (employees) {
          emit(
            EmployeeLoaded(
              branches: st.branches,
              departments: st.departments,
              employees: employees,
              allEmployees: employees,
              selectedBranch: st.selectedBranch,
              selectedDepartment: newDept,
              searchQuery: '',
              selectedEmployeeIds: <String>{},
            ),
          );
        },
      );
    }
  }

  void _onSearch(SearchEmployees evt, Emitter<EmployeeState> emit) {
    if (state is EmployeeLoaded) {
      final st = state as EmployeeLoaded;
      final query = evt.query.trim().toLowerCase();

      final filteredEmployees = query.isNotEmpty
          ? st.allEmployees.where((e) {
              final name = e.userFullName?.toLowerCase() ?? '';
              final dept = e.designation?.toLowerCase() ?? '';
              return name.contains(query) || dept.contains(query);
            }).toList()
          : st.allEmployees;

      emit(
        EmployeeLoaded(
          branches: st.branches,
          departments: st.departments,
          employees: filteredEmployees,
          allEmployees: st.allEmployees,
          selectedBranch: st.selectedBranch,
          selectedDepartment: st.selectedDepartment,
          searchQuery: evt.query,
          selectedEmployeeIds: st.selectedEmployeeIds,
        ),
      );
    }
  }

  void _onToggleEmployeeSelection(
    ToggleEmployeeSelection event,
    Emitter<EmployeeState> emit,
  ) {
    if (state is EmployeeLoaded) {
      final currentState = state as EmployeeLoaded;
      final Set<String> updatedSelectedEmployeeIds = Set.from(
        currentState.selectedEmployeeIds,
      );

      if (updatedSelectedEmployeeIds.contains(event.employeeId)) {
        updatedSelectedEmployeeIds.remove(event.employeeId);
      } else {
        updatedSelectedEmployeeIds.add(event.employeeId);
      }

      emit(
        EmployeeLoaded(
          branches: currentState.branches,
          departments: currentState.departments,
          employees: currentState.employees,
          allEmployees: currentState.allEmployees,
          selectedBranch: currentState.selectedBranch,
          selectedDepartment: currentState.selectedDepartment,
          searchQuery: currentState.searchQuery,
          selectedEmployeeIds: updatedSelectedEmployeeIds,
        ),
      );
    }
  }

  Future<void> _onRefreshEmployeeData(
    RefreshEmployeeData event,
    Emitter<EmployeeState> emit,
  ) async {
    if (state is EmployeeLoaded) {
      final currentState = state as EmployeeLoaded;
      emit(EmployeeLoading());

      final userId = _userId ?? '';
      final companyId = _companyId ?? '';

      if (userId.isEmpty || companyId.isEmpty) {
        emit(EmployeeError('User ID or Company ID not found for refresh.'));
        return;
      }

      final result = await getUserData.call(
        userId: userId,
        companyId: companyId,
      );

      result.fold(
        (failure) => emit(EmployeeError(_mapFailureToMessage(failure))),
        (data) {
          final branches = data.value1;
          final departments = data.value2;
          final employees = data.value3;

          emit(
            EmployeeLoaded(
              branches: branches,
              departments: departments,
              employees: employees,
              allEmployees: employees,
              selectedBranch: currentState.selectedBranch,
              selectedDepartment: currentState.selectedDepartment,
              searchQuery: currentState.searchQuery,
              selectedEmployeeIds: currentState.selectedEmployeeIds,
            ),
          );
        },
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) return 'Server error: ${failure.message}';
    if (failure is NetworkFailure) {
      return 'Network error: Please check your internet connection.';
    }
    return 'An unexpected error occurred.';
  }
}
