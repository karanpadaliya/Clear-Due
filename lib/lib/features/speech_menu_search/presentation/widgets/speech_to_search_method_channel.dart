import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/features/speech_menu_search/presentation/bloc/speech_bloc.dart';

class SpeechChannelService {
  static const MethodChannel _speechChannel = MethodChannel('com.myco.speech');
  final BlocBase<SpeechState> speechBloc;

  SpeechChannelService(this.speechBloc) {
    _speechChannel.setMethodCallHandler(_handleNativeMethodCalls);
  }

  Future<void> _handleNativeMethodCalls(MethodCall call) async {
    // Safely cast to SpeechBloc before dispatching events
    final mySpeechBloc = speechBloc as SpeechBloc;

    switch (call.method) {
      case 'onResult':
        final String recognizedText = call.arguments as String;
        log('Final result from native: $recognizedText');
        mySpeechBloc.add(ProcessSpokenText(recognizedText));
        break;
      case 'onPartialResult':
        final String recognizedText = call.arguments as String;
        log('Partial result from native: $recognizedText');
        // `emit` is safe to call directly from a bloc instance within its o  wn flow
        // mySpeechBloc.emit(SpeechListening(spokenText: recognizedText));
        mySpeechBloc.add(ProcessSpokenText(recognizedText));

        break;
      case 'onStatus':
        final String status = call.arguments as String;
        log('Status from native: $status');
        if (status == 'notListening' && speechBloc.state is! SpeechMatched) {
          mySpeechBloc.add(
            const SpeechErrorOccurred(
              'No speech was detected. Please try again.',
            ),
          );
        }
        break;
      case 'onError':
        final String errorMessage = call.arguments as String;
        log('Error from native: $errorMessage');
        mySpeechBloc.add(SpeechErrorOccurred(errorMessage));
        break;
      default:
        log('Unknown native method call: ${call.method}');
    }
  }

  Future<void> startListening() async {
    try {
      await _speechChannel.invokeMethod('startListening');
    } on PlatformException catch (e) {
      log('Failed to start listening: ${e.message}');
      (speechBloc as SpeechBloc).add(
        SpeechErrorOccurred(e.message ?? 'Unknown error'),
      );
    }
  }

  Future<void> stopListening() async {
    try {
      await _speechChannel.invokeMethod('stopListening');
    } on PlatformException catch (e) {
      log('Failed to stop listening: ${e.message}');
    }
  }
}
