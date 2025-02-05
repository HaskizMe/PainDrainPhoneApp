// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tens.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TensImpl _$$TensImplFromJson(Map<String, dynamic> json) => _$TensImpl(
      intensity: (json['intensity'] as num?)?.toInt() ?? 0,
      mode: (json['mode'] as num?)?.toInt() ?? 1,
      isPlaying: json['isPlaying'] as bool? ?? false,
      channel: (json['channel'] as num?)?.toInt() ?? 1,
      phase: (json['phase'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$TensImplToJson(_$TensImpl instance) =>
    <String, dynamic>{
      'intensity': instance.intensity,
      'mode': instance.mode,
      'isPlaying': instance.isPlaying,
      'channel': instance.channel,
      'phase': instance.phase,
    };
