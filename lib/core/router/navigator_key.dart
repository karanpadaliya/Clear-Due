import 'package:flutter/material.dart';

// Create a single instance of the GlobalKey for the Navigator.
// This key will be used throughout the app to access the navigator's state and overlay.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();