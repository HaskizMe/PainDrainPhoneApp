import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:developer';

class BleScan extends StatefulWidget {
  const BleScan({Key? key}) : super(key: key);

  @override
  State<BleScan> createState() => _BleScanState();
}

class _BleScanState extends State<BleScan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "test"
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            debugPrint("object");
            //bleScanAndConnect();
            scanning();

          },
          child: const Text("Scan"),
        ),
      )
    );
  }
}

void scanning() async{
  // check adapter availability
  if (await FlutterBluePlus.isAvailable == false) {
    print("Bluetooth not supported by this device");
    return;
  }

// turn on bluetooth ourself if we can
// for iOS, the user controls bluetooth enable/disable
  if (Platform.isAndroid) {
    var status = Permission.bluetooth.status;
    print(status.toString());
    await FlutterBluePlus.turnOn();
  }

// wait bluetooth to be on & print states
// note: for iOS the initial state is typically BluetoothAdapterState.unknown
// note: if you have permissions issues you will get stuck at BluetoothAdapterState.unauthorized
  await FlutterBluePlus.adapterState
      .map((s){print(s);return s;})
      .where((s) => s == BluetoothAdapterState.on)
      .first;

}

// void bleScanAndConnect() async{
//   var status = await scanning();
//
// }