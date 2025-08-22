import 'package:equatable/equatable.dart';
import 'package:myco_flutter/features/work_from_home/domain/entities/add_wfh/add_wfh_entity.dart';

abstract class AddWfhState extends Equatable {
  const AddWfhState();
  @override
  List<Object?> get props => [];
}

class WFHInitial extends AddWfhState {
  const WFHInitial();
}

class WFHLoading extends AddWfhState {
  const WFHLoading();
}

class WFHLoaded extends AddWfhState {
  final List<GetWfhListItemEntity> fullList;
  final List<GetWfhListItemEntity> filteredList;
  final List<GetWfhAddressListEntity> wfhAddressList;
  final String selectedMonth;
  final String selectedYear;
  final String selectedStatus;

  const WFHLoaded({
    required this.fullList,
    required this.filteredList,
    required this.wfhAddressList,
    required this.selectedMonth,
    required this.selectedYear,
    required this.selectedStatus,
  });

  WFHLoaded copyWith({
    List<GetWfhListItemEntity>? fullList,
    List<GetWfhListItemEntity>? filteredList,
    List<GetWfhAddressListEntity>? wfhAddressList,
    String? selectedMonth,
    String? selectedYear,
    String? selectedStatus,
    int? selectedIndex,
  }) => WFHLoaded(
    fullList: fullList ?? this.fullList,
    filteredList: filteredList ?? this.filteredList,
    wfhAddressList: wfhAddressList ?? this.wfhAddressList,
    selectedMonth: selectedMonth ?? this.selectedMonth,
    selectedYear: selectedYear ?? this.selectedYear,
    selectedStatus: selectedStatus ?? this.selectedStatus,
  );

  @override
  List<Object?> get props => [
    fullList,
    filteredList,
    wfhAddressList,
    selectedMonth,
    selectedYear,
    selectedStatus,
  ];
}

class WFHShowToast extends AddWfhState {
  final String message;
  const WFHShowToast(this.message);
  @override
  List<Object?> get props => [message];
}

class WFHError extends AddWfhState {
  final String message;
  const WFHError(this.message);
  @override
  List<Object?> get props => [message];
}
