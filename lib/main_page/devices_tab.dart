import 'package:flutter/material.dart';
import 'package:findflow_mobile/themes/theme_manager.dart';

class DevicesTab extends StatefulWidget {
  @override
  _DevicesTabState createState() => _DevicesTabState();
}

class _DevicesTabState extends State<DevicesTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          color: ThemeManager.instance.currentMode.colorScheme.surfaceContainer,
          borderRadius: const BorderRadius.all(Radius.circular(50.0)),
        ),

        child: SingleChildScrollView(
          child: Column(
            children: [
              devicePanel("Device 1"),
              devicePanel("Device 2"),
              devicePanel("Device 3"),
              devicePanel("Device 4"),
            ],
          ),
        ),
      ),
    );
  }
}
Widget devicePanel(String deviceName) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(

      width: double.infinity,
      decoration: BoxDecoration(
        color: ThemeManager.instance.currentMode.colorScheme.secondaryContainer,
        borderRadius: const BorderRadius.all(Radius.circular(33.0)),
      ),

      height: 300,

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          deviceName,
          style: TextStyle(
            color: ThemeManager.instance.currentMode.colorScheme.primary,
            fontSize: 18.0,
          ),
        ),
      ),

    ),
  );
}
