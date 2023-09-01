import 'package:flutter/material.dart';
import 'screens/TENS_settings.dart';
import 'screens/temp_settings.dart';
import 'screens//vibration_settings.dart';
import 'screens/preset_settings.dart';
import 'screens/splash_screen.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:pain_drain_mobile_app/ble/bluetooth_controller.dart';
void main() {
  // This initializes the Bluetooth controller class so we can use it wherever
  // in the app.
  Get.put(BluetoothController());
  runApp(const GetMaterialApp(
    home: SplashScreen(),
  ));
  FlutterBluePlus.setLogLevel(LogLevel.verbose, color: false);
}

// This class Navigates through all the screens
class PageNavigation extends StatefulWidget with WidgetsBindingObserver {
  const PageNavigation({Key? key}) : super(key: key);

  @override
  State<PageNavigation> createState() => _PageNavigation();
}

class _PageNavigation extends State<PageNavigation> with WidgetsBindingObserver {
  // Declare and initialize the page controller
  final PageController _pageController = PageController(initialPage: 0);

  // The index of the current page
  int _activePage = 0;

  final List<Widget> _pages = [
    //const ConnectDevice(),
    //const BleConnect(),
    const TENSSettings(),
    const TempSettings(),
    const VibrationSettings(),
    const PresetSettings()
  ];

  // @override
  // void initState(){
  //   super.initState();
  //   //bluetoothConnectionManager.startConnectionListener(yourBluetoothDevice);
  //   //WidgetsBinding.instance!.addObserver(this);
  // }
  // @override
  // void dispose(){
  //   //WidgetsBinding.instance!.removeObserver(this);
  //   super.dispose();
  // }
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state){
  //   if(state == AppLifecycleState.paused){
  //     print("App is in the background");
  //   }
  //   else if(state == AppLifecycleState.resumed){
  //     print("App is in the foreground");
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page){
              setState(() {
                _activePage = page;
              });
            },
            itemCount: _pages.length,
            itemBuilder: (BuildContext context, int index) {
              return _pages[index % _pages.length];
            },
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 80,
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
                            ? Colors.black : Colors.grey,
                        ),
                      ),
                    )
                )
              )
            ),
          ),

        ],
      ),
    );
  }
}