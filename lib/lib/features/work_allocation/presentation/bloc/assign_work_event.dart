import 'package:equatable/equatable.dart';
import 'package:myco_flutter/features/work_allocation/data/models/request/add_work_allocation_requset.dart';
import 'package:myco_flutter/features/work_allocation/data/models/request/hod_approval_request.dart';
import 'package:myco_flutter/features/work_allocation/data/models/request/task_approval_request.dart';
import 'package:myco_flutter/features/work_allocation/data/models/request/task_completion_request.dart';
import 'package:myco_flutter/features/work_allocation/presentation/widgets/employee_details.dart';

abstract class AssignWorkEvent extends Equatable {
  const AssignWorkEvent();

  @override
  List<Object?> get props => [];
}

//fetch category list
class FetchWorkCategoryList extends AssignWorkEvent {
  final String companyId;
  final String getWorkCategory;
  final String languageId;

  const FetchWorkCategoryList({
    required this.companyId,
    required this.getWorkCategory,
    required this.languageId,
  });

  @override
  List<Object?> get props => [companyId, getWorkCategory, languageId];
}

//select category
class SelectDynamicWorkCategoryEvent extends AssignWorkEvent {
  final String selectedCategory;

  const SelectDynamicWorkCategoryEvent(this.selectedCategory);

  @override
  List<Object?> get props => [selectedCategory];
}

//add work allocation
class AddWorkAllocationEvent extends AssignWorkEvent {
  final AddWorkAllocationRequest request;

  const AddWorkAllocationEvent(this.request);

  @override
  List<Object?> get props => [request];
}

//approve task
class ApproveTaskEvent extends AssignWorkEvent {
  final TaskApprovalRequest request;

  const ApproveTaskEvent(this.request);

  @override
  List<Object?> get props => [request];
}

//task deny
class DenyTaskEvent extends AssignWorkEvent {
  final TaskApprovalRequest request;

  const DenyTaskEvent(this.request);

  @override
  List<Object?> get props => [request];
}

// assign_work_event.dart
class CompleteTaskEvent extends AssignWorkEvent {
  final TaskCompletionRequest request;

  const CompleteTaskEvent({required this.request});

  @override
  List<Object?> get props => [request];
}

//approve by hod
class ApproveByHodEvent extends AssignWorkEvent {
  final HodApprovalRequest request;

  const ApproveByHodEvent({required this.request});

  @override
  List<Object?> get props => [request];
}

class SelectEmployeeEvent extends AssignWorkEvent {
  final Employee selectedEmployee;

  const SelectEmployeeEvent(this.selectedEmployee);

  @override
  List<Object?> get props => [selectedEmployee];
}
