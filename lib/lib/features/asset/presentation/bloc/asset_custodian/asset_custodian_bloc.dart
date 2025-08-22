import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/features/asset/domain/usecases/asset_use_case.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/asset_custodian/asset_custodian_event.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/asset_custodian/asset_custodian_state.dart';

class CustodianUserBloc extends Bloc<CustodianUserEvent, CustodianUserState> {
  final AddAssetUserUseCases addAssetUserUseCases;

  CustodianUserBloc(this.addAssetUserUseCases) : super(CustodianUserInitial()) {
    //upload image and Pdf api
    on<FetchCustodianUser>(_onFetchCustodian);
  }

  void _onFetchCustodian(
    FetchCustodianUser event,
    Emitter<CustodianUserState> emit,
  ) async {
    emit(CustodianUserLoading());

    final request = {
      'getMembersByDepartment': 'getMembersByDepartment',
      'society_id': '1',
      'block_id': event.blockId,
      'floor_id': event.floorId,
      'user_id': '1679',
      'language_id': '1',
    };

    final freshResult = await addAssetUserUseCases.getAddAssetsUser(request);

    freshResult.fold(
      (failure) => emit(CustodianUserApiError(failure.message)),
      (response) => emit(CustodianUserApiSuccess(response)),
    );
  }
}
