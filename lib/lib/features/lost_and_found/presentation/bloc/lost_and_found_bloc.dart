import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/features/lost_and_found/domain/use_cases/add_lost_and_found_item_use_case.dart';
import 'package:myco_flutter/features/lost_and_found/domain/use_cases/delete_lost_and_found_item_use_case.dart';
import 'package:myco_flutter/features/lost_and_found/domain/use_cases/edit_lost_and_found_item_use_case.dart';
import 'package:myco_flutter/features/lost_and_found/domain/use_cases/lost_and_found_usecases.dart';
import 'package:myco_flutter/features/lost_and_found/presentation/bloc/lost_and_found_event.dart';
import 'package:myco_flutter/features/lost_and_found/presentation/bloc/lost_and_found_state.dart';
import 'package:myco_flutter/widgets/custom_loader.dart';

class LostAndFoundBloc extends Bloc<LostAndFoundEvent, LostAndFoundState> {
  final GetLostAndFoundItemsUseCase getItemsUseCase;
  final AddLostAndFoundItemUseCase addItemsUseCase;
  final DeleteLostAndFoundItemUseCase deleteItemsUseCase;
  final EditLostAndFoundItemUseCase editItemsUseCase;

  LostAndFoundBloc({
    required this.getItemsUseCase,
    required this.addItemsUseCase,
    required this.deleteItemsUseCase,
    required this.editItemsUseCase,
  }) : super(LostAndFoundInitial()) {
    on<GetLostAndFoundItemsEvent>(_onGetLostAndFoundItems);
    on<AddLostAndFoundItemsEvent>(_onAddLostAndFoundItem);
    on<DeleteLostAndFoundItemsEvent>(_onDeleteLostAndFoundItem);
    on<EditLostAndFoundItemsEvent>(_onEditLostAndFoundItem);
  }

  void _onGetLostAndFoundItems(
    GetLostAndFoundItemsEvent event,
    Emitter<LostAndFoundState> emit,
  ) async {
    emit(LostAndFoundLoading());
    final preferenceManager = GetIt.I<PreferenceManager>();
    final result = await getItemsUseCase(event.request);
    final userId = await preferenceManager.getUserId();
    final menuChat = await preferenceManager.getMenuChat() ?? false;

    result.fold(
      (failure) => emit(LostAndFoundError(failure.message)),
      (items) => emit(LostAndFoundLoaded(items, userId!, menuChat: menuChat)),
    );
  }

  void _onAddLostAndFoundItem(
    AddLostAndFoundItemsEvent event,
    Emitter<LostAndFoundState> emit,
  ) async {
    emit(LostAndFoundLoading());
    final result = await addItemsUseCase(event.request);

    result.fold(
      (failure) => emit(LostAndFoundError(failure.message)),
      (response) => emit(LostAndFoundItemAddedSuccess(response)),
    );
  }

  void _onEditLostAndFoundItem(
    EditLostAndFoundItemsEvent event,
    Emitter<LostAndFoundState> emit,
  ) async {
    const CustomLoader();
    emit(LostAndFoundLoading());
    final result = await editItemsUseCase(event.request);

    result.fold(
      (failure) => emit(LostAndFoundError(failure.message)),
      (response) => emit(LostAndFoundItemEditedSuccess(response)),
    );
  }

  void _onDeleteLostAndFoundItem(
    DeleteLostAndFoundItemsEvent event,
    Emitter<LostAndFoundState> emit,
  ) async {
    emit(LostAndFoundLoading());
    final result = await deleteItemsUseCase(event.request);

    result.fold(
      (failure) => emit(LostAndFoundError(failure.message)),
      (response) => emit(LostAndFoundItemDeletedSuccess(response)),
    );
  }
}
