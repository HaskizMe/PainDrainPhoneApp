// preset.dart
import 'tens.dart';
import 'vibration.dart';
import 'temperature.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'preset.freezed.dart';
part 'preset.g.dart';


@freezed
class Preset with _$Preset {
  const factory Preset({
    required int id,
    required Tens tens,
    required Vibration vibration,
    required Temperature temperature,
    @Default('') String name,
  }) = _Preset;

  factory Preset.fromJson(Map<String, dynamic> json) => _$PresetFromJson(json);
}
