import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/features/work_allocation/domain/usecases/work_allocation_use_case.dart';
import 'package:myco_flutter/features/work_allocation/presentation/bloc/work_allocation/work_allocation_event.dart';
import 'package:myco_flutter/features/work_allocation/presentation/bloc/work_allocation/work_allocation_state.dart';

class WorkAllocationBloc
    extends Bloc<WorkAllocationEvent, WorkAllocationState> {
  final WorkAllocationUseCase useCase;

  WorkAllocationBloc(this.useCase) : super(const WorkAllocationLoading()) {
    on<FetchWorkAllocationListEvent>(_onFetchWorkAllocationList);
    on<FetchAssigneeDetailsEvent>(_onFetchAssigneeDetails);
  }

  //for work allocation data get
  Future<void> _onFetchWorkAllocationList(
    FetchWorkAllocationListEvent event,
    Emitter<WorkAllocationState> emit,
  ) async {
    emit(const WorkAllocationLoading());

    try {
      final result = await useCase.getPendingWorkAllocations(event.params);

      result.fold(
        (failure) => emit(WorkAllocationError(failure.message)),
        (response) => emit(WorkAllocationList(workAllocationList: response)),
      );
    } catch (e) {
      emit(const WorkAllocationError('Unexpected error occurred'));
    }
  }

  // fetch assign details
  Future<void> _onFetchAssigneeDetails(
    FetchAssigneeDetailsEvent event,
    Emitter<WorkAllocationState> emit,
  ) async {
    emit(const WorkAllocationLoading());
    final result = await useCase.getAssigneeDetails(event.params);

    result.fold(
      (failure) => emit(WorkAllocationError(failure.message)),
      (response) => emit(AssigneeDetailsLoaded(response)),
    );
  }
}
