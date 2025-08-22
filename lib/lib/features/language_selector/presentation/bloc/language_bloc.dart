import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/features/language_selector/domain/repositories/language_repository.dart';
import 'package:myco_flutter/features/language_selector/presentation/bloc/language_event.dart';
import 'package:myco_flutter/features/language_selector/presentation/bloc/language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final LanguageRepository repository;
  final PreferenceManager preference = GetIt.I<PreferenceManager>();

  LanguageBloc(this.repository) : super(LanguageInitial()) {
    on<FetchLanguages>(_onFetch);
    on<SelectLanguage>(_onSelect);
    on<InitializeLanguage>(_onInitialize);
  }

    void _onInitialize(
    InitializeLanguage event,
    Emitter<LanguageState> emit,
  ) async {
    emit(LanguageLoading());
    try {
      // 1. First, try to load from local storage
      final storedLanguageJson = await preference.readString(VariableBag.appLanguage);

      if (storedLanguageJson != null && storedLanguageJson.isNotEmpty) {
        final Map<String, dynamic> jsonMap = jsonDecode(storedLanguageJson);
        LanguageManager().loadTranslations(jsonMap);
        // Successfully loaded from cache, no need to fetch from network.
        emit(LanguageValueDownloaded());
        return; // Exit here
      }

      // 2. If no local data, fetch from network (defaulting to English '1')
      final success = await repository.getAppLanguageValues(
        "1", // Default language ID
        preference.getCompanyId().toString(),
      );

      success.fold(
        (failure) {
          emit(LanguageError(failure.message ?? "Failed to load default language"));
        },
        (isSuccess) {
          if (isSuccess) {
            // The repository call already saves it to preferences and LanguageManager
            emit(LanguageValueDownloaded());
          } else {
            emit(LanguageError("Failed to download language values"));
          }
        },
      );
    } catch (e) {
      emit(LanguageError("An unexpected error occurred while loading language."));
    }
  }

  void _onFetch(FetchLanguages event, Emitter<LanguageState> emit) async {
    emit(LanguageLoading());
    try {
      final languages = await repository.getAppLanguage();
      languages.fold(
        (failure) {
          emit(LanguageError(failure.message ?? "Failed to load languages"));
        },
        (success) {
          if (success.language?.isNotEmpty == true) {
            emit(LanguageLoaded(success.language ?? []));
          } else {
            emit(LanguageError("Failed to load languages"));
          }
        },
      );
    } catch (e) {
      emit(LanguageError("Failed to load languages"));
    }
  }

  void _onSelect(SelectLanguage event, Emitter<LanguageState> emit) async {
    if (state is LanguageLoaded) {
      final current = (state as LanguageLoaded).languages;
      emit(LanguageLoaded(current, selected: event.selectedLanguage));
      // fetch and store language JSON from languageFile
      final success = await repository.getAppLanguageValues(
        event.selectedLanguage?.languageId ?? "1",
        preference.getCompanyId().toString(),
      );
      success.fold(
        (failure) {
          emit(LanguageError(failure.message ?? "Failed to load languages"));
        },
        (isSuccess) {
          if (isSuccess) {
            emit(LanguageValueDownloaded());
          } else {
            emit(LanguageError("Failed to load language values"));
          }
        },
      );
    }
  }
}
