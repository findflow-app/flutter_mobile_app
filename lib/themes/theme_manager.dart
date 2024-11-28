import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier {
  bool isDark = false;
  ThemeData _currentMode = lightMode;
  get currentMode => _currentMode; 

  void toggleTheme(bool dark) {
    isDark = dark;
    _currentMode = dark? darkMode : lightMode;
    notifyListeners();
  }
}

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.black)
);

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.white)
);