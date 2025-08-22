import 'package:bloc/bloc.dart';
import 'package:myco_flutter/features/work_allocation/data/models/request/get_work_category_request.dart';
import 'package:myco_flutter/features/work_allocation/domain/usecases/work_allocation_use_case.dart';
import 'package:myco_flutter/features/work_allocation/presentation/bloc/assign_work_event.dart';
import 'package:myco_flutter/features/work_allocation/presentation/bloc/assign_work_state.dart';
import 'package:myco_flutter/features/work_allocation/presentation/widgets/employee_details.dart';

class AssignWorkBloc extends Bloc<AssignWorkEvent, AssignWorkState> {
  final WorkAllocationUseCase useCase;

  String? _selectedCategory;

  final List<Employee> _filteredEmployees = [];
  final bool _showEmployeeList = false;

  String? get selectedCategory => _selectedCategory;

  List<Employee> get filteredEmployees => _filteredEmployees;

  bool get showEmployeeList => _showEmployeeList;
  Employee? _selectedEmployee;

  Employee? get selectedEmployee => _selectedEmployee;

  AssignWorkBloc({required this.useCase}) : super(AssignWorkInitial()) {
    on<FetchWorkCategoryList>(_onFetchWorkCategoryList);
    on<SelectDynamicWorkCategoryEvent>(_onSelectDynamicCategory);
    on<AddWorkAllocationEvent>(_onAddWorkAllocation);
    on<ApproveTaskEvent>(_onApproveTask);
    on<DenyTaskEvent>(_onDenyTask);
    on<CompleteTaskEvent>(_onCompleteTask);
    on<ApproveByHodEvent>(_onApproveByHod);
    on<SelectEmployeeEvent>(_onSelectEmployee);
  }

  //fetch category list
  Future<void> _onFetchWorkCategoryList(
    FetchWorkCategoryList event,
    Emitter<AssignWorkState> emit,
  ) async {
    emit(AssignWorkLoading());

    final request = GetWorkCategoryRequest(
      getWorkCategory: 'getWorkCategory',
      companyId: event.companyId,
      languageId: event.languageId,
    );

    final result = await useCase.getWorkCategoryList(request);

    result.fold((failure) => emit(AssignWorkError(failure.message)), (
      response,
    ) {
      final categories = response.workCategory ?? [];
      emit(
        AssignWorkListLoaded(categories, selectedCategory: _selectedCategory),
      );
    });
  }

  //select category
  void _onSelectDynamicCategory(
    SelectDynamicWorkCategoryEvent event,
    Emitter<AssignWorkState> emit,
  ) {
    _selectedCategory = event.selectedCategory;

    // Re-emit the previous category list with updated selection
    final currentState = state;
    if (currentState is AssignWorkListLoaded) {
      emit(
        AssignWorkListLoaded(
          currentState.categories,
          selectedCategory: _selectedCategory,
        ),
      );
    } else {
      emit(WorkCategorySelected(event.selectedCategory));
    }
  }

  //add work allocation
  Future<void> _onAddWorkAllocation(
    AddWorkAllocationEvent event,
    Emitter<AssignWorkState> emit,
  ) async {
    // emit(AssignWorkLoading());

    final result = await useCase.addWorkAllocation(event.request);

    result.fold(
      (failure) => emit(AssignWorkError(failure.message)),
      (response) => emit(
        AddAssignWorkSuccess(response.message ?? 'Work Assigned Successfully'),
      ),
    );
  }

  //approve task
  Future<void> _onApproveTask(
    ApproveTaskEvent event,
    Emitter<AssignWorkState> emit,
  ) async {
    emit(AssignWorkLoading());

    final result = await useCase.approveTask(event.request);

    result.fold(
      (failure) => emit(AssignWorkError(failure.message)),
      (response) => emit(
        ApproveTaskSuccess(response.message ?? 'Task Approved Successfully'),
      ),
    );
  }

  //deny task
  Future<void> _onDenyTask(
    DenyTaskEvent event,
    Emitter<AssignWorkState> emit,
  ) async {
    emit(AssignWorkLoading());

    final result = await useCase.approveTask(event.request);

    result.fold(
      (failure) => emit(AssignWorkError(failure.message)),
      (response) =>
          emit(TaskApprovalSuccess(response.message ?? 'Task denied')),
    );
  }

  //complete task
  Future<void> _onCompleteTask(
    CompleteTaskEvent event,
    Emitter<AssignWorkState> emit,
  ) async {
    emit(AssignWorkLoading());

    final result = await useCase.completeTask(event.request);

    result.fold(
      (failure) => emit(AssignWorkError(failure.message)),
      (response) =>
          emit(TaskCompletionSuccess(response.message ?? 'Task Completed')),
    );
  }

  //approve by hod
  Future<void> _onApproveByHod(
    ApproveByHodEvent event,
    Emitter<AssignWorkState> emit,
  ) async {
    emit(AssignWorkLoading());

    final result = await useCase.approveByHod(event.request);

    result.fold(
      (failure) => emit(AssignWorkError(failure.message)),
      (response) => emit(
        ApproveByHodSuccess(response.message ?? 'Approved successfully'),
      ),
    );
  }

  void _onSelectEmployee(
    SelectEmployeeEvent event,
    Emitter<AssignWorkState> emit,
  ) {
    _selectedEmployee = event.selectedEmployee;
    emit(EmployeeSelectedState(_selectedEmployee!));
  }
}
