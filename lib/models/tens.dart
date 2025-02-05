import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tens.freezed.dart';
part 'tens.g.dart';

@freezed
class Tens with _$Tens {
  const factory Tens({
    @Default(0) int intensity,
    @Default(1) int mode,
    @Default(false) bool isPlaying,
    @Default(1) int channel,
    @Default(0) int phase,
  }) = _Tens;

  factory Tens.fromJson(Map<String, dynamic> json) => _$TensFromJson(json);
}