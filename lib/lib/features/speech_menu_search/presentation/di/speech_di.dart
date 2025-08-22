import 'package:get_it/get_it.dart';
import 'package:myco_flutter/features/speech_menu_search/presentation/bloc/speech_bloc.dart';

void setupSpeechToSearchDI(GetIt sl) {
  sl.registerLazySingleton<SpeechBloc>(SpeechBloc.new);
}
