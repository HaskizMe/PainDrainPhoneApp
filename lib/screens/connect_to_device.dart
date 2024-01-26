import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pain_drain_mobile_app/scheme_colors/app_colors.dart';
import 'package:pain_drain_mobile_app/screens/home_page.dart';
import 'dart:io';
import '../ble/bluetooth_controller.dart';
import '../helper_files/clip_paths.dart';
import '../main.dart';
import '../widgets/custom_card.dart';

class ConnectDevice extends StatefulWidget {
  const ConnectDevice({Key? key}) : super(key: key);

  @override
  State<ConnectDevice> createState() => _ConnectDeviceState();
}

class _ConnectDeviceState extends State<ConnectDevice> {
  BluetoothController bluetoothController = Get.find<BluetoothController>();

  // bool isConnected = false;
  bool isPulsing = false;

  @override
  @override
  void initState() {
    super.initState();
  }


  Future<void> scanAndConnect() async {
    setState(() {
      isPulsing = true;
    });

    await bluetoothController.scanForDevices();
    List<ScanResult> results = bluetoothController.scanResults;
    if(results.isNotEmpty){
      BluetoothDevice device = results.first.device;
      bool success = await bluetoothController.connectDevice(device);
      if(success) {
        Get.to(() => const HomePage());
        print("success");
      }
      else{
        print("Unsuccessful");
      }
    }
    print("List ${bluetoothController.scanResults}");

    setState(() {
      isPulsing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PulseIcon(isPulsing: isPulsing,), // Use the PulseIcon widget
                const SizedBox(height: 20),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: ConnectBottomScreenClipper(),
              child: Container(
                color: AppColors.amber.withOpacity(.7),
                height: 525,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: ConnectBottomScreenClipper(),
              child: Container(
                color: AppColors.mintGreen,
                height: 500,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: (MediaQuery.of(context).size.width / 2) - 150,
            child: SizedBox(
              width: 300,
              child: Column(
                children: [
                  const Text("Press 'CONNECT' to connect to device",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  const SizedBox(height: 30,),
                  SizedBox(
                    width: 200,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        if(!isPulsing){
                          await scanAndConnect();
                        }

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mintGreen.withOpacity(.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Text(
                        'SCAN',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  Text(globalValues.deviceConnected ? "Connected" : "Disconnected"),

                  // globalValues.deviceConnected ? Text("connected") : Text("disconnected"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PulseIcon extends StatefulWidget {
  final bool isPulsing;
  const PulseIcon({super.key, required this.isPulsing});

  @override
  _PulseIconState createState() => _PulseIconState();
}

class _PulseIconState extends State<PulseIcon> with TickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PulseIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Start or stop the animation based on the isPulsing state
    if (widget.isPulsing) {
      _pulseController.repeat(reverse: true);
    } else {
      _pulseController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(
          parent: _pulseController,
          curve: Curves.easeInOut,
        ),
      ),
      child: Container(
        width: 130.0,
        height: 130.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: const Icon(Icons.bluetooth_connected_rounded, size: 100.0, color: AppColors.mintGreen),
      ),
    );
  }
}

