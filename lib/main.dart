import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pain_drain_mobile_app/controllers/presets_controller.dart';
import 'package:pain_drain_mobile_app/controllers/stimulus_controller.dart';
import 'package:pain_drain_mobile_app/screens/connect_to_device.dart';
import 'package:pain_drain_mobile_app/screens/home_screen.dart';
import 'controllers/bluetooth_controller.dart';
import 'package:get/get.dart';
import 'package:device_preview/device_preview.dart';

Future<void> main() async {
  // This initializes the Bluetooth controller class so we can use it wherever in the app.
  Get.put(StimulusController());
  Get.put(BluetoothController());
  Get.put(SavedPresets());
  runApp(DevicePreview(
    //enabled: true,
    enabled: false,

    builder: (context) => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Specify initial route
      getPages: [
        GetPage(name: '/', page: () => const ConnectDevice()), // Define route for "/"
        //GetPage(name: '/', page: () => const HomeScreen()), // Define route for "/"
      ],
    ),
  ));
  //FlutterBluePlus.setLogLevel(LogLevel.verbose, color: false);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Allow portrait orientation
  ]);
}