import 'package:findflow_mobile/main_page/devices_tab.dart';
import 'package:findflow_mobile/themes/theme_manager.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        title: Image.asset("assets/images/find_flow_logo.png", height: 40, color: ThemeManager.instance.currentMode.colorScheme.primary),
        scrolledUnderElevation: 10,
      ),

      body: DevicesTab(),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Devices',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Find',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        selectedItemColor: ThemeManager.instance.currentMode.colorScheme.primary,
        backgroundColor: ThemeManager.instance.currentMode.colorScheme.surfaceContainer,
      ),
    );
  }
}