// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PresetImpl _$$PresetImplFromJson(Map<String, dynamic> json) => _$PresetImpl(
      id: (json['id'] as num).toInt(),
      tens: Tens.fromJson(json['tens'] as Map<String, dynamic>),
      vibration: Vibration.fromJson(json['vibration'] as Map<String, dynamic>),
      temperature:
          Temperature.fromJson(json['temperature'] as Map<String, dynamic>),
      name: json['name'] as String,
    );

Map<String, dynamic> _$$PresetImplToJson(_$PresetImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tens': instance.tens,
      'vibration': instance.vibration,
      'temperature': instance.temperature,
      'name': instance.name,
    };
