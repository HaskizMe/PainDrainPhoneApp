import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain_drain_mobile_app/ble/bluetooth_controller.dart';


class BleConnect extends StatefulWidget {
  const BleConnect({Key? key}) : super(key: key);

  @override
  State<BleConnect> createState() => _BleConnectState();
}

class _BleConnectState extends State<BleConnect> {
  BluetoothController bluetoothController = Get.find<BluetoothController>();
  bool isScanning = false;
  bool isSnackBarVisible = false;

  // Callback function to show the SnackBar when disconnected
  void showDisconnectedSnackBar() {
    // Only show the SnackBar if it's not already displayed
    if (!isSnackBarVisible) {
      isSnackBarVisible = true; // Set a flag to indicate that the SnackBar is displayed

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.bluetooth_connected_rounded, color: Colors.blue),
              SizedBox(width: 8),
              Text('Device reconnecting'),
            ],
          ),
          duration: Duration(seconds: 5),
        ),
      ).closed.then((reason) {
        // Reset the flag when the SnackBar is closed
        setState(() {
          isSnackBarVisible = false;
        });
      });
    }
  }
  void startScanning() {
    setState(() {
      isScanning = true;
    });

    bluetoothController.startScanning();

    // Set a delay to return to the button state after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        isScanning = false;
      });
    });
  }
  @override
  void initState(){
    super.initState();
    bluetoothController.onDisconnectedCallback = showDisconnectedSnackBar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
          title: const Text('Bluetooth Devices'),
              backgroundColor: Colors.grey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: isScanning ? null : () => startScanning(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[900],
                minimumSize: const Size(350, 55),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              child: isScanning
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : const Center(
                child: Text(
                    'Scan for Devices',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Connect',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
              ),
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
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
              ),
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
