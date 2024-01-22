import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pain_drain_mobile_app/scheme_colors/app_colors.dart';
import 'package:pain_drain_mobile_app/screens/ble_scan.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Connect to Device"),
      // ),
      backgroundColor: AppColors.offWhite,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white, // You can set your desired color
                  ),
                  child: const Icon(Icons.bluetooth_connected_rounded, size: 80.0, color: AppColors.mintGreen,),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
                clipper: ConnectBottomScreenClipper(),
                child: Container(color: AppColors.amber.withOpacity(.7), height: 525, width: MediaQuery.of(context).size.width,),
              ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: ConnectBottomScreenClipper(),
              child: Container(color: AppColors.mintGreen, height: 500, width: MediaQuery.of(context).size.width,),
            ),
          ),
          Positioned(
            bottom: 40,
            left: (MediaQuery.of(context).size.width / 2) - 150,
            child: SizedBox(
              width: 300,
              child: Column(
                children: [
                  const Text("Press 'CONNECT' to connect to device", style: TextStyle(fontSize: 16, color: Colors.white),),
                  const SizedBox(height: 30,),
                  SizedBox(
                    width: 200,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {

                      //   Navigator.push(context, MaterialPageRoute(builder: (context) => const BleConnect()),
                      //   // MaterialPageRoute(builder: (context) => PageNavigation(activePage: 0, pageController: PageController(initialPage: 0),))
                      // );
                        await bluetoothController.startScanning();
                        // await Future.delayed(const Duration(seconds: 5));
                        bool containsPainDrain = bluetoothController.notConnectedDevices.any(
                              (result) => result.device.localName == 'PainDrain',
                        );
                        print("Pain Drain Devices $containsPainDrain");
                        // RxList<ScanResult> devices = bluetoothController.notConnectedDevices;
                        //
                        // int indexOfPainDrain = devices.indexWhere((device) => device.localName == 'PainDrain');


                        },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mintGreen.withOpacity(.1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)
                        ),

                      ),
                      child: const Text(
                        'CONNECT',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}





