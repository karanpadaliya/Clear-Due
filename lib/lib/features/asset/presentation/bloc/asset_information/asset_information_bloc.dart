import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/asset/domain/usecases/asset_use_case.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/asset_information/asset_information_event.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/asset_information/asset_information_state.dart';

class GetAssetInformationBloc
    extends Bloc<GetAssetInformationEvent, GetAssetInformationState> {
  final GetAssetInformationUseCases useCases;

  GetAssetInformationBloc(this.useCases) : super(GetAssetInformationInitial()) {
    on<FetchAssetInformationEvent>(_onFetchAssetInformation);
  }

  Future<void> _onFetchAssetInformation(
    FetchAssetInformationEvent event,
    Emitter<GetAssetInformationState> emit,
  ) async {
    emit(GetAssetInformationLoading());

    final dataMap = {
      'getAssetInformation': 'getAssetInformation',
      'society_id': '1',
      'language_id': '1',
      'user_id': '1679',
      'assets_id': event.assetId,
    };

    final result = await useCases.getAssetInformation(dataMap);
    result.fold(
      (failure) => emit(
        GetAssetInformationError(message: _mapFailureToMessage(failure)),
      ),
      (data) => emit(GetAssetInformationLoaded(assetInformation: data)),
    );
  }

  String _mapFailureToMessage(Failure failure) => failure.message;
}
