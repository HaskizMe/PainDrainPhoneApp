import 'dart:io';
import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:pain_drain_mobile_app/main.dart';
import 'package:pain_drain_mobile_app/screens/ble_scan.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

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
  Function? onReconnectedCallback;
  String customServiceUUID = "3bf00c21-d291-4688-b8e9-5a379e3d9874";
  String customCharacteristicUUID = "93c836a2-695a-42cc-95ac-1afa0eef6b0a";
  String batteryServiceUUID = "0000180f-0000-1000-8000-00805f9b34fb";
  String batteryCharacteristicUUID = "00002a19-0000-1000-8000-00805f9b34fb";
  late BluetoothService customService;
  late BluetoothCharacteristic customCharacteristic;
  late BluetoothService batteryService;
  late BluetoothCharacteristic batteryCharacteristic;
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
    //var locationStatus = await Permission.locationWhenInUse.status;
    // continue testing if user dialogue to enable location isn't showing
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
      timeout: const Duration(seconds: 5), androidUsesFineLocation: true
    );
  }

  Future<void> startScanning() async {
    await _setupBluetooth();
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      // This connects to the device and then navigates to the other pages
      await device.connect();
      connectedDevice = device;
      services = await connectedDevice.discoverServices();
      // Reads all services and finds the custom service uuid
      for (BluetoothService service in services) {
        if(service.uuid.toString() == customServiceUUID){
          print("Custom service found");
          customService = service;
        }
        if(service.uuid.toString() == batteryServiceUUID){
          print("Battery service found");
          batteryService = service;
        }
      }
      // Reads all characteristics
      var customServiceCharacteristics = customService.characteristics;
      var batteryServiceCharacteristics = batteryService.characteristics;
      for(BluetoothCharacteristic characteristic in customServiceCharacteristics) {
        if(characteristic.uuid.toString() == customCharacteristicUUID){
          print("Custom characteristic found");
          customCharacteristic = characteristic;
        }
      }
      for(BluetoothCharacteristic characteristic in batteryServiceCharacteristics) {
        if(characteristic.uuid.toString() == batteryCharacteristicUUID){
          print("Battery characteristic found");
          batteryCharacteristic = characteristic;
        }
      }

      // This listens to the device and if it gets connected it will return back
      // to the connection page also, if its already connected it will navigate
      // to the other pages.
      late StreamSubscription<BluetoothConnectionState> connectionStateSubscription;
      connectionStateSubscription = device.connectionState.listen((state) async {
        if (state == BluetoothConnectionState.connected) {
          print("Connected");
          await Future.delayed(const Duration(seconds: 2));
           Get.to(() => PageNavigation(activePage: 0, pageController: PageController(initialPage: 0),));
          //Get.to(() => Test());
        }
        else if (state == BluetoothConnectionState.disconnected) {
          print("Disconnected");
          connectionStateSubscription.cancel();
          reconnectToDevice(device);
        }
      });
    } catch (e) {
      print("Error connecting $e");
      onDisconnectedCallback!();
      Get.to(() => const BleConnect());
    }




  }

  Future<void> reconnectToDevice(BluetoothDevice device) async {
    try {
      await device.disconnect();
      await connectToDevice(device);
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

  Future writeToDevice(String stimulus, List<int> hexValues) async {
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
        print('vibration $hexValues');
        await customCharacteristic.write(hexValues);
        print("vibration");
        break;
      case "register":
        print('register $hexValues');
        await customCharacteristic.write(hexValues);
        print("register");
        break;
      default:
        print("error");
        break;
    }
  }

  Future<List<int>> readFromDevice() async {
    try {
      List<int> rspHexValues = await customCharacteristic.read();

      // Remove elements after the null terminator ('\0')
      if (rspHexValues.contains(0)) {
        rspHexValues = rspHexValues.sublist(0, rspHexValues.indexOf(0));
      }

      return rspHexValues;
    } catch (e) {
      print('Error during readFromDevice: $e');
      rethrow; // Rethrow the exception after logging or handle it appropriately
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

  String hexToString(List<int> list){
    String asciiString = "";

    for (int hexValue in list) {
      // Convert each hex value to its corresponding ASCII character
      asciiString += String.fromCharCode(hexValue);
    }
    return asciiString;
  }

  Future<int> batteryLevelRead() async {
    List<int> rspHexValues = [];
    rspHexValues = await batteryCharacteristic.read();

    return rspHexValues[0];
  }



}

