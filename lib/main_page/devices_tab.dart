import 'package:findflow_mobile/main_page/device_tile.dart';
import 'package:findflow_mobile/models/beacon_model.dart';
import 'package:flutter/material.dart';
import 'package:findflow_mobile/themes/theme_manager.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

class DevicesTab extends StatelessWidget {
  List<DeviceObject> devices;
  Map<String, Beacon> beacons;

  DevicesTab({super.key, required this.devices, required this.beacons});

  // void _onReceiveTaskData(Object data) {
  @override
  Widget build(BuildContext context) {
    if (devices.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    DeviceObject closest = devices.reduce((a, b) => a.rssi > b.rssi ? a : b);

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(50.0)),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
          ),
          child: ListView.builder(
            itemBuilder: (context, index) {
              if (index == 0) return SizedBox(height: 8.0);
              DeviceObject device = devices[index - 1];
              return DeviceTile(
                result: device,
                isClosest: device == closest,
                lastSeen: device.lastSeen,
                beacon: beacons[device.id],
              );
            },
            itemCount: devices.length + 1,
          ),
        ),
      ),
    );
  }
}

class ScanResult {
  final BluetoothDevice device;
  final int rssi;
  final AdvertisementData advertisementData;

  ScanResult(this.device, this.rssi, this.advertisementData);
}

class DeviceObject {
  final String id;
  final int rssi;
  final int batteryLevel;
  final DateTime lastSeen;

  DeviceObject(this.id, this.rssi, this.batteryLevel, this.lastSeen);
}
