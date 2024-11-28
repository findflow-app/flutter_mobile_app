import 'package:findflow_mobile/login_page/login_page.dart';
import 'package:findflow_mobile/login_page/sign_up_page.dart';
import 'package:findflow_mobile/main_page/main_page.dart';
import 'package:findflow_mobile/themes/theme_manager.dart';
import 'package:flutter/material.dart';
import "package:permission_handler/permission_handler.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.bluetooth.request();
  await Permission.location.request();
  await Permission.bluetoothScan.request();
  await Permission.locationWhenInUse.request();

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
      home: const MainScreen(),
    );
  }
}
