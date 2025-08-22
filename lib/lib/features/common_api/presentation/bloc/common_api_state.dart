part of 'common_api_bloc.dart';

abstract class CommonApiState extends Equatable {
  const CommonApiState();

  @override
  List<Object> get props => [];
}

class CommonInitial extends CommonApiState {}

class CommonApiLoading extends CommonApiState {}

// block api success
class UploadImagePdfApiSuccess extends CommonApiState {
  final UploadFileResponseEntity imgPdfList;

  const UploadImagePdfApiSuccess(this.imgPdfList);

  @override
  List<Object> get props => [imgPdfList];
}

// block api success
class BlockApiSuccess extends CommonApiState {
  final BranchResponseEntity blockList;

  const BlockApiSuccess(this.blockList);

  @override
  List<Object> get props => [blockList];
}

// floor unit api error
class FloorUnitApiSuccess extends CommonApiState {
  final DepartmentAndDesignationResponseEntity response;

  const FloorUnitApiSuccess(this.response);

  @override
  List<Object> get props => [response];
}

// Shift api error
class ShiftApiSuccess extends CommonApiState {
  final ShiftResponseEntity shiftList;

  const ShiftApiSuccess(this.shiftList);

  @override
  List<Object> get props => [shiftList];
}

// Employee api success
class EmployeeApiSuccess extends CommonApiState {
  final GetAllEmployeeResponseEntity response;

  const EmployeeApiSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class CommonApiError extends CommonApiState {
  final String message;

  const CommonApiError(this.message);

  @override
  List<Object> get props => [message];
}

class EmployeeSelectedState extends CommonApiState {
  final String selectedEmployee;

  const EmployeeSelectedState(this.selectedEmployee);

  @override
  List<Object> get props => [selectedEmployee];
}
