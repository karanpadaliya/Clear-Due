import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/features/work_from_home/data/models/admin_req_wfh/req_wfh_request_model.dart';
// import 'package:myco_flutter/features/work_from_home/domain/entities/admin_req_wfh/req_wfh_entity.dart';
import 'package:myco_flutter/features/work_from_home/domain/repositories/admin_req_wfh/req_wfh_repository.dart';
import 'package:myco_flutter/features/work_from_home/presentation/bloc/admin_req_wfh/req_wfh_event.dart';
import 'package:myco_flutter/features/work_from_home/presentation/bloc/admin_req_wfh/req_wfh_state.dart';

class RequestWfhBloc extends Bloc<RequestWfhEvent, RequestWfhState> {
  final RequestWfhRepository requestWfhUseCase;
  final preferenceManager = GetIt.I<PreferenceManager>();

  // List<AdminWfhEntity> _wfhList = [];
  String selectedMonth = 'All';
  String selectedYear = DateTime.now().year.toString();
  String selectedStatus = '';
  int selectedTabIndex = 0;
  RequestWfhBloc({required this.requestWfhUseCase})
    : super(const WFHInitial()) {
    on<InitializeWfhTab>(_onInitialize);
    on<FetchWFHList>(_onFetchWFHList);
    on<RefreshWFHList>(_onRefresh);
    on<ApproveRequest>(_onApproveRequest);
    on<RejectRequest>(_onRejectRequest);

    add(FetchWFHList(year: selectedYear));
  }
  void _onInitialize(InitializeWfhTab event, Emitter<RequestWfhState> emit) {
    emit(const WFHInitial());
    add(FetchWFHList(year: selectedYear));
  }

  Future<void> _onFetchWFHList(
    FetchWFHList event,
    Emitter<RequestWfhState> emit,
  ) async {
    emit(const WFHLoading());

    final String? userId = await preferenceManager.getUserId();
    final String? societyId = await preferenceManager.getCompanyId();
    final String? languageId = await preferenceManager.getLanguageId();
    final request = GetAdminWfhRequestModel(
      getAllWFH: 'getMyWFH',
      societyId: societyId,
      userId: userId,
      languageId: languageId,
      allData: '1',
      endDate: '',
      startDate: '',
      searchUserId: '1',
      sort: '',
      userIds: '',
      wfhStatus: '',
    );
    final freshResult = await requestWfhUseCase.getAllReqWfh(request);

    freshResult.fold((failure) => emit(WFHError(failure.message)), (response) {
      emit(WFHLoaded(fullList: response.wfhList ?? []));
    });
  }

  Future<void> _onApproveRequest(
    ApproveRequest event,
    Emitter<RequestWfhState> emit,
  ) async {
    emit(const WFHLoading());

    final String? userId = await preferenceManager.getUserId();
    final String? societyId = await preferenceManager.getCompanyId();
    final String? languageId = await preferenceManager.getLanguageId();
    final request = AdminWfhApproveRequestModel(
      approveWFHNew: 'approveWFHNew',
      languageId: languageId,
      userId: userId,
      societyId: societyId,
      wfhUserId: event.wfhItemEntity.userId,
      wfhAttendanceRange: event.wfhItemEntity.wfhAttendanceRange,
      wfhId: event.wfhItemEntity.wfhId,
      userName: event.wfhItemEntity.userFullName,
      wfhStartDate: event.wfhItemEntity.wfhStartDate,
      wfhGroupId: event.wfhItemEntity.wfhGroupId,
      fullDayToHalfDay: event.wfhItemEntity.wfhDayType,
      selfieAttendance: event.wfhItemEntity.wfhAttachment,
    );
    final freshResult = await requestWfhUseCase.approveAdminWfhRequest(request);

    freshResult.fold((failure) => emit(WFHError(failure.message)), (response) {
      emit(WFHLoaded(fullList: response.wfhList ?? []));
    });
  }

  Future<void> _onRejectRequest(
    RejectRequest event,
    Emitter<RequestWfhState> emit,
  ) async {
    emit(const WFHLoading());

    final String? userId = await preferenceManager.getUserId();
    final String? floorId = await preferenceManager.getBranchId();
    final String? societyId = await preferenceManager.getCompanyId();
    final String? languageId = await preferenceManager.getLanguageId();
    final request = AdminWfhRejectRequestModel(
      rejectWFHNew: 'rejectWFHNew',
      languageId: languageId,
      userId: userId,
      societyId: societyId,
      floorId: floorId,
      wfhUserId: event.wfhItemEntity.userId,
      wfhId: event.wfhItemEntity.wfhId,
      userName: event.wfhItemEntity.userFullName,
      wfhStartDate: event.wfhItemEntity.wfhStartDate,
      wfhDeclinedReason: event.reason,
    );
    final freshResult = await requestWfhUseCase.rejectAdminWfhRequest(request);

    freshResult.fold((failure) => emit(WFHError(failure.message)), (response) {
      emit(WFHLoaded(fullList: response.wfhList ?? []));
    });
  }

  void _onRefresh(RefreshWFHList event, Emitter<RequestWfhState> emit) {
    add(FetchWFHList());
  }
}
