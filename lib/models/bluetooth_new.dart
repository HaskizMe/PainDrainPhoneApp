import 'dart:async';
import 'dart:collection';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

part 'bluetooth_new.freezed.dart';

@freezed
class BluetoothNew with _$BluetoothNew {
  const factory BluetoothNew({
    Queue<List<int>>? queue, // Nullable queue
    @Default("3bf00c21-d291-4688-b8e9-5a379e3d9874") String customServiceUUID,
    @Default("93c836a2-695a-42cc-95ac-1afa0eef6b0a") String customCharacteristicUUID,
    @Default("180f") String batteryServiceUUID,
    @Default("2a19") String batteryCharacteristicUUID,
    @Default("2902") String characteristicConfigurationUUID,
    @Default([]) List<BluetoothService> services,
    @Default(false) bool isCharging,
    @Default(false) bool showChargingAnimation,
    BluetoothDescriptor? customConfigurationDescriptor,
    BluetoothService? customService,
    BluetoothService? batteryService,
    BluetoothCharacteristic? customCharacteristic,
    BluetoothCharacteristic? batteryCharacteristic,
    BluetoothDevice? connectedDevice,
  }) = _BluetoothNew;
}