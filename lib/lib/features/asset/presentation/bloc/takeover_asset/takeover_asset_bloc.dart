import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/takeover_asset/takeover_asset_event.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/takeover_asset/takeover_asset_state.dart';

class TakeoverAssetBloc extends Bloc<TakeoverAssetEvent, TakeoverAssetState> {
  TakeoverAssetBloc() : super(TakeoverAssetInitial()) {
    on<HandoverToOtherEmployeeEvent>(_onFetchBool);
  }

  void _onFetchBool(
    HandoverToOtherEmployeeEvent event,
    Emitter<TakeoverAssetState> emit,
  ) async {
    emit(TakeoverAssetApiSuccess(toOtherEmployee: event.toOtherEmployeee));
  }
}
