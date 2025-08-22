import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// --- STATE ---
abstract class GlobalErrorState extends Equatable {
  final String? message;
  final bool isErrorActive;

  const GlobalErrorState({this.message, this.isErrorActive = false});

  @override
  List<Object?> get props => [message, isErrorActive];
}

class GlobalErrorInitial extends GlobalErrorState {
  const GlobalErrorInitial() : super(isErrorActive: false, message: null);
}

class GlobalErrorShown extends GlobalErrorState {
  const GlobalErrorShown(String message) : super(isErrorActive: true, message: message);
}


// --- CUBIT ---
class GlobalErrorCubit extends Cubit<GlobalErrorState> {
  GlobalErrorCubit() : super(const GlobalErrorInitial());

  /// Shows an error message if one is not already active.
  void showGlobalError(String message) {
    // This condition prevents a new error from showing if one is already active.
    if (!state.isErrorActive) {
      emit(GlobalErrorShown(message));
    }
  }

  /// Hides the currently active error, allowing a new one to be shown.
  void hideError() {
    if (state.isErrorActive) {
      emit(const GlobalErrorInitial());
    }
  }
}