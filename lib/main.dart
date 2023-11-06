import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'global_values.dart';
import 'screens/TENS_settings.dart';
import 'screens/temp_settings.dart';
import 'screens/vibration_settings.dart'; // Removed double slashes
import 'screens/preset_settings.dart';
import 'screens/splash_screen.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:pain_drain_mobile_app/ble/bluetooth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_preview/device_preview.dart';
final globalValues = GlobalValues();

void main() {
  // This initializes the Bluetooth controller class so we can use it wherever
  // in the app.
  Get.put(BluetoothController());
  runApp(DevicePreview(
    enabled: false,
    builder: (context) => const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
  ));
  FlutterBluePlus.setLogLevel(LogLevel.verbose, color: false);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Allow portrait orientation
  ]);
}

bool showStack = true;

// This class Navigates through all the screens
class PageNavigation extends StatefulWidget with WidgetsBindingObserver {
  const PageNavigation({Key? key}) : super(key: key);

  @override
  State<PageNavigation> createState() => _PageNavigationState();
}

class _PageNavigationState extends State<PageNavigation> with WidgetsBindingObserver {
  // Declare and initialize the page controller
  final BluetoothController bluetoothController = Get.find<BluetoothController>();
  final PageController _pageController = PageController(initialPage: 0);

  // The index of the current page
  int _activePage = 0;
  int batteryLevel = 0;

  bool isSmallScreen(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    print('my width is $height');
    return height < 670;
  }
  final List<Widget> _pages = [
    const TENSSettings(),
    const TempSettings(),
    const VibrationSettings(),
    const PresetSettings()
  ];

  // Battery percentage indicator widget
  // Widget _buildBatteryIndicator() {
  //   const Widget batteryIcon = Icon(
  //     Icons.battery_6_bar_rounded,
  //     color: Colors.white,
  //     size: 24,
  //   );
  //
  //   const Widget batteryText = Text(
  //     "80% ${bluetoothController.batteryLevelRead()}", // Replace with your actual battery percentage
  //     style: TextStyle(
  //       color: Colors.white,
  //       fontSize: 16,
  //     ),
  //   );
  //
  //   return const Row(
  //     mainAxisSize: MainAxisSize.min, // Allows the row to take the minimum required space
  //     children: [
  //       batteryText,
  //       batteryIcon,
  //     ],
  //   );
  // }
  // This added a battery indicator but is not needed right now
  // Widget _buildBatteryIndicator() {
  //   const Widget batteryIcon = Icon(
  //     Icons.battery_6_bar_rounded,
  //     color: Colors.white,
  //     size: 24,
  //   );
  //
  //   return FutureBuilder<int>(
  //     future: bluetoothController.batteryLevelRead(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         // While waiting for the result, you can display a loading indicator or placeholder.
  //         return const CircularProgressIndicator();
  //       } else if (snapshot.hasError) {
  //         // Handle any errors that may have occurred during the async operation.
  //         return Text("Error: ${snapshot.error}");
  //       } else {
  //         // Once the future completes successfully, you can display the battery percentage.
  //         final int batteryLevel = snapshot.data ?? 0;
  //         return Row(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text(
  //               "${batteryLevel.toString()}%", // Display the battery level
  //               style: const TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 20,
  //               ),
  //             ),
  //             batteryIcon,
  //           ],
  //         );
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: Stack(
        children: [
          // PageView and navigation dots
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _activePage = page;
              });
            },
            itemCount: _pages.length,
            itemBuilder: (BuildContext context, int index) {
              return _pages[index % _pages.length];
            },
          ),
          // This will only show the navigation dots when in portrait mode
          if (orientation == Orientation.portrait || orientation == Orientation.landscape)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: isSmallScreen(context) ? 40.0 : 80.0,
              child: Container(
                color: Colors.black54,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                    _pages.length,
                        (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: InkWell(
                        onTap: () {
                          _pageController.animateToPage(index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: _activePage == index
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

          // Battery percentage indicator above the app title bar not needed right now
          // Align(
          //   alignment: Alignment.bottomRight, // Adjust the values to position it as needed
          //   child: Padding(
          //     padding: const EdgeInsets.only(bottom: 8.0, right: 8.0), // Adjust the values for padding
          //     child: _buildBatteryIndicator(),
          //   ),
          // ),

        ],
      ),
    );
  }
}