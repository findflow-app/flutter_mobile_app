import 'dart:async';

import 'package:findflow_mobile/main_page/devices_tab.dart';
import 'package:findflow_mobile/main_page/profile_tab.dart';
import 'package:findflow_mobile/providers.dart';
import 'package:findflow_mobile/services/user_service.dart';
import 'package:findflow_mobile/themes/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  List<DeviceObject> devices = [];
  late Timer _timer;
  int _currentIndex = 0;

  void _startScan() {
    FlutterBluePlus.startScan();
    FlutterBluePlus.onScanResults.listen((results) {
      final devicesList = results
          .where((v) => v.device.advName == "findflow_beacon")
          // .map(
          //   (v) => DeviceObject(
          //     v.device.remoteId.str,
          //     v.rssi,
          //     v.advertisementData.serviceData.values.first[0],
          //   ),
          // )
          .toList();

      for (var device in devicesList) {
        print("device: ${device.device.remoteId.str} - ${device.timeStamp}");
        print("----------------");
      }

      // dcheck if the device hasnt been seen in the last 10 seconds
      List<DeviceObject> newDevicesList = devicesList
          .toList()
          .map((d) => DeviceObject(d.device.remoteId.str, d.rssi,
              d.advertisementData.serviceData.values.first[0], d.timeStamp))
          .toList();

      if (this.mounted)
        setState(() {
          devices = newDevicesList;
        });
    });
  }

  void _startTimer() {
    AuthService authService = ref.read(authServiceProvider.notifier);
    // AuthState authState = ref.watch(authServiceProvider);

    Timer.periodic(Duration(seconds: 4), (timer) {
      // // avaiableDevices are devices that have been seen in the last 10 seconds
      // final availableDevices = devices
      //     .where((element) => element.lastSeen
      //         .isAfter(DateTime.now().subtract(Duration(seconds: 10))))
      //     .toList();

      // final removedDevices = devices
      //     .where((element) => element.lastSeen
      //         .isBefore(DateTime.now().subtract(Duration(seconds: 10))))
      //     .toList();

      final closestDevice = devices.reduce((a, b) => a.rssi > b.rssi ? a : b);

      print("closestDevice: ${closestDevice.id}");
      authService.logBeacon(closestDevice.id);

      // setState(() {
      //   devices = availableDevices;
      // });
    });
  }

  @override
  void initState() {
    // Add a callback to receive data sent from the TaskHandler.
    // FlutterForegroundTask.addTaskDataCallback(_onReceiveTaskData);
    _startScan();
    _startTimer();

    Timer.periodic(Duration(seconds: 30), (timer) {
      // reset the devices list
      // setState(() {
      //   devices = [];
      // });

      FlutterBluePlus.stopScan();

      _startScan();
    });

    super.initState();
  }

  @override
  void dispose() {
    // Remove a callback to receive data sent from the TaskHandler.
    // FlutterForegroundTask.removeTaskDataCallback(_onReceiveTaskData);
    FlutterBluePlus.stopScan();

    // _timer.cancel();

    FlutterBluePlus.scanResults.listen((event) {}).cancel();

    super.dispose();
  }

  Widget getBody() {
    switch (_currentIndex) {
      case 0:
        return DevicesTab(devices: devices);
      case 1:
        return Container();
      case 2:
        return ProfileTab();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        title: Image.asset("assets/images/find_flow_logo.png",
            height: 40, color: Theme.of(context).colorScheme.primary),
        scrolledUnderElevation: 10,
      ),
      body: getBody(),
      bottomNavigationBar: Container(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(24),
            topLeft: Radius.circular(24),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
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
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
            selectedItemColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          ),
        ),
      ),
    );
  }
}
