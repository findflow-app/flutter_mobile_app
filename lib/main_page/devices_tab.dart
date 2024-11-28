import 'package:findflow_mobile/main_page/device_tile.dart';
import 'package:flutter/material.dart';
import 'package:findflow_mobile/themes/theme_manager.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

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

class _DevicesTabState extends State<DevicesTab> {
  List<ScanResult> devices = [];

  @override
  void initState() {
    startScan();
    super.initState();
  }

  void startScan() {
    FlutterBluePlus.startScan();

    FlutterBluePlus.scanResults.listen((results) {
      setState(() {
        devices = results
            .where((v) => v.device.advName == "findflow_beacon")
            .map(
              (v) => ScanResult(v.device, v.rssi, v.advertisementData),
            )
            .toList();
      });
    });
  }

  void resetScan() {
    FlutterBluePlus.stopScan();
    setState(() {
      devices.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    print(devices);
    return ListView.builder(
      itemBuilder: (context, index) {
        ScanResult device = devices[index];

        return DeviceTile(
          result: device,
        );
      },
      itemCount: devices.length,
    );
  }
}
