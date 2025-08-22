import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/common_api/data/models/request/branch_list_request.dart';
import 'package:myco_flutter/features/common_api/data/models/request/department_and_designation_list_request.dart';
import 'package:myco_flutter/features/common_api/data/models/request/get_all_employee_request.dart';
import 'package:myco_flutter/features/common_api/data/models/request/shift_list_request.dart';
import 'package:myco_flutter/features/common_api/domain/entities/Branch_response_entity.dart';
import 'package:myco_flutter/features/common_api/domain/entities/department_and_designation_response_entity.dart';
import 'package:myco_flutter/features/common_api/domain/entities/get_all_employee_response_entity.dart';
import 'package:myco_flutter/features/common_api/domain/entities/shift_response_entity.dart';
import 'package:myco_flutter/features/common_api/domain/entities/uploaded_file_response_entity.dart';
import 'package:myco_flutter/features/common_api/domain/usecase/common_api_usercase.dart';

part 'common_api_event.dart';
part 'common_api_state.dart';

class CommonApiBloc extends Bloc<CommonApiEvent, CommonApiState> {
  final CommonApiUserCase commonApiUserCase;

  String? _selectedEmployee;

  String? get selectedEmployee => _selectedEmployee;

  CommonApiBloc({required this.commonApiUserCase}) : super(CommonInitial()) {
    //upload image and Pdf api
    on<UploadAttachments>(_onFetchUploadAttachments);

    on<LoadBranch>(_onFetchBranch);
    on<LoadDepartmentAndDesignation>(_onFetchDepartmentAndDesignation);
    on<LoadShift>(_onFetchShift);
    on<GetAllEmployeeEvent>(_onGetAllEmployee);
  }

  // uploaded image and pdf api
  void _onFetchUploadAttachments(
    UploadAttachments event,
    Emitter<CommonApiState> emit,
  ) async {
    emit(CommonApiLoading());

    final Either<Failure, UploadFileResponseEntity> result =
        await commonApiUserCase.uploadAttachments(
          event.loginType,
          event.filePath,
        );

    result.fold(
      (failure) => emit(CommonApiError(failure.message)),
      (response) => emit(UploadImagePdfApiSuccess(response)),
    );
  }

  void _onFetchBranch(LoadBranch event, Emitter<CommonApiState> emit) async {
    emit(CommonApiLoading());

    final request = BranchListRequest(
      tag: 'getBlocks',
      companyId: event.companyId,
      userId: event.userId,
      languageId: '1',
    );

    final freshResult = await commonApiUserCase.callBranch(request);

    freshResult.fold(
      (failure) => emit(CommonApiError(failure.message)),
      (response) => emit(BlockApiSuccess(response)),
    );
  }

  void _onFetchDepartmentAndDesignation(
    LoadDepartmentAndDesignation event,
    Emitter<CommonApiState> emit,
  ) async {
    emit(CommonApiLoading());

    final request = DepartmentAndDesignationListRequest(
      tag: 'getFloorandUnitNew',
      companyId: event.companyId,
      branchId: event.branchId,
      languageId: '1',
    );

    final freshResult = await commonApiUserCase.getDepartmentAndDesignation(
      request,
    );

    freshResult.fold(
      (failure) => emit(CommonApiError(failure.message)),
      (response) => emit(FloorUnitApiSuccess(response)),
    );
  }

  void _onFetchShift(LoadShift event, Emitter<CommonApiState> emit) async {
    emit(CommonApiLoading());

    final request = ShiftListRequest(
      tag: 'getShiftsRegister',
      companyId: event.companyId,
      floorId: event.floorId,
      languageId: '1',
    );

    final freshResult = await commonApiUserCase.callShift(request);

    freshResult.fold(
      (failure) => emit(CommonApiError(failure.message)),
      (response) => emit(ShiftApiSuccess(response)),
    );
  }

  // get all employee
  Future<void> _onGetAllEmployee(
    GetAllEmployeeEvent event,
    Emitter<CommonApiState> emit,
  ) async {
    emit(CommonApiLoading());
    final result = await commonApiUserCase.getAllEmployee(event.request);
    result.fold(
      (failure) => emit(CommonApiError(failure.message)),
      (response) => emit(EmployeeApiSuccess(response)),
    );
  }
}
