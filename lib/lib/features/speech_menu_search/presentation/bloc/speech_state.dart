part of 'speech_bloc.dart';

abstract class SpeechState extends Equatable {
  const SpeechState();

  @override
  List<Object?> get props => [];
}

class SpeechInitial extends SpeechState {}

class SpeechListening extends SpeechState {
  final String spokenText;

  const SpeechListening({required this.spokenText});

  @override
  List<Object?> get props => [spokenText];
}

class SpeechProcessing extends SpeechState {}

class SpeechMatched extends SpeechState {
  final List<AppMenuEntity> matchedItems;

  const SpeechMatched(this.matchedItems);

  @override
  List<Object?> get props => [matchedItems];
}

class SpeechError extends SpeechState {
  final String message;

  const SpeechError(this.message);

  @override
  List<Object?> get props => [message];
}
