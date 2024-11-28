import 'package:findflow_mobile/main_page/device_tile.dart';
import 'package:flutter/material.dart';
import 'package:findflow_mobile/themes/theme_manager.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

class DevicesTab extends StatefulWidget {
  @override
  _DevicesTabState createState() => _DevicesTabState();
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

  DeviceObject(this.id, this.rssi, this.batteryLevel);
}

class _DevicesTabState extends State<DevicesTab> {
  List<DeviceObject> devices = [];

  void _onReceiveTaskData(Object data) {
    print("Received data from the TaskHandler: $data");

    final Map<String, dynamic> devicesFromBackgroundTask =
        data as Map<String, dynamic>;

    print("Received data from the TaskHandler: $devicesFromBackgroundTask");

    List<DeviceObject> devicesList = [];
    // loop by keys of the map
    devicesFromBackgroundTask.keys.forEach((key) {
      // get the value of the key
      String value = devicesFromBackgroundTask[key]!;
      // split the value by comma
      List<String> values = value.split(";");
      // create a new DeviceObject and add it to the list
      devicesList
          .add(DeviceObject(key, int.parse(values[0]), int.parse(values[1])));
    });

    // update the state with the new list of devices
    setState(() {
      devices = devicesList;
    });
  }

  @override
  void initState() {
    super.initState();
    // Add a callback to receive data sent from the TaskHandler.
    FlutterForegroundTask.addTaskDataCallback(_onReceiveTaskData);
  }

  @override
  void dispose() {
    // Remove a callback to receive data sent from the TaskHandler.
    FlutterForegroundTask.removeTaskDataCallback(_onReceiveTaskData);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        DeviceObject device = devices[index];

        return DeviceTile(
          result: device,
        );
      },
      itemCount: devices.length,
    );
  }
}
