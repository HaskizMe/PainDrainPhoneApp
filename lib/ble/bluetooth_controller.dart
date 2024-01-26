import 'dart:ffi';
import 'dart:io';
import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:pain_drain_mobile_app/main.dart';
import 'package:pain_drain_mobile_app/screens/ble_scan.dart';
import 'package:flutter/material.dart';
import 'package:pain_drain_mobile_app/screens/connect_to_device.dart';
import 'package:pain_drain_mobile_app/screens/home_page.dart';
import 'package:permission_handler/permission_handler.dart';

DeviceIdentifier luna3Identifier = const DeviceIdentifier('E6:D8:E7:66:CB:0D');
DeviceIdentifier painDrainIdentifier = const DeviceIdentifier('00:A0:50:00:00:03');
// BluetoothDevice luna3 = BluetoothDevice(
//     remoteId: luna3Identifier,
//     localName: 'Luna3',
//     type: BluetoothDeviceType.le
// );

// BluetoothDevice painDrain = BluetoothDevice(
//     remoteId: painDrainIdentifier,
//     localName: 'PainDrain',
//     type: BluetoothDeviceType.le
// );

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
  BluetoothDevice? myConnectedDevice;

  late List<BluetoothService> services;

  final RxList<BluetoothDevice> connectedDevices = RxList<BluetoothDevice>();
  final RxList<ScanResult> notConnectedDevices = RxList<ScanResult>();
  final RxList<BluetoothDevice> notConnectedDevices2 = RxList<BluetoothDevice>();

  late final List<ScanResult> results;
  // final StreamController<List<ScanResult>> _scanResultController = StreamController<List<ScanResult>>.broadcast();
  // Stream<List<ScanResult>> get scanResultsStream => _scanResultController.stream;

  @override
  void onInit() {
    super.onInit();
    // _setupBluetooth();
  }


  // Future<void> _setupBluetooth() async {
  //   //var locationStatus = await Permission.locationWhenInUse.status;
  //   // continue testing if user dialogue to enable location isn't showing
  //   if (await FlutterBluePlus.isSupported == false) {
  //     print("Bluetooth not supported by this device");
  //     return;
  //   }
  //
  //   if (Platform.isAndroid) {
  //     await FlutterBluePlus.turnOn();
  //   }
  //
  //   await FlutterBluePlus.adapterState
  //       .map((s) => s)
  //       .where((s) => s == BluetoothAdapterState.on)
  //       .first;
  //
  //   var subscription = FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
  //     print(state);
  //     if (state == BluetoothAdapterState.on) {
  //       // usually start scanning, connecting, etc
  //     } else {
  //       // show an error to the user, etc
  //     }
  //   });
  //   // FlutterBluePlus.connectedSystemDevices.then((devices) {
  //   //   connectedDevices.clear();
  //   //   connectedDevices.assignAll(devices);
  //   // });
  //   var scanSubscription = FlutterBluePlus.onScanResults.listen((results) {
  //     if (results.isNotEmpty) {
  //       ScanResult r = results.last; // the most recently found device
  //       print('${r.device.remoteId}: "${r.advertisementData.advName}" found!');
  //       myDevice = r.device;
  //     }
  //   },
  //     onError: (e) => print(e),
  //   );
  //
  //
  //   // FlutterBluePlus.scanResults.listen((results) {
  //   //   notConnectedDevices.clear();
  //   //   notConnectedDevices.assignAll(results);
  //   // });
  //
  //   FlutterBluePlus.startScan(
  //       timeout: const Duration(seconds: 5),
  //       androidUsesFineLocation: true,
  //       withNames: ["PainDrain"]
  //   );
  //   // cleanup: cancel subscription when scanning stops
  //   FlutterBluePlus.cancelWhenScanComplete(scanSubscription);
  //   print("devices found: ${notConnectedDevices2}");
  //
  //   await FlutterBluePlus.isScanning.where((val) => val == false).first;
  //
  // }
  // Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

  // void startScanning() {
  //   notConnectedDevices.clear();
  //   _setupBluetooth();
  //
  // }







  // Future<void> myScan() async {
  //   //var locationStatus = await Permission.locationWhenInUse.status;
  //   // continue testing if user dialogue to enable location isn't showing
  //   if (await FlutterBluePlus.isSupported == false) {
  //     print("Bluetooth not supported by this device");
  //     return;
  //   }
  //
  //   // await FlutterBluePlus.adapterState
  //   //     .map((s) => s)
  //   //     .where((s) => s == BluetoothAdapterState.on)
  //   //     .first;
  //
  //   var adapterSubscription = FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
  //     print(state);
  //     if (state == BluetoothAdapterState.on) {
  //       // usually start scanning, connecting, etc
  //       var scanSubscription = FlutterBluePlus.scanResults.listen((results) {
  //         // notConnectedDevices.clear();
  //         // notConnectedDevices.assignAll(results);
  //         // print("devices $notConnectedDevices");
  //         if(results.isNotEmpty) {
  //           ScanResult result = results.last;
  //           print("My result ${result.advertisementData.advName}");
  //           myDevice = result.device;
  //         }
  //
  //       });
  //       FlutterBluePlus.cancelWhenScanComplete(scanSubscription);
  //     } else {
  //       // show an error to the user, etc
  //     }
  //   });
  //
  //   // turn on bluetooth ourself if we can
  //   // for iOS, the user controls bluetooth enable/disable
  //   if (Platform.isAndroid) {
  //     await FlutterBluePlus.turnOn();
  //   }
  //
  //   // cancel to prevent duplicate listeners
  //   adapterSubscription.cancel();
  //
  //   // FlutterBluePlus.connectedSystemDevices.then((devices) {
  //   //   connectedDevices.clear();
  //   //   connectedDevices.assignAll(devices);
  //   // });
  //
  //   // FlutterBluePlus.onScanResults.listen((results) {
  //   //   notConnectedDevices.clear();
  //   //   notConnectedDevices.assignAll(results);
  //   //   print("devices $notConnectedDevices");
  //   //
  //   // });
  //
  //   await FlutterBluePlus.startScan(
  //       timeout: const Duration(seconds: 5), androidUsesFineLocation: true, withNames: ["PainDrain"]
  //   );
  //
  //
  //   // Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;
  // }

  // Future<void> startScanning() async {
  //   await _setupBluetooth();
  // }

  // Future<bool> connectingMyDevice() async {
  //   bool connected = false;
  //   var subscription = myDevice.connectionState.listen((BluetoothConnectionState state) async {
  //     if (state == BluetoothConnectionState.disconnected) {
  //       // 1. typically, start a periodic timer that tries to
  //       //    reconnect, or just call connect() again right now
  //       // 2. you must always re-discover services after disconnection!
  //       print("${myDevice.disconnectReason?.description} ${myDevice.disconnectReason}");
  //       connected = false;
  //     }
  //     else if(state == BluetoothConnectionState.connected) {
  //       connected = true;
  //       print("Connected");
  //     }
  //   });
  //
  //   // cleanup: cancel subscription when disconnected
  //   // Note: `delayed:true` lets us receive the `disconnected` event in our handler
  //   // Note: `next:true` means cancel on *next* disconnection. Without this, it
  //   // would cancel immediately because we're already disconnected right now.
  //   myDevice.cancelWhenDisconnected(subscription, delayed:true, next:true);
  //
  //   // Connect to the device
  //   try {
  //     await myDevice.connect();
  //   } catch(e){
  //     print(e);
  //     connected = false;
  //   }
  //   return connected;
  // }

  // Future<BluetoothDevice?> scanAndConnect() async {
  //   late BluetoothDevice? myDevice;
  //
  //   // continue testing if user dialogue to enable location isn't showing
  //   if (await FlutterBluePlus.isSupported == false) {
  //     print("Bluetooth not supported by this device");
  //     return null;
  //   }
  //
  //   var adapterSubscription = FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
  //     print(state);
  //     if (state == BluetoothAdapterState.on) {
  //       // usually start scanning, connecting, etc
  //       var scanSubscription = FlutterBluePlus.scanResults.listen((results) async {
  //         if(results.isNotEmpty) {
  //           ScanResult result = results.last;
  //           print("My result ${result.advertisementData.advName}");
  //           myDevice = result.device;
  //
  //           await connectDevice(myDevice!);
  //
  //         }
  //
  //       });
  //       FlutterBluePlus.cancelWhenScanComplete(scanSubscription);
  //     } else {
  //       // show an error to the user, etc
  //     }
  //   });
  //
  //   // turn on bluetooth ourself if we can
  //   // for iOS, the user controls bluetooth enable/disable
  //   if (Platform.isAndroid) {
  //     await FlutterBluePlus.turnOn();
  //   }
  //
  //   // cancel to prevent duplicate listeners
  //   adapterSubscription.cancel();
  //
  //
  //   await FlutterBluePlus.startScan(
  //       timeout: const Duration(seconds: 5), androidUsesFineLocation: true, withNames: ["PainDrain"]
  //   );
  //
  //
  //
  //   return myDevice;
  // }

// Future<void> connectDevice(BluetoothDevice device) async {
//     var connectionSubscription = device.connectionState.listen((BluetoothConnectionState state) async {
//       if (state == BluetoothConnectionState.disconnected) {
//         print("Device Disconnected");
//         print("${device.disconnectReason}");
//         Get.to(() => const ConnectDevice());
//
//       } else if (state == BluetoothConnectionState.connected) {
//         print("Device Connected");
//         Get.to(() => const HomePage());
//
//       }
//       try {
//         await device.connect();
//       } catch(e) {
//         print("Error Cannot Connect");
//       }
//
//     });
//
//     device.cancelWhenDisconnected(connectionSubscription, delayed: true, next: true);
//
// }



  // Future<void> scanAndConnect() async {
  //
  //   // Checks to see if Bluetooth in supported on phone
  //   if (await FlutterBluePlus.isSupported == false) {
  //     print("Bluetooth not supported by this device");
  //     return;
  //   }
  //
  //   // handle bluetooth on & off
  //   var subscription = FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) async {
  //     print(state);
  //     if (state == BluetoothAdapterState.on) {
  //       // usually start scanning, connecting, etc
  //
  //
  //       // listen to scan results
  //       // Note: `onScanResults` only returns live scan results, i.e. during scanning
  //       // Use: `scanResults` if you want live scan results *or* the results from a previous scan
  //       var subscription = FlutterBluePlus.onScanResults.listen((results) async {
  //         if (results.isNotEmpty) {
  //           ScanResult r = results.last; // the most recently found device
  //           print('${r.device.remoteId}: "${r.advertisementData.advName}" found!');
  //           BluetoothDevice myDevice = r.device;
  //           // await bluetoothController.connectDevice(myDevice);
  //           var connectionSubscription = myDevice.connectionState.listen((BluetoothConnectionState state) async {
  //             if (state == BluetoothConnectionState.disconnected) {
  //               print("Device Disconnected");
  //               print("${myDevice.disconnectReason}");
  //               Get.to(() => const ConnectDevice());
  //
  //             } else if (state == BluetoothConnectionState.connected) {
  //               print("Device Connected");
  //               Get.to(() => const HomePage());
  //
  //             }
  //             try {
  //               await myDevice.connect();
  //               // myConnectedDevice = myDevice;
  //             } catch(e) {
  //               print("Error Cannot Connect");
  //             }
  //
  //           });
  //
  //           myDevice.cancelWhenDisconnected(connectionSubscription, delayed: true, next: true);
  //         }
  //       },
  //         onError: (e) => print(e),
  //       );
  //
  //       // cleanup: cancel subscription when scanning stops
  //       FlutterBluePlus.cancelWhenScanComplete(subscription);
  //
  //
  //       // Start scanning w/ timeout
  //       // Optional: you can use `stopScan()` as an alternative to using a timeout
  //       // Note: scan filters use an *or* behavior. i.e. if you set `withServices` & `withNames`
  //       //   we return all the advertisments that match any of the specified services *or* any
  //       //   of the specified names.
  //       await FlutterBluePlus.startScan(
  //           withNames:["PainDrain"],
  //           timeout: Duration(seconds: 5));
  //
  //       // wait for scanning to stop
  //       await FlutterBluePlus.isScanning.where((val) => val == false).first;
  //
  //     } else {
  //       // show an error to the user, etc
  //     }
  //   });
  //
  //   // turn on bluetooth ourself if we can
  //   // for iOS, the user controls bluetooth enable/disable
  //   if (Platform.isAndroid) {
  //     await FlutterBluePlus.turnOn();
  //   }
  //
  //   // cancel to prevent duplicate listeners
  //   subscription.cancel();
  // }

  List<ScanResult> scanResults = [];

  Future<void> scanForDevices() async {
    var subscription = FlutterBluePlus.onScanResults.listen((results) {
      scanResults = results.toList(); // Store scan results in the list
    },
      onError: (e) => print(e),
    );

    FlutterBluePlus.cancelWhenScanComplete(subscription);
    await FlutterBluePlus.startScan(
        withNames:["PainDrain"],
        timeout: const Duration(seconds: 5));

    // wait for scanning to stop
    await FlutterBluePlus.isScanning.where((val) => val == false).first;

  }

  Future<bool> connectDevice(BluetoothDevice device) async {
    bool success = false;

    var connectionSubscription = device.connectionState.listen((BluetoothConnectionState state) async {
      if (state == BluetoothConnectionState.disconnected) {
        Get.to(() => const ConnectDevice());
        // success = false;
      } else if (state == BluetoothConnectionState.connected) {
        success = true;
      }
    });

    try {
      await device.connect();
      success = true;
    } catch (e) {
      success = false;
      print("Error Cannot Connect");
    }

    device.cancelWhenDisconnected(connectionSubscription, delayed: true, next: true);

    return success;
  }

  final StreamController<bool> _connectionStreamController = StreamController<bool>.broadcast();

  Stream<bool> get connectionStream => _connectionStreamController.stream;

  Future<void> scanAndConnect() async {
    var subscription = FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) async {
      if (state == BluetoothAdapterState.on) {
        var subscription = FlutterBluePlus.onScanResults.listen((results) async {
          if (results.isNotEmpty) {
            ScanResult r = results.last;
            BluetoothDevice myDevice = r.device;
            var connectionSubscription = myDevice.connectionState.listen((BluetoothConnectionState state) async {
              if (state == BluetoothConnectionState.disconnected) {
                // _connectionStreamController.add(false); // Notify that connection failed
              } else if (state == BluetoothConnectionState.connected) {
                _connectionStreamController.add(true); // Notify that connection succeeded
              }
            });

            try {
              await myDevice.connect();
            } catch (e) {
              print("Error Cannot Connect");
              // _connectionStreamController.add(false); // Notify that connection failed
            }

            myDevice.cancelWhenDisconnected(connectionSubscription, delayed: true, next: true);
          }
        }, onError: (e) {
          print(e);
          // _connectionStreamController.add(false); // Notify that connection failed
        });

        FlutterBluePlus.cancelWhenScanComplete(subscription);

        await FlutterBluePlus.startScan(withNames: ["PainDrain"], timeout: Duration(seconds: 5));

        await FlutterBluePlus.isScanning.where((val) => val == false).first;
      } else {
        // Handle Bluetooth off
        // _connectionStreamController.add(false); // Notify that connection failed
      }
    });

    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }

    subscription.cancel();
  }





  ///////////KEEP THIS FOR NOW
  // static Future<void> scanAndConnect(Function(bool) onConnectionStatus) async {
  //
  //   // Checks to see if Bluetooth in supported on phone
  //   try {
  //     if (await FlutterBluePlus.isSupported == false) {
  //       print("Bluetooth not supported by this device");
  //       return;
  //     }
  //
  //     // Starts a subscription to listen to Bluetooth state
  //     var bleStateSubscription = FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
  //       // print(state);
  //       // Checks to see if Bluetooth is on
  //       if (state == BluetoothAdapterState.on) {
  //
  //
  //         var bleScanSubscription = FlutterBluePlus.onScanResults.listen((results) async {
  //           if (results.isNotEmpty) {
  //             ScanResult r = results.last;
  //             print('${r.device.remoteId}: "${r.advertisementData.advName}" found!');
  //             try {
  //               await r.device.connect();
  //               var connectionSubscription = r.device.connectionState.listen((BluetoothConnectionState state) async {
  //                 if (state == BluetoothConnectionState.disconnected) {
  //                   print("Device Disconnected");
  //                   print("${r.device.disconnectReason} ${r.device.disconnectReason?.description}");
  //                   Get.to(() => const ConnectDevice());
  //                   onConnectionStatus(false);
  //                 } else if (state == BluetoothConnectionState.connected) {
  //                   await Future.delayed(const Duration(seconds: 3), () {});
  //                   onConnectionStatus(true);
  //                   print("Device Connected");
  //                 } else {
  //                     // onConnectionStatus(false);
  //                 }
  //               });
  //               r.device.cancelWhenDisconnected(connectionSubscription, delayed: true, next: true);
  //             } catch (e) {
  //               print("Error connecting to device: $e");
  //             }
  //
  //           } else {
  //             print("No devices found");
  //           }
  //           }, onError: (e) {print("Scan results error: $e");},
  //         );
  //         FlutterBluePlus.cancelWhenScanComplete(bleScanSubscription);
  //       } else {
  //         print("Turn on Bluetooth");
  //       }
  //     });
  //
  //     await FlutterBluePlus.startScan(withNames: ["PainDrain"], timeout: const Duration(seconds: 5));
  //
  //     if (Platform.isAndroid) {
  //       await FlutterBluePlus.turnOn();
  //     }
  //
  //     bleStateSubscription.cancel();
  //   } catch (e) {
  //     print("Error in scanAndConnect: $e");
  //     // onConnectionStatus(false);
  //   }
  //   await Future.delayed(const Duration(seconds: 3), () {});
  //   onConnectionStatus(false);
  // }

  // Future<void> scanAndConnect(Function(bool) onConnectionStatus) async {
  //
  //   // Checks to see if Bluetooth in supported on phone
  //   try {
  //     if (await FlutterBluePlus.isSupported == false) {
  //       print("Bluetooth not supported by this device");
  //       return;
  //     }
  //     if (Platform.isAndroid) {
  //       await FlutterBluePlus.turnOn();
  //     }
  //
  //     // Starts a subscription to listen to Bluetooth state
  //     var bleStateSubscription = FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) async {
  //       // Checks to see if Bluetooth is on
  //       if (state == BluetoothAdapterState.on) {
  //         await scanning();
  //       } else {
  //         print("Turn on Bluetooth");
  //       }
  //     });
  //     bleStateSubscription.cancel();
  //   } catch (e) {
  //     print("Error in scanAndConnect: $e");
  //   }
  //   // await Future.delayed(const Duration(seconds: 3), () {});
  //   // onConnectionStatus(false);
  // }
  //
  // Future<void> scanning() async {
  //
  //   var bleScanSubscription = FlutterBluePlus.onScanResults.listen((results) async {
  //     if (results.isNotEmpty) {
  //       ScanResult r = results.last;
  //       print('${r.device.remoteId}: "${r.advertisementData.advName}" found!');
  //       await connecting(r);
  //       // try {
  //       //   await r.device.connect();
  //       //   var connectionSubscription = r.device.connectionState.listen((BluetoothConnectionState state) async {
  //       //     if (state == BluetoothConnectionState.disconnected) {
  //       //       print("Device Disconnected");
  //       //       print("${r.device.disconnectReason} ${r.device.disconnectReason?.description}");
  //       //       Get.to(() => const ConnectDevice());
  //       //       onConnectionStatus(false);
  //       //     } else if (state == BluetoothConnectionState.connected) {
  //       //       await Future.delayed(const Duration(seconds: 3), () {});
  //       //       onConnectionStatus(true);
  //       //       print("Device Connected");
  //       //     } else {
  //       //       // onConnectionStatus(false);
  //       //     }
  //       //   });
  //       //   r.device.cancelWhenDisconnected(connectionSubscription, delayed: true, next: true);
  //       // } catch (e) {
  //       //   print("Error connecting to device: $e");
  //       // }
  //
  //     } else {
  //       print("No devices found");
  //     }
  //   }, onError: (e) {print("Scan results error: $e");},
  //   );
  //   await FlutterBluePlus.startScan(withNames: ["PainDrain"], timeout: const Duration(seconds: 5));
  //
  //   FlutterBluePlus.cancelWhenScanComplete(bleScanSubscription);
  // }
  //
  // Future<void> connecting(ScanResult r) async {
  //   try {
  //     await r.device.connect();
  //     var connectionSubscription = r.device.connectionState.listen((BluetoothConnectionState state) async {
  //       if (state == BluetoothConnectionState.disconnected) {
  //         print("Device Disconnected");
  //         print("${r.device.disconnectReason} ${r.device.disconnectReason?.description}");
  //         Get.to(() => const ConnectDevice());
  //         onConnectionStatus(false);
  //       } else if (state == BluetoothConnectionState.connected) {
  //         await Future.delayed(const Duration(seconds: 3), () {});
  //         onConnectionStatus(true);
  //         print("Device Connected");
  //       } else {
  //         // onConnectionStatus(false);
  //       }
  //     });
  //     r.device.cancelWhenDisconnected(connectionSubscription, delayed: true, next: true);
  //   } catch (e) {
  //     print("Error connecting to device: $e");
  //   }
  // }
  // Future<ScanResult?> scanForDevices() async {
  //   try {
  //     if (await FlutterBluePlus.isSupported == false) {
  //       print("Bluetooth not supported by this device");
  //       return null;
  //     }
  //
  //     var bleStateSubscription = FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
  //       if (state == BluetoothAdapterState.on) {
  //         var bleScanSubscription = FlutterBluePlus.onScanResults.listen((results) async {
  //           if (results.isNotEmpty) {
  //             for (ScanResult r in results) {
  //               print('${r.device.remoteId}: "${r.advertisementData.advName}" found!');
  //               return r;
  //               // onDeviceFound(r);
  //             }
  //           } else {
  //             print("No devices found");
  //           }
  //         }, onError: (e) {
  //           print("Scan results error: $e");
  //         });
  //
  //         FlutterBluePlus.cancelWhenScanComplete(bleScanSubscription);
  //       } else {
  //         print("Turn on Bluetooth");
  //       }
  //     });
  //
  //     await FlutterBluePlus.startScan(withNames: ["PainDrain"], timeout: const Duration(seconds: 5));
  //
  //     if (Platform.isAndroid) {
  //       await FlutterBluePlus.turnOn();
  //     }
  //
  //     bleStateSubscription.cancel();
  //   } catch (e) {
  //     print("Error in scanForDevices: $e");
  //   }
  //   return null;
  // }

  Future<void> connectingToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      var connectionSubscription = device.connectionState.listen((BluetoothConnectionState state) async {
        if (state == BluetoothConnectionState.disconnected) {
          print("Device Disconnected");
          print("${device.disconnectReason} ${device.disconnectReason?.description}");
          Get.to(() => const ConnectDevice());
        } else if (state == BluetoothConnectionState.connected) {
          await Future.delayed(const Duration(seconds: 3), () {});
          print("Device Connected");
        }
      });
      device.cancelWhenDisconnected(connectionSubscription, delayed: true, next: true);
    } catch (e) {
      print("Error connecting to device: $e");
    }
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
    // luna3.disconnect();
    // painDrain.disconnect();
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

