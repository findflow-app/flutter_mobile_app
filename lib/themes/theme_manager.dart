import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier {
  static ThemeManager instance = ThemeManager();

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
  colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(52, 128, 185, 1.0), brightness: Brightness.dark),
  
);

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(52, 128, 185, 1.0), brightness: Brightness.light),
);