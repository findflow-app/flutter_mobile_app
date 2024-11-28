import 'package:findflow_mobile/login_page/login_page.dart';
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
    return MaterialApp(

      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset("assets/images/find_flow_logo.png", height: 30),
        ),

        body: const LoginScreen(),
      ),
    );
  }
}
