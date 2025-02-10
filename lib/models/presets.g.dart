// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PresetsImpl _$$PresetsImplFromJson(Map<String, dynamic> json) =>
    _$PresetsImpl(
      presets: (json['presets'] as List<dynamic>)
          .map((e) => Preset.fromJson(e as Map<String, dynamic>))
          .toList(),
      selectedPreset: json['selectedPreset'] == null
          ? null
          : Preset.fromJson(json['selectedPreset'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PresetsImplToJson(_$PresetsImpl instance) =>
    <String, dynamic>{
      'presets': instance.presets,
      'selectedPreset': instance.selectedPreset,
    };
