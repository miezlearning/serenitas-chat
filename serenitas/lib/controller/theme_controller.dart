import 'package:flutter/material.dart';

class ThemeModeData extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkModeActive => _themeMode == ThemeMode.dark;

  // Change the theme and notify listeners
  void changeTheme(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  // Set initial theme based on system's brightness or saved preferences
  void setInitialTheme() {
    final currentSystemTheme = WidgetsBinding.instance.window.platformBrightness;
    _themeMode = currentSystemTheme == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
