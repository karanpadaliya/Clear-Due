part of 'visit_bloc.dart';

abstract class VisitEvent {}

/// Face Detection Events
class LaunchCamera extends VisitEvent {}

class StartDateTime extends VisitEvent {}

class UpdateDateTime extends VisitEvent {
  final String formattedDateAndTime;

  UpdateDateTime({required this.formattedDateAndTime});
}

class UpdateScanningState extends VisitEvent {
  final String scanningState;

  UpdateScanningState({required this.scanningState});
}

class StartScanningTimer extends VisitEvent {}

class UpdateProgress extends VisitEvent {
  final double progress;
  final String remainingTime;

  UpdateProgress({required this.progress, required this.remainingTime});
}

/// Tag Management Events
class InitVisit extends VisitEvent {}

class AddBranchTagFromSheet extends VisitEvent {
  final String branchTag;
  final String id;

  AddBranchTagFromSheet(this.branchTag, this.id);
}

class RemoveBranchTag extends VisitEvent {
  final String branchTag;

  RemoveBranchTag(this.branchTag);
}

class AddDepartmentTagFromSheet extends VisitEvent {
  final String departmentTag;
  final String id;

  AddDepartmentTagFromSheet(this.departmentTag, this.id);
}

class RemoveDepartmentTag extends VisitEvent {
  final String departmentTag;

  RemoveDepartmentTag(this.departmentTag);
}

class ToggleEmployeeSelection extends VisitEvent {
  final int index;

  ToggleEmployeeSelection(this.index);
}

class SearchEmployees extends VisitEvent {
  final String query;

  SearchEmployees(this.query);
}

/// Myvisit Page
class TabChanged extends VisitEvent {
  final int newIndex;

  TabChanged(this.newIndex);
}

class UpdateSelectedDate extends VisitEvent {
  final DateTime newDate;

  UpdateSelectedDate(this.newDate);
}

class NextDate extends VisitEvent {}

class PreviousDate extends VisitEvent {}

class ToggleAutoExpence extends VisitEvent {}

///Add New Visit Page
class UpdateVisitTypeAndTapEvent extends VisitEvent {
  final String selectedVisitType;
  final int index;
  final bool isTapped;
  final String actionType;

  UpdateVisitTypeAndTapEvent({
    required this.selectedVisitType,
    required this.index,
    required this.isTapped,
    required this.actionType,
  });
}

/// Add Customer Form

class UpdateContactPerson extends VisitEvent {
  final String code;
  final String id;

  UpdateContactPerson({required this.code, required this.id});
}

class UpdateAlternativePhone extends VisitEvent {
  final String code;
  final String id;

  UpdateAlternativePhone({required this.code, required this.id});
}

class CitySelectionEvent extends VisitEvent {
  final String cityName;

  CitySelectionEvent(this.cityName);
}

class AreaSelectionEvent extends VisitEvent {
  final String areaName;

  AreaSelectionEvent(this.areaName);
}
