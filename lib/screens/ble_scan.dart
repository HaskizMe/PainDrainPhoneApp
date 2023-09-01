import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:pain_drain_mobile_app/ble/bluetooth_controller.dart';
import '../main.dart';
import 'package:pain_drain_mobile_app/screens/TENS_settings.dart';


class BleConnect extends StatelessWidget {
  BluetoothController bluetoothController = Get.find<BluetoothController>();
  //final BluetoothController bluetoothController2 = Get.lazyPut(() => null)

  BleConnect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bluetooth Devices')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                bluetoothController.startScanning();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(350, 55),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  )
              ),
              child: const Center(
                child: Text(
                    'Scan for Devices'
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Connect',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: bluetoothController.notConnectedDevices.length,
                itemBuilder: (context, index) {
                  final result = bluetoothController.notConnectedDevices[index];

                  // Filtering devices by name
                  if (result.device.localName == 'PainDrain' || result.device.localName == 'Luna3') {
                    return GestureDetector(
                      onTap: () async {
                          bluetoothController.connectToDevice(result.device);
                      },
                      child: Card(
                        elevation: 4,
                        child: ListTile(
                          title: Text(result.device.localName),
                          subtitle: Text(result.device.remoteId.toString()),
                          trailing: Text(result.rssi.toString()),
                        ),
                      ),
                    );
                  }

                  return const SizedBox.shrink(); // Empty space for devices not matching the filter
                },
              )),
            ),
            const SizedBox(height: 20),
            const Text(
              'Connected Devices',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: bluetoothController.connectedDevices.length,
                itemBuilder: (context, index) {
                  final device = bluetoothController.connectedDevices[index];

                  // Filtering devices by name
                  if (device.localName == 'PainDrain' || device.localName == 'Luna3') {
                    return GestureDetector(
                      onTap: () async {
                        bluetoothController.connectToDevice(device);
                        //bool isConnected = await getConnectionState();
                        // if(isConnected){
                        //   Get.to(() => const PageNavigation());
                        // }
                      },
                      child: Card(
                        elevation: 4,
                        child: ListTile(
                          title: Text(device.localName),
                          subtitle: Text(device.remoteId.toString()),
                        ),
                      ),
                    );
                  }

                  return const SizedBox.shrink(); // Empty space for devices not matching the filter
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
}
