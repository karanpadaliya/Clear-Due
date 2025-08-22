part of 'speech_bloc.dart';

abstract class SpeechEvent extends Equatable {
  const SpeechEvent();

  @override
  List<Object?> get props => [];
}

class SetSpeechMenuData extends SpeechEvent {
  final List<AppMenuEntity> menuItems;

  const SetSpeechMenuData(this.menuItems);

  @override
  List<Object?> get props => [menuItems];
}

class ProcessSpokenText extends SpeechEvent {
  final String spokenText;

  const ProcessSpokenText(this.spokenText);

  @override
  List<Object?> get props => [spokenText];
}

class StartListening extends SpeechEvent {}

class StopListening extends SpeechEvent {}

// speech_event.dart
class SpeechStatusChanged extends SpeechEvent {
  final String status;
  const SpeechStatusChanged(this.status);
  @override
  List<Object?> get props => [status];
}

class SpeechErrorOccurred extends SpeechEvent {
  final String errorMessage;
  const SpeechErrorOccurred(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}