import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:device_preview/device_preview.dart';
import 'package:go_router/go_router.dart';
import 'package:pain_drain_mobile_app/utils/go_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize your controllers or models as needed.
  // If you're using Get.put() for dependency injection and want to remove Get,
  // you might consider using Riverpod providers instead.
  // For now, we'll simply instantiate them:

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
