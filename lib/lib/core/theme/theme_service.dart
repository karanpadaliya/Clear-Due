import 'package:flutter/material.dart';

class ThemeService extends ValueNotifier<ThemeMode> {
  ThemeService() : super(ThemeMode.system);

  void toggleTheme() {
    if (value == ThemeMode.system) {
      value = ThemeMode.light;
    } else if (value == ThemeMode.light) {
      value = ThemeMode.dark;
    } else {
      value = ThemeMode.system;
    }
  }
}
