import 'package:flutter/material.dart';
import 'package:myco_flutter/widgets/error_banner.dart';

void showErrorBanner({
  required BuildContext context,
  required String message,
  Duration duration = const Duration(seconds: 4),
}) {
  // Get the OverlayState from the context.
  // Overlay.of(context) returns an OverlayState? so we need to handle null.
  final overlayState = Overlay.of(context);
  
  // If there is no overlay, we cannot proceed.
  if (overlayState == null) return;

  OverlayEntry? overlayEntry;

  // *** THE FIX IS HERE ***
  // Use the OverlayState itself as the TickerProvider for the animation.
  final animationController = AnimationController(
    vsync: overlayState, // Use overlayState instead of Navigator.of(context)
    duration: const Duration(milliseconds: 350),
  );

  final animation = CurvedAnimation(
    parent: animationController,
    curve: Curves.easeInOutCubic,
  );

  void removeBanner() {
    // Check if the entry is still mounted before trying to remove it.
    // This prevents errors if the banner is dismissed multiple times.
    if (overlayEntry != null) {
      animationController.reverse().then((_) {
        overlayEntry?.remove();
        overlayEntry = null;
        animationController.dispose();
      });
    }
  }

  overlayEntry = OverlayEntry(
    builder: (context) {
      return Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1.0),
            end: Offset.zero,
          ).animate(animation),
          child: ErrorBanner(
            message: message,
            onDismiss: removeBanner,
          ),
        ),
      );
    },
  );

  // Insert the entry into the overlay.
  overlayState.insert(overlayEntry!);

  animationController.forward();

  Future.delayed(duration, removeBanner);
}