// speech_bloc.dart

import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/home_menu_response_entity.dart';
import 'package:myco_flutter/features/speech_menu_search/presentation/widgets/speech_to_search_method_channel.dart';

part 'speech_event.dart';
part 'speech_state.dart';

class SpeechBloc extends Bloc<SpeechEvent, SpeechState> {
  List<AppMenuEntity> _allMenuItems = [];
  late final SpeechChannelService _speechService;

  SpeechBloc() : super(SpeechInitial()) {
    _speechService = SpeechChannelService(this); // Pass the bloc instance

    on<SetSpeechMenuData>(_onSetSpeechMenuData);
    on<ProcessSpokenText>(_onProcessSpokenText);
    on<StartListening>(_onStartListening);
    on<StopListening>(_onStopListening);
    on<SpeechErrorOccurred>(_onSpeechErrorOccurred);
  }

  void _onSetSpeechMenuData(SetSpeechMenuData event, Emitter<SpeechState> emit) {
    _allMenuItems = event.menuItems;
  }

  void _onStartListening(StartListening event, Emitter<SpeechState> emit) {
    // The native code will handle the permissions and initialization.
    // The BLoC will simply change to a processing state. 
    emit(SpeechProcessing());
    _speechService.startListening();
  }

  void _onProcessSpokenText(ProcessSpokenText event, Emitter<SpeechState> emit) {
    emit(SpeechProcessing());

    final spokenText = event.spokenText.trim().toLowerCase();

    if (spokenText.isEmpty) {
      emit(const SpeechError('No speech was detected. Please try again.'));
      return;
    }

    log('Processing spoken text: $spokenText');

    final exactMatches = _allMenuItems
        .where((item) => item.menuTitleSearch?.trim().toLowerCase() == spokenText)
        .toList();

    if (exactMatches.isNotEmpty) {
      // Emit the matched state for exact matches and stop.
      emit(SpeechMatched(exactMatches));
      return;
    }

    final partialMatches = _allMenuItems
        .where((item) => item.menuTitleSearch?.trim().toLowerCase().contains(spokenText) ?? false)
        .toList();

    if (partialMatches.isNotEmpty) {
      // Emit the matched state for partial matches.
      emit(SpeechMatched(partialMatches));
    } else {
      // Emit an error state if no matches are found.
      emit(const SpeechError('No matching menu item found.'));
    }
  }

  void _onStopListening(StopListening event, Emitter<SpeechState> emit) {
    _speechService.stopListening();
    emit(SpeechInitial());
  }

  void _onSpeechErrorOccurred(SpeechErrorOccurred event, Emitter<SpeechState> emit) {
    emit(SpeechError(event.errorMessage));
  }

  @override
  Future<void> close() {
    _speechService.stopListening();
    return super.close();
  }
}
  // In speech_bloc.dart

 