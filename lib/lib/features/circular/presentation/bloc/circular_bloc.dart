import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/features/circular/data/models/request/notice_filter_request.dart';
import 'package:myco_flutter/features/circular/data/models/request/notice_single_request.dart';
import 'package:myco_flutter/features/circular/domain/entity/notice_board_response_entity.dart';
import 'package:myco_flutter/features/circular/domain/usecase/circular_usecase.dart';

part 'circular_event.dart';
part 'circular_state.dart';

class CircularBloc extends Bloc<CircularEvent, CircularState> {
  final CircularUseCase registerUseCase;


  final preferenceManager = GetIt.I<PreferenceManager>();

  CircularBloc({required this.registerUseCase}) : super(CircularInitial()) {
    on<NoticeFilterList>(_onFetchNoticeFilterList);
    on<NoticeSingleFetch>(_onFetchNoticeSingleList);
  }


  void _onFetchNoticeFilterList(NoticeFilterList event, Emitter<CircularState> emit) async {
    emit(CircularApiLoading());

    final String? unitId = await preferenceManager.getUnitId();
    final String? userId = await preferenceManager.getUserId();
    final String? departmentId = await preferenceManager.getDepartmentId();
    final String? blockId = await preferenceManager.getBranchId();
    final String? companyId = await preferenceManager.getCompanyId();
    final String? languageId = await preferenceManager.getLanguageId();


    final request = NoticeFilterRequest(
        tag: 'getNoticeFilter',
        unitId: unitId,
        userId: userId,
        floorId: departmentId,
        blockId: blockId,
        companyId: companyId,
        languageId: languageId,
        filterType: '3',
        fromDate: event.startDate,
        toDate: event.endDate
    );

    final freshResult = await registerUseCase.callNoticeFilter(request);

    freshResult.fold(
          (failure) => emit(CircularApiError(failure.message)),
          (response) => emit(NoticeFilterApiSuccess(response)),
    );
  }



  void _onFetchNoticeSingleList(NoticeSingleFetch event, Emitter<CircularState> emit) async {
    emit(CircularSingleApiLoading());

    final String? unitId = await preferenceManager.getUnitId();
    final String? userId = await preferenceManager.getUserId();
    final String? departmentId = await preferenceManager.getDepartmentId();
    final String? blockId = await preferenceManager.getBranchId();
    final String? companyId = await preferenceManager.getCompanyId();
    final String? languageId = await preferenceManager.getLanguageId();


    final request = NoticeSingleRequest(
        tag: 'getNoticeSingle',
        unitId: unitId,
        userId: userId,
        floorId: departmentId,
        blockId: blockId,
        companyId: companyId,
        languageId: languageId,
        noticeBoardId: event.noticeId,
    );

    final freshResult = await registerUseCase.callNoticeSingle(request);

    freshResult.fold(
          (failure) => emit(CircularSingleApiError(failure.message)),
          (response) => emit(NoticeSingleApiSuccess(response)),
    );
  }




}