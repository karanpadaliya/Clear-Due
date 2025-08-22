import 'package:equatable/equatable.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/branch_department_entity.dart';

abstract class VisitApiEvent extends Equatable {
  const VisitApiEvent();

  @override
  List<Object?> get props => [];
}

///MyVisit Page
class GetVisitDataEvent extends VisitApiEvent {
  final String filterDate;

  const GetVisitDataEvent({required this.filterDate});

  @override
  List<Object> get props => [filterDate];
}

class AddNewVisitEvent extends VisitApiEvent {
  const AddNewVisitEvent();

  @override
  List<Object?> get props => [];
}

///visitWith page

class FetchBranchData extends VisitApiEvent {
  const FetchBranchData();

  @override
  List<Object> get props => [];
}

class FetchDepartmentData extends VisitApiEvent {
  final List<int> SelectedBranchId;

  const FetchDepartmentData({required this.SelectedBranchId});

  @override
  List<Object> get props => [];
}

class FetchEmployeeData extends VisitApiEvent {
  final List<int> SelectedDepartmentId;

  const FetchEmployeeData({required this.SelectedDepartmentId});

  @override
  List<Object> get props => [];
}

class SearchEmployees extends VisitApiEvent {
  final String query;

  SearchEmployees(this.query);
}

///assigned to

class AddSelectedBranchTag extends VisitApiEvent {
  final BranchEntity branch;

  AddSelectedBranchTag(this.branch);
}

class RemoveSelectedBranchTag extends VisitApiEvent {
  final BranchEntity branch;

  RemoveSelectedBranchTag(this.branch);
}

class AddSelectedDepartmentTag extends VisitApiEvent {
  final DepartmentEntity department;

  AddSelectedDepartmentTag(this.department);
}

class RemoveSelectedDepartmentTag extends VisitApiEvent {
  final DepartmentEntity department;

  RemoveSelectedDepartmentTag(this.department);
}

class GetBranchDepartmentData extends VisitApiEvent {}

// class AssignedToggleEmployeeSelection extends VisitApiEvent {
//   final int index;
//
//   AssignedToggleEmployeeSelection(this.index);
// }

class GetEmployeeDetailEvent extends VisitApiEvent {
  final String floorId;
  final String BlockId;

  const GetEmployeeDetailEvent(this.floorId, this.BlockId);

  @override
  List<Object?> get props => [floorId, BlockId];
}
