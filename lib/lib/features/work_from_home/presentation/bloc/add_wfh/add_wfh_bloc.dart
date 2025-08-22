import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/features/work_from_home/data/models/add_wfh/add_wfh_request_model.dart';
import 'package:myco_flutter/features/work_from_home/domain/repositories/add_wfh/add_wfh_repository.dart';
import 'package:myco_flutter/features/work_from_home/presentation/bloc/add_wfh/add_wfh_event.dart';
import 'package:myco_flutter/features/work_from_home/presentation/bloc/add_wfh/add_wfh_state.dart';

class AddWfhBloc extends Bloc<AddWfhEvent, AddWfhState> {
  final AddWfhRepository addWfhUseCase;
  final preferenceManager = GetIt.I<PreferenceManager>();

  final String _selectedMonth = 'All';
  final String _selectedYear = DateTime.now().year.toString();

  AddWfhBloc({required this.addWfhUseCase}) : super(const WFHInitial()) {
    on<InitializeWfhTab>(_onInitialize);
    on<FetchWFHList>(_onFetchWFHList);
    on<RefreshWFHList>(_onRefresh);
    on<DeleteWFHRequest>(_onDelete);
    on<AddWfhRequest>(_doAddWfhRequest);

    add(FetchWFHList(year: _selectedYear));
  }

  void _onInitialize(InitializeWfhTab event, Emitter<AddWfhState> emit) {
    emit(const WFHInitial());
    add(FetchWFHList(year: _selectedYear));
  }

  Future<void> _onFetchWFHList(
    FetchWFHList event,
    Emitter<AddWfhState> emit,
  ) async {
    emit(const WFHLoading());

    final String? unitId = await preferenceManager.getUnitId();
    final String? userId = await preferenceManager.getUserId();
    final String? societyId = await preferenceManager.getCompanyId();
    final String? languageId = await preferenceManager.getLanguageId();
    final request = GetMyWfhRequestModel(
      getMyWFH: 'getMyWFH',
      societyId: societyId,
      unitId: unitId,
      userId: userId,
      languageId: languageId,
      year: _selectedYear,
    );
    final freshResult = await addWfhUseCase.getAddWfh(request);

    freshResult.fold((failure) => emit(WFHError(failure.message)), (response) {
      final wfhAddressList = response.wfhAddressList ?? [];
      final wfhList = response.wfhList ?? [];

      emit(
        WFHLoaded(
          fullList: wfhList,
          filteredList: wfhList,
          wfhAddressList: wfhAddressList,
          selectedMonth: _selectedMonth,
          selectedYear: _selectedYear,
          selectedStatus: 'All',
        ),
      );
    });
  }

  Future<void> _doAddWfhRequest(
    AddWfhRequest event,
    Emitter<AddWfhState> emit,
  ) async {
    emit(const WFHLoading());

    event.model.addWFHRequest = 'addWFHRequest';
    event.model.societyId = await preferenceManager.getCompanyId();
    event.model.unitId = await preferenceManager.getUnitId();
    event.model.userId = await preferenceManager.getUserId();
    event.model.languageId = await preferenceManager.getLanguageId();

    final freshResult = await addWfhUseCase.addWfhRequest(event.model);

    freshResult.fold((failure) => emit(WFHError(failure.message)), (response) {
      emit(WFHShowToast(response.message ?? ''));
      // add(const FetchWFHList());
      //Move to History tab, and api call
    });
  }

  Future<void> _onDelete(
    DeleteWFHRequest event,
    Emitter<AddWfhState> emit,
  ) async {
    emit(const WFHLoading());

    final String? unitId = await preferenceManager.getUnitId();
    final String? userId = await preferenceManager.getUserId();
    final String? societyId = await preferenceManager.getCompanyId();
    final String? languageId = await preferenceManager.getLanguageId();
    final request = DeleteWfhRequestModel(
      deleteWFHRequest: 'deleteWFHRequest',
      societyId: societyId,
      unitId: unitId,
      userId: userId,
      languageId: languageId,
      wfhId: event.wfhId,
    );
    final freshResult = await addWfhUseCase.deleteWfhRequest(request);

    freshResult.fold((failure) => emit(WFHError(failure.message)), (response) {
      add(FetchWFHList(year: _selectedYear));
      emit(WFHShowToast(response.message ?? ''));
      // if (response.status == '200') {
      add(const FetchWFHList());
      // }
    });
  }

  void _onRefresh(RefreshWFHList event, Emitter<AddWfhState> emit) {
    add(FetchWFHList(year: _selectedYear));
  }
}
