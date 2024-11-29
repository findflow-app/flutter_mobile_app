import 'package:findflow_mobile/main_page/devices_tab.dart';
import 'package:findflow_mobile/themes/theme_manager.dart';
import 'package:flutter/material.dart';

class DeviceTile extends StatelessWidget {
  DeviceObject result;
  bool isClosest;
  DateTime lastSeen;

  DeviceTile(
      {super.key,
      required this.result,
      this.isClosest = false,
      required this.lastSeen});

  String getDate(DateTime date) {
    return "${date.hour}:${date.minute}:${date.second}";
  }

  @override
  Widget build(BuildContext context) {
    int batteryLevel = result.batteryLevel;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isClosest
              ? Theme.of(context).colorScheme.secondaryContainer
              : Theme.of(context).colorScheme.onSecondary,
          borderRadius: const BorderRadius.all(Radius.circular(33.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: Column(
            children: [
              Text(
                result.id,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
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
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    "Battery: $batteryLevel%",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 14.0,
                    ),
                  ),
                  Text("${getDate(lastSeen)}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 14.0,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
