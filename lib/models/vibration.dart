import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vibration.freezed.dart';
part 'vibration.g.dart';

@freezed
class Vibration with _$Vibration {
  const factory Vibration({
    @Default(0) int frequency,
  }) = _Vibration;

  factory Vibration.fromJson(Map<String, dynamic> json) =>
      _$VibrationFromJson(json);
}