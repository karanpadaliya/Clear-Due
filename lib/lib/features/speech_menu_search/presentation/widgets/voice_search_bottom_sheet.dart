import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/home_menu_response_entity.dart';
import 'package:myco_flutter/features/speech_menu_search/presentation/bloc/speech_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class VoiceSearchBottomSheet extends StatefulWidget {
  final Function(List<AppMenuEntity>) onResult;

  const VoiceSearchBottomSheet({required this.onResult, super.key});

  @override
  State<VoiceSearchBottomSheet> createState() => _VoiceSearchBottomSheetState();
}

class _VoiceSearchBottomSheetState extends State<VoiceSearchBottomSheet>
    with TickerProviderStateMixin {
  late AnimationController _micPulseController;

  @override
  void initState() {
    super.initState();
    _micPulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0.8,
      upperBound: 1.1,
    )..repeat(reverse: true);

    // Request permission here before dispatching the event to native.
    _requestPermissionAndStartListening();
  }

  Future<void> _requestPermissionAndStartListening() async {
    final status = await Permission.microphone.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      final result = await Permission.microphone.request();
      if (!result.isGranted) {
        context.read<SpeechBloc>().add(const SpeechErrorOccurred('Microphone permission denied.'));
        return;
      }
    }
    context.read<SpeechBloc>().add(StartListening());
  }

  @override
  void dispose() {
    _micPulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<SpeechBloc, SpeechState>(
    listener: (context, state) {
      if (state is SpeechMatched) {
        log('Speech matched with items: ${state.matchedItems.length}');
        context.pop();
        widget.onResult(state.matchedItems);
      } else if (state is SpeechError) {
        // The BLoC handles stopping the speech service, so the UI just reacts.
      }
    },
    builder: (context, state) {
      String statusText;
      if (state is SpeechProcessing) {
        statusText = 'Processing...';
      } else if (state is SpeechError) {
        statusText = 'Error occurred';
      } else {
        statusText = 'Listening...';
      }

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        height: 0.3 * Responsive.getHeight(context),
        child: Column(
          children: [
            Text(statusText, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            if (state is SpeechProcessing)
              const Center(child: CircularProgressIndicator())
            else if (state is SpeechError)
              _buildErrorUI(context, state)
            else
              _buildListeningUI(context, state),
            const Spacer(),
            TextButton(
              onPressed: () {
                context.read<SpeechBloc>().add(StopListening());
                context.pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppTheme.getColor(context).primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );

  Widget _buildErrorUI(BuildContext context, SpeechError state) => Column(
    children: [
      const Icon(Icons.error, color: Colors.red, size: 40),
      const SizedBox(height: 10),
      Text(state.message, textAlign: TextAlign.center),
      const SizedBox(height: 16),
      ElevatedButton.icon(
        onPressed: () {
          context.read<SpeechBloc>().add(StartListening());
        },
        icon: const Icon(Icons.refresh),
        label: const Text('Retry'),
      ),
    ],
  );

  Widget _buildListeningUI(BuildContext context, SpeechState state) {
    String recognizedText = '';
    if (state is SpeechListening) {
      recognizedText = state.spokenText;
    }

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            ScaleTransition(
              scale: _micPulseController,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.4),
                      Theme.of(context).primaryColor.withOpacity(0.1),
                    ],
                    radius: 0.85,
                  ),
                ),
              ),
            ),
            Icon(Icons.mic, size: 60, color: AppTheme.getColor(context).onPrimary),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          recognizedText.isEmpty ? 'Say something...' : recognizedText,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
