import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/features/my_visit/data/models/request/add_new_visit_Request_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/request/branch_department_request_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/request/get_branch_response_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/request/get_department_response_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/request/get_employee_request_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/request/get_members_by_department_request_model.dart';
import 'package:myco_flutter/features/my_visit/data/models/request/visit_request_model.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/branch_department_entity.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/visit_entity.dart';
import 'package:myco_flutter/features/my_visit/domain/usecases/myvisit_usecase.dart';
import 'package:myco_flutter/features/my_visit/presentation/bloc/bloc_api/visit_api_event.dart';
import 'package:myco_flutter/features/my_visit/presentation/bloc/bloc_api/visit_api_state.dart';

class VisitApiBloc extends Bloc<VisitApiEvent, VisitApiState> {
  final GetVisitData useCases;

  VisitApiBloc(this.useCases) : super(VisitInitialState()) {
    on<GetVisitDataEvent>(_onGetVisitDataEvent);
    on<AddNewVisitEvent>(_addNewVisit);
    on<GetBranchDepartmentData>(_onGetBranchDepartmentData);
    on<FetchDepartmentData>(_onGetDepartmentData);
    on<FetchBranchData>(_onGetBranchData);
    on<FetchEmployeeData>(_onGetEmployeeData);
    on<AddSelectedBranchTag>(_onAddSelectedBranchTag);
    on<RemoveSelectedBranchTag>(_onRemoveSelectedBranchTag);
    on<AddSelectedDepartmentTag>(_onAddSelectedDepartmentTag);
    on<RemoveSelectedDepartmentTag>(_onRemoveSelectedDepartmentTag);
    on<GetEmployeeDetailEvent>(_getEmployeeDetail);
  }

  Future<void> _onGetVisitDataEvent(
    GetVisitDataEvent event,
    Emitter<VisitApiState> emit,
  ) async {
    emit(VisitLoadingState());

    final request = VisitRequestModel(
      companyId: '1',
      FilterDate: event.filterDate,
      getMyVisitsNew: 'getMyVisitsNew',
      Userid: '1259',
      UserLatitude: '22.9892059',
      UserLongitude: '72.4971264',
    );

    final result = await useCases.getVisitData(request);
    result.fold((failure) => emit(VisitApiError(failure.message)), (data) {
      if (state is VisitApiLoaded) {
        final currentState = state as VisitApiLoaded;
        emit(
          currentState.copyWith(
            visitModelEntity: data,
            loadedFilterDate: event.filterDate,
          ),
        );
      } else {
        emit(
          VisitApiLoaded(
            visitModelEntity: data,
            loadedFilterDate: event.filterDate,
            branches: [],
            departments: [],
          ),
        );
      }
    });
  }

  Future<void> _addNewVisit(
    AddNewVisitEvent event,
    Emitter<VisitApiState> emit,
  ) async {
    emit(VisitLoadingState());

    final request = AddNewVisitRequestModel(
      addMyVisit: 'addMyVisit',
      companyId: '1',
      userId: '1259',
      retailerId: '279',
      DepartmentId: '',
      currentLang: '72.4971264',
      branchId: '',
      currentLat: '22.9892059',
      isOtherVisit: '0',
      isVisitRescheduled: '0',
      languageId: '1',
      managerName: '',
      otherUserId: '',
      otherUserName: '',
      physicalOrVirtualVisit: '0',
      rescheduledVisitDate: '',
      rescheduledVisitId: '',
      rescheduleReason: '',
      retailerName: 'Ravi Metal Metoda (RT279)',
      retailerVisitById: '1259',
      retailerVisitStartDatetime: '2025-07-31 07:25 PM',
      shiftTimeZone: 'Asia/Kolkata',
      slotId: '',
      thirdPartyJson: '',
      userName: 'Dev Harsh',
      visitDate: '31-07-2025',
      visitRemark: 'purpose',
      visitTime: '07:25 PM',
      visitTypeReason: '',
    );

    final result = await useCases.addMyVisit(request);
    result.fold(
      (failure) => emit(VisitFailureState(failure.message)),
      (response) => emit(VisitSuccessState(response.message ?? 'Success')),
    );
  }

  Future<void> _onGetDepartmentData(
    FetchDepartmentData event,
    Emitter<VisitApiState> emit,
  ) async {
    emit(VisitLoadingState());
    final request = GetDepartmentRequestModel(
      companyId: '1',
      Userid: '1259',
      LanguageId: '1',
      blockId: '1',
      getDepartmentsDiscussion: 'getDepartmentsDiscussion',
      MyFloorId: '1',
      SelectedBlockId: event.SelectedBranchId.join(','),
    );

    final result = await useCases.getDepartmentData(request);
    result.fold((failure) => emit(VisitApiError(failure.message)), (data) {
      final departmentList = data.departments
          .map((d) => {'name': d.departmentName, 'id': d.floorId})
          .toList();

      if (state is VisitApiLoaded) {
        final currentState = state as VisitApiLoaded;
        emit(currentState.copyWith(VisitWithDepartments: departmentList));
      } else {
        emit(
          VisitApiLoaded(
            visitModelEntity: MyVisitModelEntity(),
            loadedFilterDate: '',
            VisitWithDepartments: departmentList,
            branches: [],
            departments: [],
          ),
        );
      }
    });
  }

  Future<void> _onGetBranchData(
    FetchBranchData event,
    Emitter<VisitApiState> emit,
  ) async {
    final request = const GetBranchRequestModel(
      getBranchList: 'getBranchList',
      companyId: '1',
      Userid: '1259',
      LanguageId: '1',
      blockId: '2',
    );

    final result = await useCases.getBranchData(request);
    result.fold((failure) => emit(VisitApiError(failure.message)), (data) {
      final branchList = data.branchList
          .map((d) => {'name': d.blockName, 'id': d.blockId})
          .toList();

      if (state is VisitApiLoaded) {
        final currentState = state as VisitApiLoaded;
        emit(currentState.copyWith(VisitWithBranches: branchList));
      } else {
        emit(
          VisitApiLoaded(
            visitModelEntity: MyVisitModelEntity(),
            loadedFilterDate: '',
            VisitWithBranches: branchList,
            branches: [],
            departments: [],
          ),
        );
      }
    });
  }

  Future<void> _onGetEmployeeData(
    FetchEmployeeData event,
    Emitter<VisitApiState> emit,
  ) async {
    final request = GetMembersByDepartmentRequestModel(
      getMembersByDepartment: 'getMembersByDepartmentMeeting',
      blockId: '',
      floorId: event.SelectedDepartmentId.join(','),
      languageId: '1',
      societyId: '1',
      userId: '1259',
    );

    final result = await useCases.getMembers(request);
    result.fold((failure) => emit(VisitApiError(failure.message)), (data) {
      final EmployeeList = data.employees!
          .map(
            (d) => {
              'name': d.userFullName ?? '',
              'designation': d.designation ?? '',
              'photo': d.userProfilePic ?? '',
            },
          )
          .toList();

      if (state is VisitApiLoaded) {
        final currentState = state as VisitApiLoaded;
        emit(currentState.copyWith(VisitWithEmployee: EmployeeList));
      } else {
        emit(
          VisitApiLoaded(
            visitModelEntity: MyVisitModelEntity(),
            loadedFilterDate: '',
            VisitWithEmployee: EmployeeList,
            branches: [],
            departments: [],
          ),
        );
      }
    });
  }

  ///assined visit
  void _onAddSelectedBranchTag(
    AddSelectedBranchTag event,
    Emitter<VisitApiState> emit,
  ) {
    if (state is VisitApiLoaded) {
      final currentState = state as VisitApiLoaded;

      final updatedBranchList = [event.branch]; // single select

      emit(currentState.copyWith(selectedBranch: updatedBranchList));
    }
  }

  void _onRemoveSelectedBranchTag(
    RemoveSelectedBranchTag event,
    Emitter<VisitApiState> emit,
  ) {
    if (state is VisitApiLoaded) {
      final currentState = state as VisitApiLoaded;

      final updatedBranchList = currentState.selectedBranch
          .where((b) => b.blockId != event.branch.blockId)
          .toList();

      final clearDepartments = updatedBranchList.isEmpty;

      emit(
        currentState.copyWith(
          selectedBranch: updatedBranchList,
          selectedDepartment: clearDepartments
              ? []
              : currentState.selectedDepartment,
        ),
      );
    }
  }

  void _onAddSelectedDepartmentTag(
    AddSelectedDepartmentTag event,
    Emitter<VisitApiState> emit,
  ) {
    if (state is VisitApiLoaded) {
      final currentState = state as VisitApiLoaded;

      final updatedDeptList = [event.department];
      final blockid = event.department.blockId;
      final floorid = event.department.floorId;

      emit(
        currentState.copyWith(
          selectedDepartment: updatedDeptList,
          SelectedFloorID: floorid,
          SelectedBlockID: blockid,
        ),
      );
    }
  }

  void _onRemoveSelectedDepartmentTag(
    RemoveSelectedDepartmentTag event,
    Emitter<VisitApiState> emit,
  ) {
    if (state is VisitApiLoaded) {
      final currentState = state as VisitApiLoaded;

      final updatedDeptList = currentState.selectedDepartment
          .where((d) => d.departmentName != event.department.departmentName)
          .toList();

      emit(currentState.copyWith(selectedDepartment: updatedDeptList));
    }
  }

  Future<void> _onGetBranchDepartmentData(
    GetBranchDepartmentData event,
    Emitter<VisitApiState> emit,
  ) async {
    final request = const BranchDepartmentRequestModel(
      companyId: '1',
      Userid: '1259',
      checkAccessVisit: 'checkAccessVisit',
      LanguageId: '1',
    );

    emit(VisitLoadingState());

    final result = await useCases.getBranchDepartmentData(request);

    result.fold((failure) => emit(VisitApiError(failure.message)), (data) {
      final branchEntities = data.branchList
          .map(
            (branchModel) => BranchEntity(
              blockId: branchModel.blockId,
              blockName: branchModel.blockName,
              floorIds: branchModel.floorIds,
            ),
          )
          .toList();

      final departmentEntities = data.departments
          .map(
            (deptModel) => DepartmentEntity(
              departmentName: deptModel.departmentName,
              floorId: deptModel.floorId,
              blockId: deptModel.blockId,
              branchName: deptModel.branchName,
            ),
          )
          .toList();

      emit(
        VisitApiLoaded(
          visitModelEntity: MyVisitModelEntity(),
          loadedFilterDate: '',
          branches: branchEntities,
          departments: departmentEntities,
          selectedBranch: [],
          selectedDepartment: [],
        ),
      );
    });
  }

  Future<void> _getEmployeeDetail(
    GetEmployeeDetailEvent event,
    Emitter<VisitApiState> emit,
  ) async {
    final request = GetEmployeeRequestModel(
      getMembersByDepartment: 'getMembersByDepartment',
      checkAccessVisit: 'checkAccessVisit',
      societyId: '1',
      blockId: event.BlockId,
      floorId: event.floorId,
      userId: '1259',
      languageId: '1',
      selfUserType: '',
    );

    final result = await useCases.getEmployeeDetail(request);

    result.fold(
      (failure) {
        emit(VisitFailureState(failure.message));
      },
      (response) {
        final employeeList = response.employees?.toList() ?? [];

        if (state is VisitApiLoaded) {
          final currentState = state as VisitApiLoaded;
          emit(currentState.copyWith(EmployeeDetails: employeeList));
        } else {
          emit(
            VisitApiLoaded(
              visitModelEntity: MyVisitModelEntity(),
              loadedFilterDate: '',
              branches: const [],
              departments: const [],
              EmployeeDetails: employeeList,
            ),
          );
        }
      },
    );
  }

  // /// Helper: Remove item from list
  // List<String> _removeFromList(List<String> list, String item) {
  //   final updated = List<String>.from(list);
  //   updated.remove(item);
  //   return updated;
  // }
}
