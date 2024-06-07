import 'dart:async';
import 'dart:collection';
import 'package:get/get.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:pain_drain_mobile_app/controllers/stimulus_controller.dart';
import 'package:pain_drain_mobile_app/screens/connect_to_device.dart';


class BluetoothController extends GetxController {
  final StimulusController _stimulusController = Get.find();
  Function? onDisconnectedCallback;
  Function? onReconnectedCallback;
  final Queue<List<int>> _queue = Queue<List<int>>();
  String customServiceUUID = "3bf00c21-d291-4688-b8e9-5a379e3d9874";
  String customCharacteristicUUID = "93c836a2-695a-42cc-95ac-1afa0eef6b0a";
  // String batteryServiceUUID = "0000180f-0000-1000-8000-00805f9b34fb";
  // String batteryCharacteristicUUID = "00002a19-0000-1000-8000-00805f9b34fb";
  String batteryServiceUUID = "180f";
  String batteryCharacteristicUUID = "2a19";
  String characteristicConfigurationUUID = "2902";
  //String batteryConfigurationUUID = "2902";
  //late BluetoothCharacteristic customConfigurationCharacteristic;
  late BluetoothDescriptor customConfigurationDescriptor;

  late BluetoothService customService;
  late BluetoothService batteryService;
  late BluetoothCharacteristic customCharacteristic;
  late BluetoothCharacteristic batteryCharacteristic;
  BluetoothDevice? myConnectedDevice;
  late List<BluetoothService> services;
  final RxList<BluetoothDevice> connectedDevices = RxList<BluetoothDevice>();
  final RxList<ScanResult> notConnectedDevices = RxList<ScanResult>();
  List<ScanResult> scanResults = [];
  var isCharging = false.obs;
  var showChargingAnimation = false.obs;

  Future<void> scanForDevices() async {

    var subscription = FlutterBluePlus.onScanResults.listen((results) {
      scanResults = results.toList(); // Store scan results in the list
    },
      onError: (e) => print(e),
    );

    FlutterBluePlus.cancelWhenScanComplete(subscription);
    await FlutterBluePlus.startScan(
        withNames:["PainDrain"],
        timeout: const Duration(seconds: 5)
    );

    // wait for scanning to stop
    await FlutterBluePlus.isScanning.where((val) => val == false).first;

    if(scanResults.isNotEmpty){
      print("not empty");
    }
    else{
      print("empty");
    }
  }

  Future<bool> connectDevice(BluetoothDevice device) async {
    bool success = false;
    try {
      myConnectedDevice = device;
      await device.connect();
      var connectionSubscription = device.connectionState.listen((BluetoothConnectionState state) async {
        if (state == BluetoothConnectionState.disconnected) {
          Get.to(() => const ConnectDevice());
          print("Device Disconnected");
          print("Error disconnection description: ${device.disconnectReason}");
        } else if (state == BluetoothConnectionState.connected) {
          success = true;
        }

      });
      device.cancelWhenDisconnected(connectionSubscription, delayed: true, next: true);
      await discoverServices(device);
      success = true;

      setupListeners(device);
    } catch (e) {
      success = false;
      print("Error Cannot Connect $e");
    }

    return success;
  }

  Future<bool> disconnectDevice() async {
    if(myConnectedDevice != null){
      try{
        await myConnectedDevice!.disconnect();
        return true;
      } catch(e){
        print("Couldn't disconnect $e");
      }
    }
    return false;
  }

  Future<void> discoverServices(BluetoothDevice connectedDevice) async {
    services = await connectedDevice.discoverServices();

    // Reads all services and finds the custom service uuid
    for (BluetoothService service in services) {
      //print("Services: ${service.uuid.toString()}");
      //print("Services: $service");
      if(service.uuid.toString() == customServiceUUID){
        print("Custom service found");
        customService = service;
      } else if(service.uuid.toString() == batteryServiceUUID){
        batteryService = service;
      }

    }
    // Reads all characteristics
    var customServiceCharacteristics = customService.characteristics;
    // var batteryServiceCharacteristics = batteryService.characteristics;
    for(BluetoothCharacteristic characteristic in customServiceCharacteristics) {
      //print(characteristic);
      if(characteristic.uuid.toString() == customCharacteristicUUID){
        print("Custom characteristic found");
        customCharacteristic = characteristic;
        for(BluetoothDescriptor descriptor in customCharacteristic.descriptors){
          if(descriptor.uuid.toString() == characteristicConfigurationUUID){
            customConfigurationDescriptor = descriptor;
            print("Descriptor found");
          }
        }
      }
    }
    var batteryServiceCharacteristics = batteryService.characteristics;

    for(BluetoothCharacteristic characteristic in batteryServiceCharacteristics) {
      if(characteristic.uuid.toString() == batteryCharacteristicUUID){
        print("Battery characteristic found: $characteristic");
        batteryCharacteristic = characteristic;
      }
    }
  }

  @override
  void onClose() {
    // luna3.disconnect();
    // painDrain.disconnect();
    FlutterBluePlus.stopScan();
    print("on close");
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
      case "notifications":
        await customCharacteristic.write(hexValues);
        break;
      case "B":
        await customCharacteristic.write(hexValues);
      default:
        print("error");
        break;
    }
  }

  Future<void> newWriteToDevice(String command) async {
    try {
      //String command = getCommand(stimulus);
      List<int> hexValues = stringToHexList(command);
      // Add the command to the queue
      _queue.add(hexValues);
      // Process each element in the queue until it's empty
      while (_queue.isNotEmpty) {
        print("Elements in queue: ${_queue.length}");
        List<int> currentHexValues = _queue.removeFirst();

        if(currentHexValues.length > 20){
          print("Big data");
          await customCharacteristic.write(currentHexValues, allowLongWrite: true);
        } else {
          await customCharacteristic.write(currentHexValues);
        }
        // Remove the processed command from the queue

        // Optionally, you can wait for a response from the device
        //List<int> readValues = await readFromDevice();
        // String read = hexToString(readValues);
        // devDebugPrint(read);
        //print("Read Values: $read");
        //print("Read Values: $readValues");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void devDebugPrint(String readString) {
    if(readString[0] == "T") {
      if(readString[2] == "p"){
        _stimulusController.readPhase = readString;
      } else {
        _stimulusController.readTens = readString;
      }
    } else if(readString[0] == "v"){
      _stimulusController.readVibe = readString;
    } else if(readString[0] == "t") {
      _stimulusController.readTemp = readString;
    } else {
      print("no value");
    }
  }

  String getCommand(String stimulus){
    String channel;
    String command = "";

    if(_stimulusController.getCurrentChannel() == 1){
      channel = _stimulusController.tensDurCh1;
    } else {
      channel = _stimulusController.tensDurCh2;
    }

    switch (stimulus){
      case "tens":
        print("tens");
        command = "T "
            "${_stimulusController.getStimulus(_stimulusController.tensAmp).toInt()} "
            "${_stimulusController.getStimulus(channel)} "
            "${_stimulusController.getStimulus(_stimulusController.tensPeriod).toInt()} "
            "${_stimulusController.getCurrentChannel()}";
        print(command);
        break;
      case "phase":
        command = "T p ${_stimulusController.getStimulus(_stimulusController.tensPhase).toInt()}";
        print(command);

        break;
      case "temperature":
        print("temperature");
        command = "t "
            "${_stimulusController.getStimulus(_stimulusController.temp).toInt()} ";
        print(command);

        break;
      case "vibration":
        print("vibration");
        //String shortenedWaveType = _stimulusController.getAbbreviation(_stimulusController.getCurrentWaveType());
        command = "v "
            "${_stimulusController.getStimulus(_stimulusController.vibeIntensity).toInt()} "
            "${_stimulusController.getStimulus(_stimulusController.vibeFreq).toInt()} ";
            //"${_stimulusController.getStimulus(_stimulusController.vibeWaveform).toInt()} ";
        print(command);
        break;

      default:
        print("error: Stimulus doesn't exist. Use 'tens', 'vibration', 'phase', or 'temperature'");
        break;
    }
    print("sending");
    return command;
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

  setupListeners(BluetoothDevice device) async {
    // This sends a command to the device to enable notifications. So that the below code can read value changes
    await customConfigurationDescriptor.write([1]);
    print("subscribing to custom characteristic");


    final customCharacteristicSubscription = customCharacteristic.onValueReceived.listen((value) {
      /// This is where I will add the code to get the battery percentage. Right now
      /// this is only called when readFromDevice() is called anywhere in the program.
      /// I need to add a notifier function to the Firmware
      print("Battery Characteristic received: $value");
      print("Battery Characteristic received String: ${hexToString(value)}");
      String read = hexToString(value);
      devDebugPrint(read);
      print("Read Values: $read");
      print("Value received!!!!!!!!!!");

      if(read == "charging 0"){
        _stimulusController.disableAllStimuli();
        //sendDisableCommand();
        //update();
        isCharging.value = true; // Update the state variable when the device is charging
        showChargingAnimation.value = true;
        Future.delayed(const Duration(seconds: 5), () {
          showChargingAnimation.value = false;
        });
      } else if(read == "charging 1") {
        isCharging.value = false; // Update the state variable when the device is not charging
      }
    });

    // cleanup: cancel subscription when disconnected
    device.cancelWhenDisconnected(customCharacteristicSubscription);


    // This enables notifications
    // Note: If a characteristic supports both **notifications** and **indications**,
    // it will default to **notifications**. This matches how CoreBluetooth works on iOS.
    await customCharacteristic.setNotifyValue(true);
  }

  // void sendDisableCommand(){
  //   String command = getCommand("tens");
  //   newWriteToDevice(command);
  //   command = getCommand("phase");
  //   newWriteToDevice(command);
  //   command = getCommand("temperature");
  //   newWriteToDevice(command);
  //   command = getCommand("vibration");
  //   newWriteToDevice(command);
  // }



}

