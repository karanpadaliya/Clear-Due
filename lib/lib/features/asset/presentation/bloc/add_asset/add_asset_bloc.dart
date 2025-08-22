import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/asset/domain/usecases/asset_use_case.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/add_asset/add_asset_event.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/add_asset/add_asset_state.dart';

class AddAssetBloc extends Bloc<AddAssetEvent, AddAssetState> {
  final AddAssetUseCases addAssetUseCases;
  final AddAssetUserUseCases addAssetUserUseCases;

  AddAssetBloc(this.addAssetUseCases, this.addAssetUserUseCases)
    : super(AddAssetInitial()) {
    ///
    // ----- Fetch Add Asset Category and Users ----
    on<FetchAddAssetAndUserEvent>(_onFetchCategoryUser);

    // ----- change validation according category selection ----
    on<SelectAssetCategoryEvent>(_onSelectCategory);

    // ----- set validation index ----
    on<SetFieldErrorIndexEvent>(_setFieldErrorIndexEvent);
  }

  Future<void> _onFetchCategoryUser(
    FetchAddAssetAndUserEvent event,
    Emitter<AddAssetState> emit,
  ) async {
    emit(AddAssetLoading());

    final assetMap = {
      'getAddAssetsData': 'getAddAssetsData',
      'user_id': '1679',
      'society_id': '1',
      'language_id': '1',
      'brand': '0',
    };

    final assetResult = await addAssetUseCases.getAddAssets(assetMap);

    // Step 1: Handle asset failure
    if (assetResult.isLeft()) {
      final failure = assetResult.fold((l) => l, (_) => null);
      emit(AddAssetError(_mapFailureToMessage(failure!)));
      return;
    }

    // Step 3: Extract values using getOrElse (safe because we've already checked isLeft)
    final assetEntity = assetResult.getOrElse(
      () => throw Exception('Unexpected asset error'),
    );

    // Step 4: Emit loaded state
    emit(AddAssetLoaded(assetEntity));
  }

  void _onSelectCategory(
    SelectAssetCategoryEvent event,
    Emitter<AddAssetState> emit,
  ) {
    final currentState = state;
    if (currentState is AddAssetLoaded) {
      emit(
        AddAssetCategorySelected(
          addAssetEntity: currentState.addAssetEntity,
          selectedCategory: event.category,
        ),
      );
    } else if (currentState is AddAssetCategorySelected) {
      emit(
        AddAssetCategorySelected(
          addAssetEntity: currentState.addAssetEntity,
          selectedCategory: event.category,
        ),
      );
    }
  }

  void _setFieldErrorIndexEvent(
    SetFieldErrorIndexEvent event,
    Emitter<AddAssetState> emit,
  ) {
    final currentState = state;

    if (currentState is AddAssetLoaded) {
      emit(
        AddAssetLoaded(
          currentState.addAssetEntity,
          currentFieldErrorKey: event.fieldKey,
        ),
      );
    } else if (currentState is AddAssetCategorySelected) {
      emit(
        AddAssetCategorySelected(
          addAssetEntity: currentState.addAssetEntity,
          selectedCategory: currentState.selectedCategory,
          currentFieldErrorKey: event.fieldKey,
        ),
      );
    } else {
      emit(AddAssetInitial(currentFieldErrorKey: event.fieldKey));
    }
  }

  String _mapFailureToMessage(Failure failure) => failure.message;
}
