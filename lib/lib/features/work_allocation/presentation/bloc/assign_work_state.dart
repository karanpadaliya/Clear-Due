  import 'package:equatable/equatable.dart';
  import 'package:myco_flutter/features/work_allocation/domain/entities/get_work_category_entity.dart';
  import 'package:myco_flutter/features/work_allocation/presentation/widgets/employee_details.dart';

  abstract class AssignWorkState extends Equatable {
    const AssignWorkState();

    @override
    List<Object?> get props => [];
  }

  class AssignWorkInitial extends AssignWorkState {}

  // Loading state (for fetching categories or submitting form)
  class AssignWorkLoading extends AssignWorkState {}

  // Category list loaded
  class AssignWorkListLoaded extends AssignWorkState {
    final List<WorkCategoryListEntity> categories;
    final String? selectedCategory;

    const AssignWorkListLoaded(this.categories, {this.selectedCategory});

    @override
    List<Object?> get props => [categories, selectedCategory];
  }

  // Work allocation form submitted successfully
  class AssignWorkSuccess extends AssignWorkState {
    final String message;

    const AssignWorkSuccess(this.message);

    @override
    List<Object?> get props => [message];
  }

  // Error state
  class AssignWorkError extends AssignWorkState {
    final String error;

    const AssignWorkError(this.error);

    @override
    List<Object?> get props => [error];
  }

  // Category selected
  class WorkCategorySelected extends AssignWorkState {
    final String selectedCategory;

    const WorkCategorySelected(this.selectedCategory);

    @override
    List<Object?> get props => [selectedCategory];
  }

  // add assign work
  class AddAssignWorkSuccess extends AssignWorkState {
    final String message;

    const AddAssignWorkSuccess(this.message);

    @override
    List<Object> get props => [message];
  }

  // Approve task success
  class ApproveTaskSuccess extends AssignWorkState {
    final String message;

    const ApproveTaskSuccess(this.message);

    @override
    List<Object> get props => [message];
  }

  // Task approval success - deny
  class TaskApprovalSuccess extends AssignWorkState {
    final String message;

    const TaskApprovalSuccess(this.message);

    @override
    List<Object?> get props => [message];
  }

  // **NEWLY ADDED STATE**
  class TaskDenySuccess extends AssignWorkState {
    final String message;

    const TaskDenySuccess(this.message);

    @override
    List<Object?> get props => [message];
  }

  // assign_work_state.dart
  class TaskCompletionSuccess extends AssignWorkState {
    final String message;

    const TaskCompletionSuccess(this.message);

    @override
    List<Object> get props => [message];
  }

  // Approve by HOD success
  class ApproveByHodSuccess extends AssignWorkState {
    final String message;

    const ApproveByHodSuccess(this.message);

    @override
    List<Object?> get props => [message];
  }

  class EmployeeSelectedState extends AssignWorkState {
    final Employee employee;

    const EmployeeSelectedState(this.employee);

    @override
    List<Object?> get props => [employee];
  }
