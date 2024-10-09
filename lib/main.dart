import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pain_drain_mobile_app/models/presets.dart';
import 'package:pain_drain_mobile_app/models/stimulus.dart';
import 'package:pain_drain_mobile_app/screens/connect_device/connect_to_device.dart';
import 'package:pain_drain_mobile_app/screens/home/home_screen.dart';
import 'package:pain_drain_mobile_app/screens/test/test.dart';
import 'models/bluetooth.dart';
import 'package:get/get.dart';
import 'package:device_preview/device_preview.dart';

Future<void> main() async {
  // This initializes the Bluetooth controller class so we can use it wherever in the app.
  Get.put(Stimulus());
  Get.put(Bluetooth());
  Get.put(Presets());
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