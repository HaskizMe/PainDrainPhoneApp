// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:pain_drain_mobile_app/models/presets.dart';
// import 'package:pain_drain_mobile_app/models/stimulus.dart';
// import 'package:pain_drain_mobile_app/screens/connect_device/connect_to_device.dart';
// import 'package:pain_drain_mobile_app/screens/home/home_screen.dart';
// import 'package:pain_drain_mobile_app/screens/test/test.dart';
// import 'models/bluetooth.dart';
// import 'package:get/get.dart';
// import 'package:device_preview/device_preview.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // This initializes the Bluetooth controller class so we can use it wherever in the app.
//   Get.put(Stimulus());
//   //Get.put(Bluetooth());
//   Get.put(Presets());
//   runApp(ProviderScope(
//     child: DevicePreview(
//       //enabled: true,
//       enabled: false,
//
//       builder: (context) => GetMaterialApp(
//         debugShowCheckedModeBanner: false,
//         initialRoute: '/', // Specify initial route
//         getPages: [
//           GetPage(name: '/', page: () => const ConnectDevice()), // Define route for "/"
//           //GetPage(name: '/', page: () => const HomeScreen()), // Define route for "/"
//         ],
//       ),
//     ),
//   ));
//   //FlutterBluePlus.setLogLevel(LogLevel.verbose, color: false);
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp, // Allow portrait orientation
//   ]);
// }


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:device_preview/device_preview.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';

// Import your screens and models
import 'package:pain_drain_mobile_app/screens/connect_device/connect_to_device.dart';
import 'package:pain_drain_mobile_app/screens/home/home_screen.dart';
import 'package:pain_drain_mobile_app/models/presets.dart';
import 'package:pain_drain_mobile_app/models/stimulus.dart';
import 'package:pain_drain_mobile_app/utils/go_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize your controllers or models as needed.
  // If you're using Get.put() for dependency injection and want to remove Get,
  // you might consider using Riverpod providers instead.
  // For now, we'll simply instantiate them:
  Get.put(Stimulus());
  Get.put(Presets());

  runApp(
    ProviderScope(
      child: DevicePreview(
        enabled: false, // Set to true if you want to preview on different devices.
        builder: (context) => MyApp(router: routes),
      ),
    ),
  );

  // Lock the app to portrait mode.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatelessWidget {
  final GoRouter router;
  const MyApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // Optionally, wrap your app with DevicePreview's appBuilder if needed:
      builder: DevicePreview.appBuilder,
      title: 'Pain Drain',
      debugShowCheckedModeBanner: false,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
