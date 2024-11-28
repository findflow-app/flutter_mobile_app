import 'package:findflow_mobile/login_page/login_page.dart';
import 'package:findflow_mobile/login_page/sign_up_page.dart';
import 'package:findflow_mobile/themes/theme_manager.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {

    ThemeManager.instance.toggleTheme(true);

    return MaterialApp(
      theme: lightMode,
      darkTheme: darkMode,
      home: const SignupScreen(),
    
    );
  }
}
