import 'dart:io';
import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:pain_drain_mobile_app/main.dart';
import 'package:pain_drain_mobile_app/screens/ble_scan.dart';

DeviceIdentifier luna3Identifier = const DeviceIdentifier('E6:D8:E7:66:CB:0D');
DeviceIdentifier painDrainIdentifier = const DeviceIdentifier('00:A0:50:00:00:03');
BluetoothDevice luna3 = BluetoothDevice(
    remoteId: luna3Identifier,
    localName: 'Luna3',
    type: BluetoothDeviceType.le
);

BluetoothDevice painDrain = BluetoothDevice(
    remoteId: painDrainIdentifier,
    localName: 'PainDrain',
    type: BluetoothDeviceType.le
);

class BluetoothController extends GetxController {
  Function? onDisconnectedCallback;
  String customServiceUUID = "3bf00c21-d291-4688-b8e9-5a379e3d9874";
  String customCharacteristicUUID = "93c836a2-695a-42cc-95ac-1afa0eef6b0a";
  late BluetoothService customService;
  late BluetoothCharacteristic customCharacteristic;
  late BluetoothDevice connectedDevice;
  late List<BluetoothService> services;

  final RxList<BluetoothDevice> connectedDevices = RxList<BluetoothDevice>();
  final RxList<ScanResult> notConnectedDevices = RxList<ScanResult>();

  // @override
  // void onInit() {
  //   super.onInit();
  //   _setupBluetooth();
  // }

  Future<void> _setupBluetooth() async {
    if (await FlutterBluePlus.isAvailable == false) {
      print("Bluetooth not supported by this device");
      return;
    }

    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }

    await FlutterBluePlus.adapterState
        .map((s) => s)
        .where((s) => s == BluetoothAdapterState.on)
        .first;

    FlutterBluePlus.connectedSystemDevices.then((devices) {
      connectedDevices.clear();
      connectedDevices.assignAll(devices);
    });

    FlutterBluePlus.scanResults.listen((results) {
      notConnectedDevices.clear();
      notConnectedDevices.assignAll(results);
    });

    FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 5),
      androidUsesFineLocation: false,
    );
    //FlutterBluePlus.stopScan();
  }

  void startScanning() {
    _setupBluetooth();
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      // This connects to the device and then navigates to the other pages
      //await device.disconnect();
      await device.connect();
      connectedDevice = device;
      services = await connectedDevice.discoverServices();
      // Reads all services and finds the custom service uuid
      for (BluetoothService service in services) {
        if(service.uuid.toString() == customServiceUUID){
          print("Custom service found");
          customService = service;
        }
      }
      // Reads all characteristics
      var characteristics = customService.characteristics;
      for(BluetoothCharacteristic characteristic in characteristics) {
        print(characteristic.uuid);
        if(characteristic.uuid.toString() == customCharacteristicUUID){
          print("Custom characteristic found");
          customCharacteristic = characteristic;
        }
      }
      // This listens to the device and if it gets connected it will return back
      // to the connection page also, if its already connected it will navigate
      // to the other pages.
      device.connectionState.listen((state) async {
        if (state == BluetoothConnectionState.disconnected) {
          print("Disconnected");
          Get.to(() => const BleConnect());
          onDisconnectedCallback!();

        } else if (state == BluetoothConnectionState.connected) {
          print("already connected");
          //connectedDevice = device;
          Get.to(() => const PageNavigation());
        }
      });
      //await customCharacteristic.write([116, 32, 49, 48, 48]);
    } catch (e) {
      print(e);
    }
  }


  @override
  void onClose() {
    luna3.disconnect();
    painDrain.disconnect();
    FlutterBluePlus.stopScan();
    super.onClose();
  }

// Future<bool> getConnectionState() async {
//   Completer<bool> completer = Completer<bool>();
//
//   luna3.connectionState.listen((state) async {
//     if (state == BluetoothConnectionState.connected) {
//       completer.complete(true);
//       print("isConnected");
//     } else if (state == BluetoothConnectionState.disconnected) {
//       completer.complete(false);
//       print("isNotConnected");
//     }
//   });
//
//   return completer.future;
// }

  Future writeToDevice(String stimulus, List<int> hexValues) async {
    //List<BluetoothService> services = await connectedDevice.discoverServices();
    //await customCharacteristic.write(hexValues);
    switch (stimulus){
      case "tens":
        await customCharacteristic.write(hexValues);
        print("tens");
        break;
      case "temperature":
        await customCharacteristic.write(hexValues);
        print("temperature");
        break;
      case "vibration":
        await customCharacteristic.write(hexValues);
        print("vibration");
        break;
      default:
        print("error");
        break;
    }
    //print(connectedDevice);
    //print("hi");
  }

  Future readFromDevice(characteristics) async {
    for (BluetoothCharacteristic c in characteristics) {
      List<int> value = await c.read();
      //print(value);
    }
  }
  List<int> stringToHexList(String input) {
    List<int> hexList = [];

    for (int i = 0; i < input.length; i++) {
      final char = input[i];
      final hexValue = char.codeUnitAt(0);
      hexList.add(hexValue);
    }

    return hexList;
  }
}

