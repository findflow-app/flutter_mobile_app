import 'package:findflow_mobile/main_page/devices_tab.dart';
import 'package:findflow_mobile/main_page/profile_tab.dart';
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
  int _currentIndex = 0;

  void _startScan() {
    FlutterBluePlus.startScan();
    FlutterBluePlus.scanResults.listen((results) {
      List<DeviceObject> devicesList = results
          .where((v) => v.device.advName == "findflow_beacon")
          .map(
            (v) => DeviceObject(
              v.device.remoteId.str,
              v.rssi,
              v.advertisementData.serviceData.values.first[0],
            ),
          )
          .toList();

      if (this.mounted)
        setState(() {
          devices = devicesList;
        });
    });
  }

  @override
  void initState() {
    super.initState();
    // Add a callback to receive data sent from the TaskHandler.
    // FlutterForegroundTask.addTaskDataCallback(_onReceiveTaskData);
    _startScan();
  }

  @override
  void dispose() {
    // Remove a callback to receive data sent from the TaskHandler.
    // FlutterForegroundTask.removeTaskDataCallback(_onReceiveTaskData);
    FlutterBluePlus.stopScan();

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
                icon: Icon(Icons.account_circle),
                label: 'Profile',
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
