import 'package:findflow_mobile/main_page/devices_tab.dart';
import 'package:findflow_mobile/themes/theme_manager.dart';
import 'package:flutter/material.dart';

class DeviceTile extends StatelessWidget {
  ScanResult result;

  DeviceTile({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    int batteryLevel = result.advertisementData.serviceData.values.first[0];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color:
              ThemeManager.instance.currentMode.colorScheme.secondaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(33.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: Column(
            children: [
              Text(
                result.device.remoteId.str,
                style: TextStyle(
                  color: ThemeManager.instance.currentMode.colorScheme.primary,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "RSSI: ${result.rssi}",
                    style: TextStyle(
                      color:
                          ThemeManager.instance.currentMode.colorScheme.primary,
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    "Battery: $batteryLevel%",
                    style: TextStyle(
                      color:
                          ThemeManager.instance.currentMode.colorScheme.primary,
                      fontSize: 14.0,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
