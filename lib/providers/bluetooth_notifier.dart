
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/bluetooth_new.dart';

part 'bluetooth_notifier.g.dart';

@Riverpod(keepAlive: true)
class BluetoothNotifier extends _$BluetoothNotifier {


  @override
  BluetoothNew build() {
    return const BluetoothNew(); // Initial state
  }



}