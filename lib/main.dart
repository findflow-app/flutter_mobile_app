import 'dart:isolate';
import 'dart:io';

import 'package:findflow_mobile/login_page/login_page.dart';
import 'package:findflow_mobile/login_page/sign_up_page.dart';
import 'package:findflow_mobile/main_page/main_page.dart';
import 'package:findflow_mobile/themes/theme_manager.dart';
import 'package:flutter/material.dart';
import "package:permission_handler/permission_handler.dart";

import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(BleScanTaskHandler());
}

class ScanResult {
  final BluetoothDevice device;
  final int rssi;
  final AdvertisementData advertisementData;

  ScanResult(this.device, this.rssi, this.advertisementData);
}

class BleScanTaskHandler extends TaskHandler {
  List<ScanResult> devices = [];

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    // Start BLE scanning
    print('BACKGROUND BLE scanning started');

    FlutterBluePlus.startScan();

    FlutterBluePlus.scanResults.listen((results) {
      devices = results
          .where((v) => v.device.advName == "findflow_beacon")
          .map(
            (v) => ScanResult(v.device, v.rssi, v.advertisementData),
          )
          .toList();

      // Send data to main isolate.
      final Map<String, dynamic> data = {};

      for (ScanResult device in devices) {
        data[device.device.remoteId.str] =
            "${device.rssi};${device.advertisementData.serviceData.values.first[0]}";
      }

      print("SENDING DATA TO MAIN ISOLATE");
      print(data);

      FlutterForegroundTask.sendDataToMain(data);
    });
  }

  @override
  Future<void> onDestroy(DateTime timestamp) async {
    // Stop BLE scanning
    print('BACKGROUND BLE scanning stopped');

    if (FlutterBluePlus.isScanningNow) FlutterBluePlus.stopScan();
  }

  @override
  Future<void> onRepeatEvent(DateTime timestamp) async {
    // Send data to main isolate.
    print("REPEATE EVEN BUDE TADY MORENA KOKOT VOLEW");

    // Send data to main isolate.
    final Map<String, dynamic> data = {};

    for (ScanResult device in devices) {
      data[device.device.remoteId.str] =
          "${device.rssi};${device.advertisementData.serviceData.values.first[0]}";
    }

    FlutterForegroundTask.sendDataToMain(data);
  }
}

Future<void> _requestPermissions() async {
  // Android 13+, you need to allow notification permission to display foreground service notification.
  //0
  // iOS: If you need notification, ask for permission.
  final NotificationPermission notificationPermission =
      await FlutterForegroundTask.checkNotificationPermission();
  if (notificationPermission != NotificationPermission.granted) {
    await FlutterForegroundTask.requestNotificationPermission();
  }

  if (Platform.isAndroid) {
    // Android 12+, there are restrictions on starting a foreground service.
    //
    // To restart the service on device reboot or unexpected problem, you need to allow below permission.
    if (!await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
      // This function requires `android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS` permission.
      await FlutterForegroundTask.requestIgnoreBatteryOptimization();
    }

    // Use this utility only if you provide services that require long-term survival,
    // such as exact alarm service, healthcare service, or Bluetooth communication.
    //
    // This utility requires the "android.permission.SCHEDULE_EXACT_ALARM" permission.
    // Using this permission may make app distribution difficult due to Google policy.
    if (!await FlutterForegroundTask.canScheduleExactAlarms) {
      // When you call this function, will be gone to the settings page.
      // So you need to explain to the user why set it.
      await FlutterForegroundTask.openAlarmsAndRemindersSettings();
    }
  }
}

void _initService() {
  FlutterForegroundTask.init(
    androidNotificationOptions: AndroidNotificationOptions(
      channelId: 'foreground_service',
      channelName: 'Foreground Service Notification',
      channelDescription:
          'This notification appears when the foreground service is running.',
      onlyAlertOnce: true,
    ),
    iosNotificationOptions: const IOSNotificationOptions(
      showNotification: false,
      playSound: false,
    ),
    foregroundTaskOptions: ForegroundTaskOptions(
      eventAction: ForegroundTaskEventAction.repeat(5000),
      autoRunOnBoot: true,
      autoRunOnMyPackageReplaced: true,
      allowWakeLock: true,
      allowWifiLock: true,
    ),
  );
}

Future<ServiceRequestResult> _startService() async {
  if (await FlutterForegroundTask.isRunningService) {
    return FlutterForegroundTask.restartService();
  } else {
    return FlutterForegroundTask.startService(
      serviceId: 256,
      notificationTitle: 'Foreground Service is running',
      notificationText: 'Tap to return to the app',
      notificationIcon: null,
      notificationButtons: [
        const NotificationButton(id: 'btn_hello', text: 'hello'),
      ],
      callback: startCallback,
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.bluetooth.request();
  await Permission.location.request();
  await Permission.bluetoothScan.request();
  await Permission.locationWhenInUse.request();

  FlutterForegroundTask.initCommunicationPort();

  await _requestPermissions();
  _initService();

  ServiceRequestResult r = await _startService();
  print(r.success);
  print(r.error);

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    ThemeManager.instance.toggleTheme(true);

    return MaterialApp(
      theme: lightMode,
      darkTheme: darkMode,
      home: const MainScreen(),
    );
  }
}
