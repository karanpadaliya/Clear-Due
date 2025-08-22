import 'package:equatable/equatable.dart';
import 'package:myco_flutter/features/work_from_home/data/models/add_wfh/add_wfh_request_model.dart';

abstract class AddWfhEvent extends Equatable {
  const AddWfhEvent();
  // Default implementation, can be overridden
  @override
  List<Object?> get props => [];
}

class InitializeWfhTab extends AddWfhEvent {
  final int index;
  InitializeWfhTab({required this.index});
}

class FetchWFHList extends AddWfhEvent {
  final String month;
  final String year;
  const FetchWFHList({this.month = 'All', this.year = '2025'});
}

class DoAddWfhRequest extends AddWfhEvent {
  final String month;
  final String year;
  DoAddWfhRequest(this.month, this.year);
}

class RefreshWFHList extends AddWfhEvent {}

class FilterWFHByMonthYear extends AddWfhEvent {
  final String month;
  final String year;
  FilterWFHByMonthYear(this.month, this.year);
}

class DeleteWFHRequest extends AddWfhEvent {
  final String wfhId;
  const DeleteWFHRequest(this.wfhId);
}

class AddWfhRequest extends AddWfhEvent {
  final AddWfhRequestModel model;
  const AddWfhRequest(this.model);
}

class SelectStatusFilter extends AddWfhEvent {
  final String status; // "0", "1", "2/3"
  SelectStatusFilter(this.status);
}

class OnSearchWfh extends AddWfhEvent {
  final String status; // "0", "1", "2/3"
  OnSearchWfh(this.status);
}
