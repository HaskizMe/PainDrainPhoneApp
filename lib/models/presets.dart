// preset.dart
import 'package:pain_drain_mobile_app/models/preset.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'presets.freezed.dart';
part 'presets.g.dart';


@freezed
class Presets with _$Presets {
  const factory Presets({
    required List<Preset> presets,
    required Preset? selectedPreset,
  }) = _Presets;

  factory Presets.fromJson(Map<String, dynamic> json) => _$PresetsFromJson(json);
}
