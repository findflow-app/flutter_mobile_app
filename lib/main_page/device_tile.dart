import 'package:findflow_mobile/main_page/devices_tab.dart';
import 'package:findflow_mobile/models/beacon_model.dart';
import 'package:findflow_mobile/services/beacons_service.dart';
import 'package:findflow_mobile/themes/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeviceTile extends ConsumerWidget {
  DeviceObject result;
  bool isClosest;
  DateTime lastSeen;
  Beacon? beacon;

  DeviceTile(
      {super.key,
      required this.result,
      this.isClosest = false,
      required this.lastSeen,
      this.beacon});

  String getDate(DateTime date) {
    return "${date.hour}:${date.minute}:${date.second}";
  }

  void openInfo(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Beacon Info"),
        ),
        body: Column(
          children: [
            Text("Name: ${beacon?.name}"),
            Text("Data Type: ${beacon?.data_type}"),
            Text("Data: ${beacon?.data}"),
          ],
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BeaconsState state = ref.watch(beaconsServiceProvider);
    BeaconsService beaconsService = ref.read(beaconsServiceProvider.notifier);

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
                beacon != null ? beacon!.name : result.id,
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
              ),
              if (isClosest)
                SizedBox(
                  height: 8.0,
                ),
              if (isClosest)
                ElevatedButton(
                    onPressed: () => openInfo(context),
                    child: Text("open info"))
            ],
          ),
        ),
      ),
    );
  }
}
